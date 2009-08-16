From: Eric Witcher <ewitcher@mindspring.com>
Subject: Re: [PATCH 10/10] OMAP3: update OMAP3 Beagle defconfig, v2
Date: Sun, 16 Aug 2009 01:48:30 +0000 (UTC)
Message-ID: <loom.20090816T011000-32@post.gmane.org>
References: <20090812120926.17601.85860.stgit@localhost> <20090812122415.17601.44872.stgit@localhost> <20090812122710.GA23166@nokia.com> <20090812165258.GM7278@atomide.com> <87d471vti5.fsf@deeprootsystems.com> <20090812191109.GB21001@gandalf> <20090813070233.GP7278@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:41756 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751392AbZHPBuJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 15 Aug 2009 21:50:09 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1McUsl-0000jn-0X
	for linux-omap@vger.kernel.org; Sun, 16 Aug 2009 01:50:03 +0000
Received: from dialup-4.154.93.152.Dial1.Atlanta1.Level3.net ([4.154.93.152])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sun, 16 Aug 2009 01:50:02 +0000
Received: from ewitcher by dialup-4.154.93.152.Dial1.Atlanta1.Level3.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Sun, 16 Aug 2009 01:50:02 +0000
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Tony Lindgren <tony <at> atomide.com> writes:

<snip>

> I don't have a Beagle, so somebody please check this defconfig and enable
> PM and OTG if possible.
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
Hi,

I checked this defconfig at it's commit
5dc8c8ffb27d93533d71493ca4a419f0290a3b2f
with the following:

1.  Brought omap3_beagle_defconfig forward to  2.6.31-rc5 level.
(via make gconfig)  

2.  Enabled CONFIG_PM, CONFIG_USB_MUSB_OTG, and
 CONFIG_USB_GADGET_MUSB_HDRC with associated
default subchoices. (via make gconfig)

3.  Removed 1 line work in progress? from arch/arm/mach-omap2/serial.c

4.  Added previously posted (but not committed) patch
for drivers/usb/otg/twl4030-usb.c

I was able to boot through INIT.

The diffs are against the 2.6.31-rc5 generated
version of omap3_beagle_defconfig.

Hope this helps.

diff --git a/arch/arm/configs/omap3_beagle_defconfig
b/arch/arm/configs/omap3_beagle_defconfig
index 59eaf8c..3c001e5 100644
--- a/arch/arm/configs/omap3_beagle_defconfig
+++ b/arch/arm/configs/omap3_beagle_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.31-rc5
-# Sat Aug 15 19:12:37 2009
+# Sat Aug 15 20:05:10 2009
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -136,7 +136,7 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
-# CONFIG_FREEZER is not set
+CONFIG_FREEZER=y
 
 #
 # System Type
@@ -338,7 +338,12 @@ CONFIG_BINFMT_MISC=y
 #
 # Power management options
 #
-# CONFIG_PM is not set
+CONFIG_PM=y
+# CONFIG_PM_DEBUG is not set
+CONFIG_PM_SLEEP=y
+CONFIG_SUSPEND=y
+CONFIG_SUSPEND_FREEZER=y
+# CONFIG_APM_EMULATION is not set
 CONFIG_ARCH_SUSPEND_POSSIBLE=y
 CONFIG_NET=y
 
@@ -829,7 +834,8 @@ CONFIG_USB=y
 CONFIG_USB_DEVICEFS=y
 CONFIG_USB_DEVICE_CLASS=y
 # CONFIG_USB_DYNAMIC_MINORS is not set
-# CONFIG_USB_OTG is not set
+CONFIG_USB_SUSPEND=y
+CONFIG_USB_OTG=y
 # CONFIG_USB_OTG_WHITELIST is not set
 # CONFIG_USB_OTG_BLACKLIST_HUB is not set
 CONFIG_USB_MON=y
@@ -853,10 +859,10 @@ CONFIG_USB_MUSB_SOC=y
 #
 # OMAP 343x high speed USB support
 #
-CONFIG_USB_MUSB_HOST=y
+# CONFIG_USB_MUSB_HOST is not set
 # CONFIG_USB_MUSB_PERIPHERAL is not set
-# CONFIG_USB_MUSB_OTG is not set
-# CONFIG_USB_GADGET_MUSB_HDRC is not set
+CONFIG_USB_MUSB_OTG=y
+CONFIG_USB_GADGET_MUSB_HDRC=y
 CONFIG_USB_MUSB_HDRC_HCD=y
 # CONFIG_MUSB_PIO_ONLY is not set
 CONFIG_USB_INVENTRA_DMA=y
@@ -931,8 +937,7 @@ CONFIG_USB_GADGET_SELECTED=y
 # CONFIG_USB_GADGET_S3C_HSOTG is not set
 # CONFIG_USB_GADGET_IMX is not set
 # CONFIG_USB_GADGET_S3C2410 is not set
-CONFIG_USB_GADGET_M66592=y
-CONFIG_USB_M66592=y
+# CONFIG_USB_GADGET_M66592 is not set
 # CONFIG_USB_GADGET_AMD5536UDC is not set
 # CONFIG_USB_GADGET_FSL_QE is not set
 # CONFIG_USB_GADGET_CI13XXX is not set
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 3f29376..bd9e2b2 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -429,7 +429,6 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 		omap_ctrl_writew(v, uart->padconf);
 	}
 
-	p->irqflags |= IRQF_SHARED;
 	ret = request_irq(p->irq, omap_uart_interrupt, IRQF_SHARED,
 			  "serial idle", (void *)uart);
 	WARN_ON(ret);
diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 9e3e7a5..d1852d4 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -774,7 +774,7 @@ static int __init twl4030_usb_init(void)
 {
 	return platform_driver_register(&twl4030_usb_driver);
 }
-subsys_initcall(twl4030_usb_init);
+subsys_initcall_sync(twl4030_usb_init);
 
 static void __exit twl4030_usb_exit(void)
 {












