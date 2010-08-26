From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH 05/11] OMAP: plat-omap: Fix static function warnings
Date: Fri, 27 Aug 2010 02:26:43 +0530
Message-ID: <1282856209-15645-6-git-send-email-manjugk@ti.com>
References: <1282856209-15645-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35374 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752920Ab0HZU6F (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Aug 2010 16:58:05 -0400
In-Reply-To: <1282856209-15645-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

From: Manjunatha GK <manjugk@ti.com>

This patch fixes sparse warnings due non declarations of static functions.

arch/arm/plat-omap/sram.c:130:13: warning: symbol 'omap_detect_sram' was not declared. Should it be static?
arch/arm/plat-omap/sram.c:216:13: warning: symbol 'omap_map_sram' was not declared. Should it be static?
arch/arm/plat-omap/sram.c:348:12: warning: symbol 'omap242x_sram_init' was not declared. Should it be static?
arch/arm/plat-omap/sram.c:369:12: warning: symbol 'omap243x_sram_init' was not declared. Should it be static?
arch/arm/plat-omap/sram.c:425:12: warning: symbol 'omap34xx_sram_init' was not declared. Should it be static?
arch/arm/plat-omap/sram.c:441:12: warning: symbol 'omap44xx_sram_init' was not declared. Should it be static

arch/arm/plat-omap/mcbsp.c:36:6: warning: symbol 'omap_mcbsp_write' was not declared. Should it be static?
arch/arm/plat-omap/mcbsp.c:50:5: warning: symbol 'omap_mcbsp_read' was not declared. Should it be static?
arch/arm/plat-omap/mcbsp.c:65:6: warning: symbol 'omap_mcbsp_st_write' was not declared. Should it be static?
arch/arm/plat-omap/mcbsp.c:70:5: warning: symbol 'omap_mcbsp_st_read' was not declared. Should it be static?
arch/arm/plat-omap/mcbsp.c:1648:15: warning: symbol 'omap_st_add' was not declared. Should it be static?

arch/arm/plat-omap/fb.c:414:15: warning: symbol 'omapfb_reserve_sram' was not declared. Should it be static?
arch/arm/plat-omap/cpu-omap.c:43:5: warning: symbol 'omap_verify_speed' was not declared. Should it be static?
arch/arm/plat-omap/cpu-omap.c:61:14: warning: symbol 'omap_getspeed' was not declared. Should it be static?

Signed-off-by: Manjunatha GK <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
---
 arch/arm/plat-omap/cpu-omap.c |    4 ++--
 arch/arm/plat-omap/fb.c       |    1 +
 arch/arm/plat-omap/mcbsp.c    |   10 +++++-----
 arch/arm/plat-omap/sram.c     |   13 +++++++------
 include/linux/omapfb.h        |    5 +++++
 5 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
index 6d3d333..11c54ec 100644
--- a/arch/arm/plat-omap/cpu-omap.c
+++ b/arch/arm/plat-omap/cpu-omap.c
@@ -40,7 +40,7 @@ static struct clk *mpu_clk;
 
 /* TODO: Add support for SDRAM timing changes */
 
-int omap_verify_speed(struct cpufreq_policy *policy)
+static int omap_verify_speed(struct cpufreq_policy *policy)
 {
 	if (freq_table)
 		return cpufreq_frequency_table_verify(policy, freq_table);
@@ -58,7 +58,7 @@ int omap_verify_speed(struct cpufreq_policy *policy)
 	return 0;
 }
 
-unsigned int omap_getspeed(unsigned int cpu)
+static unsigned int omap_getspeed(unsigned int cpu)
 {
 	unsigned long rate;
 
diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index 0054b95..9a12893 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -421,3 +421,4 @@ unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
 }
 
 #endif
+EXPORT_SYMBOL(omapfb_reserve_sram);
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index e31496e..a81fa35 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -33,7 +33,7 @@
 struct omap_mcbsp **mcbsp_ptr;
 int omap_mcbsp_count, omap_mcbsp_cache_size;
 
-void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
+static void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
 {
 	if (cpu_class_is_omap1()) {
 		((u16 *)mcbsp->reg_cache)[reg / sizeof(u16)] = (u16)val;
@@ -47,7 +47,7 @@ void omap_mcbsp_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
 	}
 }
 
-int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache)
+static int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache)
 {
 	if (cpu_class_is_omap1()) {
 		return !from_cache ? __raw_readw(mcbsp->io_base + reg) :
@@ -62,12 +62,12 @@ int omap_mcbsp_read(struct omap_mcbsp *mcbsp, u16 reg, bool from_cache)
 }
 
 #ifdef CONFIG_ARCH_OMAP3
-void omap_mcbsp_st_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
+static void omap_mcbsp_st_write(struct omap_mcbsp *mcbsp, u16 reg, u32 val)
 {
 	__raw_writel(val, mcbsp->st_data->io_base_st + reg);
 }
 
-int omap_mcbsp_st_read(struct omap_mcbsp *mcbsp, u16 reg)
+static int omap_mcbsp_st_read(struct omap_mcbsp *mcbsp, u16 reg)
 {
 	return __raw_readl(mcbsp->st_data->io_base_st + reg);
 }
@@ -1645,7 +1645,7 @@ static const struct attribute_group sidetone_attr_group = {
 	.attrs = (struct attribute **)sidetone_attrs,
 };
 
-int __devinit omap_st_add(struct omap_mcbsp *mcbsp)
+static int __devinit omap_st_add(struct omap_mcbsp *mcbsp)
 {
 	struct omap_mcbsp_platform_data *pdata = mcbsp->pdata;
 	struct omap_mcbsp_st_data *st_data;
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 226b2e8..f178c2a 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -127,7 +127,7 @@ static int is_sram_locked(void)
  * to secure SRAM will hang the system. Also the SRAM is not
  * yet mapped at this point.
  */
-void __init omap_detect_sram(void)
+static void __init omap_detect_sram(void)
 {
 	unsigned long reserved;
 
@@ -213,7 +213,7 @@ static struct map_desc omap_sram_io_desc[] __initdata = {
 /*
  * Note that we cannot use ioremap for SRAM, as clock init needs SRAM early.
  */
-void __init omap_map_sram(void)
+static void __init omap_map_sram(void)
 {
 	unsigned long base;
 
@@ -345,7 +345,7 @@ u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP2420
-int __init omap242x_sram_init(void)
+static int __init omap242x_sram_init(void)
 {
 	_omap2_sram_ddr_init = omap_sram_push(omap242x_sram_ddr_init,
 					omap242x_sram_ddr_init_sz);
@@ -366,7 +366,7 @@ static inline int omap242x_sram_init(void)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP2430
-int __init omap243x_sram_init(void)
+static int __init omap243x_sram_init(void)
 {
 	_omap2_sram_ddr_init = omap_sram_push(omap243x_sram_ddr_init,
 					omap243x_sram_ddr_init_sz);
@@ -422,7 +422,7 @@ void omap3_sram_restore_context(void)
 }
 #endif /* CONFIG_PM */
 
-int __init omap34xx_sram_init(void)
+static int __init omap34xx_sram_init(void)
 {
 	_omap3_sram_configure_core_dpll =
 		omap_sram_push(omap3_sram_configure_core_dpll,
@@ -438,7 +438,7 @@ static inline int omap34xx_sram_init(void)
 #endif
 
 #ifdef CONFIG_ARCH_OMAP4
-int __init omap44xx_sram_init(void)
+static int __init omap44xx_sram_init(void)
 {
 	printk(KERN_ERR "FIXME: %s not implemented\n", __func__);
 
@@ -469,3 +469,4 @@ int __init omap_sram_init(void)
 
 	return 0;
 }
+EXPORT_SYMBOL(omap_sram_init);
diff --git a/include/linux/omapfb.h b/include/linux/omapfb.h
index c0b0187..059045e 100644
--- a/include/linux/omapfb.h
+++ b/include/linux/omapfb.h
@@ -257,6 +257,11 @@ struct omapfb_platform_data {
 extern void omapfb_set_platform_data(struct omapfb_platform_data *data);
 extern void omapfb_set_ctrl_platform_data(void *pdata);
 extern void omapfb_reserve_sdram_memblock(void);
+extern unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
+				  unsigned long sram_vstart,
+				  unsigned long sram_size,
+				  unsigned long pstart_avail,
+				  unsigned long size_avail);
 
 #endif
 
-- 
1.7.0.4

