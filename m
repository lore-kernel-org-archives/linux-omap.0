From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v2 13/14] ARM: OMAP5: Add the build support
Date: Fri, 6 Jul 2012 14:51:54 +0530
Message-ID: <1341566515-22665-14-git-send-email-santosh.shilimkar@ti.com>
References: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43794 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932429Ab2GFJXL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Jul 2012 05:23:11 -0400
In-Reply-To: <1341566515-22665-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, R Sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: R Sricharan <r.sricharan@ti.com>

Adding the build support required for OMAP5 soc
in to omap2+ config.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 arch/arm/mach-omap2/Kconfig          |    8 +++++++-
 arch/arm/plat-omap/Kconfig           |    4 ++--
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 9854ff4..5c90370 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -236,3 +236,4 @@ CONFIG_CRC_T10DIF=y
 CONFIG_CRC_ITU_T=y
 CONFIG_CRC7=y
 CONFIG_LIBCRC32C=y
+CONFIG_SOC_OMAP5=y
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 6c93477..90d0f85 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -9,7 +9,7 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select REGULATOR
 	select PM_RUNTIME
 	select VFP
-	select NEON if ARCH_OMAP3 || ARCH_OMAP4
+	select NEON if ARCH_OMAP3 || ARCH_OMAP4 || SOC_OMAP5
 	select SERIAL_OMAP
 	select SERIAL_OMAP_CONSOLE
 	select I2C
@@ -61,6 +61,12 @@ config ARCH_OMAP4
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select ARM_CPU_SUSPEND if PM
 
+config SOC_OMAP5
+	bool "TI OMAP5"
+	select CPU_V7
+	select ARM_GIC
+	select HAVE_SMP
+
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
 
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
1.7.9.5

