From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/10] OMAP3: 3430SDP: Fix defconfig
Date: Wed, 12 Aug 2009 15:16:00 +0300
Message-ID: <20090812121600.17601.16747.stgit@localhost>
References: <20090812120926.17601.85860.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62171 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbZHLMQI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 08:16:08 -0400
In-Reply-To: <20090812120926.17601.85860.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Sergio Aguirre <saaguirre@ti.com>, linux-omap@vger.kernel.org

From: Sergio Aguirre <saaguirre@ti.com>

This patch makes the SDP boot again with the defconfig.

Changes done:

 - Removes other selected boards.
 - Sets the Low Level debug output for UART1.
 - Disables some paripherals from other boards.

Tested on a SDP3430-VE5.1.0 (OMAP3430 ES3.1)

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
index 8fb918d..9a510ea 100644
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
@@ -1370,7 +1370,7 @@ CONFIG_SND_OMAP_SOC=y
 CONFIG_SND_OMAP_SOC_MCBSP=y
 # CONFIG_SND_OMAP_SOC_OVERO is not set
 CONFIG_SND_OMAP_SOC_SDP3430=y
-CONFIG_SND_OMAP_SOC_OMAP3_PANDORA=y
+# CONFIG_SND_OMAP_SOC_OMAP3_PANDORA is not set
 CONFIG_SND_SOC_I2C_AND_SPI=y
 # CONFIG_SND_SOC_ALL_CODECS is not set
 CONFIG_SND_SOC_TWL4030=y

