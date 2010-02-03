<?php
class comarquage_ClearcacheAction extends f_action_BaseAction
{

	/**
	 * @param Context $context
	 * @param Request $request
	 */
	public function _execute($context, $request)
	{
		$result = comarquage_ComarquageModuleService::getInstance()->clearCache();
		return $result ? self::getSuccessView() : self::getErrorView();

	}
}