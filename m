From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHv2 2/7] ARM: OMAP3 PM: Move IO Daisychain function to omap3 prm file
Date: Fri, 7 Oct 2011 23:17:46 +0530
Message-ID: <1318009671-12813-3-git-send-email-vishwanath.bs@ti.com>
References: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43420 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756111Ab1JGRzO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Oct 2011 13:55:14 -0400
In-Reply-To: <1318009671-12813-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

Since IO Daisychain modifies only PRM registers, it makes sense to move it to
PRM File.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c       |   33 +--------------------------------
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   35 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h |   14 ++++++++++++++
 3 files changed, 50 insertions(+), 32 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 041f6e6..352ad3c 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -95,37 +95,6 @@ static inline void omap3_per_restore_context(void)
 	omap_gpio_restore_context();
 }
 
-static void omap3_enable_io_chain(void)
-{
-	int timeout = 0;
-
-	if (omap_rev() >= OMAP3430_REV_ES3_1) {
-		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
-				     PM_WKEN);
-		/* Do a readback to assure write has been done */
-		omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
-
-		while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST) &
-			 OMAP3430_ST_IO_CHAIN_MASK)) {
-			timeout++;
-			if (timeout > 1000) {
-				printk(KERN_ERR "Wake up daisy chain "
-				       "activation failed.\n");
-				return;
-			}
-		}
-		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
-				     PM_WKEN);
-	}
-}
-
-static void omap3_disable_io_chain(void)
-{
-	if (omap_rev() >= OMAP3430_REV_ES3_1)
-		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
-				       PM_WKEN);
-}
-
 static void omap3_core_save_context(void)
 {
 	omap3_ctrl_save_padconf();
@@ -376,7 +345,7 @@ void omap_sram_idle(void)
 	    (per_next_state < PWRDM_POWER_ON ||
 	     core_next_state < PWRDM_POWER_ON)) {
 		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
-		omap3_enable_io_chain();
+		omap3_trigger_wuclk_ctrl();
 	}
 
 	/* Block console output in case it is on one of the OMAP UARTs */
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 051213f..915d726 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -156,3 +156,38 @@ int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift, u8 st_shift)
 
 	return (c == MAX_MODULE_HARDRESET_WAIT) ? -EBUSY : 0;
 }
+
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
+	if (omap_rev() >= OMAP3430_REV_ES3_1) {
+		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+				     PM_WKEN);
+		/* Do a readback to assure write has been done */
+		omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
+
+		omap_test_timeout(
+		(((omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST) &
+			 OMAP3430_ST_IO_CHAIN_MASK) == 1)),
+		MAX_IOPAD_LATCH_TIME, i);
+
+		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+				     PM_WKEN);
+	}
+}
+
+/* OMAP3 Daisychain disable sequence */
+void omap3_disable_io_chain(void)
+{
+	if (omap_rev() >= OMAP3430_REV_ES3_1)
+		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+				       PM_WKEN);
+}
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index a1fc62a..8bc574d 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -289,6 +289,18 @@ static inline int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift,
 		"not suppose to be used on omap4\n");
 	return 0;
 }
+extern void omap3_trigger_wuclk_ctrl(void)
+{
+	WARN(1, "prm: omap2xxx/omap3xxx specific function and "
+		"not suppose to be used on omap4\n");
+	return 0;
+}
+extern void omap3_disable_io_chain(void)
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
 
 #endif	/* CONFIG_ARCH_OMAP4 */
 #endif
-- 
1.7.0.4

