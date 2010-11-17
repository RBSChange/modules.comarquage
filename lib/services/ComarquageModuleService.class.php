<?php
class comarquage_ComarquageModuleService extends f_persistentdocument_DocumentService
{
	/**
	 * @var comarquage_ComarquageModuleService
	 */
	private static $instance;
	private $cachePath;
	private $xmlUrl;

	/**
	 * Returns the unique instance of website_WebsiteModuleService.
	 * @return comarquage_ComarquageModuleService
	 */
	public static function getInstance()
	{
		if (self::$instance === null)
		{
			self::$instance = self::getServiceClassInstance(get_class());
		}
		return self::$instance;
	}

	// --- Configuration methods ---


	/**
	 * Return remote url on service-public.fr server where xml files are available
	 *
	 * @return string url
	 * @todo do it in a better way... generic method to get module config value ?...
	 */
	public function getConfigXmlUrlValue()
	{
		if (is_null($this->xmlUrl))
		{
			if (defined('COMARQUAGE_XML_URL'))
			{
				$this->xmlUrl = COMARQUAGE_XML_URL;
			}
			else
			{
				$this->xmlUrl = 'http://lecomarquage.service-public.fr/xml2/';
			}
		}
		return $this->xmlUrl;
	}

	/**
	 * Return module cache path for xml files
	 *
	 * @return string url
	 * @todo do it in a better way... generic method to get module config value ?...
	 */
	public function getConfigCachePathValue()
	{
		if (is_null($this->cachePath))
		{
			$this->cachePath =  AG_CACHE_DIR. DIRECTORY_SEPARATOR ."comarq" . DIRECTORY_SEPARATOR;
			f_util_FileUtils::mkdir($this->cachePath);
		}
		return $this->cachePath;
	}

	/**
	 * @return Boolean
	 */
	public function clearConfig()
	{
		$xslParamFile = 'xsl-params.xsl';
		$configFile = $this->getConfigCachePathValue() . $xslParamFile;
		if(file_exists($configFile))
		{
			if(@unlink($configFile) === false)
			{
				Framework::error("Can't remove comarquage xsl config file : ".$configFile);
				return false;
			}
		}
		return true;
	}

	/**
	 * @param Integer $nbCacheHour
	 * @param String $commune
	 * @param String $department
	 * @param String $cache_path
	 * @param String $url_xml
	 * @param String $pageComarqUrl
	 * @return Boolean
	 */
	public function checkXslConfig($nbCacheHour, $commune, $department, $cache_path, $url_xml, $pageComarqUrl)
	{
		$xslParamFile = 'xsl-params.xsl';
		$configFile = $this->getConfigCachePathValue() . $xslParamFile;

		if(!file_exists($configFile))
		{
			if(strpos($pageComarqUrl, '&') !== false)
			{
				Framework::error("Url is not rewritten, module comarquage can't work without url rewritten. Actual url : ".$pageComarqUrl);
				return f_Locale::translate("&modules.comarquage.backoffice.Error;");
			}

			$xslParamsInit = FileResolver::getInstance()->setPackageName('modules_comarquage')->getPath('/xsl/xsl-params-init.xsl');
			if(!is_null($xslParamsInit) && is_readable($xslParamsInit))
			{
				$contentInitFile = file($xslParamsInit);

				for($i=0;$i<count($contentInitFile);$i++)
				{
					$value = trim($contentInitFile[$i]);
					if($value=='<xsl:param name="REFERER"></xsl:param>')
					{
						$contentInitFile[$i] = "\t<xsl:param name=\"REFERER\">".$pageComarqUrl."</xsl:param>\n";
					}
					elseif($value=='<xsl:param name="CACHEPATH"></xsl:param>')
					{
						if($nbCacheHour > 0)
						{
							$contentInitFile[$i] = "\t<xsl:param name=\"CACHEPATH\">".$cache_path."</xsl:param>\n";
						}
						else
						{
							$contentInitFile[$i] = "\t<xsl:param name=\"CACHEPATH\">".$url_xml."</xsl:param>\n";
						}
					}
					elseif(strpos($value,'Commune')!==false)
					{
						if(!is_null($commune))
						{
							$value = str_replace('//Commune','//'.str_replace(' ','-',trim($commune)),$value);

						}
						if(!is_null($department))
						{
							$value = str_replace('@dep','@'.str_replace(' ','-',trim($department)),$value);
						}
						$contentInitFile[$i] = "\t".$value."\n";
					}
				}
				if (Framework::isDebugEnabled())
				{
					Framework::debug(var_export($contentInitFile, true));
				}
				if(file_put_contents($configFile, implode('',$contentInitFile)) === false)
				{
					Framework::error("Can't save xsl config file : ".$configFile);
					return f_Locale::translate("&modules.comarquage.backoffice.Error;");
				}

				$this->createXslCacheCopy();
			}
			else
			{
				Framework::error('Init config file is missing !!!! '.$xslParamsInit);
				return f_Locale::translate("&modules.comarquage.backoffice.Error;");
			}

		}
		return true;
	}

	private function createXslCacheCopy()
	{
		$filesNames = array('Themes.xsl', 'Noeud.xsl', 'RessourcesRattachees.xsl', 'RessourceRattachee.xsl',
							'Publication.xsl', 'Ressource.xsl', 'MotsCles.xsl', 'header.xsl', 'Fiche.xsl', 'footer.xsl');

		foreach ($filesNames as $fileName)
		{
			$filePath = FileResolver::getInstance()->setPackageName('modules_comarquage')->getPath(DIRECTORY_SEPARATOR. 'xsl'. DIRECTORY_SEPARATOR . $fileName);
			$cachePath = $this->getConfigCachePathValue() . $fileName;
			file_put_contents($cachePath, file_get_contents($filePath));
		}
	}

	/**
	 * @return Boolean
	 */
	public function clearCache()
	{
		$cachedir  = $this->getConfigCachePathValue();
		if(is_dir($cachedir))
		{
			$cacheFiles = glob($cachedir.'*.xml');
			foreach ($cacheFiles as $file)
			{
				if(unlink($file)===false)
				{
					Framework::error("Can't remove comarquage xml cache file : ".$file);
					return false;
				}
			}
		}
		return true;
	}

	/**
	 * @param String $xmlName
	 * @param String $hour
	 * @return Boolean
	 */
	public function addToCache($xmlName, $hour, $key = null)
	{
		if (Framework::isDebugEnabled())
		{
			Framework::debug(__METHOD__."($xmlName, $hour, $key)");
		}
		$cachePath = $this->getConfigCachePathValue();
		$urlXml = $this->getConfigXmlUrlValue();

		if (file_exists($cachePath.$xmlName))
		{
			if(time() - filemtime($cachePath.$xmlName) > $hour * 3600)
			{
				if (Framework::isDebugEnabled())
				{
					Framework::debug(__METHOD__." Obsolete xml cache file");
				}

				if(@unlink($cachePath.$xmlName)===false)
				{
					Framework::error('Xml cache file for comarquage module was not deleted.');
				}
				$subdoc = @file_get_contents($cachePath.'key_'.$xmlName);
				if ($subdoc !== false)
				{
					@unlink($cachePath.'key_'.$xmlName);
					$files = explode('|', $subdoc);
					foreach ($files as $file)
					{
						if ($file != '' && file_exists($cachePath.$file))
						{
							@unlink($cachePath.$file);
						}
					}
				}
			}
		}

		if (!file_exists($cachePath.$xmlName))
		{
			$remoteFile = @file_get_contents($urlXml.$xmlName);
			if($remoteFile === false)
			{
				Framework::error("Can't access to ".$urlXml.$xmlName);
				return false;
			}

			if(@file_put_contents($cachePath.$xmlName, $remoteFile)===false)
			{
				Framework::error("Can't save xml file : ".$cachePath.$xmlName);
				return false;
			}

			if (!is_null($key))
			{
				$keyfile = $cachePath.'key_'.$key;
				Framework::debug('Key : '.$keyfile);
				$subdoc = @file_get_contents($keyfile);
				if ($subdoc === false)
				{
					$subdoc = $xmlName;
				}
				else if (strpos($subdoc, $xmlName) === false)
				{
					$subdoc .= '|' . $xmlName;
				}
				Framework::debug('Key content: '.$subdoc);
				@file_put_contents($keyfile, $subdoc);
			}
		}
		return true;
	}
}