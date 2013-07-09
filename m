From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 11/12] ARM: DRA7: Add the build support in omap2plus
Date: Tue, 9 Jul 2013 13:02:18 +0530
Message-ID: <1373355139-12487-12-git-send-email-rnayak@ti.com>
References: <1373355139-12487-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34132 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753218Ab3GIHdc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Jul 2013 03:33:32 -0400
In-Reply-To: <1373355139-12487-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, khilman@linaro.org, benoit.cousson@gmail.com, r.sricharan@ti.com, ambresh@ti.com, Rajendra Nayak <rnayak@ti.com>

From: R Sricharan <r.sricharan@ti.com>

Now that all the needed pieces for DRA7 based SoCs' is present, enable
the build support in omap2plus_defconfig

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 arch/arm/mach-omap2/Kconfig          |   10 +++++++++-
 arch/arm/plat-omap/Kconfig           |    2 +-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 2ac0ffb..8b17466 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -286,3 +286,4 @@ CONFIG_SOC_OMAP5=y
 CONFIG_TI_DAVINCI_MDIO=y
 CONFIG_TI_DAVINCI_CPDMA=y
 CONFIG_TI_CPSW=y
+CONFIG_SOC_DRA7XX=y
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index bd34483..e85d430 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -36,7 +36,7 @@ config ARCH_OMAP2PLUS_TYPICAL
 	select I2C
 	select I2C_OMAP
 	select MENELAUS if ARCH_OMAP2
-	select NEON if ARCH_OMAP3 || ARCH_OMAP4 || SOC_OMAP5
+	select NEON if CPU_V7
 	select PM_RUNTIME
 	select REGULATOR
 	select TWL4030_CORE if ARCH_OMAP3 || ARCH_OMAP4
@@ -115,6 +115,14 @@ config SOC_OMAP5
 	select COMMON_CLK
 	select HAVE_ARM_ARCH_TIMER
 
+config SOC_DRA7XX
+	bool "TI DRA7XX"
+	select ARM_ARCH_TIMER
+	select CPU_V7
+	select ARM_GIC
+	select HAVE_SMP
+	select COMMON_CLK
+
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
 
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index f82bae2..436ea97 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -106,7 +106,7 @@ config OMAP_32K_TIMER
 	  This timer saves power compared to the OMAP_MPU_TIMER, and has
 	  support for no tick during idle. The 32KHz timer provides less
 	  intra-tick resolution than OMAP_MPU_TIMER. The 32KHz timer is
-	  currently only available for OMAP16XX, 24XX, 34XX and OMAP4/5.
+	  currently only available for OMAP16XX, 24XX, 34XX, OMAP4/5 and DRA7XX.
 
 	  On OMAP2PLUS this value is only used for CONFIG_HZ and
 	  CLOCK_TICK_RATE compile time calculation.
-- 
1.7.9.5

