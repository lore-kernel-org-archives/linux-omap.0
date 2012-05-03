From: R Sricharan <r.sricharan@ti.com>
Subject: [PATCH 12/13] ARM: OMAP5: Add the build support
Date: Thu, 3 May 2012 12:56:21 +0530
Message-ID: <1336029982-31898-13-git-send-email-r.sricharan@ti.com>
References: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46872 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161Ab2ECH0d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 May 2012 03:26:33 -0400
In-Reply-To: <1336029982-31898-1-git-send-email-r.sricharan@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, tony@atomide.com, b-cousson@ti.com, r.sricharan@ti.com

Adding the build support required for OMAP5 soc
in to omap2+ config.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: R Sricharan <r.sricharan@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 arch/arm/mach-omap2/Kconfig          |   13 ++++++++++++-
 arch/arm/plat-omap/Kconfig           |    4 ++--
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index d5f00d7..8beba1a 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -234,3 +234,5 @@ CONFIG_CRC_T10DIF=y
 CONFIG_CRC_ITU_T=y
 CONFIG_CRC7=y
 CONFIG_LIBCRC32C=y
+CONFIG_ARCH_OMAP5=y
+CONFIG_MACH_OMAP5_SEVM=y
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 8141b76..b50541a 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -9,7 +9,7 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select REGULATOR
 	select PM_RUNTIME
 	select VFP
-	select NEON if ARCH_OMAP3 || ARCH_OMAP4
+	select NEON if ARCH_OMAP3 || ARCH_OMAP4 || ARCH_OMAP5
 	select SERIAL_OMAP
 	select SERIAL_OMAP_CONSOLE
 	select I2C
@@ -55,6 +55,13 @@ config ARCH_OMAP4
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select ARM_CPU_SUSPEND if PM
 
+config ARCH_OMAP5
+	bool "TI OMAP5"
+	depends on ARCH_OMAP2PLUS
+	select CPU_V7
+	select ARM_GIC
+	select HAVE_SMP
+
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
 
@@ -343,6 +350,10 @@ config MACH_OMAP4_PANDA
 	select OMAP_PACKAGE_CBS
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
+config MACH_OMAP5_SEVM
+	bool "OMAP5 sevm Board"
+	depends on ARCH_OMAP5
+
 config OMAP3_EMU
 	bool "OMAP3 debugging peripherals"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index ad95c7a..dcfb506 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -29,7 +29,7 @@ config ARCH_OMAP2PLUS
 	select USE_OF
 	select PROC_DEVICETREE if PROC_FS
 	help
-	  "Systems based on OMAP2, OMAP3 or OMAP4"
+	  "Systems based on OMAP2, OMAP3, OMAP4 or OMAP5"
 
 endchoice
 
@@ -150,7 +150,7 @@ config OMAP_32K_TIMER
 	  This timer saves power compared to the OMAP_MPU_TIMER, and has
 	  support for no tick during idle. The 32KHz timer provides less
 	  intra-tick resolution than OMAP_MPU_TIMER. The 32KHz timer is
-	  currently only available for OMAP16XX, 24XX, 34XX and OMAP4.
+	  currently only available for OMAP16XX, 24XX, 34XX and OMAP4/5.
 
 config OMAP3_L2_AUX_SECURE_SAVE_RESTORE
 	bool "OMAP3 HS/EMU save and restore for L2 AUX control register"
-- 
1.7.1

