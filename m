From: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [balbi-usb:testing/next 64/67]
 drivers/usb/phy/phy-gpio-vbus-usb.c:200: undefined reference to
 `usb_gadget_vbus_disconnect'
Date: Tue, 7 Jun 2016 01:25:16 +0800
Message-ID: <201606070112.FKJ27Gxt%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="UugvWAfsgieZRqgk"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: kbuild-all-JC7UmRfGjtg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git testing/next
head:   89fe2b5ab11cdf6a67d4492d893e70e330aa7060
commit: 231b31ca34485552fe27e67dc6d30d06079c7648 [64/67] usb: gadget: move gadget API functions to udc-core
config: arm-pxa_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 231b31ca34485552fe27e67dc6d30d06079c7648
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `gpio_vbus_set_peripheral':
>> drivers/usb/phy/phy-gpio-vbus-usb.c:200: undefined reference to `usb_gadget_vbus_disconnect'
   drivers/built-in.o: In function `gpio_vbus_work':
   drivers/usb/phy/phy-gpio-vbus-usb.c:145: undefined reference to `usb_gadget_vbus_disconnect'
>> drivers/usb/phy/phy-gpio-vbus-usb.c:126: undefined reference to `usb_gadget_vbus_connect'

vim +200 drivers/usb/phy/phy-gpio-vbus-usb.c

6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  120  	gpio = pdata->gpio_pullup;
e44694e8 drivers/usb/otg/gpio_vbus.c         Shinya Kuribayashi 2012-05-10  121  
e44694e8 drivers/usb/otg/gpio_vbus.c         Shinya Kuribayashi 2012-05-10  122  	if (vbus) {
662c738d drivers/usb/otg/gpio_vbus.c         Heiko Stübner      2012-02-29  123  		status = USB_EVENT_VBUS;
e47d9254 drivers/usb/phy/phy-gpio-vbus-usb.c Antoine Tenart     2014-10-30  124  		gpio_vbus->phy.otg->state = OTG_STATE_B_PERIPHERAL;
662c738d drivers/usb/otg/gpio_vbus.c         Heiko Stübner      2012-02-29  125  		gpio_vbus->phy.last_event = status;
16bc1bb2 drivers/usb/otg/gpio_vbus.c         Heikki Krogerus    2012-02-13 @126  		usb_gadget_vbus_connect(gpio_vbus->phy.otg->gadget);
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  127  
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  128  		/* drawing a "unit load" is *always* OK, except for OTG */
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  129  		set_vbus_draw(gpio_vbus, 100);
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  130  
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  131  		/* optionally enable D+ pullup */
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  132  		if (gpio_is_valid(gpio))
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  133  			gpio_set_value(gpio, !pdata->gpio_pullup_inverted);
662c738d drivers/usb/otg/gpio_vbus.c         Heiko Stübner      2012-02-29  134  
662c738d drivers/usb/otg/gpio_vbus.c         Heiko Stübner      2012-02-29  135  		atomic_notifier_call_chain(&gpio_vbus->phy.notifier,
662c738d drivers/usb/otg/gpio_vbus.c         Heiko Stübner      2012-02-29  136  					   status, gpio_vbus->phy.otg->gadget);
b20f3f9e drivers/usb/phy/phy-gpio-vbus-usb.c Kiran Raparthy     2014-11-24  137  		usb_phy_set_event(&gpio_vbus->phy, USB_EVENT_ENUMERATED);
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  138  	} else {
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  139  		/* optionally disable D+ pullup */
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  140  		if (gpio_is_valid(gpio))
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  141  			gpio_set_value(gpio, pdata->gpio_pullup_inverted);
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  142  
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  143  		set_vbus_draw(gpio_vbus, 0);
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  144  
16bc1bb2 drivers/usb/otg/gpio_vbus.c         Heikki Krogerus    2012-02-13  145  		usb_gadget_vbus_disconnect(gpio_vbus->phy.otg->gadget);
662c738d drivers/usb/otg/gpio_vbus.c         Heiko Stübner      2012-02-29  146  		status = USB_EVENT_NONE;
e47d9254 drivers/usb/phy/phy-gpio-vbus-usb.c Antoine Tenart     2014-10-30  147  		gpio_vbus->phy.otg->state = OTG_STATE_B_IDLE;
662c738d drivers/usb/otg/gpio_vbus.c         Heiko Stübner      2012-02-29  148  		gpio_vbus->phy.last_event = status;
662c738d drivers/usb/otg/gpio_vbus.c         Heiko Stübner      2012-02-29  149  
662c738d drivers/usb/otg/gpio_vbus.c         Heiko Stübner      2012-02-29  150  		atomic_notifier_call_chain(&gpio_vbus->phy.notifier,
662c738d drivers/usb/otg/gpio_vbus.c         Heiko Stübner      2012-02-29  151  					   status, gpio_vbus->phy.otg->gadget);
b20f3f9e drivers/usb/phy/phy-gpio-vbus-usb.c Kiran Raparthy     2014-11-24  152  		usb_phy_set_event(&gpio_vbus->phy, USB_EVENT_NONE);
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  153  	}
c2344f13 drivers/usb/otg/gpio_vbus.c         Robert Jarzmik     2009-01-24  154  }
c2344f13 drivers/usb/otg/gpio_vbus.c         Robert Jarzmik     2009-01-24  155  
c2344f13 drivers/usb/otg/gpio_vbus.c         Robert Jarzmik     2009-01-24  156  /* VBUS change IRQ handler */
c2344f13 drivers/usb/otg/gpio_vbus.c         Robert Jarzmik     2009-01-24  157  static irqreturn_t gpio_vbus_irq(int irq, void *data)
c2344f13 drivers/usb/otg/gpio_vbus.c         Robert Jarzmik     2009-01-24  158  {
c2344f13 drivers/usb/otg/gpio_vbus.c         Robert Jarzmik     2009-01-24  159  	struct platform_device *pdev = data;
19f9e188 drivers/usb/phy/phy-gpio-vbus-usb.c Jingoo Han         2013-07-30  160  	struct gpio_vbus_mach_info *pdata = dev_get_platdata(&pdev->dev);
c2344f13 drivers/usb/otg/gpio_vbus.c         Robert Jarzmik     2009-01-24  161  	struct gpio_vbus_data *gpio_vbus = platform_get_drvdata(pdev);
16bc1bb2 drivers/usb/otg/gpio_vbus.c         Heikki Krogerus    2012-02-13  162  	struct usb_otg *otg = gpio_vbus->phy.otg;
c2344f13 drivers/usb/otg/gpio_vbus.c         Robert Jarzmik     2009-01-24  163  
c2344f13 drivers/usb/otg/gpio_vbus.c         Robert Jarzmik     2009-01-24  164  	dev_dbg(&pdev->dev, "VBUS %s (gadget: %s)\n",
c2344f13 drivers/usb/otg/gpio_vbus.c         Robert Jarzmik     2009-01-24  165  		is_vbus_powered(pdata) ? "supplied" : "inactive",
16bc1bb2 drivers/usb/otg/gpio_vbus.c         Heikki Krogerus    2012-02-13  166  		otg->gadget ? otg->gadget->name : "none");
c2344f13 drivers/usb/otg/gpio_vbus.c         Robert Jarzmik     2009-01-24  167  
16bc1bb2 drivers/usb/otg/gpio_vbus.c         Heikki Krogerus    2012-02-13  168  	if (otg->gadget)
934ccec4 drivers/usb/otg/gpio_vbus.c         Shinya Kuribayashi 2012-05-10  169  		schedule_delayed_work(&gpio_vbus->work, msecs_to_jiffies(100));
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  170  
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  171  	return IRQ_HANDLED;
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  172  }
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  173  
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  174  /* OTG transceiver interface */
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  175  
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  176  /* bind/unbind the peripheral controller */
16bc1bb2 drivers/usb/otg/gpio_vbus.c         Heikki Krogerus    2012-02-13  177  static int gpio_vbus_set_peripheral(struct usb_otg *otg,
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  178  					struct usb_gadget *gadget)
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  179  {
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  180  	struct gpio_vbus_data *gpio_vbus;
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  181  	struct gpio_vbus_mach_info *pdata;
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  182  	struct platform_device *pdev;
123bbcee drivers/usb/otg/gpio_vbus.c         Shinya Kuribayashi 2012-05-17  183  	int gpio;
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  184  
19c1eac2 drivers/usb/phy/phy-gpio-vbus-usb.c Antoine Tenart     2014-10-30  185  	gpio_vbus = container_of(otg->usb_phy, struct gpio_vbus_data, phy);
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  186  	pdev = to_platform_device(gpio_vbus->dev);
19f9e188 drivers/usb/phy/phy-gpio-vbus-usb.c Jingoo Han         2013-07-30  187  	pdata = dev_get_platdata(gpio_vbus->dev);
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  188  	gpio = pdata->gpio_pullup;
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  189  
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  190  	if (!gadget) {
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  191  		dev_dbg(&pdev->dev, "unregistering gadget '%s'\n",
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  192  			otg->gadget->name);
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  193  
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  194  		/* optionally disable D+ pullup */
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  195  		if (gpio_is_valid(gpio))
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  196  			gpio_set_value(gpio, pdata->gpio_pullup_inverted);
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  197  
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  198  		set_vbus_draw(gpio_vbus, 0);
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  199  
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24 @200  		usb_gadget_vbus_disconnect(otg->gadget);
e47d9254 drivers/usb/phy/phy-gpio-vbus-usb.c Antoine Tenart     2014-10-30  201  		otg->state = OTG_STATE_UNDEFINED;
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  202  
6084f1bf drivers/usb/otg/gpio_vbus.c         Philipp Zabel      2008-11-24  203  		otg->gadget = NULL;

:::::: The code at line 200 was first introduced by commit
:::::: 6084f1bf0c51a99cbba612ee90a4607cffb8b042 USB: otg: gpio_vbus transceiver stub

:::::: TO: Philipp Zabel <philipp.zabel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
:::::: CC: Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--UugvWAfsgieZRqgk
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--UugvWAfsgieZRqgk--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
