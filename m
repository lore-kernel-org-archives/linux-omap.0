From: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Subject: [PATCH] ARM: OMAP: 3430SDP: Fix defconfig
Date: Tue, 23 Jun 2009 11:06:24 -0500
Message-ID: <A24693684029E5489D1D202277BE894441307A75@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42474 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753847AbZFWQEh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Jun 2009 12:04:37 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5NG4YZx001539
	for <linux-omap@vger.kernel.org>; Tue, 23 Jun 2009 11:04:39 -0500
Received: from dlep20.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id n5NG4YnK028498
	for <linux-omap@vger.kernel.org>; Tue, 23 Jun 2009 11:04:34 -0500 (CDT)
Received: from dsbe71.ent.ti.com (localhost [127.0.0.1])
	by dlep20.itg.ti.com (8.12.11/8.12.11) with ESMTP id n5NG4XbB012411
	for <linux-omap@vger.kernel.org>; Tue, 23 Jun 2009 11:04:34 -0500 (CDT)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>

>From 50761c71479cf310313a733fe7bafda9af43e7a0 Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Tue, 23 Jun 2009 10:55:28 -0500
Subject: [PATCH] ARM: OMAP: 3430SDP: Fix defconfig

This patch makes the SDP boot again with the defconfig.

Changes done:

 - Removes other selected boards.
 - Sets the Low Level debug output for UART1.
 - Disables some paripherals from other boards.

Tested on a SDP3430-VE5.1.0 (OMAP3430 ES3.1)

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index 73e0128..8a4a7e2 100644
--- a/arch/arm/configs/omap_3430sdp_defconfig
+++ b/arch/arm/configs/omap_3430sdp_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.29-rc8
-# Fri Mar 13 14:17:01 2009
+# Linux kernel version: 2.6.30-omap1
+# Tue Jun 23 10:36:45 2009
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -197,9 +197,9 @@ CONFIG_OMAP_MCBSP=y
 CONFIG_OMAP_32K_TIMER=y
 CONFIG_OMAP_32K_TIMER_HZ=128
 CONFIG_OMAP_DM_TIMER=y
-# CONFIG_OMAP_LL_DEBUG_UART1 is not set
+CONFIG_OMAP_LL_DEBUG_UART1=y
 # CONFIG_OMAP_LL_DEBUG_UART2 is not set
-CONFIG_OMAP_LL_DEBUG_UART3=y
+# CONFIG_OMAP_LL_DEBUG_UART3 is not set
 CONFIG_OMAP_SERIAL_WAKE=y
 CONFIG_ARCH_OMAP34XX=y
 CONFIG_ARCH_OMAP3430=y
@@ -207,10 +207,10 @@ CONFIG_ARCH_OMAP3430=y
 #
 # OMAP Board Type
 #
-CONFIG_MACH_OMAP3_BEAGLE=y
-CONFIG_MACH_OMAP_LDP=y
-CONFIG_MACH_OVERO=y
-CONFIG_MACH_OMAP3_PANDORA=y
+# CONFIG_MACH_OMAP3_BEAGLE is not set
+# CONFIG_MACH_OMAP_LDP is not set
+# CONFIG_MACH_OVERO is not set
+# CONFIG_MACH_OMAP3_PANDORA is not set
 CONFIG_MACH_OMAP_3430SDP=y
 
 #
@@ -950,7 +950,7 @@ CONFIG_SPI_OMAP24XX=y
 # CONFIG_SPI_TLE62X0 is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
 CONFIG_GPIOLIB=y
-CONFIG_DEBUG_GPIO=y
+# CONFIG_DEBUG_GPIO is not set
 CONFIG_GPIO_SYSFS=y
 
 #
@@ -1405,7 +1405,7 @@ CONFIG_SND_OMAP_SOC=y
 CONFIG_SND_OMAP_SOC_MCBSP=y
 # CONFIG_SND_OMAP_SOC_OVERO is not set
 CONFIG_SND_OMAP_SOC_SDP3430=y
-CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=y
+# CONFIG_SND_OMAP_SOC_OMAP3_PANDORA is not set
 CONFIG_SND_SOC_I2C_AND_SPI=y
 # CONFIG_SND_SOC_ALL_CODECS is not set
 CONFIG_SND_SOC_TWL4030=y
-- 
1.6.3.2

