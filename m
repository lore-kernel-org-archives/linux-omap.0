From: Madhusudhan Gowda <madhusudhan.gowda@elektrobit.com>
Subject: [PATCH] ARM: OMAP3 PM:Save and restore EMU context across MPU OFF
Date: Fri, 13 Jan 2012 11:50:37 +0200
Message-ID: <1326448237-28251-1-git-send-email-madhusudhan.gowda@elektrobit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: madhusudhan.gowda@elektrobit.com
List-Id: linux-omap@vger.kernel.org

EMU domain is part of MPU subsystem, save and restore CM_CLKSTCTRL of
EMU domain across MPU OFF instead of CORE OFF. Though CM belongs to CORE
power domain, this register is of cold reset type and gets reset upon
MPU domain wakeup from OFF.

Embedded trace debug tools like Serial Trace Interface(sti) using
EMU domain loses connection across MPU OFF. The patch fixes this issue

Signed-off-by: Madhusudhan Gowda <madhusudhan.gowda@elektrobit.com>
---
 arch/arm/mach-omap2/cm2xxx_3xxx.c |   16 ++++++++++++----
 arch/arm/mach-omap2/cm2xxx_3xxx.h |    2 ++
 arch/arm/mach-omap2/pm34xx.c      |    8 ++++++++
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.c b/arch/arm/mach-omap2/cm2xxx_3xxx.c
index 04d39cd..4f98e17 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.c
@@ -301,6 +301,18 @@ struct omap3_cm_regs {
 
 static struct omap3_cm_regs cm_context;
 
+void omap3_emu_save_context(void)
+{
+	cm_context.emu_cm_clkstctrl =
+		omap2_cm_read_mod_reg(OMAP3430_EMU_MOD, OMAP2_CM_CLKSTCTRL);
+}
+
+void omap3_emu_restore_context(void)
+{
+	omap2_cm_write_mod_reg(cm_context.emu_cm_clkstctrl, OMAP3430_EMU_MOD,
+			       OMAP2_CM_CLKSTCTRL);
+}
+
 void omap3_cm_save_context(void)
 {
 	cm_context.iva2_cm_clksel1 =
@@ -318,8 +330,6 @@ void omap3_cm_save_context(void)
 		omap2_cm_read_mod_reg(OMAP3430_PER_MOD, CM_CLKSEL);
 	cm_context.emu_cm_clksel =
 		omap2_cm_read_mod_reg(OMAP3430_EMU_MOD, CM_CLKSEL1);
-	cm_context.emu_cm_clkstctrl =
-		omap2_cm_read_mod_reg(OMAP3430_EMU_MOD, OMAP2_CM_CLKSTCTRL);
 	/*
 	 * As per erratum i671, ROM code does not respect the PER DPLL
 	 * programming scheme if CM_AUTOIDLE_PLL.AUTO_PERIPH_DPLL == 1.
@@ -449,8 +459,6 @@ void omap3_cm_restore_context(void)
 			       CM_CLKSEL);
 	omap2_cm_write_mod_reg(cm_context.emu_cm_clksel, OMAP3430_EMU_MOD,
 			       CM_CLKSEL1);
-	omap2_cm_write_mod_reg(cm_context.emu_cm_clkstctrl, OMAP3430_EMU_MOD,
-			       OMAP2_CM_CLKSTCTRL);
 	/*
 	 * As per erratum i671, ROM code does not respect the PER DPLL
 	 * programming scheme if CM_AUTOIDLE_PLL.AUTO_PERIPH_DPLL == 1.
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.h b/arch/arm/mach-omap2/cm2xxx_3xxx.h
index 088bbad..ffb0195 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.h
@@ -150,6 +150,8 @@ extern void omap2xxx_cm_set_apll96_auto_low_power_stop(void);
 # ifndef __ASSEMBLER__
 extern void omap3_cm_save_context(void);
 extern void omap3_cm_restore_context(void);
+extern void omap3_emu_save_context(void);
+extern void omap3_emu_restore_context(void);
 # endif
 
 #endif
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index fc69875..b05dc02 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -315,6 +315,10 @@ void omap_sram_idle(void)
 	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON)
 		pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
 
+	/* EMU */
+	if (mpu_next_state == PWRDM_POWER_OFF)
+		omap3_emu_save_context();
+
 	/* Enable IO-PAD and IO-CHAIN wakeups */
 	per_next_state = pwrdm_read_next_pwrst(per_pwrdm);
 	core_next_state = pwrdm_read_next_pwrst(core_pwrdm);
@@ -377,6 +381,10 @@ void omap_sram_idle(void)
 	    core_next_state == PWRDM_POWER_OFF)
 		sdrc_write_reg(sdrc_pwr, SDRC_POWER);
 
+	/* EMU */
+	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == PWRDM_POWER_OFF)
+		omap3_emu_restore_context();
+
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
 		core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
-- 
1.7.5.4



----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.
