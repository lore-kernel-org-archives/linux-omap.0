From: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Subject: [PATCH 1/1] ARM: OMAP: SmartReflex driver: enable in omap_3430sdp_defconfig
Date: Tue, 24 Jun 2008 09:43:29 +0300
Message-ID: <1214289809-24098-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:43977 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592AbYFXGnD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jun 2008 02:43:03 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m5O6h093018112
	for <linux-omap@vger.kernel.org>; Tue, 24 Jun 2008 01:43:02 -0500
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>

This patch enables the SmartReflex driver in omap_3430sdp_defconfig. Also removes
obsolete options and adds new previously undefined options as "not set".

Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index 947c25f..df03af3 100644
--- a/arch/arm/configs/omap_3430sdp_defconfig
+++ b/arch/arm/configs/omap_3430sdp_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.26-rc4-omap1
-# Fri May 30 13:43:29 2008
+# Linux kernel version: 2.6.26-rc7-omap1
+# Tue Jun 24 08:42:24 2008
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -170,9 +170,10 @@ CONFIG_ARCH_OMAP3=y
 #
 # OMAP Feature Selections
 #
-CONFIG_OMAP_DEBUG_SRAM_PATCH=y
 # CONFIG_OMAP_DEBUG_POWERDOMAIN is not set
 # CONFIG_OMAP_DEBUG_CLOCKDOMAIN is not set
+CONFIG_OMAP_SMARTREFLEX=y
+# CONFIG_OMAP_SMARTREFLEX_TESTING is not set
 CONFIG_OMAP_RESET_CLOCKS=y
 CONFIG_OMAP_BOOT_TAG=y
 CONFIG_OMAP_BOOT_REASON=y
@@ -1017,6 +1018,7 @@ CONFIG_USB_MON=y
 # CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_IOWARRIOR is not set
 CONFIG_USB_TEST=y
+# CONFIG_USB_ISIGHTFW is not set
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DEBUG=y
 CONFIG_USB_GADGET_DEBUG_FILES=y
-- 
1.5.4.3

