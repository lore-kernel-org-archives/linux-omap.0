From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v8 06/20] OMAP2+: UART: Add runtime pm support for omap-serial driver
Date: Fri, 11 Nov 2011 15:27:23 +0530
Message-ID: <1321005446-21741-7-git-send-email-govindraj.raja@ti.com>
References: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44417 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756114Ab1KKJ6u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Nov 2011 04:58:50 -0500
In-Reply-To: <1321005446-21741-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>

Adapts omap-serial driver to use pm_runtime API's.
Use runtime runtime API's to handle uart clocks and obtain
device_usage statics. Set runtime API's usage to irq_safe so that
we can use get_sync from irq context. Auto-suspend for port specific
activities and put for reg access. Moving suspend/resume hooks
to dev_pm_ops structure and bing with config_suspend to avoid any
compilation warning if config_suspend is disabled.

By default uart autosuspend delay is set to -1 to avoid character loss
if uart's are autoidled and woken up on rx pin.

After boot up UART's can be autoidled by setting autosuspend delay from sysfs.

echo 3000 > /sys/devices/platform/omap/omap_uart.X/power/autosuspend_delay_ms
X=0,1,2,3 for UART1/2/3/4. Number of uarts available may vary across omap_soc.

Also if uart is not wakeup capable we can prevent runtime autosuspend by
forbiding runtime.

Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 drivers/tty/serial/omap-serial.c |  122 ++++++++++++++++++++++++++++++++++----
 1 files changed, 109 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 31f0cbf..f16ef4b9 100644
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
@@ -433,8 +465,10 @@ static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
 	if (mctrl & TIOCM_LOOP)
 		mcr |= UART_MCR_LOOP;
 
+	pm_runtime_get_sync(&up->pdev->dev);
 	mcr |= up->mcr;
 	serial_out(up, UART_MCR, mcr);
+	pm_runtime_put(&up->pdev->dev);
 }
 
 static void serial_omap_break_ctl(struct uart_port *port, int break_state)
@@ -443,6 +477,7 @@ static void serial_omap_break_ctl(struct uart_port *port, int break_state)
 	unsigned long flags = 0;
 
 	dev_dbg(up->port.dev, "serial_omap_break_ctl+%d\n", up->pdev->id);
+	pm_runtime_get_sync(&up->pdev->dev);
 	spin_lock_irqsave(&up->port.lock, flags);
 	if (break_state == -1)
 		up->lcr |= UART_LCR_SBC;
@@ -450,6 +485,7 @@ static void serial_omap_break_ctl(struct uart_port *port, int break_state)
 		up->lcr &= ~UART_LCR_SBC;
 	serial_out(up, UART_LCR, up->lcr);
 	spin_unlock_irqrestore(&up->port.lock, flags);
+	pm_runtime_put(&up->pdev->dev);
 }
 
 static int serial_omap_startup(struct uart_port *port)
@@ -468,6 +504,7 @@ static int serial_omap_startup(struct uart_port *port)
 
 	dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->pdev->id);
 
+	pm_runtime_get_sync(&up->pdev->dev);
 	/*
 	 * Clear the FIFO buffers and disable them.
 	 * (they will be reenabled in set_termios())
@@ -523,6 +560,8 @@ static int serial_omap_startup(struct uart_port *port)
 	/* Enable module level wake up */
 	serial_out(up, UART_OMAP_WER, OMAP_UART_WER_MOD_WKUP);
 
+	pm_runtime_mark_last_busy(&up->pdev->dev);
+	pm_runtime_put_autosuspend(&up->pdev->dev);
 	up->port_activity = jiffies;
 	return 0;
 }
@@ -533,6 +572,8 @@ static void serial_omap_shutdown(struct uart_port *port)
 	unsigned long flags = 0;
 
 	dev_dbg(up->port.dev, "serial_omap_shutdown+%d\n", up->pdev->id);
+
+	pm_runtime_get_sync(&up->pdev->dev);
 	/*
 	 * Disable interrupts from this port
 	 */
@@ -566,6 +607,8 @@ static void serial_omap_shutdown(struct uart_port *port)
 			up->uart_dma.rx_buf_dma_phys);
 		up->uart_dma.rx_buf = NULL;
 	}
+
+	pm_runtime_put(&up->pdev->dev);
 	free_irq(up->port.irq, up);
 }
 
@@ -680,6 +723,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * Ok, we're now changing the port state. Do it with
 	 * interrupts disabled.
 	 */
+	pm_runtime_get_sync(&up->pdev->dev);
 	spin_lock_irqsave(&up->port.lock, flags);
 
 	/*
@@ -809,6 +853,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_omap_configure_xonxoff(up, termios);
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
+	pm_runtime_put(&up->pdev->dev);
 	dev_dbg(up->port.dev, "serial_omap_set_termios+%d\n", up->pdev->id);
 }
 
@@ -820,6 +865,8 @@ serial_omap_pm(struct uart_port *port, unsigned int state,
 	unsigned char efr;
 
 	dev_dbg(up->port.dev, "serial_omap_pm+%d\n", up->pdev->id);
+
+	pm_runtime_get_sync(&up->pdev->dev);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	efr = serial_in(up, UART_EFR);
 	serial_out(up, UART_EFR, efr | UART_EFR_ECB);
@@ -829,6 +876,15 @@ serial_omap_pm(struct uart_port *port, unsigned int state,
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	serial_out(up, UART_EFR, efr);
 	serial_out(up, UART_LCR, 0);
+
+	if (!device_may_wakeup(&up->pdev->dev)) {
+		if (!state)
+			pm_runtime_forbid(&up->pdev->dev);
+		else
+			pm_runtime_allow(&up->pdev->dev);
+	}
+
+	pm_runtime_put(&up->pdev->dev);
 }
 
 static void serial_omap_release_port(struct uart_port *port)
@@ -906,19 +962,26 @@ static inline void wait_for_xmitr(struct uart_omap_port *up)
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
@@ -946,6 +1009,8 @@ serial_omap_console_write(struct console *co, const char *s,
 	unsigned int ier;
 	int locked = 1;
 
+	pm_runtime_get_sync(&up->pdev->dev);
+
 	local_irq_save(flags);
 	if (up->port.sysrq)
 		locked = 0;
@@ -978,6 +1043,8 @@ serial_omap_console_write(struct console *co, const char *s,
 	if (up->msr_saved_flags)
 		check_modem_status(up);
 
+	pm_runtime_mark_last_busy(&up->pdev->dev);
+	pm_runtime_put_autosuspend(&up->pdev->dev);
 	if (locked)
 		spin_unlock(&up->port.lock);
 	local_irq_restore(flags);
@@ -1060,24 +1127,25 @@ static struct uart_driver serial_omap_reg = {
 	.cons		= OMAP_CONSOLE,
 };
 
-static int
-serial_omap_suspend(struct platform_device *pdev, pm_message_t state)
+#ifdef CONFIG_SUSPEND
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
 	return 0;
 }
+#endif
 
 static void serial_omap_rx_timeout(unsigned long uart_no)
 {
@@ -1135,6 +1203,7 @@ static int serial_omap_start_rxdma(struct uart_omap_port *up)
 	int ret = 0;
 
 	if (up->uart_dma.rx_dma_channel == -1) {
+		pm_runtime_get_sync(&up->pdev->dev);
 		ret = omap_request_dma(up->uart_dma.uart_dma_rx,
 				"UART Rx DMA",
 				(void *)uart_rx_dma_callback, up,
@@ -1299,6 +1368,14 @@ static int serial_omap_probe(struct platform_device *pdev)
 		up->uart_dma.rx_dma_channel = OMAP_UART_DMA_CH_FREE;
 	}
 
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev,
+			OMAP_UART_AUTOSUSPEND_DELAY);
+
+	pm_runtime_irq_safe(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
+
 	ui[pdev->id] = up;
 	serial_omap_add_console_port(up);
 
@@ -1306,6 +1383,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 	if (ret != 0)
 		goto do_release_region;
 
+	pm_runtime_put(&pdev->dev);
 	platform_set_drvdata(pdev, up);
 	return 0;
 err:
@@ -1320,22 +1398,40 @@ static int serial_omap_remove(struct platform_device *dev)
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
+#ifdef CONFIG_PM_RUNTIME
+static int serial_omap_runtime_suspend(struct device *dev)
+{
 	return 0;
 }
 
+static int serial_omap_runtime_resume(struct device *dev)
+{
+	return 0;
+}
+#endif
+
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

