From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v4 07/11] Serial: OMAP: Add runtime pm support for omap-serial
	driver
Date: Wed, 7 Sep 2011 18:23:29 +0530
Message-ID: <1315400013-4849-8-git-send-email-govindraj.raja@ti.com>
References: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Adapts omap-serial driver to use pm_runtime API's.

1.) Moving context_restore func to driver from serial.c
2.) Use runtime irq safe to use get_sync from irq context.
3.) autosuspend for port specific activities and put for reg access.
4.) for earlyprintk usage the debug macro will write to console uart
    so keep uart clocks active from boot, idle using hwmod API's re-enable back
    using runtime API's.
5.) Moving context restore to runtime suspend and using reg values from port
    structure to restore the uart port context based on context_loss_count.
    Maintain internal state machine for avoiding repeated enable/disable of
    uart port wakeup mechanism.
6.) Add API to enable wakeup and check wakeup status.

Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c                  |   49 ++++++
 arch/arm/plat-omap/include/plat/omap-serial.h |   10 ++
 drivers/tty/serial/omap-serial.c              |  211 ++++++++++++++++++++++---
 3 files changed, 250 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 2e10357..7117220 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -30,6 +30,7 @@
 #include <plat/common.h>
 #include <plat/board.h>
 #include <plat/omap_device.h>
+#include <plat/omap-pm.h>
 
 #include "prm2xxx_3xxx.h"
 #include "pm.h"
@@ -246,6 +247,51 @@ static void omap_uart_idle_init(struct omap_uart_port_info *uart,
 	}
 }
 
+static bool omap_uart_chk_wakeup(struct platform_device *pdev)
+{
+	struct omap_uart_port_info *up = pdev->dev.platform_data;
+	struct omap_device *od;
+	u32 wkst = 0;
+	bool ret = false;
+
+	if (up->wk_st && up->wk_en && up->wk_mask) {
+		/* Check for normal UART wakeup (and clear it) */
+		wkst = __raw_readl(up->wk_st) & up->wk_mask;
+		if (wkst) {
+			__raw_writel(up->wk_mask, up->wk_st);
+			ret = true;
+		}
+	}
+
+	od = to_omap_device(pdev);
+	if (omap_hwmod_pad_get_wakeup_status(od->hwmods[0]) == true)
+		ret = true;
+
+	return ret;
+}
+
+static void omap_uart_wakeup_enable(struct platform_device *pdev, bool enable)
+{
+	struct omap_device *od;
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
+
+	od = to_omap_device(pdev);
+	if (enable)
+		omap_hwmod_enable_wakeup(od->hwmods[0]);
+	else
+		omap_hwmod_disable_wakeup(od->hwmods[0]);
+}
+
 struct omap_hwmod *omap_uart_hwmod_lookup(int num)
 {
 	struct omap_hwmod *oh;
@@ -317,6 +363,9 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 
 	pdata->uartclk = OMAP24XX_BASE_BAUD * 16;
 	pdata->flags = UPF_BOOT_AUTOCONF;
+	pdata->enable_wakeup = omap_uart_wakeup_enable;
+	pdata->chk_wakeup = omap_uart_chk_wakeup;
+	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
 
 	pdev = omap_device_build(name, bdata->id, oh, pdata,
 				sizeof(*pdata),	omap_uart_latency,
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 06e3aa2..7fc63b8 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -67,6 +67,9 @@ struct omap_uart_port_info {
 	void __iomem *wk_st;
 	void __iomem *wk_en;
 	u32 wk_mask;
+	void (*enable_wakeup)(struct platform_device *, bool);
+	bool (*chk_wakeup)(struct platform_device *);
+	u32 (*get_context_loss_count)(struct device *);
 };
 
 struct uart_omap_dma {
@@ -118,7 +121,14 @@ struct uart_omap_port {
 	unsigned char		msr_saved_flags;
 	char			name[20];
 	unsigned long		port_activity;
+	u32			context_loss_cnt;
+	u8			wake_status;
+
 	unsigned int		errata;
+	unsigned int		clocked;
+	u8			console_locked;
+
+	bool (*chk_wakeup)(struct platform_device *);
 };
 
 #endif /* __OMAP_SERIAL_H__ */
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6ac0ade..30bdd05 100644
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
+#define OMAP_UART_AUTOSUSPEND_DELAY 3000	/* Value is msecs */
 
 static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 
@@ -102,6 +106,8 @@ static void serial_omap_stop_rxdma(struct uart_omap_port *up)
 		omap_free_dma(up->uart_dma.rx_dma_channel);
 		up->uart_dma.rx_dma_channel = OMAP_UART_DMA_CH_FREE;
 		up->uart_dma.rx_dma_used = false;
+		pm_runtime_mark_last_busy(&up->pdev->dev);
+		pm_runtime_put_autosuspend(&up->pdev->dev);
 	}
 }
 
@@ -110,8 +116,11 @@ static void serial_omap_enable_ms(struct uart_port *port)
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
 
 	dev_dbg(up->port.dev, "serial_omap_enable_ms+%d\n", up->pdev->id);
+
+	pm_runtime_get_sync(&up->pdev->dev);
 	up->ier |= UART_IER_MSI;
 	serial_out(up, UART_IER, up->ier);
+	pm_runtime_put(&up->pdev->dev);
 }
 
 static void serial_omap_stop_tx(struct uart_port *port)
@@ -129,23 +138,32 @@ static void serial_omap_stop_tx(struct uart_port *port)
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
@@ -262,7 +280,10 @@ static void serial_omap_start_tx(struct uart_port *port)
 	int ret = 0;
 
 	if (!up->use_dma) {
+		pm_runtime_get_sync(&up->pdev->dev);
 		serial_omap_enable_ier_thri(up);
+		pm_runtime_mark_last_busy(&up->pdev->dev);
+		pm_runtime_put_autosuspend(&up->pdev->dev);
 		return;
 	}
 
@@ -272,6 +293,7 @@ static void serial_omap_start_tx(struct uart_port *port)
 	xmit = &up->port.state->xmit;
 
 	if (up->uart_dma.tx_dma_channel == OMAP_UART_DMA_CH_FREE) {
+		pm_runtime_get_sync(&up->pdev->dev);
 		ret = omap_request_dma(up->uart_dma.uart_dma_tx,
 				"UART Tx DMA",
 				(void *)uart_tx_dma_callback, up,
@@ -354,9 +376,12 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
 	unsigned int iir, lsr;
 	unsigned long flags;
 
+	pm_runtime_get_sync(&up->pdev->dev);
 	iir = serial_in(up, UART_IIR);
-	if (iir & UART_IIR_NO_INT)
+	if (iir & UART_IIR_NO_INT) {
+		pm_runtime_put(&up->pdev->dev);
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
@@ -911,25 +958,31 @@ static inline void wait_for_xmitr(struct uart_omap_port *up)
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
 
 #ifdef CONFIG_SERIAL_OMAP_CONSOLE
-
 static struct uart_omap_port *serial_omap_console_ports[4];
 
 static struct uart_driver serial_omap_reg;
@@ -951,6 +1004,8 @@ serial_omap_console_write(struct console *co, const char *s,
 	unsigned int ier;
 	int locked = 1;
 
+	pm_runtime_get_sync(&up->pdev->dev);
+
 	local_irq_save(flags);
 	if (up->port.sysrq)
 		locked = 0;
@@ -983,9 +1038,12 @@ serial_omap_console_write(struct console *co, const char *s,
 	if (up->msr_saved_flags)
 		check_modem_status(up);
 
+	pm_runtime_mark_last_busy(&up->pdev->dev);
+	pm_runtime_put_autosuspend(&up->pdev->dev);
 	if (locked)
 		spin_unlock(&up->port.lock);
 	local_irq_restore(flags);
+	up->port_activity = jiffies;
 }
 
 static int __init
@@ -1065,22 +1123,33 @@ static struct uart_driver serial_omap_reg = {
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
+		if (up->port.line == up->port.cons->index &&
+				!is_console_locked())
+			up->console_locked = console_trylock();
+	}
+
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
+		if (up->port.line == up->port.cons->index &&
+					up->console_locked) {
+			console_unlock();
+			up->console_locked = 0;
+		}
+	}
+
 	return 0;
 }
 
@@ -1140,6 +1209,7 @@ static int serial_omap_start_rxdma(struct uart_omap_port *up)
 	int ret = 0;
 
 	if (up->uart_dma.rx_dma_channel == -1) {
+		pm_runtime_get_sync(&up->pdev->dev);
 		ret = omap_request_dma(up->uart_dma.uart_dma_rx,
 				"UART Rx DMA",
 				(void *)uart_rx_dma_callback, up,
@@ -1228,9 +1298,10 @@ static void uart_tx_dma_callback(int lch, u16 ch_status, void *data)
 
 static int serial_omap_probe(struct platform_device *pdev)
 {
-	struct uart_omap_port	*up;
+	struct uart_omap_port	*up = NULL;
 	struct resource		*mem, *irq, *dma_tx, *dma_rx;
 	struct omap_uart_port_info *omap_up_info = pdev->dev.platform_data;
+	struct omap_device *od;
 	int ret = -ENOSPC;
 
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -1280,12 +1351,20 @@ static int serial_omap_probe(struct platform_device *pdev)
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
+	up->chk_wakeup = omap_up_info->chk_wakeup;
 
 	if (omap_up_info->dma_enabled) {
 		up->uart_dma.uart_dma_tx = dma_tx->start;
@@ -1299,18 +1378,34 @@ static int serial_omap_probe(struct platform_device *pdev)
 		up->uart_dma.rx_dma_channel = OMAP_UART_DMA_CH_FREE;
 	}
 
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev,
+			OMAP_UART_AUTOSUSPEND_DELAY);
+
+	pm_runtime_irq_safe(&pdev->dev);
+	if (device_may_wakeup(&pdev->dev)) {
+		pm_runtime_enable(&pdev->dev);
+		od = to_omap_device(up->pdev);
+		omap_hwmod_idle(od->hwmods[0]);
+		pm_runtime_get_sync(&up->pdev->dev);
+		up->clocked = 1;
+	}
+
 	ui[pdev->id] = up;
 	serial_omap_add_console_port(up);
 
 	ret = uart_add_one_port(&serial_omap_reg, &up->port);
 	if (ret != 0)
-		goto do_release_region;
+		goto err1;
 
 	platform_set_drvdata(pdev, up);
+
 	return 0;
 err:
 	dev_err(&pdev->dev, "[UART%d]: failure [%s]: %d\n",
 				pdev->id, __func__, ret);
+err1:
+	kfree(up);
 do_release_region:
 	release_mem_region(mem->start, resource_size(mem));
 	return ret;
@@ -1322,20 +1417,96 @@ static int serial_omap_remove(struct platform_device *dev)
 
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
+static int omap_serial_runtime_suspend(struct device *dev)
+{
+	struct uart_omap_port *up = dev_get_drvdata(dev);
+	struct omap_uart_port_info *pdata = dev->platform_data;
+
+	if (!up)
+		return -EINVAL;
+
+	if (pdata->get_context_loss_count)
+		up->context_loss_cnt = pdata->get_context_loss_count(dev);
+
+	if (device_may_wakeup(dev)) {
+		if (!up->wake_status) {
+			pdata->enable_wakeup(up->pdev, true);
+			up->wake_status = true;
+		}
+	} else {
+		if (up->wake_status) {
+			pdata->enable_wakeup(up->pdev, false);
+			up->wake_status = false;
+		}
+	}
+
+	return 0;
+}
+
+static int omap_serial_runtime_resume(struct device *dev)
+{
+	struct uart_omap_port *up = dev_get_drvdata(dev);
+	struct omap_uart_port_info *pdata = dev->platform_data;
+
+	if (up) {
+		if (pdata->get_context_loss_count) {
+			u32 loss_cnt = pdata->get_context_loss_count(dev);
+
+			if (up->context_loss_cnt != loss_cnt)
+				omap_uart_restore_context(up);
+		}
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_RUNTIME
+static const struct dev_pm_ops omap_serial_dev_pm_ops = {
+	.suspend = serial_omap_suspend,
+	.resume	= serial_omap_resume,
+	.runtime_suspend = omap_serial_runtime_suspend,
+	.runtime_resume = omap_serial_runtime_resume,
+};
+#define SERIAL_PM_OPS (&omap_serial_dev_pm_ops)
+#else
+#define SERIAL_PM_OPS NULL
+#endif
+
 static struct platform_driver serial_omap_driver = {
 	.probe          = serial_omap_probe,
 	.remove         = serial_omap_remove,
-
-	.suspend	= serial_omap_suspend,
-	.resume		= serial_omap_resume,
 	.driver		= {
 		.name	= DRIVER_NAME,
+		.pm = SERIAL_PM_OPS,
 	},
 };
 
-- 
1.7.4.1
