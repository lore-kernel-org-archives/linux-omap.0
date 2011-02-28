From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 5/7] Serial: OMAP: add runtime pm support for omap-serial driver
Date: Mon, 28 Feb 2011 20:09:16 +0530
Message-ID: <1298903958-6496-6-git-send-email-govindraj.raja@ti.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46144 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754345Ab1B1OQF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 28 Feb 2011 09:16:05 -0500
In-Reply-To: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Govindraj.R" <govindraj.raja@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

Adapts omap-serial driver to use pm_runtime api's.

1.) Populate reg values to uart port which can be used for context restore.
2.) Moved Erratum handling func to driver from serial.c
3.) adding port_enable/disable func to enable/disable given uart port.
4.) using prepare/resume api's to cut and enable back uart func_clks.
5.) using timer to set flag to cut uart clocks based on this flag in
    sram_idle path.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 drivers/tty/serial/omap-serial.c |  304 +++++++++++++++++++++++++++++++++++---
 1 files changed, 283 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index d40924a..bc877b9 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -33,10 +33,21 @@
 #include <linux/clk.h>
 #include <linux/serial_core.h>
 #include <linux/irq.h>
+#include <linux/pm_runtime.h>
 
 #include <plat/dma.h>
 #include <plat/dmtimer.h>
 #include <plat/omap-serial.h>
+#include <plat/serial.h>
+#include <plat/omap_device.h>
+
+#ifdef CONFIG_SERIAL_OMAP_CONSOLE
+#define omap_uart_console(port) ((port)->cons && (port)->cons->index == (port)->line)
+#else
+#define omap_uart_console(port)	NULL
+#endif
+
+#define OMAP_UART_CLK_PUT_DELAY (5 * HZ)
 
 static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 
@@ -44,6 +55,7 @@ static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 static void uart_tx_dma_callback(int lch, u16 ch_status, void *data);
 static void serial_omap_rx_timeout(unsigned long uart_no);
 static int serial_omap_start_rxdma(struct uart_omap_port *up);
+static void omap_uart_mdr1_errataset(struct uart_omap_port *up);
 
 static inline unsigned int serial_in(struct uart_omap_port *up, int offset)
 {
@@ -90,6 +102,73 @@ serial_omap_get_divisor(struct uart_port *port, unsigned int baud)
 	return port->uartclk/(baud * divisor);
 }
 
+static void omap_uart_smart_idle(struct uart_omap_port *up)
+{
+	struct platform_device *pdev = up->pdev;
+	struct omap_device *od = container_of(pdev, struct omap_device, pdev);
+
+	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_SMART);
+}
+
+static void serial_omap_port_disable(struct uart_omap_port *up)
+{
+	if (!pm_runtime_suspended(&up->pdev->dev)) {
+		del_timer(&up->inactivity_timer);
+		if (omap_uart_console(&up->port))
+			console_stop(up->port.cons);
+
+		pm_runtime_put_sync(&up->pdev->dev);
+	}
+}
+
+static void serial_omap_inactivity_timer(unsigned long uart_no)
+{
+	struct uart_omap_port *up = ui[uart_no];
+
+	up->can_sleep = 1;
+	omap_uart_smart_idle(up);
+}
+
+static void serial_omap_port_enable(struct uart_omap_port *up)
+{
+	if (pm_runtime_suspended(&up->pdev->dev)) {
+		if (omap_uart_console(&up->port))
+			console_start(up->port.cons);
+
+		pm_runtime_get_sync(&up->pdev->dev);
+	}
+
+	up->can_sleep = 0;
+	mod_timer(&up->inactivity_timer, jiffies + OMAP_UART_CLK_PUT_DELAY);
+}
+
+void omap_uart_prepare_idle(int num)
+{
+	struct uart_omap_port *up = ui[num];
+
+	if (up && up->can_sleep)
+		serial_omap_port_disable(up);
+}
+
+void omap_uart_resume_idle(int num)
+{
+	struct uart_omap_port *up = ui[num];
+	struct omap_device *od;
+	struct platform_device *pdev;
+
+	if (!up)
+		return;
+
+	pdev = up->pdev;
+	od = container_of(pdev, struct omap_device, pdev);
+
+	if (omap_hmwod_pad_wakeup_status(od->hwmods[0]) == true)
+		serial_omap_port_enable(up);
+
+	if (up->wk_st && (__raw_readl(up->wk_st) & up->wk_mask))
+		serial_omap_port_enable(up);
+}
+
 static void serial_omap_stop_rxdma(struct uart_omap_port *up)
 {
 	if (up->uart_dma.rx_dma_used) {
@@ -105,6 +184,7 @@ static void serial_omap_enable_ms(struct uart_port *port)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
 
+	serial_omap_port_enable(up);
 	dev_dbg(up->port.dev, "serial_omap_enable_ms+%d\n", up->pdev->id);
 	up->ier |= UART_IER_MSI;
 	serial_out(up, UART_IER, up->ier);
@@ -114,6 +194,7 @@ static void serial_omap_stop_tx(struct uart_port *port)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
 
+	serial_omap_port_enable(up);
 	if (up->use_dma &&
 		up->uart_dma.tx_dma_channel != OMAP_UART_DMA_CH_FREE) {
 		/*
@@ -137,6 +218,7 @@ static void serial_omap_stop_rx(struct uart_port *port)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
 
+	serial_omap_port_enable(up);
 	if (up->use_dma)
 		serial_omap_stop_rxdma(up);
 	up->ier &= ~UART_IER_RLSI;
@@ -258,6 +340,7 @@ static void serial_omap_start_tx(struct uart_port *port)
 	unsigned int start;
 	int ret = 0;
 
+	serial_omap_port_enable(up);
 	if (!up->use_dma) {
 		serial_omap_enable_ier_thri(up);
 		return;
@@ -351,6 +434,7 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
 	unsigned int iir, lsr;
 	unsigned long flags;
 
+	serial_omap_port_enable(up);
 	iir = serial_in(up, UART_IIR);
 	if (iir & UART_IIR_NO_INT)
 		return IRQ_NONE;
@@ -385,6 +469,7 @@ static unsigned int serial_omap_tx_empty(struct uart_port *port)
 	unsigned long flags = 0;
 	unsigned int ret = 0;
 
+	serial_omap_port_enable(up);
 	dev_dbg(up->port.dev, "serial_omap_tx_empty+%d\n", up->pdev->id);
 	spin_lock_irqsave(&up->port.lock, flags);
 	ret = serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
@@ -399,6 +484,7 @@ static unsigned int serial_omap_get_mctrl(struct uart_port *port)
 	unsigned char status;
 	unsigned int ret = 0;
 
+	serial_omap_port_enable(up);
 	status = check_modem_status(up);
 	dev_dbg(up->port.dev, "serial_omap_get_mctrl+%d\n", up->pdev->id);
 
@@ -419,6 +505,7 @@ static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	unsigned char mcr = 0;
 
 	dev_dbg(up->port.dev, "serial_omap_set_mctrl+%d\n", up->pdev->id);
+	serial_omap_port_enable(up);
 	if (mctrl & TIOCM_RTS)
 		mcr |= UART_MCR_RTS;
 	if (mctrl & TIOCM_DTR)
@@ -440,6 +527,7 @@ static void serial_omap_break_ctl(struct uart_port *port, int break_state)
 	unsigned long flags = 0;
 
 	dev_dbg(up->port.dev, "serial_omap_break_ctl+%d\n", up->pdev->id);
+	serial_omap_port_enable(up);
 	spin_lock_irqsave(&up->port.lock, flags);
 	if (break_state == -1)
 		up->lcr |= UART_LCR_SBC;
@@ -465,6 +553,7 @@ static int serial_omap_startup(struct uart_port *port)
 
 	dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->pdev->id);
 
+	serial_omap_port_enable(up);
 	/*
 	 * Clear the FIFO buffers and disable them.
 	 * (they will be reenabled in set_termios())
@@ -530,6 +619,8 @@ static void serial_omap_shutdown(struct uart_port *port)
 	unsigned long flags = 0;
 
 	dev_dbg(up->port.dev, "serial_omap_shutdown+%d\n", up->pdev->id);
+
+	serial_omap_port_enable(up);
 	/*
 	 * Disable interrupts from this port
 	 */
@@ -668,6 +759,10 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/13);
 	quot = serial_omap_get_divisor(port, baud);
 
+	up->dll = quot & 0xff;
+	up->dlh = quot >> 8;
+	up->mdr1 = UART_OMAP_MDR1_DISABLE;
+
 	up->fcr = UART_FCR_R_TRIG_01 | UART_FCR_T_TRIG_01 |
 			UART_FCR_ENABLE_FIFO;
 	if (up->use_dma)
@@ -677,6 +772,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * Ok, we're now changing the port state. Do it with
 	 * interrupts disabled.
 	 */
+	serial_omap_port_enable(up);
 	spin_lock_irqsave(&up->port.lock, flags);
 
 	/*
@@ -755,8 +851,11 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_out(up, UART_MCR, up->mcr);
 
 	/* Protocol, Baud Rate, and Interrupt Settings */
+	if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
+		omap_uart_mdr1_errataset(up);
+	else
+		serial_out(up, UART_OMAP_MDR1, up->mdr1);
 
-	serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_DISABLE);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 
 	up->efr = serial_in(up, UART_EFR);
@@ -766,8 +865,8 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_out(up, UART_IER, 0);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 
-	serial_out(up, UART_DLL, quot & 0xff);          /* LS of divisor */
-	serial_out(up, UART_DLM, quot >> 8);            /* MS of divisor */
+	serial_out(up, UART_DLL, up->dll);	/* LS of divisor */
+	serial_out(up, UART_DLM, up->dlh);	/* MS of divisor */
 
 	serial_out(up, UART_LCR, 0);
 	serial_out(up, UART_IER, up->ier);
@@ -777,9 +876,14 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_out(up, UART_LCR, cval);
 
 	if (baud > 230400 && baud != 3000000)
-		serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_13X_MODE);
+		up->mdr1 = UART_OMAP_MDR1_13X_MODE;
+	else
+		up->mdr1 = UART_OMAP_MDR1_16X_MODE;
+
+	if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
+		omap_uart_mdr1_errataset(up);
 	else
-		serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_16X_MODE);
+		serial_out(up, UART_OMAP_MDR1, up->mdr1);
 
 	/* Hardware Flow Control Configuration */
 
@@ -818,6 +922,8 @@ serial_omap_pm(struct uart_port *port, unsigned int state,
 	unsigned char efr;
 
 	dev_dbg(up->port.dev, "serial_omap_pm+%d\n", up->pdev->id);
+
+	serial_omap_port_enable(up);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	efr = serial_in(up, UART_EFR);
 	serial_out(up, UART_EFR, efr | UART_EFR_ECB);
@@ -827,6 +933,8 @@ serial_omap_pm(struct uart_port *port, unsigned int state,
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_EFR, efr);
 	serial_out(up, UART_LCR, 0);
+	if (state)
+		serial_omap_port_disable(up);
 }
 
 static void serial_omap_release_port(struct uart_port *port)
@@ -904,6 +1012,8 @@ static inline void wait_for_xmitr(struct uart_omap_port *up)
 static void serial_omap_poll_put_char(struct uart_port *port, unsigned char ch)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
+
+	serial_omap_port_enable(up);
 	wait_for_xmitr(up);
 	serial_out(up, UART_TX, ch);
 }
@@ -911,8 +1021,10 @@ static void serial_omap_poll_put_char(struct uart_port *port, unsigned char ch)
 static int serial_omap_poll_get_char(struct uart_port *port)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
-	unsigned int status = serial_in(up, UART_LSR);
+	unsigned int status;
 
+	serial_omap_port_enable(up);
+	status = serial_in(up, UART_LSR);
 	if (!(status & UART_LSR_DR))
 		return NO_POLL_CHAR;
 
@@ -922,7 +1034,6 @@ static int serial_omap_poll_get_char(struct uart_port *port)
 #endif /* CONFIG_CONSOLE_POLL */
 
 #ifdef CONFIG_SERIAL_OMAP_CONSOLE
-
 static struct uart_omap_port *serial_omap_console_ports[4];
 
 static struct uart_driver serial_omap_reg;
@@ -931,6 +1042,7 @@ static void serial_omap_console_putchar(struct uart_port *port, int ch)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
 
+	serial_omap_port_enable(up);
 	wait_for_xmitr(up);
 	serial_out(up, UART_TX, ch);
 }
@@ -944,6 +1056,7 @@ serial_omap_console_write(struct console *co, const char *s,
 	unsigned int ier;
 	int locked = 1;
 
+	serial_omap_port_enable(up);
 	local_irq_save(flags);
 	if (up->port.sysrq)
 		locked = 0;
@@ -1058,22 +1171,25 @@ static struct uart_driver serial_omap_reg = {
 	.cons		= OMAP_CONSOLE,
 };
 
-static int
-serial_omap_suspend(struct platform_device *pdev, pm_message_t state)
+static int serial_omap_suspend(struct device *dev)
 {
-	struct uart_omap_port *up = platform_get_drvdata(pdev);
+	struct uart_omap_port *up = dev_get_drvdata(dev);
 
-	if (up)
+	if (up) {
 		uart_suspend_port(&serial_omap_reg, &up->port);
+		serial_omap_port_disable(up);
+	}
+
 	return 0;
 }
 
-static int serial_omap_resume(struct platform_device *dev)
+static int serial_omap_resume(struct device *dev)
 {
-	struct uart_omap_port *up = platform_get_drvdata(dev);
+	struct uart_omap_port *up = dev_get_drvdata(dev);
 
 	if (up)
 		uart_resume_port(&serial_omap_reg, &up->port);
+
 	return 0;
 }
 
@@ -1221,9 +1337,10 @@ static void uart_tx_dma_callback(int lch, u16 ch_status, void *data)
 
 static int serial_omap_probe(struct platform_device *pdev)
 {
-	struct uart_omap_port	*up;
+	struct uart_omap_port	*up = NULL;
 	struct resource		*mem, *irq, *dma_tx, *dma_rx;
 	struct omap_uart_port_info *omap_up_info = pdev->dev.platform_data;
+	struct omap_device *od;
 	int ret = -ENOSPC;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1273,12 +1390,23 @@ static int serial_omap_probe(struct platform_device *pdev)
 	up->port.ops = &serial_omap_pops;
 	up->port.line = pdev->id;
 
-	up->port.membase = omap_up_info->membase;
-	up->port.mapbase = omap_up_info->mapbase;
+	up->port.mapbase = mem->start;
+	up->port.membase = ioremap(mem->start, mem->end - mem->start);
+
+	if (!up->port.membase) {
+		dev_err(&pdev->dev, "can't ioremap UART\n");
+		ret = -ENOMEM;
+		goto err1;
+	}
+
 	up->port.flags = omap_up_info->flags;
-	up->port.irqflags = omap_up_info->irqflags;
 	up->port.uartclk = omap_up_info->uartclk;
 	up->uart_dma.uart_base = mem->start;
+	up->errata = omap_up_info->errata;
+
+	up->wk_st = omap_up_info->wk_st;
+	up->wk_en = omap_up_info->wk_en;
+	up->wk_mask = omap_up_info->wk_mask;
 
 	if (omap_up_info->dma_enabled) {
 		up->uart_dma.uart_dma_tx = dma_tx->start;
@@ -1291,19 +1419,35 @@ static int serial_omap_probe(struct platform_device *pdev)
 		up->uart_dma.tx_dma_channel = OMAP_UART_DMA_CH_FREE;
 		up->uart_dma.rx_dma_channel = OMAP_UART_DMA_CH_FREE;
 	}
+	init_timer(&(up->inactivity_timer));
+	up->inactivity_timer.function = serial_omap_inactivity_timer;
+	up->inactivity_timer.data = up->pdev->id;
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_irq_safe(&pdev->dev);
+
+	if (omap_up_info->console_uart) {
+		od = container_of(pdev, struct omap_device, pdev);
+		omap_hwmod_idle(od->hwmods[0]);
+		serial_omap_port_enable(up);
+	}
 
 	ui[pdev->id] = up;
 	serial_omap_add_console_port(up);
 
 	ret = uart_add_one_port(&serial_omap_reg, &up->port);
 	if (ret != 0)
-		goto do_release_region;
+		goto err1;
 
+	dev_set_drvdata(&pdev->dev, up);
 	platform_set_drvdata(pdev, up);
+
 	return 0;
 err:
 	dev_err(&pdev->dev, "[UART%d]: failure [%s]: %d\n",
 				pdev->id, __func__, ret);
+err1:
+	kfree(up);
 do_release_region:
 	release_mem_region(mem->start, (mem->end - mem->start) + 1);
 	return ret;
@@ -1315,20 +1459,138 @@ static int serial_omap_remove(struct platform_device *dev)
 
 	platform_set_drvdata(dev, NULL);
 	if (up) {
+		pm_runtime_disable(&up->pdev->dev);
 		uart_remove_one_port(&serial_omap_reg, &up->port);
 		kfree(up);
 	}
 	return 0;
 }
 
+/*
+ * Work Around for Errata i202 (3430 - 1.12, 3630 - 1.6)
+ * The access to uart register after MDR1 Access
+ * causes UART to corrupt data.
+ *
+ * Need a delay =
+ * 5 L4 clock cycles + 5 UART functional clock cycle (@48MHz = ~0.2uS)
+ * give 10 times as much
+ */
+static void omap_uart_mdr1_errataset(struct uart_omap_port *up)
+{
+	u8 timeout = 255;
+
+	serial_out(up, UART_OMAP_MDR1, up->mdr1);
+	udelay(2);
+	serial_out(up, UART_FCR, up->fcr | UART_FCR_CLEAR_XMIT |
+			UART_FCR_CLEAR_RCVR);
+	/*
+	 * Wait for FIFO to empty: when empty, RX_FIFO_E bit is 0 and
+	 * TX_FIFO_E bit is 1.
+	 */
+	while (UART_LSR_THRE != (serial_in(up, UART_LSR) &
+				(UART_LSR_THRE | UART_LSR_DR))) {
+		timeout--;
+		if (!timeout) {
+			/* Should *never* happen. we warn and carry on */
+			dev_crit(&up->pdev->dev, "Errata i202: timedout %x\n",
+			serial_in(up, UART_LSR));
+			break;
+		}
+		udelay(1);
+	}
+}
+
+static void omap_uart_restore_context(struct uart_omap_port *up)
+{
+	u16 efr = 0;
+
+	if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
+		omap_uart_mdr1_errataset(up);
+	else
+		serial_out(up, UART_OMAP_MDR1, up->mdr1);
+	serial_out(up, UART_LCR, 0xBF); /* Config B mode */
+	efr = serial_in(up, UART_EFR);
+	serial_out(up, UART_EFR, UART_EFR_ECB);
+	serial_out(up, UART_LCR, 0x0); /* Operational mode */
+	serial_out(up, UART_IER, 0x0);
+	serial_out(up, UART_LCR, 0xBF); /* Config B mode */
+	serial_out(up, UART_DLL, up->dll);
+	serial_out(up, UART_DLM, up->dlh);
+	serial_out(up, UART_LCR, 0x0); /* Operational mode */
+	serial_out(up, UART_IER, up->ier);
+	serial_out(up, UART_FCR, up->fcr);
+	serial_out(up, UART_LCR, 0x80);
+	serial_out(up, UART_MCR, up->mcr);
+	serial_out(up, UART_LCR, 0xBF); /* Config B mode */
+	serial_out(up, UART_EFR, efr);
+	serial_out(up, UART_LCR, UART_LCR_WLEN8);
+	if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
+		omap_uart_mdr1_errataset(up);
+	else
+		/* UART 16x mode */
+		serial_out(up, UART_OMAP_MDR1, up->mdr1);
+}
+
+static void omap_uart_enable_wakeup(struct uart_omap_port *up)
+{
+	/* Set wake-enable bit */
+	if (up->wk_en && up->wk_mask) {
+		u32 v = __raw_readl(up->wk_en);
+		v |= up->wk_mask;
+		__raw_writel(v, up->wk_en);
+	}
+}
+
+static void omap_uart_disable_wakeup(struct uart_omap_port *up)
+{
+	/* Clear wake-enable bit */
+	if (up->wk_en && up->wk_mask) {
+		u32 v = __raw_readl(up->wk_en);
+		v &= ~up->wk_mask;
+		__raw_writel(v, up->wk_en);
+	}
+}
+
+static int omap_serial_runtime_suspend(struct device *dev)
+{
+	struct uart_omap_port *up = dev_get_drvdata(dev);
+
+	if (!up)
+		goto done;
+
+	if (device_may_wakeup(&up->pdev->dev))
+		omap_uart_enable_wakeup(up);
+	else
+		omap_uart_disable_wakeup(up);
+done:
+	return 0;
+}
+
+static int omap_serial_runtime_resume(struct device *dev)
+{
+	struct uart_omap_port *up = dev_get_drvdata(dev);
+
+	if (!up)
+		goto done;
+
+	omap_uart_restore_context(up);
+done:
+	return 0;
+}
+
+static const struct dev_pm_ops omap_serial_dev_pm_ops = {
+	.suspend = serial_omap_suspend,
+	.resume	= serial_omap_resume,
+	.runtime_suspend = omap_serial_runtime_suspend,
+	.runtime_resume = omap_serial_runtime_resume,
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
+		.pm = &omap_serial_dev_pm_ops,
 	},
 };
 
-- 
1.7.1

