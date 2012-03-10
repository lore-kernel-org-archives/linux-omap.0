From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCHv5 2/6] ARM: OMAP3 PM: Move IO Daisychain function to
 omap3 prm file
Date: Fri, 9 Mar 2012 20:50:57 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1203092049210.30879@utopia.booyaka.com>
References: <1331046702-2472-1-git-send-email-t-kristo@ti.com> <1331046702-2472-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:56927 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630Ab2CJDu6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Mar 2012 22:50:58 -0500
In-Reply-To: <1331046702-2472-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>, nm@ti.com

Hi

On Tue, 6 Mar 2012, Tero Kristo wrote:

> From: Vishwanath BS <vishwanath.bs@ti.com>
> 
> Since IO Daisychain modifies only PRM registers, it makes sense to move
> it to PRM File. Also changed the timeout value for IO chain enable to
> 100us and added a wait for status disable at the end.
> 
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

This patch has been updated in a few different ways, described below.  
Please let me know if you're okay with it.


- Paul

From: Vishwanath BS <vishwanath.bs@ti.com>
Date: Fri, 2 Mar 2012 17:17:51 +0200
Subject: [PATCH 2/6] ARM: OMAP3: PM: Move IO Daisychain function to omap3 prm
 file

Since IO Daisychain modifies only PRM registers, it makes sense to move
it to PRM File. Also changed the timeout value for IO chain enable to
100us and added a wait for status disable at the end.

Thanks to Nishanth Menon <nm@ti.com> for contributing a fix to the
timeout code waiting for WUCLKOUT to go high.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Nishanth Menon <nm@ti.com>
[paul@pwsan.com: renamed omap3_trigger_io_chain() to better describe the
 end result and to match other PRM functions; removed
 omap3_disable_io_chain(); moved MAX_IOPAD_LATCH_TIME to prcm-common as it
 will also be used by the OMAP4 code; removed unnecessary barrier;
 added kerneldoc; added credit for fix from Nishanth]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/pm34xx.c       |   35 ++---------------------------------
 arch/arm/mach-omap2/prcm-common.h  |    8 ++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.c |   31 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h |    2 ++
 4 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b0821a8..378a0de 100644
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
+			omap3_reconfigure_io_chain();
 	}
 
 	pwrdm_pre_transition();
@@ -407,12 +379,9 @@ void omap_sram_idle(void)
 	/* Disable IO-PAD and IO-CHAIN wakeup */
 	if (omap3_has_io_wakeup() &&
 	    (per_next_state < PWRDM_POWER_ON ||
-	     core_next_state < PWRDM_POWER_ON)) {
+	     core_next_state < PWRDM_POWER_ON))
 		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
 					     PM_WKEN);
-		if (omap3_has_io_chain_ctrl())
-			omap3_disable_io_chain();
-	}
 
 	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 }
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 5aa5435..f057c15 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -406,6 +406,14 @@
  */
 #define MAX_MODULE_HARDRESET_WAIT		10000
 
+/*
+ * Maximum time(us) it takes to output the signal WUCLKOUT of the last
+ * pad of the I/O ring after asserting WUCLKIN high.  Tero measured
+ * the actual time at 7 to 8 microseconds on OMAP3 and 2 to 4
+ * microseconds on OMAP4, so this timeout may be too high.
+ */
+#define MAX_IOPAD_LATCH_TIME			100
+
 # ifndef __ASSEMBLER__
 extern void __iomem *prm_base;
 extern void __iomem *cm_base;
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 9ce7654..7d62bd6 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -301,6 +301,37 @@ void omap3xxx_prm_restore_irqen(u32 *saved_mask)
 				OMAP3_PRM_IRQENABLE_MPU_OFFSET);
 }
 
+/**
+ * omap3xxx_prm_reconfigure_io_chain - clear latches and reconfigure I/O chain
+ *
+ * Clear any previously-latched I/O wakeup events and ensure that the
+ * I/O wakeup gates are aligned with the current mux settings.  Works
+ * by asserting WUCLKIN, waiting for WUCLKOUT to be asserted, and then
+ * deasserting WUCLKIN and clearing the ST_IO_CHAIN WKST bit.  No
+ * return value.
+ */
+void omap3xxx_prm_reconfigure_io_chain(void)
+{
+	int i = 0;
+
+	omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+				   PM_WKEN);
+
+	omap_test_timeout(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST) &
+			  OMAP3430_ST_IO_CHAIN_MASK,
+			  MAX_IOPAD_LATCH_TIME, i);
+	if (i == MAX_IOPAD_LATCH_TIME)
+		pr_warn("PRM: I/O chain clock line assertion timed out\n");
+
+	omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+				     PM_WKEN);
+
+	omap2_prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK, WKUP_MOD,
+				   PM_WKST);
+
+	omap2_prm_read_mod_reg(WKUP_MOD, PM_WKST);
+}
+
 static int __init omap3xxx_prcm_init(void)
 {
 	if (cpu_is_omap34xx())
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 70ac2a1..1ba3d65 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -315,6 +315,8 @@ extern u32 omap3_prm_vcvp_read(u8 offset);
 extern void omap3_prm_vcvp_write(u32 val, u8 offset);
 extern u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
 
+extern void omap3xxx_prm_reconfigure_io_chain(void);
+
 /* PRM interrupt-related functions */
 extern void omap3xxx_prm_read_pending_irqs(unsigned long *events);
 extern void omap3xxx_prm_ocp_barrier(void);
-- 
1.7.9.1

