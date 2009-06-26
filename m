From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP: update OMAP3 Beagle defconfig
Date: Thu, 25 Jun 2009 23:58:26 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0906252357240.2676@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36862 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbZFZF6Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Jun 2009 01:58:24 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jkridner@beagleboard.org


Update the OMAP3 Beagle defconfig to add EHCI, MMC, TWL4030 GPIO support.
Beagle can again use MMC rootfs after this patch.  Tested on BeagleBoard 
rev C2.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Jason Kridner <jkridner@beagleboard.org>
---
 arch/arm/configs/omap3_beagle_defconfig |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
index c4726f0..0c6eee7 100644
--- a/arch/arm/configs/omap3_beagle_defconfig
+++ b/arch/arm/configs/omap3_beagle_defconfig
@@ -236,6 +236,7 @@ CONFIG_ARM_THUMB=y
 # CONFIG_CPU_BPREDICT_DISABLE is not set
 CONFIG_HAS_TLS_REG=y
 # CONFIG_OUTER_CACHE is not set
+CONFIG_COMMON_CLKDEV=y
 
 #
 # Bus support
@@ -713,6 +714,7 @@ CONFIG_GPIOLIB=y
 # CONFIG_GPIO_MAX732X is not set
 # CONFIG_GPIO_PCA953X is not set
 # CONFIG_GPIO_PCF857X is not set
+CONFIG_GPIO_TWL4030=y
 
 #
 # PCI GPIO expanders:
@@ -741,6 +743,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_MFD_SM501 is not set
 # CONFIG_HTC_EGPIO is not set
 # CONFIG_HTC_PASIC3 is not set
+CONFIG_TWL4030_CORE=y
 # CONFIG_UCB1400_CORE is not set
 # CONFIG_MFD_TMIO is not set
 # CONFIG_MFD_T7L66XB is not set
@@ -832,7 +835,7 @@ CONFIG_FONT_8x16=y
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
-# CONFIG_USB_ARCH_HAS_EHCI is not set
+CONFIG_USB_ARCH_HAS_EHCI=y
 CONFIG_USB=y
 # CONFIG_USB_DEBUG is not set
 # CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
@@ -851,6 +854,8 @@ CONFIG_USB_MON=y
 #
 # USB Host Controller Drivers
 #
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
 # CONFIG_USB_C67X00_HCD is not set
 # CONFIG_USB_ISP116X_HCD is not set
 # CONFIG_USB_ISP1760_HCD is not set
@@ -968,6 +973,7 @@ CONFIG_MMC_BLOCK_BOUNCE=y
 #
 # CONFIG_MMC_SDHCI is not set
 # CONFIG_MMC_OMAP is not set
+CONFIG_MMC_OMAP_HS=y
 # CONFIG_MEMSTICK is not set
 # CONFIG_ACCESSIBILITY is not set
 # CONFIG_NEW_LEDS is not set
@@ -1026,10 +1032,11 @@ CONFIG_RTC_INTF_DEV=y
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
-- 
1.6.3.3.334.g916e1

