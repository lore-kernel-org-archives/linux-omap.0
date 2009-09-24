From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 1/1] OMAP3: Common mechanism to identify cpu revision
Date: Thu, 24 Sep 2009 21:21:21 +0530
Message-ID: <1253807481-19214-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46988 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752379AbZIXPvU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 11:51:20 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n8OFpMnA016629
	for <linux-omap@vger.kernel.org>; Thu, 24 Sep 2009 10:51:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

There are multiple mechanisms to identify the cpu revisions.
Most common is use of omap_rev(). This, however, does a
absolute comparison of omap_revision - which includes
CPU id, CPU rev and CPU class. This comparison fails for
OMAP35x processors.

This patch defines generic functions that use only the
CPU rev bits in omap_revision to identify the revision
information.

Usage will change from (for example):
	if (omap_rev() > OMAP3430_REV_ES2_0)
to:
	if (cpu_is_omap34xx() && omap_rev_gt_2_0())

Specific check for cpu_is_xxx() will not be needed for
files specific to silicon e.g. pm34xx.c, clock34xx.c, etc.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/clock34xx.c       |    4 +-
 arch/arm/mach-omap2/control.c         |    6 ++--
 arch/arm/mach-omap2/pm34xx.c          |   17 +++++-----
 arch/arm/plat-omap/include/mach/cpu.h |   55 +++++++++++++++++++++++++++++++++
 4 files changed, 69 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index e0df0ce..074c593 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -815,7 +815,7 @@ static int omap3_dpll4_set_rate(struct clk *clk, unsigned long rate)
 	 * on 3430ES1 prevents us from changing DPLL multipliers or dividers
 	 * on DPLL4.
 	 */
-	if (omap_rev() == OMAP3430_REV_ES1_0) {
+	if (omap_rev_is_1_0()) {
 		printk(KERN_ERR "clock: DPLL4 cannot change rate due to "
 		       "silicon 'Limitation 2.5' on 3430ES1.\n");
 		return -EINVAL;
@@ -1157,7 +1157,7 @@ int __init omap2_clk_init(void)
 		 * Update this if there are further clock changes between ES2
 		 * and production parts
 		 */
-		if (omap_rev() == OMAP3430_REV_ES1_0) {
+		if (omap_rev_is_1_0()) {
 			/* No 3430ES1-only rates exist, so no RATE_IN_3430ES1 */
 			cpu_clkflg |= CK_3430ES1;
 		} else {
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index c9407c0..089e714 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -209,8 +209,8 @@ void omap3_save_scratchpad_contents(void)
 
 	/* Populate the Scratchpad contents */
 	scratchpad_contents.boot_config_ptr = 0x0;
-	if (omap_rev() != OMAP3430_REV_ES3_0 &&
-					omap_rev() != OMAP3430_REV_ES3_1)
+	if (cpu_is_omap34xx()
+		&& !omap_rev_is_3_0() && !omap_rev_is_3_1())
 		scratchpad_contents.public_restore_ptr =
 			virt_to_phys(get_restore_pointer());
 	else
@@ -271,7 +271,7 @@ void omap3_save_scratchpad_contents(void)
 	 * of AUTO_CNT = 1 prior to any transition to OFF mode.
 	 */
 	if ((omap_type() != OMAP2_DEVICE_TYPE_GP)
-			&& (omap_rev() >= OMAP3430_REV_ES3_0))
+		&& cpu_is_omap34xx() && omap_rev_ge_3_0())
 		sdrc_block_contents.power = (sdrc_read_reg(SDRC_POWER) &
 				~(SDRC_POWER_AUTOCOUNT_MASK|
 				SDRC_POWER_CLKCTRL_MASK)) |
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c1d58a7..7a1eb95 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -28,6 +28,7 @@
 #include <linux/clk.h>
 #include <linux/usb/musb.h>
 
+#include <mach/cpu.h>
 #include <mach/sram.h>
 #include <mach/prcm.h>
 #include <mach/clockdomain.h>
@@ -108,7 +109,7 @@ static void omap3_enable_io_chain(void)
 {
 	int timeout = 0;
 
-	if (omap_rev() >= OMAP3430_REV_ES3_1) {
+	if (omap_rev_ge_3_1()) {
 		prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN, WKUP_MOD, PM_WKEN);
 		/* Do a readback to assure write has been done */
 		prm_read_mod_reg(WKUP_MOD, PM_WKEN);
@@ -129,7 +130,7 @@ static void omap3_enable_io_chain(void)
 
 static void omap3_disable_io_chain(void)
 {
-	if (omap_rev() >= OMAP3430_REV_ES3_1)
+	if (omap_rev_ge_3_1())
 		prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN, WKUP_MOD, PM_WKEN);
 }
 
@@ -248,7 +249,7 @@ static int _prcm_int_handle_wakeup(void)
 	c = prcm_clear_mod_irqs(WKUP_MOD, 1);
 	c += prcm_clear_mod_irqs(CORE_MOD, 1);
 	c += prcm_clear_mod_irqs(OMAP3430_PER_MOD, 1);
-	if (omap_rev() > OMAP3430_REV_ES1_0) {
+	if (omap_rev_gt_1_0()) {
 		c += prcm_clear_mod_irqs(CORE_MOD, 3);
 		c += prcm_clear_mod_irqs(OMAP3430ES2_USBHOST_MOD, 1);
 	}
@@ -432,7 +433,7 @@ void omap_sram_idle(void)
 	* of AUTO_CNT = 1 enabled. This takes care of errata 1.142.
 	* Hence store/restore the SDRC_POWER register here.
 	*/
-	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
+	if (omap_rev_ge_3_0() &&
 	    omap_type() != OMAP2_DEVICE_TYPE_GP &&
 	    core_next_state == PWRDM_POWER_OFF)
 		sdrc_pwr = sdrc_read_reg(SDRC_POWER);
@@ -449,7 +450,7 @@ void omap_sram_idle(void)
 	cpu_init();
 
 	/* Restore normal SDRC POWER settings */
-	if (omap_rev() >= OMAP3430_REV_ES3_0 &&
+	if (omap_rev_ge_3_0() &&
 	    omap_type() != OMAP2_DEVICE_TYPE_GP &&
 	    core_next_state == PWRDM_POWER_OFF)
 		sdrc_write_reg(sdrc_pwr, SDRC_POWER);
@@ -784,7 +785,7 @@ static void __init prcm_setup_regs(void)
 	prm_write_mod_reg(0, OMAP3430_NEON_MOD, PM_WKDEP);
 	prm_write_mod_reg(0, OMAP3430_CAM_MOD, PM_WKDEP);
 	prm_write_mod_reg(0, OMAP3430_PER_MOD, PM_WKDEP);
-	if (omap_rev() > OMAP3430_REV_ES1_0) {
+	if (omap_rev_gt_1_0()) {
 		prm_write_mod_reg(0, OMAP3430ES2_SGX_MOD, PM_WKDEP);
 		prm_write_mod_reg(0, OMAP3430ES2_USBHOST_MOD, PM_WKDEP);
 	} else
@@ -835,7 +836,7 @@ static void __init prcm_setup_regs(void)
 		OMAP3430_AUTO_DES1,
 		CORE_MOD, CM_AUTOIDLE2);
 
-	if (omap_rev() > OMAP3430_REV_ES1_0) {
+	if (omap_rev_gt_1_0()) {
 		cm_write_mod_reg(
 			OMAP3430_AUTO_MAD2D |
 			OMAP3430ES2_AUTO_USBTLL,
@@ -883,7 +884,7 @@ static void __init prcm_setup_regs(void)
 		OMAP3430_PER_MOD,
 		CM_AUTOIDLE);
 
-	if (omap_rev() > OMAP3430_REV_ES1_0) {
+	if (omap_rev_gt_1_0()) {
 		cm_write_mod_reg(
 			OMAP3430ES2_AUTO_USBHOST,
 			OMAP3430ES2_USBHOST_MOD,
diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index b689013..522df64 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -453,6 +453,61 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define omap35xx_rev_mask()	(omap_rev() & 0x0000F000)
 
 /*
+ * Silicon revisions
+ */
+#define OMAP_ES_1_0		0x00
+#define OMAP_ES_2_0		0x10
+#define OMAP_ES_2_1		0x20
+#define OMAP_ES_3_0		0x30
+#define OMAP_ES_3_1		0x40
+
+#define OMAP_REV_MASK		0x0000ff00
+#define OMAP_REV_BITS		((omap_rev() & OMAP_REV_MASK) >> 8)
+
+#define OMAP_REV_IS(revid)					\
+static inline u8 omap_rev_is_ ##revid (void)			\
+{								\
+	return (OMAP_REV_BITS == OMAP_ES_ ##revid) ? 1 : 0;	\
+}
+
+#define OMAP_REV_LT(revid)					\
+static inline u8 omap_rev_lt_ ##revid (void)			\
+{								\
+	return (OMAP_REV_BITS < OMAP_ES_ ##revid) ? 1 : 0;	\
+}
+
+#define OMAP_REV_LE(revid)					\
+static inline u8 omap_rev_le_ ##revid (void)			\
+{								\
+	return (OMAP_REV_BITS <= OMAP_ES_ ##revid) ? 1 : 0;	\
+}
+
+#define OMAP_REV_GT(revid)					\
+static inline u8 omap_rev_gt_ ##revid (void)			\
+{								\
+	return (OMAP_REV_BITS > OMAP_ES_ ##revid) ? 1 : 0;	\
+}
+
+#define OMAP_REV_GE(revid)					\
+static inline u8 omap_rev_ge_ ##revid (void)			\
+{								\
+	return (OMAP_REV_BITS >= OMAP_ES_ ##revid) ? 1 : 0;	\
+}
+
+#define OMAP_REV_FUNCTIONS(revid)	\
+	OMAP_REV_IS(revid)		\
+	OMAP_REV_LT(revid)		\
+	OMAP_REV_LE(revid)		\
+	OMAP_REV_GT(revid)		\
+	OMAP_REV_GE(revid)
+
+OMAP_REV_FUNCTIONS(1_0)
+OMAP_REV_FUNCTIONS(2_0)
+OMAP_REV_FUNCTIONS(2_1)
+OMAP_REV_FUNCTIONS(3_0)
+OMAP_REV_FUNCTIONS(3_1)
+
+/*
  * omap_chip bits
  *
  * CHIP_IS_OMAP{2420,2430,3430} indicate that a particular structure is
-- 
1.6.2.2

