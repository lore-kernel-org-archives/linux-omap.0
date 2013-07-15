From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 4/4] arm: omap2plus_defconfig: enable dwc3 and dependencies
Date: Mon, 15 Jul 2013 18:33:43 +0300
Message-ID: <1373902423-28654-5-git-send-email-balbi@ti.com>
References: <1373902423-28654-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53607 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932460Ab3GOPeh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Jul 2013 11:34:37 -0400
In-Reply-To: <1373902423-28654-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Kishon Vijay Abraham I <kishon@ti.com>, Felipe Balbi <balbi@ti.com>

DWC3 enables USB3 functionality for OMAP5 boards,
it's safe to enable those drivers in omap2plus_defconfig.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 5339e6a..aed3cce 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -81,6 +81,7 @@ CONFIG_CMA=y
 CONFIG_CONNECTOR=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_OMAP_OCP2SCP=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
@@ -167,9 +168,11 @@ CONFIG_THERMAL_GOV_USER_SPACE=y
 CONFIG_CPU_THERMAL=y
 CONFIG_OMAP_WATCHDOG=y
 CONFIG_TWL4030_WATCHDOG=y
+CONFIG_MFD_PALMAS=y
 CONFIG_MFD_TPS65217=y
 CONFIG_MFD_TPS65910=y
 CONFIG_TWL6040_CORE=y
+CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_TWL4030=y
 CONFIG_REGULATOR_TPS65023=y
 CONFIG_REGULATOR_TPS6507X=y
@@ -222,10 +225,14 @@ CONFIG_USB_MON=y
 CONFIG_USB_WDM=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_LIBUSUAL=y
+CONFIG_USB_DWC3=m
+CONFIG_USB_DWC3_OMAP=m
 CONFIG_USB_TEST=y
 CONFIG_USB_PHY=y
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_USB_GADGET=y
+CONFIG_OMAP_USB2=y
+CONFIG_OMAP_USB3=y
 CONFIG_USB_GADGET_DEBUG=y
 CONFIG_USB_GADGET_DEBUG_FILES=y
 CONFIG_USB_GADGET_DEBUG_FS=y
@@ -258,6 +265,8 @@ CONFIG_TI_THERMAL=y
 CONFIG_OMAP4_THERMAL=y
 CONFIG_OMAP5_THERMAL=y
 CONFIG_DRA752_THERMAL=y
+CONFIG_EXTCON=y
+CONFIG_EXTCON_PALMAS=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 # CONFIG_EXT3_FS_XATTR is not set
-- 
1.8.2.1

