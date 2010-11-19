From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 10/13] OMAP3: PM: Errata i582: per domain reset issue: uart
Date: Thu, 18 Nov 2010 19:54:55 -0600
Message-ID: <1290131698-6194-11-git-send-email-nm@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51918 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756732Ab0KSBzD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Nov 2010 20:55:03 -0500
In-Reply-To: <1290131698-6194-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@deeprootsystems.com>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

From: Archana Sriram <archana.sriram@ti.com>

Errata Id:i582

PER Domain reset issue after Domain-OFF/OSWR Wakeup.

Issue:
When Peripheral Power Domain (PER-PD) is woken up from OFF / OSWR
state while Core Power Domain (CORE-PD) is kept active, write or
read access to some internal memory (e.g., UART3 FIFO) does not
work correctly.

Workaround :
* Prevent PER from going off when CORE has not gone to off.
* When both CORE-PD and PER-PD goes into OSWR/OFF, PER-PD should be
brought to active before CORE-PD.This can be done by configuring a wakeup
dependency so that CORE-PD and PER-PD will wake up at the same time.

Acked-by: Tero Kristo <tero.kristo@nokia.com>
Tested-by: Eduardo Valentin <eduardo.valentin@nokia.com>
Tested-by: Westerberg Mika <ext-mika.1.westerberg@nokia.com>

[vishwanath.bs@ti.com: initial code and suggestions]
Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
[nm@ti.com: forward ported to 2.6.37-rc2 and suggestions]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Archana Sriram <archana.sriram@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c             |   41 +++++++++++++++-
 arch/arm/mach-omap2/serial.c             |   80 ++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/serial.h |    4 ++
 3 files changed, 124 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index c7e2db0..218d0b0 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -84,6 +84,10 @@ static struct powerdomain *cam_pwrdm;
 static int secure_ram_save_status;
 static int secure_ram_saved;
 
+#define PER_WAKEUP_ERRATA_i582	(1 << 0)
+static u16 pm34xx_errata;
+#define IS_PM34XX_ERRATA(id)	(pm34xx_errata & (id))
+
 static inline void omap3_per_save_context(void)
 {
 	omap_gpio_save_context();
@@ -371,7 +375,8 @@ void omap_sram_idle(void)
 	int mpu_next_state = PWRDM_POWER_ON;
 	int per_next_state = PWRDM_POWER_ON;
 	int core_next_state = PWRDM_POWER_ON;
-	int core_prev_state, per_prev_state;
+	int core_prev_state = PWRDM_POWER_ON;
+	int per_prev_state = PWRDM_POWER_ON;
 	u32 sdrc_pwr = 0;
 
 	if (!_omap_sram_idle)
@@ -496,6 +501,23 @@ void omap_sram_idle(void)
 			omap3_per_restore_context();
 		omap_uart_resume_idle(2);
 		omap_uart_resume_idle(3);
+		if (IS_PM34XX_ERRATA(PER_WAKEUP_ERRATA_i582) &&
+				omap_uart_check_per_uarts_used() &&
+				(core_prev_state == PWRDM_POWER_ON) &&
+				(per_prev_state == PWRDM_POWER_OFF)) {
+			/*
+			 * We dont seem to have a real recovery other than reset
+			 * Errata i582:Alternative available here is to do a
+			 * reboot OR go to per off/core off, we will just print
+			 * and cause uart to be in an unstable state and
+			 * continue on till we hit the next off transition.
+			 * Reboot of the device due to this corner case is
+			 * undesirable.
+			 */
+			if (omap_uart_per_errata())
+				pr_err("%s: PER UART hit with Errata i582 "
+					"Corner case.\n", __func__);
+		}
 	}
 
 	/* Disable IO-PAD and IO-CHAIN wakeup */
@@ -1021,15 +1043,27 @@ void omap_push_sram_idle(void)
 				save_secure_ram_context_sz);
 }
 
+static void pm_errata_configure(void)
+{
+	if (cpu_is_omap34xx()) {
+		pm34xx_errata |= PER_WAKEUP_ERRATA_i582;
+		if (cpu_is_omap3630() && (omap_rev() > OMAP3630_REV_ES1_1))
+			pm34xx_errata &= ~PER_WAKEUP_ERRATA_i582;
+	}
+}
+
 static int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst, *tmp;
 	struct clockdomain *neon_clkdm, *per_clkdm, *mpu_clkdm, *core_clkdm;
+	struct clockdomain *wkup_clkdm;
 	int ret;
 
 	if (!cpu_is_omap34xx())
 		return -ENODEV;
 
+	pm_errata_configure();
+
 	printk(KERN_ERR "Power Management for TI OMAP3.\n");
 
 	/* XXX prcm_setup_regs needs to be before enabling hw
@@ -1067,6 +1101,7 @@ static int __init omap3_pm_init(void)
 	neon_clkdm = clkdm_lookup("neon_clkdm");
 	mpu_clkdm = clkdm_lookup("mpu_clkdm");
 	per_clkdm = clkdm_lookup("per_clkdm");
+	wkup_clkdm = clkdm_lookup("wkup_clkdm");
 	core_clkdm = clkdm_lookup("core_clkdm");
 
 	omap_push_sram_idle();
@@ -1077,6 +1112,10 @@ static int __init omap3_pm_init(void)
 	pm_idle = omap3_pm_idle;
 	omap3_idle_init();
 
+	/* Allow per to wakeup the system if errata is applicable */
+	if (IS_PM34XX_ERRATA(PER_WAKEUP_ERRATA_i582) && cpu_is_omap34xx())
+		clkdm_add_wkdep(per_clkdm, wkup_clkdm);
+
 	clkdm_add_wkdep(neon_clkdm, mpu_clkdm);
 
 	omap3_save_scratchpad_contents();
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index becf0e3..43c2ec4 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -273,6 +273,86 @@ static void omap_uart_restore_context(struct omap_uart_state *uart)
 		/* UART 16x mode */
 		serial_write_reg(uart, UART_OMAP_MDR1, 0x00);
 }
+
+static inline int _is_per_uart(struct omap_uart_state *uart)
+{
+	if (cpu_is_omap34xx() && (uart->num == 2 || uart->num == 3))
+		return 1;
+	return 0;
+}
+
+int omap_uart_check_per_uarts_used(void)
+{
+	struct omap_uart_state *uart;
+
+	list_for_each_entry(uart, &uart_list, node) {
+		if (_is_per_uart(uart))
+			return 1;
+	}
+	return 0;
+}
+
+/*
+ * Errata i582 affects PER UARTS..Loop back test is done to
+ * check the UART state when the corner case is encountered
+ */
+static int omap_uart_loopback_test(struct omap_uart_state *uart)
+{
+	u8 loopbk_rhr = 0;
+
+	omap_uart_save_context(uart);
+	serial_write_reg(uart, UART_OMAP_MDR1, 0x7);
+	serial_write_reg(uart, UART_LCR, 0xBF); /* Config B mode */
+	serial_write_reg(uart, UART_DLL, uart->dll);
+	serial_write_reg(uart, UART_DLM, uart->dlh);
+	serial_write_reg(uart, UART_LCR, 0x0); /* Operational mode */
+	/* configure uart3 in UART mode */
+	serial_write_reg(uart, UART_OMAP_MDR1, 0x00); /* UART 16x mode */
+	serial_write_reg(uart, UART_LCR, 0x80);
+	/* Enable internal loop back mode by setting MCR_REG[4].LOOPBACK_EN */
+	serial_write_reg(uart, UART_MCR, 0x10);
+
+	/* write to THR,read RHR and compare */
+	/* Tx output is internally looped back to Rx input in loop back mode */
+	serial_write_reg(uart, UART_LCR_DLAB, 0x00);
+	/* Enables write to THR and read from RHR */
+	serial_write_reg(uart, UART_TX, 0xCC); /* writing data to THR */
+	/* reading data from RHR */
+	loopbk_rhr = (serial_read_reg(uart, UART_RX) & 0xFF);
+	if (loopbk_rhr == 0xCC) {
+		/* compare passes,try comparing with different data */
+		serial_write_reg(uart, UART_TX, 0x69);
+		loopbk_rhr = (serial_read_reg(uart, UART_RX) & 0xFF);
+		if (loopbk_rhr == 0x69) {
+			/* compare passes,reset UART3 and re-configure module */
+			omap_uart_reset(uart);
+			omap_uart_restore_context(uart);
+			return 0;
+		}
+	} else {	/* requires warm reset */
+		return -ENODEV;
+	}
+	return 0;
+}
+
+int omap_uart_per_errata(void)
+{
+	struct omap_uart_state *uart;
+
+	/* For all initialised UART modules that are in PER domain
+	 * do loopback test
+	 */
+	list_for_each_entry(uart, &uart_list, node) {
+		if (_is_per_uart(uart)) {
+			if (omap_uart_loopback_test(uart))
+				return -ENODEV;
+			else
+				return 0;
+		}
+	}
+	return 0;
+}
+
 #else
 static inline void omap_uart_save_context(struct omap_uart_state *uart) {}
 static inline void omap_uart_restore_context(struct omap_uart_state *uart) {}
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index 19145f5..81169b2 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -102,6 +102,10 @@ extern void omap_uart_prepare_suspend(void);
 extern void omap_uart_prepare_idle(int num);
 extern void omap_uart_resume_idle(int num);
 extern void omap_uart_enable_irqs(int enable);
+#ifdef CONFIG_PM
+extern int omap_uart_per_errata(void);
+extern int omap_uart_check_per_uarts_used(void);
+#endif
 #endif
 
 #endif
-- 
1.6.3.3

