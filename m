From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 08/19] OMAP2/3 clock: Extend find_idlest() to pass back idle
	state value
Date: Mon, 15 Feb 2010 18:24:49 -0700
Message-ID: <20100216012448.1101.20485.stgit@localhost.localdomain>
References: <20100216011942.1101.14348.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:57416 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932491Ab0BPB06 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 20:26:58 -0500
In-Reply-To: <20100216011942.1101.14348.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Ranjith Lohithakshan <ranjithl@ti.com>

From: Ranjith Lohithakshan <ranjithl@ti.com>

Current implementation defines clock idle state indicators based on the
cpu information (cpu_is_omap24xx() or cpu_is_omap34xx()) in a system wide
manner. This patch extends the find_idlest() function in clkops to pass
back the idle state indicator for that clock, thus allowing idle state
indicators to be defined on a per clock basis if required.

This is specifically needed on AM35xx devices as the new IPSS clocks
indicates the idle status (0 is idle, 1 is ready) in a way just
opposite to how its handled in OMAP3 (0 is ready, 1 is idle).

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
[paul@pwsan.com: updated to apply after commit 98c45457 et seq.]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clkt2xxx_apll.c     |    2 +-
 arch/arm/mach-omap2/clock.c             |   25 ++++++++++++++++++++-----
 arch/arm/mach-omap2/clock.h             |    2 +-
 arch/arm/mach-omap2/clock2xxx.c         |    5 ++++-
 arch/arm/mach-omap2/clock34xx.c         |   15 ++++++++++++---
 arch/arm/mach-omap2/cm.h                |    3 +++
 arch/arm/mach-omap2/prcm.c              |   14 +++++---------
 arch/arm/plat-omap/include/plat/clock.h |    6 ++++--
 arch/arm/plat-omap/include/plat/prcm.h  |    3 ++-
 9 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt2xxx_apll.c b/arch/arm/mach-omap2/clkt2xxx_apll.c
index fc32ff8..d5b8b2b 100644
--- a/arch/arm/mach-omap2/clkt2xxx_apll.c
+++ b/arch/arm/mach-omap2/clkt2xxx_apll.c
@@ -57,7 +57,7 @@ static int omap2_clk_apll_enable(struct clk *clk, u32 status_mask)
 	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
 
 	omap2_cm_wait_idlest(OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST), status_mask,
-			     clk->name);
+			     OMAP24XX_CM_IDLEST_VAL, clk->name);
 
 	/*
 	 * REVISIT: Should we return an error code if omap2_wait_clock_ready()
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 999b91e..3bb3292 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -57,7 +57,7 @@ u8 cpu_mask;
 static void _omap2_module_wait_ready(struct clk *clk)
 {
 	void __iomem *companion_reg, *idlest_reg;
-	u8 other_bit, idlest_bit;
+	u8 other_bit, idlest_bit, idlest_val;
 
 	/* Not all modules have multiple clocks that their IDLEST depends on */
 	if (clk->ops->find_companion) {
@@ -66,9 +66,10 @@ static void _omap2_module_wait_ready(struct clk *clk)
 			return;
 	}
 
-	clk->ops->find_idlest(clk, &idlest_reg, &idlest_bit);
+	clk->ops->find_idlest(clk, &idlest_reg, &idlest_bit, &idlest_val);
 
-	omap2_cm_wait_idlest(idlest_reg, (1 << idlest_bit), clk->name);
+	omap2_cm_wait_idlest(idlest_reg, (1 << idlest_bit), idlest_val,
+			     clk->name);
 }
 
 /* Enables clock without considering parent dependencies or use count
@@ -175,7 +176,8 @@ void omap2_clk_dflt_find_companion(struct clk *clk, void __iomem **other_reg,
  * omap2_clk_dflt_find_idlest - find CM_IDLEST reg va, bit shift for @clk
  * @clk: struct clk * to find IDLEST info for
  * @idlest_reg: void __iomem ** to return the CM_IDLEST va in
- * @idlest_bit: u8 ** to return the CM_IDLEST bit shift in
+ * @idlest_bit: u8 * to return the CM_IDLEST bit shift in
+ * @idlest_val: u8 * to return the idle status indicator
  *
  * Return the CM_IDLEST register address and bit shift corresponding
  * to the module that "owns" this clock.  This default code assumes
@@ -185,13 +187,26 @@ void omap2_clk_dflt_find_companion(struct clk *clk, void __iomem **other_reg,
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
+	 * AM35xx uses both, depending on the module.
+	 */
+	if (cpu_is_omap24xx())
+		*idlest_val = OMAP24XX_CM_IDLEST_VAL;
+	else if (cpu_is_omap34xx())
+		*idlest_val = OMAP34XX_CM_IDLEST_VAL;
+	else
+		BUG();
+
 }
 
 int omap2_dflt_clk_enable(struct clk *clk)
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 7bc344b..c500a5f 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -88,7 +88,7 @@ void omap2_dflt_clk_disable(struct clk *clk);
 void omap2_clk_dflt_find_companion(struct clk *clk, void __iomem **other_reg,
 				   u8 *other_bit);
 void omap2_clk_dflt_find_idlest(struct clk *clk, void __iomem **idlest_reg,
-				u8 *idlest_bit);
+				u8 *idlest_bit, u8 *idlest_val);
 void omap2xxx_clk_commit(struct clk *clk);
 
 extern u8 cpu_mask;
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index a48b01a..94fb8a6 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -42,6 +42,7 @@ struct clk *vclk, *sclk, *dclk;
  * @clk: struct clk * being enabled
  * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
  * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
  *
  * OMAP2430 I2CHS CM_IDLEST bits are in CM_IDLEST1_CORE, but the
  * CM_*CLKEN bits are in CM_{I,F}CLKEN2_CORE.  This custom function
@@ -50,10 +51,12 @@ struct clk *vclk, *sclk, *dclk;
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
 
 #else
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 1f1b5a6..d339d2b 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -47,6 +47,7 @@ struct clk *sdrc_ick_p, *arm_fck_p;
  * @clk: struct clk * being enabled
  * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
  * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
  *
  * The OMAP3430ES2 SSI target CM_IDLEST bit is at a different shift
  * from the CM_{I,F}CLKEN bit.  Pass back the correct info via
@@ -54,13 +55,15 @@ struct clk *sdrc_ick_p, *arm_fck_p;
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
@@ -75,6 +78,7 @@ const struct clkops clkops_omap3430es2_ssi_wait = {
  * @clk: struct clk * being enabled
  * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
  * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
  *
  * Some OMAP modules on OMAP3 ES2+ chips have both initiator and
  * target IDLEST bits.  For our purposes, we are concerned with the
@@ -85,7 +89,8 @@ const struct clkops clkops_omap3430es2_ssi_wait = {
  */
 static void omap3430es2_clk_dss_usbhost_find_idlest(struct clk *clk,
 						    void __iomem **idlest_reg,
-						    u8 *idlest_bit)
+						    u8 *idlest_bit,
+						    u8 *idlest_val)
 {
 	u32 r;
 
@@ -93,6 +98,7 @@ static void omap3430es2_clk_dss_usbhost_find_idlest(struct clk *clk,
 	*idlest_reg = (__force void __iomem *)r;
 	/* USBHOST_IDLE has same shift */
 	*idlest_bit = OMAP3430ES2_ST_DSS_IDLE_SHIFT;
+	*idlest_val = OMAP34XX_CM_IDLEST_VAL;
 }
 
 const struct clkops clkops_omap3430es2_dss_usbhost_wait = {
@@ -107,6 +113,7 @@ const struct clkops clkops_omap3430es2_dss_usbhost_wait = {
  * @clk: struct clk * being enabled
  * @idlest_reg: void __iomem ** to store CM_IDLEST reg address into
  * @idlest_bit: pointer to a u8 to store the CM_IDLEST bit shift into
+ * @idlest_val: pointer to a u8 to store the CM_IDLEST indicator
  *
  * The OMAP3430ES2 HSOTGUSB target CM_IDLEST bit is at a different
  * shift from the CM_{I,F}CLKEN bit.  Pass back the correct info via
@@ -114,13 +121,15 @@ const struct clkops clkops_omap3430es2_dss_usbhost_wait = {
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
index 4e4ac8c..94728b1 100644
--- a/arch/arm/mach-omap2/cm.h
+++ b/arch/arm/mach-omap2/cm.h
@@ -139,5 +139,8 @@ static inline u32 cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
 /* CM_IDLEST_GFX */
 #define OMAP_ST_GFX					(1 << 0)
 
+/* CM_IDLEST indicator */
+#define OMAP24XX_CM_IDLEST_VAL		0
+#define OMAP34XX_CM_IDLEST_VAL		1
 
 #endif
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index e8e121a..0f87fdc 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -242,26 +242,22 @@ u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
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
index e413132..9042dab 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -22,8 +22,10 @@ struct clockdomain;
 struct clkops {
 	int			(*enable)(struct clk *);
 	void			(*disable)(struct clk *);
-	void			(*find_idlest)(struct clk *, void __iomem **, u8 *);
-	void			(*find_companion)(struct clk *, void __iomem **, u8 *);
+	void			(*find_idlest)(struct clk *, void __iomem **,
+					       u8 *, u8 *);
+	void			(*find_companion)(struct clk *, void __iomem **,
+						  u8 *);
 };
 
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-omap/include/plat/prcm.h
index 66938a9..d6a0e27 100644
--- a/arch/arm/plat-omap/include/plat/prcm.h
+++ b/arch/arm/plat-omap/include/plat/prcm.h
@@ -25,7 +25,8 @@
 
 u32 omap_prcm_get_reset_sources(void);
 void omap_prcm_arch_reset(char mode);
-int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, const char *name);
+int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
+			 const char *name);
 
 #define START_PADCONF_SAVE 0x2
 #define PADCONF_SAVE_DONE  0x1


