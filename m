From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 1/3] OMAP34xx suspend + dynamic idle fixed for chip off-mode
Date: Thu,  3 Jul 2008 18:59:14 +0300
Message-ID: <1215100756-31445-2-git-send-email-tero.kristo@nokia.com>
References: <>
 <1215100756-31445-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:37738 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757830AbYGCOAA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jul 2008 10:00:00 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m63Dxm7q017694
	for <linux-omap@vger.kernel.org>; Thu, 3 Jul 2008 16:59:57 +0300
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id m63Dxh3e018829
	for <linux-omap@vger.kernel.org>; Thu, 3 Jul 2008 16:59:44 +0300
In-Reply-To: <1215100756-31445-1-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

With this patch OMAP34xx enters and resumes from off-mode successfully
with suspend and dynamic idle. CPU idle is broken with this patch and should
be fixed separately.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c  |   15 ++---
 arch/arm/mach-omap2/cpuidle34xx.h  |    2 +
 arch/arm/mach-omap2/pm34xx.c       |  110 +++++++++++++++++++-----------------
 arch/arm/mach-omap2/serial.c       |   97 +++++++++++++++++--------------
 arch/arm/plat-omap/dma.c           |   26 +++++++++
 include/asm-arm/arch-omap/common.h |    8 ++-
 6 files changed, 150 insertions(+), 108 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 53fd376..1b960ea 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -39,8 +39,6 @@
 #include "pm.h"
 #include "clock34xx.h"
 
-#ifdef CONFIG_CPU_IDLE
-
 struct omap3_processor_cx omap3_power_states[OMAP3_MAX_STATES];
 struct omap3_processor_cx current_cx_state;
 static int padconf_saved;
@@ -404,10 +402,8 @@ void omap3_save_core_ctx(void)
 	omap_save_gpmc_ctx();
 	/* Save the system control module context, padconf already save above*/
 	omap_save_control_ctx();
-	omap_save_uart_ctx(0);
-	omap_serial_enable_clocks(0, 0);
-	omap_save_uart_ctx(1);
-	omap_serial_enable_clocks(0, 1);
+
+	omap_dma_global_context_save();
 }
 
 void omap3_restore_core_ctx(void)
@@ -418,13 +414,12 @@ void omap3_restore_core_ctx(void)
 	omap_restore_gpmc_ctx();
 	/* Restore the interrupt controller context */
 	omap_restore_intc_ctx();
-	omap_serial_enable_clocks(1, 0);
-	omap_restore_uart_ctx(0);
-	omap_serial_enable_clocks(1, 1);
-	omap_restore_uart_ctx(1);
 	padconf_saved = 0;
+
+	omap_dma_global_context_restore();
 }
 
+#ifdef CONFIG_CPU_IDLE
 /* omap3_enter_idle - Programs OMAP3 to enter the specified state.
  * returns the total time during which the system was idle.
  */
diff --git a/arch/arm/mach-omap2/cpuidle34xx.h b/arch/arm/mach-omap2/cpuidle34xx.h
index bcdf978..0b3396d 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.h
+++ b/arch/arm/mach-omap2/cpuidle34xx.h
@@ -64,6 +64,8 @@ extern void omap3_restore_per_ctx();
 extern void omap_save_uart_ctx(int);
 extern void omap_restore_uart_ctx(int);
 extern void omap3_restore_sram_ctx();
+void omap_dma_global_context_restore(void);
+void omap_dma_global_context_save(void);
 extern int omap3_can_sleep();
 
 struct omap3_processor_cx {
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index dc7bb90..ff9890a 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -60,7 +60,17 @@ u32 restore_pointer_address;
 
 static LIST_HEAD(pwrst_list);
 
-void (*_omap_sram_idle)(u32 *addr, int save_state, int disable_clocks);
+void omap3_save_per_ctx(void);
+void omap3_restore_per_ctx(void);
+void omap3_restore_sram_ctx(void);
+void omap3_save_core_ctx(void);
+void omap3_restore_core_ctx(void);
+void omap3_save_prcm_ctx(void);
+void omap3_restore_prcm_ctx(void);
+void omap_dma_global_context_restore(void);
+void omap_dma_global_context_save(void);
+
+void (*_omap_sram_idle)(u32 *addr, int save_state);
 
 static void (*saved_idle)(void);
 
@@ -245,10 +255,43 @@ void omap_sram_idle(void)
 		return;
 	}
 
-	_omap_sram_idle(context_mem, save_state, clocks_off_while_idle);
-	/* Restore table entry modified during MMU restoration */
+	omap3_save_core_ctx();
+	omap3_save_prcm_ctx();
+
+	omap3_save_per_ctx();
+	omap2_gpio_prepare_for_retention();
+
+	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
+	 * handles fcks correctly */
+	per_gpio_clk_disable();
+
+	omap_save_uart_ctx();
+	omap_serial_enable_clocks(0);
+
+	*(scratchpad_restore_addr) = restore_pointer_address;
+
+	_omap_sram_idle(context_mem, save_state);
+
+	*(scratchpad_restore_addr) = 0x0;
+
 	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == 0x0)
 		restore_table_entry();
+
+	omap3_restore_prcm_ctx();
+	omap3_restore_sram_ctx();
+	omap3_restore_core_ctx();
+
+	omap_serial_enable_clocks(1); /* Causes crash with CORE off */
+
+	omap_restore_uart_ctx();
+
+	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
+	 * handles fcks correctly */
+
+	per_gpio_clk_enable();
+	omap3_restore_per_ctx();
+
+	omap2_gpio_resume_after_retention();
 }
 
 static int omap3_fclks_active(void)
@@ -357,29 +400,8 @@ static void omap3_pm_idle(void)
 	if (omap_irq_pending())
 		goto out;
 
-	omap2_gpio_prepare_for_retention();
-
-	if (clocks_off_while_idle) {
-		omap_serial_enable_clocks(0, 0);
-		omap_serial_enable_clocks(0, 1);
-		omap_serial_enable_clocks(0, 2);
-		/* XXX This is for gpio fclk hack. Will be removed as
-		 * gpio driver * handles fcks correctly */
-		per_gpio_clk_disable();
-	}
-
 	omap_sram_idle();
 
-	if (clocks_off_while_idle) {
-		omap_serial_enable_clocks(1, 0);
-		omap_serial_enable_clocks(1, 1);
-		omap_serial_enable_clocks(1, 2);
-		/* XXX This is for gpio fclk hack. Will be removed as
-		 * gpio driver * handles fcks correctly */
-		per_gpio_clk_enable();
-	}
-
-	omap2_gpio_resume_after_retention();
 out:
 	local_fiq_enable();
 	local_irq_enable();
@@ -412,29 +434,14 @@ static int omap3_pm_suspend(void)
 			goto restore;
 	}
 
-	omap2_gpio_prepare_for_retention();
-
-	if (clocks_off_while_idle) {
-		omap_serial_enable_clocks(0, 0);
-		omap_serial_enable_clocks(0, 1);
-		omap_serial_enable_clocks(0, 2);
-		/* XXX This is for gpio fclk hack. Will be removed as
-		 * gpio driver * handles fcks correctly */
-		per_gpio_clk_disable();
-	}
+	local_irq_disable();
+	local_fiq_disable();
 
 	omap_sram_idle();
 
-	if (clocks_off_while_idle) {
-		omap_serial_enable_clocks(1, 0);
-		omap_serial_enable_clocks(1, 1);
-		omap_serial_enable_clocks(1, 2);
-		/* XXX This is for gpio fclk hack. Will be removed as
-		 * gpio driver * handles fcks correctly */
-		per_gpio_clk_enable();
-	}
+	local_fiq_enable();
+	local_irq_enable();
 
-	omap2_gpio_resume_after_retention();
 restore:
 	/* Restore next_pwrsts */
 	list_for_each_entry(pwrst, &pwrst_list, node) {
@@ -657,10 +664,9 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-	if (!strcmp(pwrst->pwrdm->name, "core_pwrdm"))
-		pwrst->next_state = PWRDM_POWER_RET;
-	else
-		pwrst->next_state = PWRDM_POWER_OFF;
+
+	pwrst->next_state = PWRDM_POWER_OFF;
+
 	list_add(&pwrst->node, &pwrst_list);
 
 	if (pwrdm_has_hdwr_sar(pwrdm))
@@ -678,6 +684,7 @@ void omap_push_sram_idle()
 int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst;
+	struct powerdomain *neon_pwrdm;
 	char clk_name[11];
 	int ret, i;
 
@@ -687,7 +694,6 @@ int __init omap3_pm_init(void)
 	 * supervised mode for powerdomains */
 	prcm_setup_regs();
 	save_scratchpad_contents();
-
 	ret = request_irq(INT_34XX_PRCM_MPU_IRQ,
 			  (irq_handler_t)prcm_interrupt_handler,
 			  IRQF_DISABLED, "prcm", NULL);
@@ -704,8 +710,10 @@ int __init omap3_pm_init(void)
 	}
 
 	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
-	if (mpu_pwrdm == NULL) {
-		printk(KERN_ERR "Failed to get mpu_pwrdm\n");
+	neon_pwrdm = pwrdm_lookup("neon_pwrdm");
+
+	if (mpu_pwrdm == NULL || neon_pwrdm == NULL) {
+		printk(KERN_ERR "Failed to get mpu_pwrdm or neon_pwrdm\n");
 		goto err2;
 	}
 
@@ -723,6 +731,7 @@ int __init omap3_pm_init(void)
 		gpio_fcks[i-1] = clk_get(NULL, clk_name);
 	}
 
+	pwrdm_add_wkdep(neon_pwrdm, mpu_pwrdm);
 err1:
 	return ret;
 err2:
@@ -851,4 +860,3 @@ void save_scratchpad_contents(void)
 	*(scratchpad_address++) = 0x0;
 	*(scratchpad_address++) = (u32) sdram_context_address;
 }
-
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 9a9ea10..c222e77 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -157,15 +157,18 @@ static void omap_serial_kick(void)
 		NSEC_PER_SEC);
 }
 
-void omap_serial_enable_clocks(int enable, int unum)
+void omap_serial_enable_clocks(int enable)
 {
-	if (uart_ick[unum] && uart_fck[unum]) {
-		if (enable) {
-			clk_enable(uart_ick[unum]);
-			clk_enable(uart_fck[unum]);
-		} else {
-			clk_disable(uart_ick[unum]);
-			clk_disable(uart_fck[unum]);
+	int i;
+	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
+		if (uart_ick[i] && uart_fck[i]) {
+			if (enable) {
+				clk_enable(uart_ick[i]);
+				clk_enable(uart_fck[i]);
+			} else {
+				clk_disable(uart_ick[i]);
+				clk_disable(uart_fck[i]);
+			}
 		}
 	}
 }
@@ -300,55 +303,61 @@ void __init omap_serial_init(void)
 	omap_serial_kick();
 }
 
-void omap_save_uart_ctx(int unum)
+void omap_save_uart_ctx(void)
 {
+	int i;
 	u16 lcr = 0;
 
-	struct plat_serial8250_port *p = serial_platform_data + unum;
+	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
+		struct plat_serial8250_port *p = serial_platform_data + i;
 
-	if (uart_ick[unum] == NULL)
-		return;
+		if (!uart_ick[i])
+			continue;
 
-	lcr = serial_read_reg(p, UART_LCR);
-	serial_write_reg(p, UART_LCR, 0xBF);
-	uart_ctx[unum].dll = serial_read_reg(p, UART_DLL);
-	uart_ctx[unum].dlh = serial_read_reg(p, UART_DLM);
-	serial_write_reg(p, UART_LCR, lcr);
-	uart_ctx[unum].ier = serial_read_reg(p, UART_IER);
-	uart_ctx[unum].sysc = serial_read_reg(p, UART_OMAP_SYSC);
-	uart_ctx[unum].scr = serial_read_reg(p, UART_OMAP_SCR);
-	uart_ctx[unum].wer = serial_read_reg(p, UART_OMAP_WER);
+		lcr = serial_read_reg(p, UART_LCR);
+		serial_write_reg(p, UART_LCR, 0xBF);
+		uart_ctx[i].dll = serial_read_reg(p, UART_DLL);
+		uart_ctx[i].dlh = serial_read_reg(p, UART_DLM);
+		serial_write_reg(p, UART_LCR, lcr);
+		uart_ctx[i].ier = serial_read_reg(p, UART_IER);
+		uart_ctx[i].sysc = serial_read_reg(p, UART_OMAP_SYSC);
+		uart_ctx[i].scr = serial_read_reg(p, UART_OMAP_SCR);
+		uart_ctx[i].wer = serial_read_reg(p, UART_OMAP_WER);
+	}
 }
 EXPORT_SYMBOL(omap_save_uart_ctx);
 
-void omap_restore_uart_ctx(int unum)
+void omap_restore_uart_ctx(void)
 {
+	int i;
 	u16 efr = 0;
 
-	struct plat_serial8250_port *p = serial_platform_data + unum;
+	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
+		struct plat_serial8250_port *p = serial_platform_data + i;
 
-	if (uart_ick[unum] == NULL)
-		return;
+		if (!uart_ick[i])
+			continue;
 
-	serial_write_reg(p, UART_OMAP_MDR1, 0x7);
-	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
-	efr = serial_read_reg(p, UART_EFR);
-	serial_write_reg(p, UART_EFR, UART_EFR_ECB);
-	serial_write_reg(p, UART_LCR, 0x0); /* Operational mode */
-	serial_write_reg(p, UART_IER, 0x0);
-	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
-	serial_write_reg(p, UART_DLL, uart_ctx[unum].dll);
-	serial_write_reg(p, UART_DLM, uart_ctx[unum].dlh);
-	serial_write_reg(p, UART_LCR, 0x0); /* Operational mode */
-	serial_write_reg(p, UART_IER, uart_ctx[unum].ier);
-	serial_write_reg(p, UART_FCR, 0xA1);
-	serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
-	serial_write_reg(p, UART_EFR, efr);
-	serial_write_reg(p, UART_LCR, UART_LCR_WLEN8);
-	serial_write_reg(p, UART_OMAP_SCR, uart_ctx[unum].scr);
-	serial_write_reg(p, UART_OMAP_WER, uart_ctx[unum].wer);
-	serial_write_reg(p, UART_OMAP_SYSC, uart_ctx[unum].sysc);
-	serial_write_reg(p, UART_OMAP_MDR1, 0x00); /* UART 16x mode */
+		serial_write_reg(p, UART_OMAP_MDR1, 0x7);
+		serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
+		efr = serial_read_reg(p, UART_EFR);
+		serial_write_reg(p, UART_EFR, UART_EFR_ECB);
+		serial_write_reg(p, UART_LCR, 0x0); /* Operational mode */
+		serial_write_reg(p, UART_IER, 0x0);
+		serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
+		serial_write_reg(p, UART_DLL, uart_ctx[i].dll);
+		serial_write_reg(p, UART_DLM, uart_ctx[i].dlh);
+		serial_write_reg(p, UART_LCR, 0x0); /* Operational mode */
+		serial_write_reg(p, UART_IER, uart_ctx[i].ier);
+		serial_write_reg(p, UART_FCR, 0xA1);
+		serial_write_reg(p, UART_LCR, 0xBF); /* Config B mode */
+		serial_write_reg(p, UART_EFR, efr);
+		serial_write_reg(p, UART_LCR, UART_LCR_WLEN8);
+		serial_write_reg(p, UART_OMAP_SCR, uart_ctx[i].scr);
+		serial_write_reg(p, UART_OMAP_WER, uart_ctx[i].wer);
+		serial_write_reg(p, UART_OMAP_SYSC, uart_ctx[i].sysc);
+		serial_write_reg(p, UART_OMAP_MDR1, 0x00); /* UART 16x mode */
+	}
 }
 EXPORT_SYMBOL(omap_restore_uart_ctx);
 
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index fac8e99..a0da9b6 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -51,6 +51,12 @@ enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
 
 static int enable_1510_mode;
 
+static struct omap_dma_global_context_registers {
+	u32 dma_irqenable_l0;
+	u32 dma_ocp_sysconfig;
+	u32 dma_gcr;
+} omap_dma_global_context;
+
 struct omap_dma_lch {
 	int next_lch;
 	int dev_id;
@@ -2290,6 +2296,26 @@ void omap_stop_lcd_dma(void)
 }
 EXPORT_SYMBOL(omap_stop_lcd_dma);
 
+void omap_dma_global_context_save(void)
+{
+	omap_dma_global_context.dma_irqenable_l0 =
+			dma_read(IRQENABLE_L0);
+	omap_dma_global_context.dma_ocp_sysconfig =
+			dma_read(OCP_SYSCONFIG);
+	omap_dma_global_context.dma_gcr = dma_read(GCR);
+}
+EXPORT_SYMBOL(omap_dma_global_context_save);
+
+void omap_dma_global_context_restore(void)
+{
+	dma_write(omap_dma_global_context.dma_gcr, GCR);
+	dma_write(omap_dma_global_context.dma_ocp_sysconfig,
+			OCP_SYSCONFIG);
+	dma_write(omap_dma_global_context.dma_irqenable_l0,
+			IRQENABLE_L0);
+}
+EXPORT_SYMBOL(omap_dma_global_context_restore);
+
 /*----------------------------------------------------------------------------*/
 
 static int __init omap_init_dma(void)
diff --git a/include/asm-arm/arch-omap/common.h b/include/asm-arm/arch-omap/common.h
index 0f8d3a8..c8b6a83 100644
--- a/include/asm-arm/arch-omap/common.h
+++ b/include/asm-arm/arch-omap/common.h
@@ -34,12 +34,14 @@ struct sys_timer;
 extern void omap_map_common_io(void);
 extern struct sys_timer omap_timer;
 extern void omap_serial_init(void);
-extern void omap_serial_enable_clocks(int enable, int unum);
+extern void omap_serial_enable_clocks(int enable);
 extern int omap_serial_can_sleep(void);
-extern void omap_gpio_save(void);
-extern void omap_gpio_restore(void);
 extern void omap_serial_fclk_mask(u32 *f1, u32 *f2);
 void omap_serial_check_wakeup(void);
+extern void omap_save_uart_ctx(void);
+extern void omap_restore_uart_ctx(void);
+extern void omap_gpio_save(void);
+extern void omap_gpio_restore(void);
 #ifdef CONFIG_I2C_OMAP
 extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
 				 struct i2c_board_info const *info,
-- 
1.5.4.3

