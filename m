From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/10] OMAP3: update OMAP3 Beagle defconfig
Date: Wed, 12 Aug 2009 15:24:15 +0300
Message-ID: <20090812122415.17601.44872.stgit@localhost>
References: <20090812120926.17601.85860.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52190 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887AbZHLMYR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 08:24:17 -0400
In-Reply-To: <20090812120926.17601.85860.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, Jason Kridner <jkridner@beagleboard.org>

From: Paul Walmsley <paul@pwsan.com>

Update the OMAP3 Beagle defconfig to add EHCI, MMC, TWL4030 GPIO support.
Beagle can again use MMC rootfs after this patch.  Tested on BeagleBoard
rev C2.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Jason Kridner <jkridner@beagleboard.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap3_beagle_defconfig |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
index 4c6fb7e..264ac2e 100644
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
@@ -787,7 +790,7 @@ CONFIG_DUMMY_CONSOLE=y
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
-# CONFIG_USB_ARCH_HAS_EHCI is not set
+CONFIG_USB_ARCH_HAS_EHCI=y
 CONFIG_USB=y
 # CONFIG_USB_DEBUG is not set
 # CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
@@ -806,6 +809,8 @@ CONFIG_USB_MON=y
 #
 # USB Host Controller Drivers
 #
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
 # CONFIG_USB_C67X00_HCD is not set
 # CONFIG_USB_ISP116X_HCD is not set
 # CONFIG_USB_ISP1760_HCD is not set
@@ -923,6 +928,7 @@ CONFIG_MMC_BLOCK_BOUNCE=y
 #
 # CONFIG_MMC_SDHCI is not set
 # CONFIG_MMC_OMAP is not set
+CONFIG_MMC_OMAP_HS=y
 # CONFIG_MEMSTICK is not set
 # CONFIG_ACCESSIBILITY is not set
 # CONFIG_NEW_LEDS is not set
@@ -981,10 +987,11 @@ CONFIG_RTC_INTF_DEV=y
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

