From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: MUSB regression in 2.6.31-rc6
Date: Sun, 16 Aug 2009 12:02:03 +0300
Message-ID: <20090816090202.GA5726@gandalf>
References: <20090815174352.c2883585.jhnikula@gmail.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB0305398E07@dbde02.ent.ti.com>
 <20090815180701.7710de51.jhnikula@gmail.com>
 <20090815174000.GA13164@nokia.com>
 <20090816104415.e12a5e46.jhnikula@gmail.com>
 <20090816082513.GA22757@gandalf>
 <20090816114731.68a0ffc3.jhnikula@gmail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:37863 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751572AbZHPJCT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Aug 2009 05:02:19 -0400
Content-Disposition: inline
In-Reply-To: <20090816114731.68a0ffc3.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: me@felipebalbi.com, felipe.balbi@nokia.com, "Gadiyar, Anand" <gadiyar@ti.com>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi,

On Sun, Aug 16, 2009 at 11:47:31AM +0300, Jarkko Nikula wrote:
> On Sun, 16 Aug 2009 11:25:14 +0300
> Felipe Balbi <me@felipebalbi.com> wrote:
> 
> > NOP should not be necessary, beagle uses twl4030-usb as its transceiver,
> > unlike evm, which uses isp1504, if I'm not wrong.
> > 
> > Could you try the following patch ?
> > 
> No help but thanks to Koen's hint, I was able to capture the oops. I
> compiled the kernel using your defconfig change and set the DEBUG_LL.

if you:

$ arm-linux-gdb vmlinux
(gdb) l *(musb_platform_suspend + 0x34)

you'll see that ends up in otg_set_suspend()

basically when it checks:

if (otg->set_suspend)

so the problem is still related to the missing otg transceiver

could you printk twl4030_usb_probe() to see what's going on ?

check whether otg_set_transceiver() is being successfully called. The
following will give some hint (maybe)


================= cut here ==========================

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 3487520..6733da9 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -213,6 +213,7 @@ int __init musb_platform_init(struct musb *musb)
 	 * which needs a driver, drivers aren't always needed.
 	 */
 	musb->xceiv = otg_get_transceiver();
+	printk(KERN_INFO "%s: xceiv %p\n", __func__, musb->xceiv);
 	if (!musb->xceiv) {
 		pr_err("HS USB OTG: no transceiver configured\n");
 		return -ENODEV;
diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 9e3e7a5..6d994cf 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -687,6 +687,7 @@ static int __devinit twl4030_usb_probe(struct platform_device *pdev)
 		kfree(twl);
 		return err;
 	}
+	print(KERN_INFO "%s: xceiv %p\n", __func__, &twl->otg);
 	otg_set_transceiver(&twl->otg);
 
 	platform_set_drvdata(pdev, twl);

-- 
balbi
