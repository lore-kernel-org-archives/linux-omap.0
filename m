From: "Rajendra Nayak" <rnayak@ti.com>
Subject: [PATCH 02/08] OMAP3 SRF: Add VDD1/VDD2 rate tables for 3430SDP
Date: Mon, 10 Nov 2008 16:58:11 +0530
Message-ID: <00c001c94327$6a211bb0$LocalHost@wipultra1382>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37956 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754486AbYKJL2U convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Nov 2008 06:28:20 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id mAABSCtn001721
	for <linux-omap@vger.kernel.org>; Mon, 10 Nov 2008 05:28:18 -0600
Received: from wipultra1382 (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id mAABSBQt012940
	for <linux-omap@vger.kernel.org>; Mon, 10 Nov 2008 16:58:12 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch adds the MPU/DSP/CORE rate tables for OMAP3430 
SDP board and registers them with the OMAP-PM layer
using the omap_pm_if_init API.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/board-3430sdp.c     |   62 +++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/board-apollon.c     |    2 -
 arch/arm/mach-omap2/board-generic.c     |    2 -
 arch/arm/mach-omap2/board-h4.c          |    2 -
 arch/arm/mach-omap2/board-ldp.c         |    2 -
 arch/arm/mach-omap2/board-n800.c        |    2 -
 arch/arm/mach-omap2/board-omap2evm.c    |    2 -
 arch/arm/mach-omap2/board-omap3beagle.c |    2 -
 arch/arm/mach-omap2/board-omap3evm.c    |    2 -
 arch/arm/mach-omap2/board-overo.c       |    2 -
 arch/arm/mach-omap2/io.c                |    7 ++-
 arch/arm/mach-omap2/pm.h                |   17 ++++++++
 arch/arm/plat-omap/include/mach/io.h    |    6 ++-
 13 files changed, 97 insertions(+), 13 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-3430sdp.c	2008-11-10 15:24:50.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/board-3430sdp.c	2008-11-10 15:26:46.000000000 +0530
@@ -40,12 +40,71 @@
 #include <mach/keypad.h>
 #include <mach/dma.h>
 #include <mach/gpmc.h>
+#include <mach/omap-pm.h>
 
 #include <asm/io.h>
 #include <asm/delay.h>
 #include <mach/control.h>
+#include <mach/clock.h>
 
 #include "sdram-qimonda-hyb18m512160af-6.h"
+#include "pm.h"
+
+/* MPU speeds */
+#define S600M   600000000
+#define S550M   550000000
+#define S500M   500000000
+#define S250M   250000000
+#define S125M   125000000
+
+/* DSP speeds */
+#define S430M   430000000
+#define S400M   400000000
+#define S360M   360000000
+#define S180M   180000000
+#define S90M    90000000
+
+/* L3 speeds */
+#define S83M    83000000
+#define S166M   166000000
+
+static struct omap_opp mpu_rate_table[] = {
+	{0, 0, 0},
+	/*OPP1*/
+	{S125M, VDD1_OPP1, 0},
+	/*OPP2*/
+	{S250M, VDD1_OPP2, 0},
+	/*OPP3*/
+	{S500M, VDD1_OPP3, 0},
+	/*OPP4*/
+	{S550M, VDD1_OPP4, 0},
+	/*OPP5*/
+	{S600M, VDD1_OPP5, 0},
+};
+
+static struct omap_opp l3_rate_table[] = {
+	{0, 0, 0},
+	/*OPP1*/
+	{0, VDD2_OPP1, 0},
+	/*OPP2*/
+	{S83M, VDD2_OPP2, 0},
+	/*OPP3*/
+	{S166M, VDD2_OPP3, 0},
+};
+
+struct omap_opp dsp_rate_table[] = {
+	{0, 0, 0},
+	/*OPP1*/
+	{S90M, VDD1_OPP1, 0},
+	/*OPP2*/
+	{S180M, VDD1_OPP2, 0},
+	/*OPP3*/
+	{S360M, VDD1_OPP3, 0},
+	/*OPP4*/
+	{S400M, VDD1_OPP4, 0},
+	/*OPP5*/
+	{S430M, VDD1_OPP5, 0},
+};
 
 #define CONFIG_DISABLE_HFCLK 1
 
@@ -283,7 +342,8 @@ static inline void __init sdp3430_init_s
 
 static void __init omap_3430sdp_init_irq(void)
 {
-	omap2_init_common_hw(hyb18m512160af6_sdrc_params);
+	omap2_init_common_hw(hyb18m512160af6_sdrc_params, mpu_rate_table,
+			     dsp_rate_table, l3_rate_table);
 	omap_init_irq();
 	omap_gpio_init();
 	sdp3430_init_smc91x();
Index: linux-omap-2.6/arch/arm/mach-omap2/io.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/io.c	2008-11-10 15:24:55.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/io.c	2008-11-10 15:26:46.000000000 +0530
@@ -198,7 +198,10 @@ void __init omap2_map_common_io(void)
 	omapfb_reserve_sdram();
 }
 
-void __init omap2_init_common_hw(struct omap_sdrc_params *sp)
+void __init omap2_init_common_hw(struct omap_sdrc_params *sp,
+				 struct omap_opp *mpu_opps,
+				 struct omap_opp *dsp_opps,
+				 struct omap_opp *l3_opps)
 {
 	omap2_mux_init();
 	omap_pm_if_early_init();
@@ -206,7 +209,7 @@ void __init omap2_init_common_hw(struct 
 	clkdm_init(clockdomains_omap, clkdm_pwrdm_autodeps);
 	omapdev_init(omapdevs);
 	omap2_clk_init();
-	omap_pm_if_init(NULL, NULL, NULL);
+	omap_pm_if_init(mpu_opps, dsp_opps, l3_opps);
 	omap2_sdrc_init(sp);
 	gpmc_init();
 }
Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/io.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/io.h	2008-11-10 15:24:50.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/io.h	2008-11-10 15:26:46.000000000 +0530
@@ -188,12 +188,16 @@
 #define omap_writel(v,a)	__raw_writel(v, IO_ADDRESS(a))
 
 struct omap_sdrc_params;
+struct omap_opp;
 
 extern void omap1_map_common_io(void);
 extern void omap1_init_common_hw(void);
 
 extern void omap2_map_common_io(void);
-extern void omap2_init_common_hw(struct omap_sdrc_params *sp);
+extern void omap2_init_common_hw(struct omap_sdrc_params *sp,
+				 struct omap_opp *mpu_opps,
+				 struct omap_opp *dsp_opps,
+				 struct omap_opp *l3_opps);
 
 #define __arch_ioremap(p,s,t)	omap_ioremap(p,s,t)
 #define __arch_iounmap(v)	omap_iounmap(v)
Index: linux-omap-2.6/arch/arm/mach-omap2/board-apollon.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-apollon.c	2008-11-10 15:24:50.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/board-apollon.c	2008-11-10 15:26:46.000000000 +0530
@@ -323,7 +323,7 @@ out:
 
 static void __init omap_apollon_init_irq(void)
 {
-	omap2_init_common_hw(NULL);
+	omap2_init_common_hw(NULL, NULL, NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	apollon_init_smc91x();
Index: linux-omap-2.6/arch/arm/mach-omap2/board-generic.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-generic.c	2008-11-10 15:24:50.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/board-generic.c	2008-11-10 15:26:46.000000000 +0530
@@ -33,7 +33,7 @@
 
 static void __init omap_generic_init_irq(void)
 {
-	omap2_init_common_hw(NULL);
+	omap2_init_common_hw(NULL, NULL, NULL, NULL);
 	omap_init_irq();
 }
 
Index: linux-omap-2.6/arch/arm/mach-omap2/board-h4.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-h4.c	2008-11-10 15:24:50.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/board-h4.c	2008-11-10 15:26:46.000000000 +0530
@@ -376,7 +376,7 @@ static void __init h4_init_flash(void)
 
 static void __init omap_h4_init_irq(void)
 {
-	omap2_init_common_hw(NULL);
+	omap2_init_common_hw(NULL, NULL, NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	h4_init_flash();
Index: linux-omap-2.6/arch/arm/mach-omap2/board-ldp.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-ldp.c	2008-11-10 15:24:50.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/board-ldp.c	2008-11-10 15:26:46.000000000 +0530
@@ -173,7 +173,7 @@ static struct platform_device *ldp_devic
 
 static void __init omap_ldp_init_irq(void)
 {
-	omap2_init_common_hw(NULL);
+	omap2_init_common_hw(NULL, NULL, NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
Index: linux-omap-2.6/arch/arm/mach-omap2/board-n800.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-n800.c	2008-11-10 15:24:50.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/board-n800.c	2008-11-10 15:26:46.000000000 +0530
@@ -122,7 +122,7 @@ static struct lm8323_platform_data lm832
 
 void __init nokia_n800_init_irq(void)
 {
-	omap2_init_common_hw(NULL);
+	omap2_init_common_hw(NULL, NULL, NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 
Index: linux-omap-2.6/arch/arm/mach-omap2/board-omap2evm.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-omap2evm.c	2008-11-10 15:24:50.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/board-omap2evm.c	2008-11-10 15:26:46.000000000 +0530
@@ -275,7 +275,7 @@ static struct twl4030_keypad_data omap2e
 
 static void __init omap2_evm_init_irq(void)
 {
-	omap2_init_common_hw(NULL);
+	omap2_init_common_hw(NULL, NULL, NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	omap2evm_init_smc911x();
Index: linux-omap-2.6/arch/arm/mach-omap2/board-omap3beagle.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-omap3beagle.c	2008-11-10 15:24:50.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/board-omap3beagle.c	2008-11-10 15:26:46.000000000 +0530
@@ -181,7 +181,7 @@ static int __init omap3_beagle_i2c_init(
 
 static void __init omap3_beagle_init_irq(void)
 {
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL, NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
Index: linux-omap-2.6/arch/arm/mach-omap2/board-omap3evm.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-omap3evm.c	2008-11-10 15:24:50.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/board-omap3evm.c	2008-11-10 15:26:46.000000000 +0530
@@ -217,7 +217,7 @@ struct spi_board_info omap3evm_spi_board
 
 static void __init omap3_evm_init_irq(void)
 {
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL, NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 	omap3evm_init_smc911x();
Index: linux-omap-2.6/arch/arm/mach-omap2/board-overo.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-overo.c	2008-11-10 15:24:50.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/board-overo.c	2008-11-10 15:26:46.000000000 +0530
@@ -182,7 +182,7 @@ static int __init overo_i2c_init(void)
 
 static void __init overo_init_irq(void)
 {
-	omap2_init_common_hw(mt46h32m32lf6_sdrc_params);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params, NULL, NULL, NULL);
 	omap_init_irq();
 	omap_gpio_init();
 }
Index: linux-omap-2.6/arch/arm/mach-omap2/pm.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/pm.h	2008-11-10 15:24:50.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/pm.h	2008-11-10 15:27:23.000000000 +0530
@@ -36,6 +36,23 @@ extern void omap3_pm_off_mode_enable(int
 extern int set_pwrdm_state(struct powerdomain *pwrdm, u32 state);
 
 
+/* VDD1 OPPS */
+#define VDD1_OPP1	0x1
+#define VDD1_OPP2	0x2
+#define VDD1_OPP3	0x3
+#define VDD1_OPP4	0x4
+#define VDD1_OPP5	0x5
+
+/* VDD2 OPPS */
+#define VDD2_OPP1	0x1
+#define VDD2_OPP2	0x2
+#define VDD2_OPP3	0x3
+
+#define MIN_VDD1_OPP	VDD1_OPP1
+#define MAX_VDD1_OPP	VDD1_OPP5
+#define MIN_VDD2_OPP	VDD2_OPP1
+#define MAX_VDD2_OPP	VDD2_OPP3
+
 #ifdef CONFIG_PM_DEBUG
 extern u32 omap2_read_32k_sync_counter(void);
 extern void omap2_pm_dump(int mode, int resume, unsigned int us);

