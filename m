From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [PATCH] OMAP: config : disable the usb host configuration in omap2plus_defconfig
Date: Fri, 6 Jul 2012 17:19:40 +0530
Message-ID: <1341575380-11972-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46116 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030231Ab2GFLuB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Jul 2012 07:50:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, sameo@linux.intel.com, parthab@india.ti.com

The usb host is disabled in the omap2 build; This is because
usb host is causing the retention to break in cpu idle.

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 9854ff4..7b32da6 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -170,17 +170,6 @@ CONFIG_SND_USB_AUDIO=m
 CONFIG_SND_SOC=m
 CONFIG_SND_OMAP_SOC=m
 CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=m
-CONFIG_USB=y
-CONFIG_USB_DEBUG=y
-CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
-CONFIG_USB_DEVICEFS=y
-CONFIG_USB_SUSPEND=y
-CONFIG_USB_MON=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_WDM=y
-CONFIG_USB_STORAGE=y
-CONFIG_USB_LIBUSUAL=y
-CONFIG_USB_TEST=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DEBUG=y
 CONFIG_USB_GADGET_DEBUG_FILES=y
-- 
1.7.9.5

