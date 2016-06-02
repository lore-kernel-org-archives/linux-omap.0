From: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [balbi-usb:testing/next 64/67] drivers/usb/phy/phy-generic.c:190:
 undefined reference to `usb_gadget_vbus_connect'
Date: Fri, 3 Jun 2016 05:25:24 +0800
Message-ID: <201606030518.fZBFoV7P%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git testing/next
head:   327475d7f63aa161bdc3bf7f9d693d9aafcd4518
commit: bcf4420283d1338b39773be8b487563c90986959 [64/67] usb: gadget: move gadget API functions to udc-core
config: arm-mvebu_v7_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout bcf4420283d1338b39773be8b487563c90986959
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the balbi-usb/testing/next HEAD 327475d7f63aa161bdc3bf7f9d693d9aafcd4518 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `nop_set_peripheral':
>> drivers/usb/phy/phy-generic.c:190: undefined reference to `usb_gadget_vbus_connect'
   drivers/built-in.o: In function `nop_gpio_vbus_thread':
   drivers/usb/phy/phy-generic.c:122: undefined reference to `usb_gadget_vbus_connect'
>> drivers/usb/phy/phy-generic.c:133: undefined reference to `usb_gadget_vbus_disconnect'

vim +190 drivers/usb/phy/phy-generic.c

7acc9973e drivers/usb/phy/phy-generic.c   Robert Jarzmik            2014-12-06  127  		atomic_notifier_call_chain(&nop->phy.notifier, status,
7acc9973e drivers/usb/phy/phy-generic.c   Robert Jarzmik            2014-12-06  128  					   otg->gadget);
7acc9973e drivers/usb/phy/phy-generic.c   Robert Jarzmik            2014-12-06  129  	} else {
7acc9973e drivers/usb/phy/phy-generic.c   Robert Jarzmik            2014-12-06  130  		nop_set_vbus_draw(nop, 0);
7acc9973e drivers/usb/phy/phy-generic.c   Robert Jarzmik            2014-12-06  131  
2eafe93b9 drivers/usb/phy/phy-generic.c   Maarten ter Huurne        2016-02-28  132  		if (otg->gadget)
7acc9973e drivers/usb/phy/phy-generic.c   Robert Jarzmik            2014-12-06 @133  			usb_gadget_vbus_disconnect(otg->gadget);
7acc9973e drivers/usb/phy/phy-generic.c   Robert Jarzmik            2014-12-06  134  		status = USB_EVENT_NONE;
7acc9973e drivers/usb/phy/phy-generic.c   Robert Jarzmik            2014-12-06  135  		otg->state = OTG_STATE_B_IDLE;
7acc9973e drivers/usb/phy/phy-generic.c   Robert Jarzmik            2014-12-06  136  		nop->phy.last_event = status;
7acc9973e drivers/usb/phy/phy-generic.c   Robert Jarzmik            2014-12-06  137  
7acc9973e drivers/usb/phy/phy-generic.c   Robert Jarzmik            2014-12-06  138  		atomic_notifier_call_chain(&nop->phy.notifier, status,
7acc9973e drivers/usb/phy/phy-generic.c   Robert Jarzmik            2014-12-06  139  					   otg->gadget);
7acc9973e drivers/usb/phy/phy-generic.c   Robert Jarzmik            2014-12-06  140  	}
7acc9973e drivers/usb/phy/phy-generic.c   Robert Jarzmik            2014-12-06  141  	return IRQ_HANDLED;
7acc9973e drivers/usb/phy/phy-generic.c   Robert Jarzmik            2014-12-06  142  }
7acc9973e drivers/usb/phy/phy-generic.c   Robert Jarzmik            2014-12-06  143  
53b6fc28e drivers/usb/phy/phy-generic.c   Sebastian Andrzej Siewior 2013-07-30  144  int usb_gen_phy_init(struct usb_phy *phy)
2319fb88e drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  145  {
4525beeb9 drivers/usb/phy/phy-generic.c   Felipe Balbi              2014-04-16  146  	struct usb_phy_generic *nop = dev_get_drvdata(phy->dev);
2319fb88e drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  147  
58f735fe4 drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  148  	if (!IS_ERR(nop->vcc)) {
58f735fe4 drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  149  		if (regulator_enable(nop->vcc))
58f735fe4 drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  150  			dev_err(phy->dev, "Failed to enable power\n");
58f735fe4 drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  151  	}
58f735fe4 drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  152  
2319fb88e drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  153  	if (!IS_ERR(nop->clk))
4d175f340 drivers/usb/phy/phy-generic.c   Mark Brown                2013-08-11  154  		clk_prepare_enable(nop->clk);
2319fb88e drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  155  
168bdb88c drivers/usb/phy/phy-generic.c   Fabio Estevam             2015-02-03  156  	nop_reset(nop);
ad63ebfc3 drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  157  
2319fb88e drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  158  	return 0;
2319fb88e drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  159  }
53b6fc28e drivers/usb/phy/phy-generic.c   Sebastian Andrzej Siewior 2013-07-30  160  EXPORT_SYMBOL_GPL(usb_gen_phy_init);
2319fb88e drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  161  
53b6fc28e drivers/usb/phy/phy-generic.c   Sebastian Andrzej Siewior 2013-07-30  162  void usb_gen_phy_shutdown(struct usb_phy *phy)
2319fb88e drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  163  {
4525beeb9 drivers/usb/phy/phy-generic.c   Felipe Balbi              2014-04-16  164  	struct usb_phy_generic *nop = dev_get_drvdata(phy->dev);
2319fb88e drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  165  
168bdb88c drivers/usb/phy/phy-generic.c   Fabio Estevam             2015-02-03  166  	gpiod_set_value(nop->gpiod_reset, 1);
ad63ebfc3 drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  167  
2319fb88e drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  168  	if (!IS_ERR(nop->clk))
4d175f340 drivers/usb/phy/phy-generic.c   Mark Brown                2013-08-11  169  		clk_disable_unprepare(nop->clk);
58f735fe4 drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  170  
58f735fe4 drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  171  	if (!IS_ERR(nop->vcc)) {
58f735fe4 drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  172  		if (regulator_disable(nop->vcc))
58f735fe4 drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  173  			dev_err(phy->dev, "Failed to disable power\n");
58f735fe4 drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  174  	}
2319fb88e drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  175  }
53b6fc28e drivers/usb/phy/phy-generic.c   Sebastian Andrzej Siewior 2013-07-30  176  EXPORT_SYMBOL_GPL(usb_gen_phy_shutdown);
2319fb88e drivers/usb/otg/nop-usb-xceiv.c Roger Quadros             2013-03-12  177  
41adf1093 drivers/usb/otg/nop-usb-xceiv.c Heikki Krogerus           2012-02-13  178  static int nop_set_peripheral(struct usb_otg *otg, struct usb_gadget *gadget)
f6d92a05c drivers/usb/otg/nop-usb-xceiv.c Ajay Kumar Gupta          2009-02-06  179  {
41adf1093 drivers/usb/otg/nop-usb-xceiv.c Heikki Krogerus           2012-02-13  180  	if (!otg)
f6d92a05c drivers/usb/otg/nop-usb-xceiv.c Ajay Kumar Gupta          2009-02-06  181  		return -ENODEV;
f6d92a05c drivers/usb/otg/nop-usb-xceiv.c Ajay Kumar Gupta          2009-02-06  182  
f6d92a05c drivers/usb/otg/nop-usb-xceiv.c Ajay Kumar Gupta          2009-02-06  183  	if (!gadget) {
41adf1093 drivers/usb/otg/nop-usb-xceiv.c Heikki Krogerus           2012-02-13  184  		otg->gadget = NULL;
f6d92a05c drivers/usb/otg/nop-usb-xceiv.c Ajay Kumar Gupta          2009-02-06  185  		return -ENODEV;
f6d92a05c drivers/usb/otg/nop-usb-xceiv.c Ajay Kumar Gupta          2009-02-06  186  	}
f6d92a05c drivers/usb/otg/nop-usb-xceiv.c Ajay Kumar Gupta          2009-02-06  187  
41adf1093 drivers/usb/otg/nop-usb-xceiv.c Heikki Krogerus           2012-02-13  188  	otg->gadget = gadget;
2eafe93b9 drivers/usb/phy/phy-generic.c   Maarten ter Huurne        2016-02-28  189  	if (otg->state == OTG_STATE_B_PERIPHERAL)
2eafe93b9 drivers/usb/phy/phy-generic.c   Maarten ter Huurne        2016-02-28 @190  		usb_gadget_vbus_connect(gadget);
2eafe93b9 drivers/usb/phy/phy-generic.c   Maarten ter Huurne        2016-02-28  191  	else
e47d92545 drivers/usb/phy/phy-generic.c   Antoine Tenart            2014-10-30  192  		otg->state = OTG_STATE_B_IDLE;
f6d92a05c drivers/usb/otg/nop-usb-xceiv.c Ajay Kumar Gupta          2009-02-06  193  	return 0;

:::::: The code at line 190 was first introduced by commit
:::::: 2eafe93b92921308b624466b4c8a99bd1ace6e4f usb: phy: generic: Handle late registration of gadget

:::::: TO: Maarten ter Huurne <maarten-Ph2Y2OKCxY1M656bX5wj8A@public.gmane.org>
:::::: CC: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--oyUTqETQ0mS9luUI
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--oyUTqETQ0mS9luUI--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
