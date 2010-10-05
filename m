From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP: hwmod: Handle modules with 16bit registers
Date: Tue, 5 Oct 2010 10:59:44 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1010051058290.13816@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35662 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753245Ab0JEQ7p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 12:59:45 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: rnayak@ti.com, tony@atomide.com, khilman@deeprootsystems.com


From: Rajendra Nayak <rnayak@ti.com>

Some modules which have 16bit registers can cause imprecise
aborts if a __raw_readl/writel is used to read/write 32 bits.

Add an additional flag to identify modules which have such
hard requirement, and handle it in the hwmod framework.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   24 +++++++++++++++---------
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    6 ++++--
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 955861a..5a30658 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -184,7 +184,7 @@ static int _update_sysc_cache(struct omap_hwmod *oh)
 
 	/* XXX ensure module interface clock is up */
 
-	oh->_sysc_cache = omap_hwmod_readl(oh, oh->class->sysc->sysc_offs);
+	oh->_sysc_cache = omap_hwmod_read(oh, oh->class->sysc->sysc_offs);
 
 	if (!(oh->class->sysc->sysc_flags & SYSC_NO_CACHE))
 		oh->_int_flags |= _HWMOD_SYSCONFIG_LOADED;
@@ -211,7 +211,7 @@ static void _write_sysconfig(u32 v, struct omap_hwmod *oh)
 
 	if (oh->_sysc_cache != v) {
 		oh->_sysc_cache = v;
-		omap_hwmod_writel(v, oh, oh->class->sysc->sysc_offs);
+		omap_hwmod_write(v, oh, oh->class->sysc->sysc_offs);
 	}
 }
 
@@ -1133,12 +1133,12 @@ static int _reset(struct omap_hwmod *oh)
 	_write_sysconfig(v, oh);
 
 	if (oh->class->sysc->sysc_flags & SYSS_HAS_RESET_STATUS)
-		omap_test_timeout((omap_hwmod_readl(oh,
+		omap_test_timeout((omap_hwmod_read(oh,
 						    oh->class->sysc->syss_offs)
 				   & SYSS_RESETDONE_MASK),
 				  MAX_MODULE_SOFTRESET_WAIT, c);
 	else if (oh->class->sysc->sysc_flags & SYSC_HAS_RESET_STATUS)
-		omap_test_timeout(!(omap_hwmod_readl(oh,
+		omap_test_timeout(!(omap_hwmod_read(oh,
 						     oh->class->sysc->sysc_offs)
 				   & SYSC_TYPE2_SOFTRESET_MASK),
 				  MAX_MODULE_SOFTRESET_WAIT, c);
@@ -1378,14 +1378,20 @@ static int _setup(struct omap_hwmod *oh, void *data)
 
 /* Public functions */
 
-u32 omap_hwmod_readl(struct omap_hwmod *oh, u16 reg_offs)
+u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs)
 {
-	return __raw_readl(oh->_mpu_rt_va + reg_offs);
+	if (oh->flags & HWMOD_16BIT_REG)
+		return __raw_readw(oh->_mpu_rt_va + reg_offs);
+	else
+		return __raw_readl(oh->_mpu_rt_va + reg_offs);
 }
 
-void omap_hwmod_writel(u32 v, struct omap_hwmod *oh, u16 reg_offs)
+void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs)
 {
-	__raw_writel(v, oh->_mpu_rt_va + reg_offs);
+	if (oh->flags & HWMOD_16BIT_REG)
+		__raw_writew(v, oh->_mpu_rt_va + reg_offs);
+	else
+		__raw_writel(v, oh->_mpu_rt_va + reg_offs);
 }
 
 /**
@@ -1732,7 +1738,7 @@ void omap_hwmod_ocp_barrier(struct omap_hwmod *oh)
 	 * Forces posted writes to complete on the OCP thread handling
 	 * register writes
 	 */
-	omap_hwmod_readl(oh, oh->class->sysc->sysc_offs);
+	omap_hwmod_read(oh, oh->class->sysc->sysc_offs);
 }
 
 /**
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index c1835af..7eaa8ed 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -370,6 +370,7 @@ struct omap_hwmod_omap4_prcm {
  *     This is needed for devices like DSS that require optional clocks enabled
  *     in order to complete the reset. Optional clocks will be disabled
  *     again after the reset.
+ * HWMOD_16BIT_REG: Module has 16bit registers
  */
 #define HWMOD_SWSUP_SIDLE			(1 << 0)
 #define HWMOD_SWSUP_MSTANDBY			(1 << 1)
@@ -379,6 +380,7 @@ struct omap_hwmod_omap4_prcm {
 #define HWMOD_SET_DEFAULT_CLOCKACT		(1 << 5)
 #define HWMOD_NO_IDLEST				(1 << 6)
 #define HWMOD_CONTROL_OPT_CLKS_IN_RESET		(1 << 7)
+#define HWMOD_16BIT_REG				(1 << 8)
 
 /*
  * omap_hwmod._int_flags definitions
@@ -527,8 +529,8 @@ int omap_hwmod_set_slave_idlemode(struct omap_hwmod *oh, u8 idlemode);
 int omap_hwmod_reset(struct omap_hwmod *oh);
 void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
 
-void omap_hwmod_writel(u32 v, struct omap_hwmod *oh, u16 reg_offs);
-u32 omap_hwmod_readl(struct omap_hwmod *oh, u16 reg_offs);
+void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs);
+u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs);
 
 int omap_hwmod_count_resources(struct omap_hwmod *oh);
 int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res);
-- 
1.7.0.4

