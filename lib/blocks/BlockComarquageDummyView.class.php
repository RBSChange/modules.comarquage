<?php
class comarquage_BlockComarquageDummyView extends block_BlockView
{
    /**
     * The initialize() method of BlockView is always called,
     * even if the View is cached.
     *
     * This is useful for modifying the block's context (page title,
     * stylesheets, etc.) while keeping a cached process and/or content.
     *
     * @param block_BlockContext $context
     * @param block_BlockRequest $request
     */
    public function initialize($context, $request)
    {
    	$this->disableCache();
    }

	/**
	 * Mandatory execute method...
	 *
	 * @param block_BlockContext $context
	 * @param block_BlockRequest $request
	 */
    public function execute($context, $request)
    {
    	
    	$this->setTemplateName('Comarquage-Block-Comarquage-Dummy');
    	$this->setAttribute('status', $this->getParameter('status'));
    }
}