From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv5 2/6] ARM: OMAP3 PM: Move IO Daisychain function to omap3 prm file
Date: Tue, 6 Mar 2012 17:11:38 +0200
Message-ID: <1331046702-2472-3-git-send-email-t-kristo@ti.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47864 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030854Ab2CFPL6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Mar 2012 10:11:58 -0500
In-Reply-To: <1331046702-2472-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

From: Vishwanath BS <vishwanath.bs@ti.com>

Since IO Daisychain modifies only PRM registers, it makes sense to move
it to PRM File. Also changed the timeout value for IO chain enable to
100us and added a wait for status disable at the end.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c       |   30 +----------------------------
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   37 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h |   14 +++++++++++++
 3 files changed, 52 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b0821a8..e97ec3f 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -85,34 +85,6 @@ static inline void omap3_per_restore_context(void)
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
@@ -324,7 +296,7 @@ void omap_sram_idle(void)
 	     core_next_state < PWRDM_POWER_ON)) {
 		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
 		if (omap3_has_io_chain_ctrl())
-			omap3_enable_io_chain();
+			omap3_trigger_io_chain();
 	}
 
 	pwrdm_pre_transition();
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 9ce7654..2f45b96 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -301,6 +301,43 @@ void omap3xxx_prm_restore_irqen(u32 *saved_mask)
 				OMAP3_PRM_IRQENABLE_MPU_OFFSET);
 }
 
+/*
+ * Maximum time(us) it takes to output the signal WUCLKOUT of the last pad of
+ * the I/O ring after asserting WUCLKIN high
+ */
+#define MAX_IOPAD_LATCH_TIME 100
+
+/* OMAP3 Daisychain enable sequence */
+void omap3_trigger_io_chain(void)
+{
+	int i = 0;
+
+	omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+				   PM_WKEN);
+	/* Do a readback to assure write has been done */
+	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
+
+	omap_test_timeout(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST) &
+			  OMAP3430_ST_IO_CHAIN_MASK,
+			  MAX_IOPAD_LATCH_TIME, i);
+
+	omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+				     PM_WKEN);
+
+	omap2_prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK, WKUP_MOD,
+				     PM_WKST);
+
+	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST);
+}
+
+/* OMAP3 Daisychain disable sequence */
+void omap3_disable_io_chain(void)
+{
+	if (omap_rev() >= OMAP3430_REV_ES3_1)
+		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK,
+					     WKUP_MOD, PM_WKEN);
+}
+
 static int __init omap3xxx_prcm_init(void)
 {
 	if (cpu_is_omap34xx())
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 70ac2a1..15973aa 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -289,6 +289,18 @@ static inline int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift,
 		"not suppose to be used on omap4\n");
 	return 0;
 }
+static inline void omap3_trigger_io_chain(void)
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
+extern void omap3_trigger_io_chain(void);
+extern void omap3_disable_io_chain(void);
 
 /* OMAP3-specific VP functions */
 u32 omap3_prm_vp_check_txdone(u8 vp_id);
-- 
1.7.4.1

