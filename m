From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 10/10] ARM: OMAP5: Enable build and frameowrk initialisations
Date: Fri, 18 Jan 2013 20:57:36 +0530
Message-ID: <1358522856-12180-11-git-send-email-santosh.shilimkar@ti.com>
References: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32942 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab3ARP12 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Jan 2013 10:27:28 -0500
In-Reply-To: <1358522856-12180-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, mturquette@linaro.org, tony@atomide.com, rnayak@ti.com, b-cousson@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>, Paul Walmsley <paul@pwsan.com>

Include the OMAP5 data files in build. Initialise the voltage, power,
clock domains and the clock tree.

Cc: Paul Walmsley <paul@pwsan.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/Makefile |    6 +++++-
 arch/arm/mach-omap2/io.c     |    9 +++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 947cafe..5ab0b7c 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -123,6 +123,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= voltagedomains44xx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(voltagedomain-common)
 obj-$(CONFIG_SOC_AM33XX)                += voltagedomains33xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= $(voltagedomain-common)
+obj-$(CONFIG_SOC_OMAP5)                += voltagedomains54xx_data.o
 
 # OMAP powerdomain framework
 powerdomain-common			+= powerdomain.o powerdomain-common.o
@@ -137,6 +138,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= powerdomains44xx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(powerdomain-common)
 obj-$(CONFIG_SOC_AM33XX)		+= powerdomains33xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= $(powerdomain-common)
+obj-$(CONFIG_SOC_OMAP5)			+= powerdomains54xx_data.o
 
 # PRCM clockdomain control
 clockdomain-common			+= clockdomain.o
@@ -152,6 +154,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= clockdomains44xx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(clockdomain-common)
 obj-$(CONFIG_SOC_AM33XX)		+= clockdomains33xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= $(clockdomain-common)
+obj-$(CONFIG_SOC_OMAP5)			+= clockdomains54xx_data.o
 
 # Clock framework
 obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o
@@ -171,7 +174,7 @@ obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) cclock44xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= dpll3xxx.o dpll44xx.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(clock-common) dpll3xxx.o
 obj-$(CONFIG_SOC_AM33XX)		+= cclock33xx_data.o
-obj-$(CONFIG_SOC_OMAP5)			+= $(clock-common)
+obj-$(CONFIG_SOC_OMAP5)			+= $(clock-common) cclock54xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= dpll3xxx.o dpll44xx.o
 
 # OMAP2 clock rate set data (old "OPP" data)
@@ -194,6 +197,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_2xxx_3xxx_interconnect_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_3xxx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= omap_hwmod_33xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
+obj-$(CONFIG_SOC_OMAP5)			+= omap_hwmod_54xx_data.o
 
 # EMU peripherals
 obj-$(CONFIG_OMAP3_EMU)			+= emu.o
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 2c3fdd6..a1da83e 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -38,6 +38,7 @@
 #include "clock2xxx.h"
 #include "clock3xxx.h"
 #include "clock44xx.h"
+#include "clock54xx.h"
 #include "omap-pm.h"
 #include "sdrc.h"
 #include "control.h"
@@ -618,7 +619,15 @@ void __init omap5_init_early(void)
 	omap2_set_globals_prcm_mpu(OMAP2_L4_IO_ADDRESS(OMAP54XX_PRCM_MPU_BASE));
 	omap_prm_base_init();
 	omap_cm_base_init();
+	omap44xx_prm_init();
 	omap5xxx_check_revision();
+	omap54xx_voltagedomains_init();
+	omap54xx_powerdomains_init();
+	omap54xx_clockdomains_init();
+	omap54xx_hwmod_init();
+	omap_hwmod_init_postsetup();
+	omap5xxx_clk_init();
+
 }
 #endif
 
-- 
1.7.9.5

