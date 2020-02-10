From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: [balbi-usb:testing/next 5/10] drivers/usb/dwc3/dwc3-meson-g12a.c:455
 dwc3_meson_g12a_otg_init() error: uninitialized symbol 'ret'.
Date: Mon, 10 Feb 2020 10:31:10 +0300
Message-ID: <20200210073110.GQ24804@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kbuild-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Hanjie Lin <hanjie.lin-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>
Cc: kbuild-all-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Yue Wang <yue.wang-LpR1jeaWuhtBDgjK7y7TUQ@public.gmane.org>, Martin Blumenstingl <martin.blumenstingl-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git testing/next
head:   b081f1dc121c0bdeacc45cf02c35d1ee95120680
commit: 729149c53f048f16aff9e662bf444c275b59ba8a [5/10] usb: dwc3: Add Amlogic A1 DWC3 glue

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reported-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

smatch warnings:
drivers/usb/dwc3/dwc3-meson-g12a.c:455 dwc3_meson_g12a_otg_init() error: uninitialized symbol 'ret'.

# https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git/commit/?id=729149c53f048f16aff9e662bf444c275b59ba8a
git remote add balbi-usb https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git
git remote update balbi-usb
git checkout 729149c53f048f16aff9e662bf444c275b59ba8a
vim +/ret +455 drivers/usb/dwc3/dwc3-meson-g12a.c

729149c53f048f Hanjie Lin     2020-01-20  411  static int dwc3_meson_g12a_otg_init(struct platform_device *pdev,
729149c53f048f Hanjie Lin     2020-01-20  412  				    struct dwc3_meson_g12a *priv)
729149c53f048f Hanjie Lin     2020-01-20  413  {
729149c53f048f Hanjie Lin     2020-01-20  414  	enum phy_mode otg_id;
729149c53f048f Hanjie Lin     2020-01-20  415  	int ret, irq;
729149c53f048f Hanjie Lin     2020-01-20  416  	struct device *dev = &pdev->dev;
729149c53f048f Hanjie Lin     2020-01-20  417  
729149c53f048f Hanjie Lin     2020-01-20  418  	if (!priv->drvdata->otg_switch_supported)
729149c53f048f Hanjie Lin     2020-01-20  419  		return 0;
729149c53f048f Hanjie Lin     2020-01-20  420  
729149c53f048f Hanjie Lin     2020-01-20  421  	if (priv->otg_mode == USB_DR_MODE_OTG) {
729149c53f048f Hanjie Lin     2020-01-20  422  		/* Ack irq before registering */
729149c53f048f Hanjie Lin     2020-01-20  423  		regmap_update_bits(priv->regmap, USB_R5,
729149c53f048f Hanjie Lin     2020-01-20  424  				   USB_R5_ID_DIG_IRQ, 0);
729149c53f048f Hanjie Lin     2020-01-20  425  
729149c53f048f Hanjie Lin     2020-01-20  426  		irq = platform_get_irq(pdev, 0);
729149c53f048f Hanjie Lin     2020-01-20  427  		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
729149c53f048f Hanjie Lin     2020-01-20  428  						dwc3_meson_g12a_irq_thread,
729149c53f048f Hanjie Lin     2020-01-20  429  						IRQF_ONESHOT, pdev->name, priv);
729149c53f048f Hanjie Lin     2020-01-20  430  		if (ret)
729149c53f048f Hanjie Lin     2020-01-20  431  			return ret;
729149c53f048f Hanjie Lin     2020-01-20  432  	}
729149c53f048f Hanjie Lin     2020-01-20  433  
729149c53f048f Hanjie Lin     2020-01-20  434  	/* Setup OTG mode corresponding to the ID pin */
729149c53f048f Hanjie Lin     2020-01-20  435  	if (priv->otg_mode == USB_DR_MODE_OTG) {
729149c53f048f Hanjie Lin     2020-01-20  436  		otg_id = dwc3_meson_g12a_get_id(priv);
729149c53f048f Hanjie Lin     2020-01-20  437  		if (otg_id != priv->otg_phy_mode) {
729149c53f048f Hanjie Lin     2020-01-20  438  			if (dwc3_meson_g12a_otg_mode_set(priv, otg_id))
729149c53f048f Hanjie Lin     2020-01-20  439  				dev_warn(dev, "Failed to switch OTG mode\n");
729149c53f048f Hanjie Lin     2020-01-20  440  		}
729149c53f048f Hanjie Lin     2020-01-20  441  	}
729149c53f048f Hanjie Lin     2020-01-20  442  
729149c53f048f Hanjie Lin     2020-01-20  443  	/* Setup role switcher */
729149c53f048f Hanjie Lin     2020-01-20  444  	priv->switch_desc.usb2_port = dwc3_meson_g12_find_child(dev,
729149c53f048f Hanjie Lin     2020-01-20  445  								"snps,dwc3");
729149c53f048f Hanjie Lin     2020-01-20  446  	priv->switch_desc.udc = dwc3_meson_g12_find_child(dev, "snps,dwc2");
729149c53f048f Hanjie Lin     2020-01-20  447  	priv->switch_desc.allow_userspace_control = true;
729149c53f048f Hanjie Lin     2020-01-20  448  	priv->switch_desc.set = dwc3_meson_g12a_role_set;
729149c53f048f Hanjie Lin     2020-01-20  449  	priv->switch_desc.get = dwc3_meson_g12a_role_get;
729149c53f048f Hanjie Lin     2020-01-20  450  
729149c53f048f Hanjie Lin     2020-01-20  451  	priv->role_switch = usb_role_switch_register(dev, &priv->switch_desc);
729149c53f048f Hanjie Lin     2020-01-20  452  	if (IS_ERR(priv->role_switch))
729149c53f048f Hanjie Lin     2020-01-20  453  		dev_warn(dev, "Unable to register Role Switch\n");
729149c53f048f Hanjie Lin     2020-01-20  454  
729149c53f048f Hanjie Lin     2020-01-20 @455  	return ret;

"ret" can be uninitialized.  It should be "return 0;" anyway.

729149c53f048f Hanjie Lin     2020-01-20  456  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
