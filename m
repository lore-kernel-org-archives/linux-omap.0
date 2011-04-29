From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v2 04/12] Serial: OMAP: Add runtime pm support for omap-serial driver
Date: Fri, 29 Apr 2011 18:09:48 +0530
Message-ID: <1304080796-625-5-git-send-email-govindraj.raja@ti.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36475 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755582Ab1D2Mmd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Apr 2011 08:42:33 -0400
In-Reply-To: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Govindraj.R" <govindraj.raja@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>

Adapts omap-serial driver to use pm_runtime api's.

1.) Populate reg values to uart port which can be used for context restore.
2.) Moving context_restore func to driver from serial.c
3.) Adding port_enable/disable func to enable/disable given uart port.
    enable port using get_sync and disable using autosuspend.
4.) using runtime irq safe api to make get_sync be called from irq context.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c                  |   16 ++
 arch/arm/plat-omap/include/plat/omap-serial.h |    2 +
 drivers/tty/serial/omap-serial.c              |  211 ++++++++++++++++++++++---
 3 files changed, 203 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 8c1a4c7..314d82f 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -189,6 +189,21 @@ static void omap_serial_fill_default_pads(struct omap_board_data *bdata)
 	}
 }
 
+static void omap_uart_wakeup_enable(struct platform_device *pdev, bool enable)
+{
+	struct omap_uart_port_info *up = pdev->dev.platform_data;
+
+	/* Set or clear wake-enable bit */
+	if (up->wk_en && up->wk_mask) {
+		u32 v = __raw_readl(up->wk_en);
+		if (enable)
+			v |= up->wk_mask;
+		else
+			v &= ~up->wk_mask;
+		__raw_writel(v, up->wk_en);
+	}
+}
+
 static void omap_uart_idle_init(struct omap_uart_port_info *uart,
 				unsigned short num)
 {
@@ -332,6 +347,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 
 	pdata->uartclk = OMAP24XX_BASE_BAUD * 16;
 	pdata->flags = UPF_BOOT_AUTOCONF;
+	pdata->enable_wakeup = omap_uart_wakeup_enable;
 	if (bdata->id == omap_uart_con_id)
 		pdata->console_uart = true;
 
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 2ca885b..ac30de8 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -65,6 +65,7 @@ struct omap_uart_port_info {
 	unsigned int		errata;
 	unsigned int		console_uart;
 
+	void (*enable_wakeup)(struct platform_device *, bool);
 	void __iomem *wk_st;
 	void __iomem *wk_en;
 	u32 wk_mask;
@@ -120,6 +121,7 @@ struct uart_omap_port {
 	char			name[20];
 	unsigned long		port_activity;
 	unsigned int		errata;
+	void (*enable_wakeup)(struct platform_device *, bool);
 };
 
 #endif /* __OMAP_SERIAL_H__ */
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 47cadf4..633dfb4 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -37,10 +37,14 @@
 #include <linux/clk.h>
 #include <linux/serial_core.h>
 #include <linux/irq.h>
+#include <linux/pm_runtime.h>
 
 #include <plat/dma.h>
 #include <plat/dmtimer.h>
 #include <plat/omap-serial.h>
+#include <plat/omap_device.h>
+
+#define OMAP_UART_AUTOSUSPEND_DELAY (30 * HZ) /* Value is msecs */
 
 static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 
@@ -94,6 +98,17 @@ serial_omap_get_divisor(struct uart_port *port, unsigned int baud)
 	return port->uartclk/(baud * divisor);
 }
 
+static inline void serial_omap_port_disable(struct uart_omap_port *up)
+{
+	pm_runtime_mark_last_busy(&up->pdev->dev);
+	pm_runtime_put_autosuspend(&up->pdev->dev);
+}
+
+static inline void serial_omap_port_enable(struct uart_omap_port *up)
+{
+	pm_runtime_get_sync(&up->pdev->dev);
+}
+
 static void serial_omap_stop_rxdma(struct uart_omap_port *up)
 {
 	if (up->uart_dma.rx_dma_used) {
@@ -110,8 +125,11 @@ static void serial_omap_enable_ms(struct uart_port *port)
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
 
 	dev_dbg(up->port.dev, "serial_omap_enable_ms+%d\n", up->pdev->id);
+
+	serial_omap_port_enable(up);
 	up->ier |= UART_IER_MSI;
 	serial_out(up, UART_IER, up->ier);
+	serial_omap_port_disable(up);
 }
 
 static void serial_omap_stop_tx(struct uart_port *port)
@@ -131,21 +149,26 @@ static void serial_omap_stop_tx(struct uart_port *port)
 		up->uart_dma.tx_dma_channel = OMAP_UART_DMA_CH_FREE;
 	}
 
+	serial_omap_port_enable(up);
 	if (up->ier & UART_IER_THRI) {
 		up->ier &= ~UART_IER_THRI;
 		serial_out(up, UART_IER, up->ier);
 	}
+
+	serial_omap_port_disable(up);
 }
 
 static void serial_omap_stop_rx(struct uart_port *port)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
 
+	serial_omap_port_enable(up);
 	if (up->use_dma)
 		serial_omap_stop_rxdma(up);
 	up->ier &= ~UART_IER_RLSI;
 	up->port.read_status_mask &= ~UART_LSR_DR;
 	serial_out(up, UART_IER, up->ier);
+	serial_omap_port_disable(up);
 }
 
 static inline void receive_chars(struct uart_omap_port *up, int *status)
@@ -261,8 +284,10 @@ static void serial_omap_start_tx(struct uart_port *port)
 	unsigned int start;
 	int ret = 0;
 
+	serial_omap_port_enable(up);
 	if (!up->use_dma) {
 		serial_omap_enable_ier_thri(up);
+		serial_omap_port_disable(up);
 		return;
 	}
 
@@ -354,9 +379,12 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
 	unsigned int iir, lsr;
 	unsigned long flags;
 
+	serial_omap_port_enable(up);
 	iir = serial_in(up, UART_IIR);
-	if (iir & UART_IIR_NO_INT)
+	if (iir & UART_IIR_NO_INT) {
+		serial_omap_port_disable(up);
 		return IRQ_NONE;
+	}
 
 	spin_lock_irqsave(&up->port.lock, flags);
 	lsr = serial_in(up, UART_LSR);
@@ -378,6 +406,8 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
 		transmit_chars(up);
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
+	serial_omap_port_disable(up);
+
 	up->port_activity = jiffies;
 	return IRQ_HANDLED;
 }
@@ -388,11 +418,12 @@ static unsigned int serial_omap_tx_empty(struct uart_port *port)
 	unsigned long flags = 0;
 	unsigned int ret = 0;
 
+	serial_omap_port_enable(up);
 	dev_dbg(up->port.dev, "serial_omap_tx_empty+%d\n", up->pdev->id);
 	spin_lock_irqsave(&up->port.lock, flags);
 	ret = serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
 	spin_unlock_irqrestore(&up->port.lock, flags);
-
+	serial_omap_port_disable(up);
 	return ret;
 }
 
@@ -402,7 +433,10 @@ static unsigned int serial_omap_get_mctrl(struct uart_port *port)
 	unsigned char status;
 	unsigned int ret = 0;
 
+	serial_omap_port_enable(up);
 	status = check_modem_status(up);
+	serial_omap_port_disable(up);
+
 	dev_dbg(up->port.dev, "serial_omap_get_mctrl+%d\n", up->pdev->id);
 
 	if (status & UART_MSR_DCD)
@@ -434,7 +468,9 @@ static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		mcr |= UART_MCR_LOOP;
 
 	mcr |= up->mcr;
+	serial_omap_port_enable(up);
 	serial_out(up, UART_MCR, mcr);
+	serial_omap_port_disable(up);
 }
 
 static void serial_omap_break_ctl(struct uart_port *port, int break_state)
@@ -443,6 +479,7 @@ static void serial_omap_break_ctl(struct uart_port *port, int break_state)
 	unsigned long flags = 0;
 
 	dev_dbg(up->port.dev, "serial_omap_break_ctl+%d\n", up->pdev->id);
+	serial_omap_port_enable(up);
 	spin_lock_irqsave(&up->port.lock, flags);
 	if (break_state == -1)
 		up->lcr |= UART_LCR_SBC;
@@ -450,6 +487,7 @@ static void serial_omap_break_ctl(struct uart_port *port, int break_state)
 		up->lcr &= ~UART_LCR_SBC;
 	serial_out(up, UART_LCR, up->lcr);
 	spin_unlock_irqrestore(&up->port.lock, flags);
+	serial_omap_port_disable(up);
 }
 
 static int serial_omap_startup(struct uart_port *port)
@@ -468,6 +506,7 @@ static int serial_omap_startup(struct uart_port *port)
 
 	dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->pdev->id);
 
+	serial_omap_port_enable(up);
 	/*
 	 * Clear the FIFO buffers and disable them.
 	 * (they will be reenabled in set_termios())
@@ -523,6 +562,7 @@ static int serial_omap_startup(struct uart_port *port)
 	/* Enable module level wake up */
 	serial_out(up, UART_OMAP_WER, OMAP_UART_WER_MOD_WKUP);
 
+	serial_omap_port_disable(up);
 	up->port_activity = jiffies;
 	return 0;
 }
@@ -533,6 +573,8 @@ static void serial_omap_shutdown(struct uart_port *port)
 	unsigned long flags = 0;
 
 	dev_dbg(up->port.dev, "serial_omap_shutdown+%d\n", up->pdev->id);
+
+	serial_omap_port_enable(up);
 	/*
 	 * Disable interrupts from this port
 	 */
@@ -566,6 +608,7 @@ static void serial_omap_shutdown(struct uart_port *port)
 			up->uart_dma.rx_buf_dma_phys);
 		up->uart_dma.rx_buf = NULL;
 	}
+	serial_omap_port_disable(up);
 	free_irq(up->port.irq, up);
 }
 
@@ -671,6 +714,10 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/13);
 	quot = serial_omap_get_divisor(port, baud);
 
+	up->dll = quot & 0xff;
+	up->dlh = quot >> 8;
+	up->mdr1 = UART_OMAP_MDR1_DISABLE;
+
 	up->fcr = UART_FCR_R_TRIG_01 | UART_FCR_T_TRIG_01 |
 			UART_FCR_ENABLE_FIFO;
 	if (up->use_dma)
@@ -680,6 +727,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * Ok, we're now changing the port state. Do it with
 	 * interrupts disabled.
 	 */
+	serial_omap_port_enable(up);
 	spin_lock_irqsave(&up->port.lock, flags);
 
 	/*
@@ -758,8 +806,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_out(up, UART_MCR, up->mcr);
 
 	/* Protocol, Baud Rate, and Interrupt Settings */
-
-	serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_DISABLE);
+	serial_out(up, UART_OMAP_MDR1, up->mdr1);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 
 	up->efr = serial_in(up, UART_EFR);
@@ -769,8 +816,8 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_out(up, UART_IER, 0);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 
-	serial_out(up, UART_DLL, quot & 0xff);          /* LS of divisor */
-	serial_out(up, UART_DLM, quot >> 8);            /* MS of divisor */
+	serial_out(up, UART_DLL, up->dll);	/* LS of divisor */
+	serial_out(up, UART_DLM, up->dlh);	/* MS of divisor */
 
 	serial_out(up, UART_LCR, 0);
 	serial_out(up, UART_IER, up->ier);
@@ -780,9 +827,11 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_out(up, UART_LCR, cval);
 
 	if (baud > 230400 && baud != 3000000)
-		serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_13X_MODE);
+		up->mdr1 = UART_OMAP_MDR1_13X_MODE;
 	else
-		serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_16X_MODE);
+		up->mdr1 = UART_OMAP_MDR1_16X_MODE;
+
+	serial_out(up, UART_OMAP_MDR1, up->mdr1)
 
 	/* Hardware Flow Control Configuration */
 
@@ -810,6 +859,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 		serial_omap_configure_xonxoff(up, termios);
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
+	serial_omap_port_disable(up);
 	dev_dbg(up->port.dev, "serial_omap_set_termios+%d\n", up->pdev->id);
 }
 
@@ -821,6 +871,8 @@ serial_omap_pm(struct uart_port *port, unsigned int state,
 	unsigned char efr;
 
 	dev_dbg(up->port.dev, "serial_omap_pm+%d\n", up->pdev->id);
+
+	serial_omap_port_enable(up);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	efr = serial_in(up, UART_EFR);
 	serial_out(up, UART_EFR, efr | UART_EFR_ECB);
@@ -830,6 +882,10 @@ serial_omap_pm(struct uart_port *port, unsigned int state,
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_EFR, efr);
 	serial_out(up, UART_LCR, 0);
+	if (state)
+		pm_runtime_put_sync(&up->pdev->dev);
+	else
+		serial_omap_port_disable(up);
 }
 
 static void serial_omap_release_port(struct uart_port *port)
@@ -907,25 +963,31 @@ static inline void wait_for_xmitr(struct uart_omap_port *up)
 static void serial_omap_poll_put_char(struct uart_port *port, unsigned char ch)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
+
+	serial_omap_port_enable(up);
 	wait_for_xmitr(up);
 	serial_out(up, UART_TX, ch);
+	serial_omap_port_disable(up);
 }
 
 static int serial_omap_poll_get_char(struct uart_port *port)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
-	unsigned int status = serial_in(up, UART_LSR);
+	unsigned int status;
 
+	serial_omap_port_enable(up);
+	status = serial_in(up, UART_LSR);
 	if (!(status & UART_LSR_DR))
 		return NO_POLL_CHAR;
 
-	return serial_in(up, UART_RX);
+	status = serial_in(up, UART_RX);
+	serial_omap_port_disable(up);
+	return status;
 }
 
 #endif /* CONFIG_CONSOLE_POLL */
 
 #ifdef CONFIG_SERIAL_OMAP_CONSOLE
-
 static struct uart_omap_port *serial_omap_console_ports[4];
 
 static struct uart_driver serial_omap_reg;
@@ -955,6 +1017,8 @@ serial_omap_console_write(struct console *co, const char *s,
 	else
 		spin_lock(&up->port.lock);
 
+	serial_omap_port_enable(up);
+
 	/*
 	 * First save the IER then disable the interrupts
 	 */
@@ -979,6 +1043,7 @@ serial_omap_console_write(struct console *co, const char *s,
 	if (up->msr_saved_flags)
 		check_modem_status(up);
 
+	serial_omap_port_disable(up);
 	if (locked)
 		spin_unlock(&up->port.lock);
 	local_irq_restore(flags);
@@ -1061,22 +1126,27 @@ static struct uart_driver serial_omap_reg = {
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
+		console_trylock();
+		serial_omap_pm(&up->port, 3, 0);
+	}
 	return 0;
 }
 
-static int serial_omap_resume(struct platform_device *dev)
+static int serial_omap_resume(struct device *dev)
 {
-	struct uart_omap_port *up = platform_get_drvdata(dev);
+	struct uart_omap_port *up = dev_get_drvdata(dev);
 
-	if (up)
+	if (up) {
 		uart_resume_port(&serial_omap_reg, &up->port);
+		console_unlock();
+	}
+
 	return 0;
 }
 
@@ -1097,6 +1167,7 @@ static void serial_omap_rx_timeout(unsigned long uart_no)
 			serial_omap_stop_rxdma(up);
 			up->ier |= (UART_IER_RDI | UART_IER_RLSI);
 			serial_out(up, UART_IER, up->ier);
+			serial_omap_port_disable(up);
 		}
 		return;
 	}
@@ -1128,6 +1199,9 @@ static void serial_omap_rx_timeout(unsigned long uart_no)
 
 static void uart_rx_dma_callback(int lch, u16 ch_status, void *data)
 {
+	struct uart_omap_port *up = (struct uart_omap_port *)data;
+
+	serial_omap_port_disable(up);
 	return;
 }
 
@@ -1135,6 +1209,7 @@ static int serial_omap_start_rxdma(struct uart_omap_port *up)
 {
 	int ret = 0;
 
+	serial_omap_port_enable(up);
 	if (up->uart_dma.rx_dma_channel == -1) {
 		ret = omap_request_dma(up->uart_dma.uart_dma_rx,
 				"UART Rx DMA",
@@ -1214,6 +1289,7 @@ static void uart_tx_dma_callback(int lch, u16 ch_status, void *data)
 		serial_omap_stop_tx(&up->port);
 		up->uart_dma.tx_dma_used = false;
 		spin_unlock(&(up->uart_dma.tx_lock));
+		serial_omap_port_disable(up);
 	} else {
 		omap_stop_dma(up->uart_dma.tx_dma_channel);
 		serial_omap_continue_tx(up);
@@ -1224,9 +1300,10 @@ static void uart_tx_dma_callback(int lch, u16 ch_status, void *data)
 
 static int serial_omap_probe(struct platform_device *pdev)
 {
-	struct uart_omap_port	*up;
+	struct uart_omap_port	*up = NULL;
 	struct resource		*mem, *irq, *dma_tx, *dma_rx;
 	struct omap_uart_port_info *omap_up_info = pdev->dev.platform_data;
+	struct omap_device *od;
 	int ret = -ENOSPC;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1276,12 +1353,20 @@ static int serial_omap_probe(struct platform_device *pdev)
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
+	up->enable_wakeup = omap_up_info->enable_wakeup;
 
 	if (omap_up_info->dma_enabled) {
 		up->uart_dma.uart_dma_tx = dma_tx->start;
@@ -1295,18 +1380,36 @@ static int serial_omap_probe(struct platform_device *pdev)
 		up->uart_dma.rx_dma_channel = OMAP_UART_DMA_CH_FREE;
 	}
 
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev,
+			OMAP_UART_AUTOSUSPEND_DELAY);
+
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_irq_safe(&pdev->dev);
+
+	if (omap_up_info->console_uart) {
+		od = to_omap_device(up->pdev);
+		omap_hwmod_idle(od->hwmods[0]);
+		serial_omap_port_enable(up);
+		serial_omap_port_disable(up);
+	}
+
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
@@ -1318,20 +1421,76 @@ static int serial_omap_remove(struct platform_device *dev)
 
 	platform_set_drvdata(dev, NULL);
 	if (up) {
+		pm_runtime_disable(&up->pdev->dev);
 		uart_remove_one_port(&serial_omap_reg, &up->port);
 		kfree(up);
 	}
 	return 0;
 }
 
+static void omap_uart_restore_context(struct uart_omap_port *up)
+{
+	u16 efr = 0;
+
+	serial_out(up, UART_OMAP_MDR1, up->mdr1);
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
+	/* UART 16x mode */
+	serial_out(up, UART_OMAP_MDR1, up->mdr1);
+}
+
+static int omap_serial_runtime_suspend(struct device *dev)
+{
+	struct uart_omap_port *up = dev_get_drvdata(dev);
+
+	if (!up)
+		goto done;
+
+	if (device_may_wakeup(dev))
+		up->enable_wakeup(up->pdev, true);
+	else
+		up->enable_wakeup(up->pdev, false);
+done:
+	return 0;
+}
+
+static int omap_serial_runtime_resume(struct device *dev)
+{
+	struct uart_omap_port *up = dev_get_drvdata(dev);
+
+	if (up)
+		omap_uart_restore_context(up);
+
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

