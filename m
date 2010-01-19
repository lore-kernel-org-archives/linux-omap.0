From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: [PATCH 1/2] OMAP2/3 clock: Extend find_idlest() to pass back idle state value
Date: Tue, 19 Jan 2010 14:50:19 +0530
Message-ID: <1263892819-2330-1-git-send-email-ranjithl@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57732 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751271Ab0ASJU0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jan 2010 04:20:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, ranjithl@ti.com

Current implementation defines clock idle state indicators based on the
cpu information (cpu_is_omap24xx() or cpu_is_omap34xx()) in a system wide
manner. This patch extends the find_idlest() function in clkops to pass
back the idle state indicator for that clock, thus allowing idle state
indicators to be defined on a per clock basis if required.

This is specifically needed on AM35xx devices as the new IPSS clocks
indicates the idle status (0 is idle, 1 is ready) in a way just
opposite to how its handled in OMAP3 (0 is ready, 1 is idle).

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
---
 arch/arm/mach-omap2/clock.c             |   22 ++++++++++++++++++----
 arch/arm/mach-omap2/clock.h             |    2 +-
 arch/arm/mach-omap2/clock2xxx.c         |    7 +++++--
 arch/arm/mach-omap2/clock34xx.c         |   15 ++++++++++++---
 arch/arm/mach-omap2/cm.h                |    3 +++
 arch/arm/mach-omap2/prcm.c              |   14 +++++---------
 arch/arm/plat-omap/include/plat/clock.h |    2 +-
 arch/arm/plat-omap/include/plat/prcm.h  |    2 +-
 8 files changed, 46 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 759c72a..b5cc7b7 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -351,7 +351,8 @@ void omap2_clk_dflt_find_companion(struct clk *clk, void __iomem **other_reg,
  * omap2_clk_dflt_find_idlest - find CM_IDLEST reg va, bit shift for @clk
  * @clk: struct clk * to find IDLEST info for
  * @idlest_reg: void __iomem ** to return the CM_IDLEST va in
- * @idlest_bit: u8 ** to return the CM_IDLEST bit shift in
+ * @idlest_bit: u8 * to return the CM_IDLEST bit shift in
+ * @idlest_val: u8 * to return the idle status indicator
  *
  * Return the CM_IDLEST register address and bit shift corresponding
  * to the module that "owns" this clock.  This default code assumes
@@ -361,13 +362,25 @@ void omap2_clk_dflt_find_companion(struct clk *clk, void __iomem **other_reg,
  * CM_IDLEST2).  This is not true for all modules.  No return value.
  */
 void omap2_clk_dflt_find_idlest(struct clk *clk, void __iomem **idlest_reg,
-				u8 *idlest_bit)
+				u8 *idlest_bit, u8 *idlest_val)
 {
 	u32 r;
 
 	r = (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
 	*idlest_reg = (__force void __iomem *)r;
 	*idlest_bit = clk->enable_bit;
+
+	/*
+	 * 24xx uses 0 to indicate not ready, and 1 to indicate ready.
+	 * 34xx reverses this, just to keep us on our toes
+	 */
+	if (cpu_is_omap24xx())
+		*idlest_val = OMAP24XX_CM_IDLEST_VAL;
+	else if (cpu_is_omap34xx())
+		*idlest_val = OMAP34XX_CM_IDLEST_VAL;
+	else
+		BUG();
+
 }
 
 /**
@@ -384,6 +397,7 @@ static void omap2_module_wait_ready(struct clk *clk)
 {
 	void __iomem *companion_reg, *idlest_reg;
 	u8 other_bit, idlest_bit;
+	u8 idlest_val;
 
 	/* Not all modules have multiple clocks that their IDLEST depends on */
 	if (clk->ops->find_companion) {
@@ -392,9 +406,9 @@ static void omap2_module_wait_ready(struct clk *clk)
 			return;
 	}
 
-	clk->ops->find_idlest(clk, &idlest_reg, &idlest_bit);
+	clk->ops->find_idlest(clk, &idlest_reg, &idlest_bit, &idlest_val);
 
-	omap2_cm_wait_idlest(idlest_reg, (1 << idlest_bit), clk->name);
+	omap2_cm_wait_idlest(idlest_reg, (1 << idlest_bit), idlest_val, clk->name);
 }
 
 int omap2_dflt_clk_enable(struct clk *clk)
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 93c48df..c159503 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -90,7 +90,7 @@ void omap2_dflt_clk_disable(struct clk *clk);
 void omap2_clk_dflt_find_companion(struct clk *clk, void __iomem **other_reg,
 				   u8 *other_bit);
 void omap2_clk_dflt_find_idlest(struct clk *clk, void __iomem **idlest_reg,
-				u8 *idlest_bit);
+				u8 *idlest_bit, u8 *idlest_val);
 
 extern u8 cpu_mask;
 
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index 5420356..9dd5265 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -72,6 +72,7 @@ void __iomem *prcm_clksrc_ctrl;
  * @clk: struct clk * being enabled
  * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
  * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
  *
  * OMAP2430 I2CHS CM_IDLEST bits are in CM_IDLEST1_CORE, but the
  * CM_*CLKEN bits are in CM_{I,F}CLKEN2_CORE.  This custom function
@@ -80,10 +81,12 @@ void __iomem *prcm_clksrc_ctrl;
  */
 static void omap2430_clk_i2chs_find_idlest(struct clk *clk,
 					   void __iomem **idlest_reg,
-					   u8 *idlest_bit)
+					   u8 *idlest_bit,
+					   u8 *idlest_val)
 {
 	*idlest_reg = OMAP_CM_REGADDR(CORE_MOD, CM_IDLEST);
 	*idlest_bit = clk->enable_bit;
+	*idlest_val = OMAP24XX_CM_IDLEST_VAL;
 }
 
 /* 2430 I2CHS has non-standard IDLEST register */
@@ -176,7 +179,7 @@ static int omap2_clk_apll_enable(struct clk *clk, u32 status_mask)
 	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
 
 	omap2_cm_wait_idlest(OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST), status_mask,
-			     clk->name);
+			     OMAP24XX_CM_IDLEST_VAL, clk->name);
 
 	/*
 	 * REVISIT: Should we return an error code if omap2_wait_clock_ready()
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index d4217b9..97752e4 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -59,6 +59,7 @@ struct clk *sdrc_ick_p, *arm_fck_p;
  * @clk: struct clk * being enabled
  * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
  * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
  *
  * The OMAP3430ES2 SSI target CM_IDLEST bit is at a different shift
  * from the CM_{I,F}CLKEN bit.  Pass back the correct info via
@@ -66,13 +67,15 @@ struct clk *sdrc_ick_p, *arm_fck_p;
  */
 static void omap3430es2_clk_ssi_find_idlest(struct clk *clk,
 					    void __iomem **idlest_reg,
-					    u8 *idlest_bit)
+					    u8 *idlest_bit,
+					    u8 *idlest_val)
 {
 	u32 r;
 
 	r = (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
 	*idlest_reg = (__force void __iomem *)r;
 	*idlest_bit = OMAP3430ES2_ST_SSI_IDLE_SHIFT;
+	*idlest_val = OMAP34XX_CM_IDLEST_VAL;
 }
 
 const struct clkops clkops_omap3430es2_ssi_wait = {
@@ -87,6 +90,7 @@ const struct clkops clkops_omap3430es2_ssi_wait = {
  * @clk: struct clk * being enabled
  * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
  * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
  *
  * Some OMAP modules on OMAP3 ES2+ chips have both initiator and
  * target IDLEST bits.  For our purposes, we are concerned with the
@@ -97,7 +101,8 @@ const struct clkops clkops_omap3430es2_ssi_wait = {
  */
 static void omap3430es2_clk_dss_usbhost_find_idlest(struct clk *clk,
 						    void __iomem **idlest_reg,
-						    u8 *idlest_bit)
+						    u8 *idlest_bit,
+						    u8 *idlest_val)
 {
 	u32 r;
 
@@ -105,6 +110,7 @@ static void omap3430es2_clk_dss_usbhost_find_idlest(struct clk *clk,
 	*idlest_reg = (__force void __iomem *)r;
 	/* USBHOST_IDLE has same shift */
 	*idlest_bit = OMAP3430ES2_ST_DSS_IDLE_SHIFT;
+	*idlest_val = OMAP34XX_CM_IDLEST_VAL;
 }
 
 const struct clkops clkops_omap3430es2_dss_usbhost_wait = {
@@ -119,6 +125,7 @@ const struct clkops clkops_omap3430es2_dss_usbhost_wait = {
  * @clk: struct clk * being enabled
  * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
  * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
  *
  * The OMAP3430ES2 HSOTGUSB target CM_IDLEST bit is at a different
  * shift from the CM_{I,F}CLKEN bit.  Pass back the correct info via
@@ -126,13 +133,15 @@ const struct clkops clkops_omap3430es2_dss_usbhost_wait = {
  */
 static void omap3430es2_clk_hsotgusb_find_idlest(struct clk *clk,
 						 void __iomem **idlest_reg,
-						 u8 *idlest_bit)
+						 u8 *idlest_bit,
+						 u8 *idlest_val)
 {
 	u32 r;
 
 	r = (((__force u32)clk->enable_reg & ~0xf0) | 0x20);
 	*idlest_reg = (__force void __iomem *)r;
 	*idlest_bit = OMAP3430ES2_ST_HSOTGUSB_IDLE_SHIFT;
+	*idlest_val = OMAP34XX_CM_IDLEST_VAL;
 }
 
 const struct clkops clkops_omap3430es2_hsotgusb_wait = {
diff --git a/arch/arm/mach-omap2/cm.h b/arch/arm/mach-omap2/cm.h
index 90a4086..be77daa 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -138,5 +138,8 @@ static inline u32 cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
 /* CM_IDLEST_GFX */
 #define OMAP_ST_GFX					(1 << 0)
 
+/* CM_IDLEST indicator */
+#define OMAP24XX_CM_IDLEST_VAL		0
+#define OMAP34XX_CM_IDLEST_VAL		1
 
 #endif
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 3ea8177..3552df7 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -220,26 +220,22 @@ u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
  * omap2_cm_wait_idlest - wait for IDLEST bit to indicate module readiness
  * @reg: physical address of module IDLEST register
  * @mask: value to mask against to determine if the module is active
+ * @idlest: idle state indicator (0 or 1) for the clock
  * @name: name of the clock (for printk)
  *
  * Returns 1 if the module indicated readiness in time, or 0 if it
  * failed to enable in roughly MAX_MODULE_ENABLE_WAIT microseconds.
  */
-int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, const char *name)
+int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
+				const char *name)
 {
 	int i = 0;
 	int ena = 0;
 
-	/*
-	 * 24xx uses 0 to indicate not ready, and 1 to indicate ready.
-	 * 34xx reverses this, just to keep us on our toes
-	 */
-	if (cpu_is_omap24xx())
-		ena = mask;
-	else if (cpu_is_omap34xx())
+	if (idlest)
 		ena = 0;
 	else
-		BUG();
+		ena = mask;
 
 	/* Wait for lock */
 	omap_test_timeout(((__raw_readl(reg) & mask) == ena),
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 94fe2a0..df5072d 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -22,7 +22,7 @@ struct clockdomain;
 struct clkops {
 	int			(*enable)(struct clk *);
 	void			(*disable)(struct clk *);
-	void			(*find_idlest)(struct clk *, void __iomem **, u8 *);
+	void			(*find_idlest)(struct clk *, void __iomem **, u8 *, u8 *);
 	void			(*find_companion)(struct clk *, void __iomem **, u8 *);
 };
 
diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
index e63e94e..329c05a 100644
--- a/arch/arm/plat-omap/include/plat/prcm.h
+++ b/arch/arm/plat-omap/include/plat/prcm.h
@@ -25,7 +25,7 @@
 
 u32 omap_prcm_get_reset_sources(void);
 void omap_prcm_arch_reset(char mode);
-int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, const char *name);
+int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest, const char *name);
 
 #define START_PADCONF_SAVE 0x2
 #define PADCONF_SAVE_DONE  0x1
-- 
1.6.2.4

