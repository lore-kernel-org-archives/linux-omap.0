From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 2/2] ARM: DRA7XX: Add support for DRA7XX only build
Date: Fri, 10 Jan 2014 11:57:30 +0200
Message-ID: <1389347850-22435-3-git-send-email-t-kristo@ti.com>
References: <1389347850-22435-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34082 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870AbaAJJ6L (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Jan 2014 04:58:11 -0500
In-Reply-To: <1389347850-22435-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

SOC_DRA7XX was under wrong menu within Kconfig file, which prevented
DRA7XX only build. Fixed the kconfig options for this SoC as we are
there. voltage.c needs to be added to the DRA7XX build also, otherwise
DRA7XX only build will fail.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Kconfig  |   18 ++++++++++--------
 arch/arm/mach-omap2/Makefile |    1 +
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index dc21df1..e65948a 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -76,6 +76,16 @@ config SOC_AM43XX
 	select ARM_GIC
 	select MACH_OMAP_GENERIC
 
+config SOC_DRA7XX
+	bool "TI DRA7XX"
+	depends on ARCH_MULTI_V7
+	select ARCH_OMAP2PLUS
+	select ARM_CPU_SUSPEND if PM
+	select ARM_GIC
+	select CPU_V7
+	select HAVE_SMP
+	select HAVE_ARM_ARCH_TIMER
+
 config ARCH_OMAP2PLUS
 	bool
 	select ARCH_HAS_BANDGAP
@@ -128,14 +138,6 @@ config SOC_HAS_REALTIME_COUNTER
 	depends on SOC_OMAP5 || SOC_DRA7XX
 	default y
 
-config SOC_DRA7XX
-	bool "TI DRA7XX"
-	select ARM_ARCH_TIMER
-	select CPU_V7
-	select ARM_GIC
-	select HAVE_SMP
-	select COMMON_CLK
-
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
 
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 96a990f..8ebe9f3 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -132,6 +132,7 @@ obj-$(CONFIG_SOC_AM33XX)		+= $(voltagedomain-common)
 obj-$(CONFIG_SOC_AM43XX)		+= $(voltagedomain-common)
 obj-$(CONFIG_SOC_OMAP5)			+= $(voltagedomain-common)
 obj-$(CONFIG_SOC_OMAP5)                += voltagedomains54xx_data.o
+obj-$(CONFIG_SOC_DRA7XX)		+= $(voltagedomain-common)
 
 # OMAP powerdomain framework
 powerdomain-common			+= powerdomain.o powerdomain-common.o
-- 
1.7.9.5

