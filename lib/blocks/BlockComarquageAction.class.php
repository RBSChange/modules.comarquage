<?php
class comarquage_BlockComarquageAction extends block_BlockAction
{
    /**
     * The initialize() method of BlockAction is always called,
     * even if the Action is cached.
     *
     * This is useful for modifying the block's context (page title,
     * stylesheets, etc.) while keeping a cached process and/or content.
     *
     * @param block_BlockContext $context
     * @param block_BlockRequest $request
     * @return void
     */
	public function initialize($context, $request)
	{
		$this->disableCache();
	}

	/**
	 * @return comarquage_ComarquageModuleService
	 */
	private function getComarquageModuleService()
	{
		return comarquage_ComarquageModuleService::getInstance();
	}

	/**
	 * @param block_BlockContext $context
	 * @param block_BlockRequest $request
	 * @return String the view name
	 */
	public function execute($context, $request)
	{
		if ($context->inBackofficeMode())
		{
			$status =  sprintf('<br/>Durée du cache : %s, Commune : %s, Département : %s',
					$this->getParameter('nbcachehour', 0),
					$this->getParameter('commune'),
					$this->getParameter('department'));
			$this->setParameter('status', $status);
			return block_BlockView::DUMMY ;
		}


		if(!$this->hasParameter('commune') || !$this->hasParameter('department'))
		{
			Framework::error("Data missing : Block should contains ".f_Locale::translate("&modules.comarquage.backoffice.toolbar.Commune;")." and ".f_Locale::translate("&modules.comarquage.backoffice.toolbar.Department;")." values");
			$this->setParameter('status', f_Locale::translate("&modules.comarquage.backoffice.Error;"));
			return block_BlockView::DUMMY ;
		}

		$nbCacheHour = intval($this->getParameter('nbcachehour', 0));
		$commune = $this->getParameter('commune');
		$department = $this->getParameter('department');

		if (Framework::isDebugEnabled())
		{
			Framework::debug(sprintf('Durée du cache : %s, Commune : %s, Département : %s', $nbCacheHour, $commune, $department));
		}

		define('CACHE_PATH_XML', $this->getComarquageModuleService()->getConfigCachePathValue());
		define('URL_XML', $this->getComarquageModuleService()->getConfigXmlUrlValue());

		$pageComarqUrl = $context->getUrl();

		// check xsl config file
		$configSet = $this->getComarquageModuleService()->checkXslConfig($nbCacheHour, $commune, $department, CACHE_PATH_XML, URL_XML, $pageComarqUrl);
		if($configSet !== true)
		{
			$this->setParameter('status', $configSet);
			return block_BlockView::DUMMY ;
		}

		$request = HttpController::getGlobalContext()->getRequest();
		$paramsArray = array();
		$paramsArray['xml'] 	= 'Themes.xml';
		$paramsArray['xsl'] 	= 'Themes.xsl';

		if($request->hasParameter('xml'))
		{
			$getXml = $request->getParameter('xml');
			if($getXml!='.xml')
			{
				$paramsArray['xml'] = $getXml;
			}
		}
		if($request->hasParameter('xsl') && $getXml!='.xml')
		{
			$paramsArray['xsl'] = $request->getParameter('xsl');
		}

		// not allow MotsCles search because of nearly unsupported feature by service-public.fr
		// moreover, MotsCles.xsl has not be adapted to Change now (may 2007)
		if($paramsArray['xsl'] == 'MotsCles.xsl')
		{
			$paramsArray['xml'] = 'Themes.xml';
			$paramsArray['xsl'] = 'Themes.xsl';
		}

		if($nbCacheHour > 0)
		{
			if (!$this->getComarquageModuleService()->addToCache($paramsArray['xml'], $nbCacheHour))
			{
				$this->setParameter('status', f_Locale::translate("&modules.comarquage.backoffice.Error;"));
				return block_BlockView::DUMMY ;
			}
		}

		global $comarq_error;
		global $comarq_key;

		function handleXslt($errno, $errstr, $errfile, $errline)
		{
			if ($errno==E_WARNING)
			{
				$pos = strpos($errstr,"&quot;");
				if($pos!==false)
				{
					$url = substr($errstr,$pos+strlen('&quot;'),-(strlen('&quot;')));
					if (Framework::isDebugEnabled())
					{

						Framework::debug('errstr : ' . $errstr);
						Framework::debug('handleXslt : ' . $url);
					}
					if(!file_exists($url) && strpos($url, CACHE_PATH_XML) === 0)
					{

						$path = explode('/', $url);
						comarquage_ComarquageModuleService::getInstance()->addToCache(end($path), 1, $GLOBALS['comarq_key']);
					}
					$GLOBALS['comarq_error'] = true;
				}
			}
		}

		set_error_handler('handleXslt');
		$comarq_key = $paramsArray['xml'];

		if($nbCacheHour > 0)
		{
			$file_xml = CACHE_PATH_XML.$paramsArray['xml'];
		}
		else
		{
			$file_xml = URL_XML.$paramsArray['xml'];
		}

		$xslPath = $this->getComarquageModuleService()->getConfigCachePathValue();
		$file_xsl = $xslPath.$paramsArray['xsl'];
		if (Framework::isDebugEnabled())
		{
			Framework::debug("file_xml : $file_xml");
			Framework::debug("file_xsl : $file_xsl");
		}
		do
		{
			unset($content,$xml,$xsl);

			$xml = new DOMDocument();
			$xsl = new XSLTProcessor();

			$xml->load($file_xsl);
			$xsl->importStylesheet($xml);

			$xml->load($file_xml);

			$comarq_error = false;
			$content = $xsl->transformToXml($xml);
		}while ($comarq_error==true); // used to load all xml file needed by the loaded page

		restore_error_handler();

		if($comarq_error!==false)
		{
			return f_Locale::translate("&modules.comarquage.backoffice.Error;");
		}

		$this->setParameter('content', $content);
		return block_BlockView::SUCCESS;
	}
}