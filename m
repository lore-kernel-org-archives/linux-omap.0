From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH] arm: omap2plus_defconfig: enable more drivers
Date: Fri, 25 Oct 2013 09:20:31 -0500
Message-ID: <1382710831-5758-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:32973 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752480Ab3JYOUF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Oct 2013 10:20:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

enable a few more drivers as modules on omap2plus_defconfig,
this helps us getting more platforms working out of the box
by just building omap2plus_defconfig.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Hi Tony,

would you consider enabling these drivers ? I didn't, yet,
make sure that these drivers won't cause PM regressions. Wanted
to make sure you'd be ok enabling so many of them.

cheers

 arch/arm/configs/omap2plus_defconfig | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 98a50c3..6530956 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -134,6 +134,7 @@ CONFIG_KEYBOARD_MATRIX=m
 CONFIG_KEYBOARD_TWL4030=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ADS7846=y
+CONFIG_TOUCHSCREEN_TI_AM335X_TSC=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_TWL4030_PWRBUTTON=y
 # CONFIG_LEGACY_PTYS is not set
@@ -169,6 +170,7 @@ CONFIG_DRA752_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_OMAP_WATCHDOG=y
 CONFIG_TWL4030_WATCHDOG=y
+CONFIG_MFD_TI_AM335X_TSCADC=m
 CONFIG_MFD_PALMAS=y
 CONFIG_MFD_TPS65217=y
 CONFIG_MFD_TPS65910=y
@@ -214,13 +216,21 @@ CONFIG_USB=y
 CONFIG_USB_DEBUG=y
 CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
 CONFIG_USB_MON=y
+CONFIG_USB_MUSB_HDRC=m
+CONFIG_USB_MUSB_TUSB6010=m
+CONFIG_USB_MUSB_OMAP2PLUS=m
+CONFIG_USB_MUSB_AM35X=m
+CONFIG_USB_MUSB_DSPS=m
 CONFIG_USB_WDM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_DWC3=m
+# CONFIG_USB_DWC3_EXYNOS is not set
+CONFIG_USB_DWC3_DEBUG=y
+CONFIG_USB_DWC3_VERBOSE=y
 CONFIG_USB_TEST=y
-CONFIG_NOP_USB_XCEIV=y
 CONFIG_OMAP_USB2=y
 CONFIG_OMAP_USB3=y
+CONFIG_AM335X_PHY_USB=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DEBUG=y
 CONFIG_USB_GADGET_DEBUG_FILES=y
@@ -242,14 +252,28 @@ CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_LEDS_TRIGGER_GPIO=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_PALMAS=m
 CONFIG_RTC_DRV_TWL92330=y
 CONFIG_RTC_DRV_TWL4030=y
+CONFIG_RTC_DRV_TPS65910=m
 CONFIG_RTC_DRV_OMAP=y
 CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
 CONFIG_DMA_OMAP=y
 CONFIG_EXTCON=y
 CONFIG_EXTCON_PALMAS=y
+CONFIG_MEMORY=y
+CONFIG_TI_EMIF=m
+CONFIG_IIO=m
+CONFIG_IIO_BUFFER=y
+CONFIG_IIO_KFIFO_BUF=m
+CONFIG_TI_AM335X_ADC=m
+CONFIG_TWL6030_GPADC=m
+CONFIG_PWM=y
+CONFIG_PWM_TIECAP=m
+CONFIG_PWM_TIEHRPWM=m
+CONFIG_PWM_TWL=m
+CONFIG_PWM_TWL_LED=m
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
-- 
1.8.4.GIT

