From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 13/18] ARM: OMAP3: PRM: move PRM init code from PM core to the driver
Date: Tue, 4 Mar 2014 18:19:13 +0200
Message-ID: <1393949958-816-14-git-send-email-t-kristo@ti.com>
References: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45125 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754628AbaCDQUn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Mar 2014 11:20:43 -0500
In-Reply-To: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

Helps to isolate the PRM driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c  |   71 +-------------------------------
 arch/arm/mach-omap2/prm3xxx.c |   90 +++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm3xxx.h |    1 +
 3 files changed, 92 insertions(+), 70 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 2fa9478..0b9a298 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -369,79 +369,10 @@ static void __init omap3_d2d_idle(void)
 
 static void __init prcm_setup_regs(void)
 {
-	u32 omap3630_en_uart4_mask = cpu_is_omap3630() ?
-					OMAP3630_EN_UART4_MASK : 0;
-	u32 omap3630_grpsel_uart4_mask = cpu_is_omap3630() ?
-					OMAP3630_GRPSEL_UART4_MASK : 0;
-
 	/* XXX This should be handled by hwmod code or SCM init code */
 	omap_ctrl_writel(OMAP3430_AUTOIDLE_MASK, OMAP2_CONTROL_SYSCONFIG);
 
-	/*
-	 * Enable control of expternal oscillator through
-	 * sys_clkreq. In the long run clock framework should
-	 * take care of this.
-	 */
-	omap2_prm_rmw_mod_reg_bits(OMAP_AUTOEXTCLKMODE_MASK,
-			     1 << OMAP_AUTOEXTCLKMODE_SHIFT,
-			     OMAP3430_GR_MOD,
-			     OMAP3_PRM_CLKSRC_CTRL_OFFSET);
-
-	/* setup wakup source */
-	omap2_prm_write_mod_reg(OMAP3430_EN_IO_MASK | OMAP3430_EN_GPIO1_MASK |
-			  OMAP3430_EN_GPT1_MASK | OMAP3430_EN_GPT12_MASK,
-			  WKUP_MOD, PM_WKEN);
-	/* No need to write EN_IO, that is always enabled */
-	omap2_prm_write_mod_reg(OMAP3430_GRPSEL_GPIO1_MASK |
-			  OMAP3430_GRPSEL_GPT1_MASK |
-			  OMAP3430_GRPSEL_GPT12_MASK,
-			  WKUP_MOD, OMAP3430_PM_MPUGRPSEL);
-
-	/* Enable PM_WKEN to support DSS LPR */
-	omap2_prm_write_mod_reg(OMAP3430_PM_WKEN_DSS_EN_DSS_MASK,
-				OMAP3430_DSS_MOD, PM_WKEN);
-
-	/* Enable wakeups in PER */
-	omap2_prm_write_mod_reg(omap3630_en_uart4_mask |
-			  OMAP3430_EN_GPIO2_MASK | OMAP3430_EN_GPIO3_MASK |
-			  OMAP3430_EN_GPIO4_MASK | OMAP3430_EN_GPIO5_MASK |
-			  OMAP3430_EN_GPIO6_MASK | OMAP3430_EN_UART3_MASK |
-			  OMAP3430_EN_MCBSP2_MASK | OMAP3430_EN_MCBSP3_MASK |
-			  OMAP3430_EN_MCBSP4_MASK,
-			  OMAP3430_PER_MOD, PM_WKEN);
-	/* and allow them to wake up MPU */
-	omap2_prm_write_mod_reg(omap3630_grpsel_uart4_mask |
-			  OMAP3430_GRPSEL_GPIO2_MASK |
-			  OMAP3430_GRPSEL_GPIO3_MASK |
-			  OMAP3430_GRPSEL_GPIO4_MASK |
-			  OMAP3430_GRPSEL_GPIO5_MASK |
-			  OMAP3430_GRPSEL_GPIO6_MASK |
-			  OMAP3430_GRPSEL_UART3_MASK |
-			  OMAP3430_GRPSEL_MCBSP2_MASK |
-			  OMAP3430_GRPSEL_MCBSP3_MASK |
-			  OMAP3430_GRPSEL_MCBSP4_MASK,
-			  OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
-
-	/* Don't attach IVA interrupts */
-	if (omap3_has_iva()) {
-		omap2_prm_write_mod_reg(0, WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
-		omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430_PM_IVAGRPSEL1);
-		omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
-		omap2_prm_write_mod_reg(0, OMAP3430_PER_MOD,
-					OMAP3430_PM_IVAGRPSEL);
-	}
-
-	/* Clear any pending 'reset' flags */
-	omap2_prm_write_mod_reg(0xffffffff, MPU_MOD, OMAP2_RM_RSTST);
-	omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP2_RM_RSTST);
-	omap2_prm_write_mod_reg(0xffffffff, OMAP3430_PER_MOD, OMAP2_RM_RSTST);
-	omap2_prm_write_mod_reg(0xffffffff, OMAP3430_EMU_MOD, OMAP2_RM_RSTST);
-	omap2_prm_write_mod_reg(0xffffffff, OMAP3430_NEON_MOD, OMAP2_RM_RSTST);
-	omap2_prm_write_mod_reg(0xffffffff, OMAP3430_DSS_MOD, OMAP2_RM_RSTST);
-	omap2_prm_write_mod_reg(0xffffffff, OMAP3430ES2_USBHOST_MOD, OMAP2_RM_RSTST);
-
-	/* Clear any pending PRCM interrupts */
-	omap2_prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+	omap3_prm_init_pm(cpu_is_omap3630(), omap3_has_iva());
 
 	/*
 	 * We need to idle iva2_pwrdm even on am3703 with no iva2.
diff --git a/arch/arm/mach-omap2/prm3xxx.c b/arch/arm/mach-omap2/prm3xxx.c
index 9ebc22c..09e50d2 100644
--- a/arch/arm/mach-omap2/prm3xxx.c
+++ b/arch/arm/mach-omap2/prm3xxx.c
@@ -274,6 +274,96 @@ void __init omap3_prm_reset_modem(void)
 }
 
 /**
+ * omap3_prm_init_pm - initialize PM related registers for PRM
+ * @has_uart4: SoC has UART4
+ * @has_iva: SoC has IVA
+ *
+ * Initializes PRM registers for PM use. Called from PM init.
+ */
+void __init omap3_prm_init_pm(bool has_uart4, bool has_iva)
+{
+	u32 en_uart4_mask;
+	u32 grpsel_uart4_mask;
+
+	/*
+	 * Enable control of expternal oscillator through
+	 * sys_clkreq. In the long run clock framework should
+	 * take care of this.
+	 */
+	omap2_prm_rmw_mod_reg_bits(OMAP_AUTOEXTCLKMODE_MASK,
+				   1 << OMAP_AUTOEXTCLKMODE_SHIFT,
+				   OMAP3430_GR_MOD,
+				   OMAP3_PRM_CLKSRC_CTRL_OFFSET);
+
+	/* setup wakup source */
+	omap2_prm_write_mod_reg(OMAP3430_EN_IO_MASK | OMAP3430_EN_GPIO1_MASK |
+				OMAP3430_EN_GPT1_MASK | OMAP3430_EN_GPT12_MASK,
+				WKUP_MOD, PM_WKEN);
+	/* No need to write EN_IO, that is always enabled */
+	omap2_prm_write_mod_reg(OMAP3430_GRPSEL_GPIO1_MASK |
+				OMAP3430_GRPSEL_GPT1_MASK |
+				OMAP3430_GRPSEL_GPT12_MASK,
+				WKUP_MOD, OMAP3430_PM_MPUGRPSEL);
+
+	/* Enable PM_WKEN to support DSS LPR */
+	omap2_prm_write_mod_reg(OMAP3430_PM_WKEN_DSS_EN_DSS_MASK,
+				OMAP3430_DSS_MOD, PM_WKEN);
+
+	if (has_uart4) {
+		en_uart4_mask = OMAP3630_EN_UART4_MASK;
+		grpsel_uart4_mask = OMAP3630_GRPSEL_UART4_MASK;
+	}
+
+	/* Enable wakeups in PER */
+	omap2_prm_write_mod_reg(en_uart4_mask |
+				OMAP3430_EN_GPIO2_MASK |
+				OMAP3430_EN_GPIO3_MASK |
+				OMAP3430_EN_GPIO4_MASK |
+				OMAP3430_EN_GPIO5_MASK |
+				OMAP3430_EN_GPIO6_MASK |
+				OMAP3430_EN_UART3_MASK |
+				OMAP3430_EN_MCBSP2_MASK |
+				OMAP3430_EN_MCBSP3_MASK |
+				OMAP3430_EN_MCBSP4_MASK,
+				OMAP3430_PER_MOD, PM_WKEN);
+
+	/* and allow them to wake up MPU */
+	omap2_prm_write_mod_reg(grpsel_uart4_mask |
+				OMAP3430_GRPSEL_GPIO2_MASK |
+				OMAP3430_GRPSEL_GPIO3_MASK |
+				OMAP3430_GRPSEL_GPIO4_MASK |
+				OMAP3430_GRPSEL_GPIO5_MASK |
+				OMAP3430_GRPSEL_GPIO6_MASK |
+				OMAP3430_GRPSEL_UART3_MASK |
+				OMAP3430_GRPSEL_MCBSP2_MASK |
+				OMAP3430_GRPSEL_MCBSP3_MASK |
+				OMAP3430_GRPSEL_MCBSP4_MASK,
+				OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
+
+	/* Don't attach IVA interrupts */
+	if (has_iva) {
+		omap2_prm_write_mod_reg(0, WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
+		omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430_PM_IVAGRPSEL1);
+		omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
+		omap2_prm_write_mod_reg(0, OMAP3430_PER_MOD,
+					OMAP3430_PM_IVAGRPSEL);
+	}
+
+	/* Clear any pending 'reset' flags */
+	omap2_prm_write_mod_reg(0xffffffff, MPU_MOD, OMAP2_RM_RSTST);
+	omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP2_RM_RSTST);
+	omap2_prm_write_mod_reg(0xffffffff, OMAP3430_PER_MOD, OMAP2_RM_RSTST);
+	omap2_prm_write_mod_reg(0xffffffff, OMAP3430_EMU_MOD, OMAP2_RM_RSTST);
+	omap2_prm_write_mod_reg(0xffffffff, OMAP3430_NEON_MOD, OMAP2_RM_RSTST);
+	omap2_prm_write_mod_reg(0xffffffff, OMAP3430_DSS_MOD, OMAP2_RM_RSTST);
+	omap2_prm_write_mod_reg(0xffffffff, OMAP3430ES2_USBHOST_MOD,
+				OMAP2_RM_RSTST);
+
+	/* Clear any pending PRCM interrupts */
+	omap2_prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+}
+
+/**
  * omap3xxx_prm_reconfigure_io_chain - clear latches and reconfigure I/O chain
  *
  * Clear any previously-latched I/O wakeup events and ensure that the
diff --git a/arch/arm/mach-omap2/prm3xxx.h b/arch/arm/mach-omap2/prm3xxx.h
index 829cdc3..7120af9 100644
--- a/arch/arm/mach-omap2/prm3xxx.h
+++ b/arch/arm/mach-omap2/prm3xxx.h
@@ -167,6 +167,7 @@ void omap3xxx_prm_iva_idle(void);
 void omap3_prm_reset_modem(void);
 int omap3xxx_prm_clear_global_cold_reset(void);
 void omap3_prm_save_scratchpad_contents(u32 *ptr);
+void omap3_prm_init_pm(bool has_uart4, bool has_iva);
 
 #endif /* __ASSEMBLER */
 
-- 
1.7.9.5

