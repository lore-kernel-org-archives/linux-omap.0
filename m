From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 10/10] OMAP3: update OMAP3 Beagle defconfig, v3
Date: Sun, 16 Aug 2009 18:42:00 +0300
Message-ID: <20090816154154.GC7278@atomide.com>
References: <20090812120926.17601.85860.stgit@localhost> <20090812122415.17601.44872.stgit@localhost> <20090812122710.GA23166@nokia.com> <20090812165258.GM7278@atomide.com> <87d471vti5.fsf@deeprootsystems.com> <20090812191109.GB21001@gandalf> <20090813070233.GP7278@atomide.com> <loom.20090816T011000-32@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cpvLTH7QU4gwfq3S"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:58077 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbZHPPl7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 16 Aug 2009 11:41:59 -0400
Content-Disposition: inline
In-Reply-To: <loom.20090816T011000-32@post.gmane.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eric Witcher <ewitcher@mindspring.com>
Cc: linux-omap@vger.kernel.org


--cpvLTH7QU4gwfq3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

* Eric Witcher <ewitcher@mindspring.com> [090816 04:50]:
> Tony Lindgren <tony <at> atomide.com> writes:
> 
> <snip>
> 
> > I don't have a Beagle, so somebody please check this defconfig and enable
> > PM and OTG if possible.
> > 
> > Tony
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo <at> vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> > 
> Hi,
> 
> I checked this defconfig at it's commit
> 5dc8c8ffb27d93533d71493ca4a419f0290a3b2f
> with the following:
> 
> 1.  Brought omap3_beagle_defconfig forward to  2.6.31-rc5 level.
> (via make gconfig)  
> 
> 2.  Enabled CONFIG_PM, CONFIG_USB_MUSB_OTG, and
>  CONFIG_USB_GADGET_MUSB_HDRC with associated
> default subchoices. (via make gconfig)

Great!
 
> 3.  Removed 1 line work in progress? from arch/arm/mach-omap2/serial.c

Yes, the related change is still in for-next, seem that it's going in
when the merge window opens.
 
> 4.  Added previously posted (but not committed) patch
> for drivers/usb/otg/twl4030-usb.c
> 
> I was able to boot through INIT.
> 

Felipe, can you please check if you have the twl4030-usb.c fix queued up?

> The diffs are against the 2.6.31-rc5 generated
> version of omap3_beagle_defconfig.
> 
> Hope this helps.

Yes, thanks! Updated patch below.

Tony

--cpvLTH7QU4gwfq3S
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="beagle-defconfig-v3.patch"

>From f9356c9b5ca663feb3a985b42d0409da5625d537 Mon Sep 17 00:00:00 2001
From: Paul Walmsley <paul@pwsan.com>
Date: Sun, 16 Aug 2009 18:29:49 +0300
Subject: [PATCH] OMAP3: update OMAP3 Beagle defconfig

Update the OMAP3 Beagle defconfig to add EHCI, MMC, TWL4030 GPIO support.
Beagle can again use MMC rootfs after this patch.  Tested on BeagleBoard
rev C2.

Patch updated to enable PM and OTG options as suggested by
Eric Witcher <ewitcher@mindspring.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Jason Kridner <jkridner@beagleboard.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
index 4c6fb7e..b213e3b 100644
--- a/arch/arm/configs/omap3_beagle_defconfig
+++ b/arch/arm/configs/omap3_beagle_defconfig
@@ -128,6 +128,7 @@ CONFIG_DEFAULT_AS=y
 # CONFIG_DEFAULT_NOOP is not set
 CONFIG_DEFAULT_IOSCHED="anticipatory"
 CONFIG_CLASSIC_RCU=y
+CONFIG_FREEZER=y
 
 #
 # System Type
@@ -236,6 +237,7 @@ CONFIG_ARM_THUMB=y
 # CONFIG_CPU_BPREDICT_DISABLE is not set
 CONFIG_HAS_TLS_REG=y
 # CONFIG_OUTER_CACHE is not set
+CONFIG_COMMON_CLKDEV=y
 
 #
 # Bus support
@@ -317,7 +319,12 @@ CONFIG_BINFMT_MISC=y
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
 
@@ -713,6 +720,7 @@ CONFIG_GPIOLIB=y
 # CONFIG_GPIO_MAX732X is not set
 # CONFIG_GPIO_PCA953X is not set
 # CONFIG_GPIO_PCF857X is not set
+CONFIG_GPIO_TWL4030=y
 
 #
 # PCI GPIO expanders:
@@ -741,6 +749,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_EGPIO is not set
 # CONFIG_HTC_PASIC3 is not set
+CONFIG_TWL4030_CORE=y
 # CONFIG_UCB1400_CORE is not set
 # CONFIG_MFD_TMIO is not set
 # CONFIG_MFD_T7L66XB is not set
@@ -787,7 +796,7 @@ CONFIG_DUMMY_CONSOLE=y
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
-# CONFIG_USB_ARCH_HAS_EHCI is not set
+CONFIG_USB_ARCH_HAS_EHCI=y
 CONFIG_USB=y
 # CONFIG_USB_DEBUG is not set
 # CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
@@ -798,7 +807,8 @@ CONFIG_USB=y
 CONFIG_USB_DEVICEFS=y
 CONFIG_USB_DEVICE_CLASS=y
 # CONFIG_USB_DYNAMIC_MINORS is not set
-# CONFIG_USB_OTG is not set
+CONFIG_USB_SUSPEND=y
+CONFIG_USB_OTG=y
 # CONFIG_USB_OTG_WHITELIST is not set
 # CONFIG_USB_OTG_BLACKLIST_HUB is not set
 CONFIG_USB_MON=y
@@ -806,6 +816,8 @@ CONFIG_USB_MON=y
 #
 # USB Host Controller Drivers
 #
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
 # CONFIG_USB_C67X00_HCD is not set
 # CONFIG_USB_ISP116X_HCD is not set
 # CONFIG_USB_ISP1760_HCD is not set
@@ -818,10 +830,10 @@ CONFIG_USB_MUSB_SOC=y
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
@@ -906,6 +918,15 @@ CONFIG_USB_ETH_RNDIS=y
 # CONFIG_USB_MIDI_GADGET is not set
 # CONFIG_USB_G_PRINTER is not set
 # CONFIG_USB_CDC_COMPOSITE is not set
+
+#
+# OTG and related infrastructure
+#
+CONFIG_USB_OTG_UTILS=y
+# CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_ISP1301_OMAP is not set
+CONFIG_TWL4030_USB=y
+# CONFIG_NOP_USB_XCEIV is not set
 CONFIG_MMC=y
 # CONFIG_MMC_DEBUG is not set
 # CONFIG_MMC_UNSAFE_RESUME is not set
@@ -923,6 +944,7 @@ CONFIG_MMC_BLOCK_BOUNCE=y
 #
 # CONFIG_MMC_SDHCI is not set
 # CONFIG_MMC_OMAP is not set
+CONFIG_MMC_OMAP_HS=y
 # CONFIG_MEMSTICK is not set
 # CONFIG_ACCESSIBILITY is not set
 # CONFIG_NEW_LEDS is not set
@@ -981,10 +1003,11 @@ CONFIG_RTC_INTF_DEV=y
 #
 # Voltage and Current regulators
 #
-# CONFIG_REGULATOR is not set
+CONFIG_REGULATOR=y
 # CONFIG_REGULATOR_FIXED_VOLTAGE is not set
 # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
 # CONFIG_REGULATOR_BQ24022 is not set
+CONFIG_REGULATOR_TWL4030=y
 # CONFIG_UIO is not set
 
 #

--cpvLTH7QU4gwfq3S--
