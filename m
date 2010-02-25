From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/6] Zoom3: Defconfig update
Date: Thu, 25 Feb 2010 15:03:08 -0800
Message-ID: <20100225230308.26233.67705.stgit@baageli.muru.com>
References: <20100225230116.26233.65157.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:58147 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934451Ab0BYXCF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 18:02:05 -0500
In-Reply-To: <20100225230116.26233.65157.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Manjunatha GK <manjugk@ti.com>, linux-omap@vger.kernel.org

From: manjugk manjugk <manjugk@ti.com>

Some of the features are not enabled by default in zoom3 defconfig.

This patch enables:
 - MMC Resume
 - TWL4030 RTC driver
 - Debug File system

Build and boot tested on Zoom3 board.

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap_zoom3_defconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/omap_zoom3_defconfig b/arch/arm/configs/omap_zoom3_defconfig
index a3e3c82..ff8ac3d 100644
--- a/arch/arm/configs/omap_zoom3_defconfig
+++ b/arch/arm/configs/omap_zoom3_defconfig
@@ -1136,7 +1136,7 @@ CONFIG_TWL4030_USB=y
 # CONFIG_NOP_USB_XCEIV is not set
 CONFIG_MMC=y
 # CONFIG_MMC_DEBUG is not set
-# CONFIG_MMC_UNSAFE_RESUME is not set
+CONFIG_MMC_UNSAFE_RESUME=y
 
 #
 # MMC/SD/SDIO Card Drivers
@@ -1186,7 +1186,7 @@ CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_DRV_PCF8563 is not set
 # CONFIG_RTC_DRV_PCF8583 is not set
 # CONFIG_RTC_DRV_M41T80 is not set
-# CONFIG_RTC_DRV_TWL4030 is not set
+CONFIG_RTC_DRV_TWL4030=y
 # CONFIG_RTC_DRV_S35390A is not set
 # CONFIG_RTC_DRV_FM3130 is not set
 # CONFIG_RTC_DRV_RX8581 is not set
@@ -1416,7 +1416,7 @@ CONFIG_FRAME_WARN=1024
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_STRIP_ASM_SYMS is not set
 # CONFIG_UNUSED_SYMBOLS is not set
-# CONFIG_DEBUG_FS is not set
+CONFIG_DEBUG_FS=y
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set

