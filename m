From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v6 09/16] OMAP2+: UART: Add runtime pm support for omap-serial driver
Date: Fri, 30 Sep 2011 16:31:35 +0530
Message-ID: <1317380495-584-9-git-send-email-govindraj.raja@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46195 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758265Ab1I3LCE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Sep 2011 07:02:04 -0400
In-Reply-To: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>

Adapts omap-serial driver to use pm_runtime API's.

Use runtime runtime API's to handle uart clocks and obtain
device_usage statics. Set runtime API's usage to irq_safe so that
we can use get_sync from irq context. Auto-suspend for port specific
activities and put for reg access. Use device_may_wakeup to check
whether uart has wakeup capabilities and then enable uart runtime
usage for the uart.

Removing save_context/restore_context functions from serial.c
Adding context restore to .runtime_suspend and using reg values from port
structure to restore the uart port context based on context_loss_count.
Maintain internal state machine using wakeups_enabled field for avoiding
repeated enable/disable of uart port wakeup mechanism.

Remove omap_uart_disable_wakeup and modify omap_uart_enable_wakeup
to accept pdev and bool value to enable/disable the uart wakeup mechanism
after uart clock's are cut. omap_hwmod_enable_wakeup is used to set
pad wakeup for the uarts. PM_WKEN reg values are left to default.
Removed omap_uart_enable/disable_clocks in serial.c now clock handling
done with runtime API's.

By default uart autosuspend delay is set to -1 to avoid character loss
if uart's are autoidled and woken up on rx pin.

After boot up UART's can be autoidled by setting autosuspendi delay from sysfs.

echo 3000 > /sys/devices/platform/omap/omap_uart.X/power/autosuspend_delay_ms
X=0,1,2,3 for UART1/2/3/4. Number of uarts available may vary across omap_soc.

Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c                  |  206 ++----------------------
 arch/arm/plat-omap/include/plat/omap-serial.h |    5 +
 drivers/tty/serial/omap-serial.c              |  169 +++++++++++++++++++--
 3 files changed, 179 insertions(+), 201 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index ca6807c..6725caf 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -33,6 +33,7 @@
 #include <plat/dma.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
+#include <plat/omap-pm.h>
 
 #include "prm2xxx_3xxx.h"
 #include "pm.h"
@@ -41,8 +42,6 @@
 #include "control.h"
 #include "mux.h"
 
-#define UART_OMAP_WER		0x17	/* Wake-up enable register */
-
 #define UART_ERRATA_i202_MDR1_ACCESS	(0x1 << 1)
 
 /*
@@ -57,24 +56,7 @@
 
 struct omap_uart_state {
 	int num;
-	int can_sleep;
 	u32 dma_enabled;
-
-	int clocked;
-
-	int regshift;
-#if defined(CONFIG_ARCH_OMAP3) && defined(CONFIG_PM)
-	int context_valid;
-
-	/* Registers to be saved/restored for OFF-mode */
-	u16 dll;
-	u16 dlh;
-	u16 ier;
-	u16 sysc;
-	u16 scr;
-	u16 wer;
-	u16 mcr;
-#endif
 };
 
 static u8 num_uarts;
@@ -101,34 +83,6 @@ static struct omap_device_pm_latency omap_uart_latency[] = {
 	},
 };
 
-static inline unsigned int __serial_read_reg(struct uart_port *up,
-					     int offset)
-{
-	offset <<= up->regshift;
-	return (unsigned int)__raw_readb(up->membase + offset);
-}
-
-static inline unsigned int serial_read_reg(struct omap_uart_state *uart,
-					   int offset)
-{
-	offset <<= uart->regshift;
-	return (unsigned int)__raw_readb(uart->membase + offset);
-}
-
-static inline void __serial_write_reg(struct uart_port *up, int offset,
-		int value)
-{
-	offset <<= up->regshift;
-	__raw_writeb(value, up->membase + offset);
-}
-
-static inline void serial_write_reg(struct omap_uart_state *uart, int offset,
-				    int value)
-{
-	offset <<= uart->regshift;
-	__raw_writeb(value, uart->membase + offset);
-}
-
 struct omap_hwmod *omap_uart_hwmod_lookup(int num)
 {
 	struct omap_hwmod *oh;
@@ -177,134 +131,8 @@ static void omap_uart_mdr1_errataset(struct omap_uart_state *uart, u8 mdr1_val,
 		udelay(1);
 	}
 }
-
-static void omap_uart_save_context(struct omap_uart_state *uart)
-{
-	u16 lcr = 0;
-
-	if (!enable_off_mode)
-		return;
-
-	lcr = serial_read_reg(uart, UART_LCR);
-	serial_write_reg(uart, UART_LCR, UART_LCR_CONF_MODE_B);
-	uart->dll = serial_read_reg(uart, UART_DLL);
-	uart->dlh = serial_read_reg(uart, UART_DLM);
-	serial_write_reg(uart, UART_LCR, lcr);
-	uart->ier = serial_read_reg(uart, UART_IER);
-	uart->sysc = serial_read_reg(uart, UART_OMAP_SYSC);
-	uart->scr = serial_read_reg(uart, UART_OMAP_SCR);
-	uart->wer = serial_read_reg(uart, UART_OMAP_WER);
-	serial_write_reg(uart, UART_LCR, UART_LCR_CONF_MODE_A);
-	uart->mcr = serial_read_reg(uart, UART_MCR);
-	serial_write_reg(uart, UART_LCR, lcr);
-
-	uart->context_valid = 1;
-}
-
-static void omap_uart_restore_context(struct omap_uart_state *uart)
-{
-	u16 efr = 0;
-
-	if (!enable_off_mode)
-		return;
-
-	if (!uart->context_valid)
-		return;
-
-	uart->context_valid = 0;
-
-	if (uart->errata & UART_ERRATA_i202_MDR1_ACCESS)
-		omap_uart_mdr1_errataset(uart, UART_OMAP_MDR1_DISABLE, 0xA0);
-	else
-		serial_write_reg(uart, UART_OMAP_MDR1, UART_OMAP_MDR1_DISABLE);
-
-	serial_write_reg(uart, UART_LCR, UART_LCR_CONF_MODE_B);
-	efr = serial_read_reg(uart, UART_EFR);
-	serial_write_reg(uart, UART_EFR, UART_EFR_ECB);
-	serial_write_reg(uart, UART_LCR, 0x0); /* Operational mode */
-	serial_write_reg(uart, UART_IER, 0x0);
-	serial_write_reg(uart, UART_LCR, UART_LCR_CONF_MODE_B);
-	serial_write_reg(uart, UART_DLL, uart->dll);
-	serial_write_reg(uart, UART_DLM, uart->dlh);
-	serial_write_reg(uart, UART_LCR, 0x0); /* Operational mode */
-	serial_write_reg(uart, UART_IER, uart->ier);
-	serial_write_reg(uart, UART_LCR, UART_LCR_CONF_MODE_A);
-	serial_write_reg(uart, UART_MCR, uart->mcr);
-	serial_write_reg(uart, UART_LCR, UART_LCR_CONF_MODE_B);
-	serial_write_reg(uart, UART_EFR, efr);
-	serial_write_reg(uart, UART_LCR, UART_LCR_WLEN8);
-	serial_write_reg(uart, UART_OMAP_SCR, uart->scr);
-	serial_write_reg(uart, UART_OMAP_WER, uart->wer);
-	serial_write_reg(uart, UART_OMAP_SYSC, uart->sysc);
-
-	if (uart->errata & UART_ERRATA_i202_MDR1_ACCESS)
-		omap_uart_mdr1_errataset(uart, UART_OMAP_MDR1_16X_MODE, 0xA1);
-	else
-		/* UART 16x mode */
-		serial_write_reg(uart, UART_OMAP_MDR1,
-				UART_OMAP_MDR1_16X_MODE);
-}
-#else
-static inline void omap_uart_save_context(struct omap_uart_state *uart) {}
-static inline void omap_uart_restore_context(struct omap_uart_state *uart) {}
 #endif /* CONFIG_PM && CONFIG_ARCH_OMAP3 */
 
-static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
-{
-	if (uart->clocked)
-		return;
-
-	omap_device_enable(uart->pdev);
-	uart->clocked = 1;
-	omap_uart_restore_context(uart);
-}
-
-#ifdef CONFIG_PM
-
-static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
-{
-	if (!uart->clocked)
-		return;
-
-	omap_uart_save_context(uart);
-	uart->clocked = 0;
-	omap_device_idle(uart->pdev);
-}
-
-static void omap_uart_enable_wakeup(struct omap_uart_state *uart)
-{
-	/* Set wake-enable bit */
-	if (uart->wk_en && uart->wk_mask) {
-		u32 v = __raw_readl(uart->wk_en);
-		v |= uart->wk_mask;
-		__raw_writel(v, uart->wk_en);
-	}
-
-	/* Ensure IOPAD wake-enables are set */
-	if (cpu_is_omap34xx() && uart->padconf) {
-		u16 v = omap_ctrl_readw(uart->padconf);
-		v |= OMAP3_PADCONF_WAKEUPENABLE0;
-		omap_ctrl_writew(v, uart->padconf);
-	}
-}
-
-static void omap_uart_disable_wakeup(struct omap_uart_state *uart)
-{
-	/* Clear wake-enable bit */
-	if (uart->wk_en && uart->wk_mask) {
-		u32 v = __raw_readl(uart->wk_en);
-		v &= ~uart->wk_mask;
-		__raw_writel(v, uart->wk_en);
-	}
-
-	/* Ensure IOPAD wake-enables are cleared */
-	if (cpu_is_omap34xx() && uart->padconf) {
-		u16 v = omap_ctrl_readw(uart->padconf);
-		v &= ~OMAP3_PADCONF_WAKEUPENABLE0;
-		omap_ctrl_writew(v, uart->padconf);
-	}
-}
-
 static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
 					       int enable)
 {
@@ -326,14 +154,6 @@ static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
 	omap_hwmod_set_slave_idlemode(uart->oh, idlemode);
 }
 
-static void omap_uart_block_sleep(struct omap_uart_state *uart)
-{
-	omap_uart_enable_clocks(uart);
-
-	omap_uart_smart_idle_enable(uart, 0);
-	uart->can_sleep = 0;
-}
-
 int omap_uart_can_sleep(void)
 {
 	struct omap_uart_state *uart;
@@ -483,12 +303,22 @@ static void omap_serial_fill_default_pads(struct omap_board_data *bdata)
 	}
 }
 
-#else
-static void omap_uart_block_sleep(struct omap_uart_state *uart)
+static void omap_uart_enable_wakeup(struct platform_device *pdev, bool enable)
 {
-	/* Needed to enable UART clocks when built without CONFIG_PM */
-	omap_uart_enable_clocks(uart);
+	struct omap_device *od = to_omap_device(pdev);
+
+	if (!od)
+		return;
+
+	if (enable)
+		omap_hwmod_enable_wakeup(od->hwmods[0]);
+	else
+		omap_hwmod_disable_wakeup(od->hwmods[0]);
 }
+
+#else
+static void omap_uart_enable_wakeup(struct platform_device *pdev, bool enable)
+{}
 #endif /* CONFIG_PM */
 
 static int __init omap_serial_early_init(void)
@@ -559,6 +389,8 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 
 	pdata->uartclk = OMAP24XX_BASE_BAUD * 16;
 	pdata->flags = UPF_BOOT_AUTOCONF;
+	pdata->enable_wakeup = omap_uart_enable_wakeup;
+	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
 
 	/* Enable the MDR1 errata for OMAP3 */
 	if (cpu_is_omap34xx() && !cpu_is_ti816x())
@@ -582,12 +414,10 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	omap_hwmod_idle(oh);
 
 	omap_device_enable(pdev);
-	omap_hwmod_enable_wakeup(oh);
 
 	console_unlock();
 
-	if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads) ||
-		(pdata->wk_en && pdata->wk_mask))
+	if ((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads)
 		device_init_wakeup(&pdev->dev, true);
 
 	kfree(pdata);
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 74822b3..8ef81ce 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -62,6 +62,9 @@ struct omap_uart_port_info {
 	upf_t			flags;		/* UPF_* flags */
 
 	u32			errata;
+
+	void (*enable_wakeup)(struct platform_device *, bool);
+	u32 (*get_context_loss_count)(struct device *);
 };
 
 struct uart_omap_dma {
@@ -113,6 +116,8 @@ struct uart_omap_port {
 	unsigned char		msr_saved_flags;
 	char			name[20];
 	unsigned long		port_activity;
+	u32			context_loss_cnt;
+	u8			wakeups_enabled;
 };
 
 #endif /* __OMAP_SERIAL_H__ */
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 9a0eac2..43c33da 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -37,11 +37,14 @@
 #include <linux/clk.h>
 #include <linux/serial_core.h>
 #include <linux/irq.h>
+#include <linux/pm_runtime.h>
 
 #include <plat/dma.h>
 #include <plat/dmtimer.h>
 #include <plat/omap-serial.h>
 
+#define OMAP_UART_AUTOSUSPEND_DELAY -1
+
 static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 
 /* Forward declaration of functions */
@@ -102,6 +105,8 @@ static void serial_omap_stop_rxdma(struct uart_omap_port *up)
 		omap_free_dma(up->uart_dma.rx_dma_channel);
 		up->uart_dma.rx_dma_channel = OMAP_UART_DMA_CH_FREE;
 		up->uart_dma.rx_dma_used = false;
+		pm_runtime_mark_last_busy(&up->pdev->dev);
+		pm_runtime_put_autosuspend(&up->pdev->dev);
 	}
 }
 
@@ -110,8 +115,11 @@ static void serial_omap_enable_ms(struct uart_port *port)
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
 
 	dev_dbg(up->port.dev, "serial_omap_enable_ms+%d\n", up->pdev->id);
+
+	pm_runtime_get_sync(&up->pdev->dev);
 	up->ier |= UART_IER_MSI;
 	serial_out(up, UART_IER, up->ier);
+	pm_runtime_put(&up->pdev->dev);
 }
 
 static void serial_omap_stop_tx(struct uart_port *port)
@@ -129,23 +137,32 @@ static void serial_omap_stop_tx(struct uart_port *port)
 		omap_stop_dma(up->uart_dma.tx_dma_channel);
 		omap_free_dma(up->uart_dma.tx_dma_channel);
 		up->uart_dma.tx_dma_channel = OMAP_UART_DMA_CH_FREE;
+		pm_runtime_mark_last_busy(&up->pdev->dev);
+		pm_runtime_put_autosuspend(&up->pdev->dev);
 	}
 
+	pm_runtime_get_sync(&up->pdev->dev);
 	if (up->ier & UART_IER_THRI) {
 		up->ier &= ~UART_IER_THRI;
 		serial_out(up, UART_IER, up->ier);
 	}
+
+	pm_runtime_mark_last_busy(&up->pdev->dev);
+	pm_runtime_put_autosuspend(&up->pdev->dev);
 }
 
 static void serial_omap_stop_rx(struct uart_port *port)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
 
+	pm_runtime_get_sync(&up->pdev->dev);
 	if (up->use_dma)
 		serial_omap_stop_rxdma(up);
 	up->ier &= ~UART_IER_RLSI;
 	up->port.read_status_mask &= ~UART_LSR_DR;
 	serial_out(up, UART_IER, up->ier);
+	pm_runtime_mark_last_busy(&up->pdev->dev);
+	pm_runtime_put_autosuspend(&up->pdev->dev);
 }
 
 static inline void receive_chars(struct uart_omap_port *up, int *status)
@@ -262,7 +279,10 @@ static void serial_omap_start_tx(struct uart_port *port)
 	int ret = 0;
 
 	if (!up->use_dma) {
+		pm_runtime_get_sync(&up->pdev->dev);
 		serial_omap_enable_ier_thri(up);
+		pm_runtime_mark_last_busy(&up->pdev->dev);
+		pm_runtime_put_autosuspend(&up->pdev->dev);
 		return;
 	}
 
@@ -272,6 +292,7 @@ static void serial_omap_start_tx(struct uart_port *port)
 	xmit = &up->port.state->xmit;
 
 	if (up->uart_dma.tx_dma_channel == OMAP_UART_DMA_CH_FREE) {
+		pm_runtime_get_sync(&up->pdev->dev);
 		ret = omap_request_dma(up->uart_dma.uart_dma_tx,
 				"UART Tx DMA",
 				(void *)uart_tx_dma_callback, up,
@@ -354,9 +375,13 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
 	unsigned int iir, lsr;
 	unsigned long flags;
 
+	pm_runtime_get_sync(&up->pdev->dev);
 	iir = serial_in(up, UART_IIR);
-	if (iir & UART_IIR_NO_INT)
+	if (iir & UART_IIR_NO_INT) {
+		pm_runtime_mark_last_busy(&up->pdev->dev);
+		pm_runtime_put_autosuspend(&up->pdev->dev);
 		return IRQ_NONE;
+	}
 
 	spin_lock_irqsave(&up->port.lock, flags);
 	lsr = serial_in(up, UART_LSR);
@@ -378,6 +403,9 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
 		transmit_chars(up);
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
+	pm_runtime_mark_last_busy(&up->pdev->dev);
+	pm_runtime_put_autosuspend(&up->pdev->dev);
+
 	up->port_activity = jiffies;
 	return IRQ_HANDLED;
 }
@@ -388,11 +416,12 @@ static unsigned int serial_omap_tx_empty(struct uart_port *port)
 	unsigned long flags = 0;
 	unsigned int ret = 0;
 
+	pm_runtime_get_sync(&up->pdev->dev);
 	dev_dbg(up->port.dev, "serial_omap_tx_empty+%d\n", up->pdev->id);
 	spin_lock_irqsave(&up->port.lock, flags);
 	ret = serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
 	spin_unlock_irqrestore(&up->port.lock, flags);
-
+	pm_runtime_put(&up->pdev->dev);
 	return ret;
 }
 
@@ -402,7 +431,10 @@ static unsigned int serial_omap_get_mctrl(struct uart_port *port)
 	unsigned char status;
 	unsigned int ret = 0;
 
+	pm_runtime_get_sync(&up->pdev->dev);
 	status = check_modem_status(up);
+	pm_runtime_put(&up->pdev->dev);
+
 	dev_dbg(up->port.dev, "serial_omap_get_mctrl+%d\n", up->pdev->id);
 
 	if (status & UART_MSR_DCD)
@@ -433,9 +465,11 @@ static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	if (mctrl & TIOCM_LOOP)
 		mcr |= UART_MCR_LOOP;
 
+	pm_runtime_get_sync(&up->pdev->dev);
 	up->mcr = serial_in(up, UART_MCR);
 	up->mcr |= mcr;
 	serial_out(up, UART_MCR, up->mcr);
+	pm_runtime_put(&up->pdev->dev);
 }
 
 static void serial_omap_break_ctl(struct uart_port *port, int break_state)
@@ -444,6 +478,7 @@ static void serial_omap_break_ctl(struct uart_port *port, int break_state)
 	unsigned long flags = 0;
 
 	dev_dbg(up->port.dev, "serial_omap_break_ctl+%d\n", up->pdev->id);
+	pm_runtime_get_sync(&up->pdev->dev);
 	spin_lock_irqsave(&up->port.lock, flags);
 	if (break_state == -1)
 		up->lcr |= UART_LCR_SBC;
@@ -451,6 +486,7 @@ static void serial_omap_break_ctl(struct uart_port *port, int break_state)
 		up->lcr &= ~UART_LCR_SBC;
 	serial_out(up, UART_LCR, up->lcr);
 	spin_unlock_irqrestore(&up->port.lock, flags);
+	pm_runtime_put(&up->pdev->dev);
 }
 
 static int serial_omap_startup(struct uart_port *port)
@@ -469,6 +505,7 @@ static int serial_omap_startup(struct uart_port *port)
 
 	dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->pdev->id);
 
+	pm_runtime_get_sync(&up->pdev->dev);
 	/*
 	 * Clear the FIFO buffers and disable them.
 	 * (they will be reenabled in set_termios())
@@ -524,6 +561,8 @@ static int serial_omap_startup(struct uart_port *port)
 	/* Enable module level wake up */
 	serial_out(up, UART_OMAP_WER, OMAP_UART_WER_MOD_WKUP);
 
+	pm_runtime_mark_last_busy(&up->pdev->dev);
+	pm_runtime_put_autosuspend(&up->pdev->dev);
 	up->port_activity = jiffies;
 	return 0;
 }
@@ -534,6 +573,8 @@ static void serial_omap_shutdown(struct uart_port *port)
 	unsigned long flags = 0;
 
 	dev_dbg(up->port.dev, "serial_omap_shutdown+%d\n", up->pdev->id);
+
+	pm_runtime_get_sync(&up->pdev->dev);
 	/*
 	 * Disable interrupts from this port
 	 */
@@ -567,6 +608,7 @@ static void serial_omap_shutdown(struct uart_port *port)
 			up->uart_dma.rx_buf_dma_phys);
 		up->uart_dma.rx_buf = NULL;
 	}
+	pm_runtime_put(&up->pdev->dev);
 	free_irq(up->port.irq, up);
 }
 
@@ -682,6 +724,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * Ok, we're now changing the port state. Do it with
 	 * interrupts disabled.
 	 */
+	pm_runtime_get_sync(&up->pdev->dev);
 	spin_lock_irqsave(&up->port.lock, flags);
 
 	/*
@@ -814,6 +857,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_omap_configure_xonxoff(up, termios);
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
+	pm_runtime_put(&up->pdev->dev);
 	dev_dbg(up->port.dev, "serial_omap_set_termios+%d\n", up->pdev->id);
 }
 
@@ -825,6 +869,8 @@ serial_omap_pm(struct uart_port *port, unsigned int state,
 	unsigned char efr;
 
 	dev_dbg(up->port.dev, "serial_omap_pm+%d\n", up->pdev->id);
+
+	pm_runtime_get_sync(&up->pdev->dev);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	efr = serial_in(up, UART_EFR);
 	serial_out(up, UART_EFR, efr | UART_EFR_ECB);
@@ -834,6 +880,7 @@ serial_omap_pm(struct uart_port *port, unsigned int state,
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_EFR, efr);
 	serial_out(up, UART_LCR, 0);
+	pm_runtime_put(&up->pdev->dev);
 }
 
 static void serial_omap_release_port(struct uart_port *port)
@@ -911,19 +958,26 @@ static inline void wait_for_xmitr(struct uart_omap_port *up)
 static void serial_omap_poll_put_char(struct uart_port *port, unsigned char ch)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
+
+	pm_runtime_get_sync(&up->pdev->dev);
 	wait_for_xmitr(up);
 	serial_out(up, UART_TX, ch);
+	pm_runtime_put(&up->pdev->dev);
 }
 
 static int serial_omap_poll_get_char(struct uart_port *port)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
-	unsigned int status = serial_in(up, UART_LSR);
+	unsigned int status;
 
+	pm_runtime_get_sync(&up->pdev->dev);
+	status = serial_in(up, UART_LSR);
 	if (!(status & UART_LSR_DR))
 		return NO_POLL_CHAR;
 
-	return serial_in(up, UART_RX);
+	status = serial_in(up, UART_RX);
+	pm_runtime_put(&up->pdev->dev);
+	return status;
 }
 
 #endif /* CONFIG_CONSOLE_POLL */
@@ -951,6 +1005,8 @@ serial_omap_console_write(struct console *co, const char *s,
 	unsigned int ier;
 	int locked = 1;
 
+	pm_runtime_get_sync(&up->pdev->dev);
+
 	local_irq_save(flags);
 	if (up->port.sysrq)
 		locked = 0;
@@ -983,6 +1039,8 @@ serial_omap_console_write(struct console *co, const char *s,
 	if (up->msr_saved_flags)
 		check_modem_status(up);
 
+	pm_runtime_mark_last_busy(&up->pdev->dev);
+	pm_runtime_put_autosuspend(&up->pdev->dev);
 	if (locked)
 		spin_unlock(&up->port.lock);
 	local_irq_restore(flags);
@@ -1065,19 +1123,18 @@ static struct uart_driver serial_omap_reg = {
 	.cons		= OMAP_CONSOLE,
 };
 
-static int
-serial_omap_suspend(struct platform_device *pdev, pm_message_t state)
+static int serial_omap_suspend(struct device *dev)
 {
-	struct uart_omap_port *up = platform_get_drvdata(pdev);
+	struct uart_omap_port *up = dev_get_drvdata(dev);
 
 	if (up)
 		uart_suspend_port(&serial_omap_reg, &up->port);
 	return 0;
 }
 
-static int serial_omap_resume(struct platform_device *dev)
+static int serial_omap_resume(struct device *dev)
 {
-	struct uart_omap_port *up = platform_get_drvdata(dev);
+	struct uart_omap_port *up = dev_get_drvdata(dev);
 
 	if (up)
 		uart_resume_port(&serial_omap_reg, &up->port);
@@ -1140,6 +1197,7 @@ static int serial_omap_start_rxdma(struct uart_omap_port *up)
 	int ret = 0;
 
 	if (up->uart_dma.rx_dma_channel == -1) {
+		pm_runtime_get_sync(&up->pdev->dev);
 		ret = omap_request_dma(up->uart_dma.uart_dma_rx,
 				"UART Rx DMA",
 				(void *)uart_rx_dma_callback, up,
@@ -1305,6 +1363,16 @@ static int serial_omap_probe(struct platform_device *pdev)
 		up->uart_dma.rx_dma_channel = OMAP_UART_DMA_CH_FREE;
 	}
 
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev,
+			OMAP_UART_AUTOSUSPEND_DELAY);
+
+	pm_runtime_irq_safe(&pdev->dev);
+	if (device_may_wakeup(&pdev->dev)) {
+		pm_runtime_enable(&pdev->dev);
+		pm_runtime_get_sync(&pdev->dev);
+	}
+
 	ui[pdev->id] = up;
 	serial_omap_add_console_port(up);
 
@@ -1312,6 +1380,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 	if (ret != 0)
 		goto do_release_region;
 
+	pm_runtime_put(&pdev->dev);
 	platform_set_drvdata(pdev, up);
 	return 0;
 err:
@@ -1326,22 +1395,96 @@ static int serial_omap_remove(struct platform_device *dev)
 {
 	struct uart_omap_port *up = platform_get_drvdata(dev);
 
-	platform_set_drvdata(dev, NULL);
 	if (up) {
+		pm_runtime_disable(&up->pdev->dev);
 		uart_remove_one_port(&serial_omap_reg, &up->port);
 		kfree(up);
 	}
+
+	platform_set_drvdata(dev, NULL);
+	return 0;
+}
+
+static void serial_omap_restore_context(struct uart_omap_port *up)
+{
+	serial_out(up, UART_OMAP_MDR1, up->mdr1);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B); /* Config B mode */
+	serial_out(up, UART_EFR, UART_EFR_ECB);
+	serial_out(up, UART_LCR, 0x0); /* Operational mode */
+	serial_out(up, UART_IER, 0x0);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B); /* Config B mode */
+	serial_out(up, UART_DLL, up->dll);
+	serial_out(up, UART_DLM, up->dlh);
+	serial_out(up, UART_LCR, 0x0); /* Operational mode */
+	serial_out(up, UART_IER, up->ier);
+	serial_out(up, UART_FCR, up->fcr);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
+	serial_out(up, UART_MCR, up->mcr);
+	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B); /* Config B mode */
+	serial_out(up, UART_EFR, up->efr);
+	serial_out(up, UART_LCR, up->lcr);
+	/* UART 16x mode */
+	serial_out(up, UART_OMAP_MDR1, up->mdr1);
+}
+
+static int serial_omap_runtime_suspend(struct device *dev)
+{
+	struct uart_omap_port *up = dev_get_drvdata(dev);
+	struct omap_uart_port_info *pdata = dev->platform_data;
+
+	if (!up)
+		return -EINVAL;
+
+	if (!pdata->enable_wakeup || !pdata->get_context_loss_count)
+		return 0;
+
+	if (pdata->get_context_loss_count)
+		up->context_loss_cnt = pdata->get_context_loss_count(dev);
+
+	if (device_may_wakeup(dev)) {
+		if (!up->wakeups_enabled) {
+			pdata->enable_wakeup(up->pdev, true);
+			up->wakeups_enabled = true;
+		}
+	} else {
+		if (up->wakeups_enabled) {
+			pdata->enable_wakeup(up->pdev, false);
+			up->wakeups_enabled = false;
+		}
+	}
+
+	return 0;
+}
+
+static int serial_omap_runtime_resume(struct device *dev)
+{
+	struct uart_omap_port *up = dev_get_drvdata(dev);
+	struct omap_uart_port_info *pdata = dev->platform_data;
+
+	if (up) {
+		if (pdata->get_context_loss_count) {
+			u32 loss_cnt = pdata->get_context_loss_count(dev);
+
+			if (up->context_loss_cnt != loss_cnt)
+				serial_omap_restore_context(up);
+		}
+	}
+
 	return 0;
 }
 
+static const struct dev_pm_ops serial_omap_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(serial_omap_suspend, serial_omap_resume)
+	SET_RUNTIME_PM_OPS(serial_omap_runtime_suspend,
+				serial_omap_runtime_resume, NULL)
+};
+
 static struct platform_driver serial_omap_driver = {
 	.probe          = serial_omap_probe,
 	.remove         = serial_omap_remove,
-
-	.suspend	= serial_omap_suspend,
-	.resume		= serial_omap_resume,
 	.driver		= {
 		.name	= DRIVER_NAME,
+		.pm	= &serial_omap_dev_pm_ops,
 	},
 };
 
-- 
1.7.4.1

