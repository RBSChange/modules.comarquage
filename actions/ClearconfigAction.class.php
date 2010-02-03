<?php
class comarquage_ClearconfigAction extends f_action_BaseAction
{

	/**
	 * @param Context $context
	 * @param Request $request
	 */
	public function _execute($context, $request)
	{
		$result = comarquage_ComarquageModuleService::getInstance()->clearConfig();
		return $result ? self::getSuccessView() : self::getErrorView();
	}
}