From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHV2 REPOST 2/7] ARM: OMAP3 PM: Move IO Daisychain function to omap3 prm file
Date: Wed, 14 Dec 2011 21:31:12 +0530
Message-ID: <1323878477-21122-3-git-send-email-vishwanath.bs@ti.com>
References: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52845 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757516Ab1LNQLF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 11:11:05 -0500
In-Reply-To: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

Since IO Daisychain modifies only PRM registers, it makes sense to move it to
PRM File.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Tested-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c       |   30 +-----------------------------
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   33 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h |   14 ++++++++++++++
 3 files changed, 48 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 074688b..448e620 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -96,34 +96,6 @@ static inline void omap3_per_restore_context(void)
 	omap_gpio_restore_context();
 }
 
-static void omap3_enable_io_chain(void)
-{
-	int timeout = 0;
-
-	omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
-				   PM_WKEN);
-	/* Do a readback to assure write has been done */
-	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
-
-	while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST) &
-		 OMAP3430_ST_IO_CHAIN_MASK)) {
-		timeout++;
-		if (timeout > 1000) {
-			pr_err("Wake up daisy chain activation failed.\n");
-			return;
-		}
-	}
-	omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
-			PM_WKEN);
-
-}
-
-static void omap3_disable_io_chain(void)
-{
-	omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
-				     PM_WKEN);
-}
-
 static void omap3_core_save_context(void)
 {
 	omap3_ctrl_save_padconf();
@@ -335,7 +307,7 @@ void omap_sram_idle(void)
 	     core_next_state < PWRDM_POWER_ON)) {
 		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
 		if (omap3_has_io_chain_ctrl())
-			omap3_enable_io_chain();
+			omap3_trigger_wuclk_ctrl();
 	}
 
 	/* Block console output in case it is on one of the OMAP UARTs */
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 2a4a678..6db5935 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -227,6 +227,39 @@ u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset)
 	return omap2_prm_rmw_mod_reg_bits(mask, bits, OMAP3430_GR_MOD, offset);
 }
 
+/**
+ * Maximum time(us) it takes to output the signal WUCLKOUT of the last pad of
+ * the I/O ring after asserting WUCLKIN high
+ */
+#define MAX_IOPAD_LATCH_TIME 1000
+
+/* OMAP3 Daisychain trigger sequence */
+void omap3_trigger_wuclk_ctrl(void)
+{
+	int i = 0;
+
+	omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+			     PM_WKEN);
+	/* Do a readback to assure write has been done */
+	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
+
+	omap_test_timeout(
+	(((omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST) &
+		 OMAP3430_ST_IO_CHAIN_MASK) == 1)),
+	MAX_IOPAD_LATCH_TIME, i);
+
+	omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+			     PM_WKEN);
+}
+
+/* OMAP3 Daisychain disable sequence */
+void omap3_disable_io_chain(void)
+{
+	if (omap_rev() >= OMAP3430_REV_ES3_1)
+		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+			PM_WKEN);
+}
+
 static int __init omap3xxx_prcm_init(void)
 {
 	if (cpu_is_omap34xx())
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index cef533d..e6f8206 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -289,6 +289,18 @@ static inline int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift,
 		"not suppose to be used on omap4\n");
 	return 0;
 }
+static inline void omap3_trigger_wuclk_ctrl(void)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+static inline void omap3_disable_io_chain(void)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
 #else
 /* Power/reset management domain register get/set */
 extern u32 omap2_prm_read_mod_reg(s16 module, u16 idx);
@@ -302,6 +314,8 @@ extern u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask);
 extern int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
 extern int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift);
 extern int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift, u8 st_shift);
+extern void omap3_trigger_wuclk_ctrl(void);
+extern void omap3_disable_io_chain(void);
 
 /* OMAP3-specific VP functions */
 u32 omap3_prm_vp_check_txdone(u8 vp_id);
-- 
1.7.0.4

