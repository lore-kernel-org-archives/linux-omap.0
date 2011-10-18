From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v7 17/21] OMAP2+: UART: Remove omap_uart_can_sleep and add pm_qos
Date: Tue, 18 Oct 2011 21:05:08 +0530
Message-ID: <1318952110-10659-3-git-send-email-govindraj.raja@ti.com>
References: <1318952110-10659-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59243 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932637Ab1JRPfW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Oct 2011 11:35:22 -0400
In-Reply-To: <1318952110-10659-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>

Omap_uart_can_sleep function blocks system wide low power state until
uart is active remove this func and add qos requests to prevent
MPU from transitioning while uart is active and remove qos request
if uart is auto-idled.

qos requests are blocking notifier calls so put these requests to
work queue to avoid warn on slow path warning while using qos
API's from runtime callbacks. Flush_sync any pending qos jobs
in work queue while suspending.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c             |    5 ---
 arch/arm/mach-omap2/pm24xx.c                  |    2 -
 arch/arm/mach-omap2/pm34xx.c                  |   10 ------
 arch/arm/mach-omap2/serial.c                  |   24 +-------------
 arch/arm/plat-omap/include/plat/omap-serial.h |    8 +++++
 drivers/tty/serial/omap-serial.c              |   41 ++++++++++++++++++++++++-
 6 files changed, 50 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 4bf6e6e..98b7d3f 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -226,11 +226,6 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 	struct omap3_idle_statedata *cx;
 	int ret;
 
-	if (!omap3_can_sleep()) {
-		new_state = dev->safe_state;
-		goto select_state;
-	}
-
 	/*
 	 * Prevent idle completely if CAM is active.
 	 * CAM does not have wakeup capability in OMAP3.
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index a75f764..192f0a4 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -248,8 +248,6 @@ static int omap2_can_sleep(void)
 {
 	if (omap2_fclks_active())
 		return 0;
-	if (!omap_uart_can_sleep())
-		return 0;
 	if (osc_ck->usecount > 1)
 		return 0;
 	if (omap_dma_running())
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 6e7f276..a635fa1 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -425,21 +425,11 @@ void omap_sram_idle(void)
 	clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 }
 
-int omap3_can_sleep(void)
-{
-	if (!omap_uart_can_sleep())
-		return 0;
-	return 1;
-}
-
 static void omap3_pm_idle(void)
 {
 	local_irq_disable();
 	local_fiq_disable();
 
-	if (!omap3_can_sleep())
-		goto out;
-
 	if (omap_irq_pending() || need_resched())
 		goto out;
 
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 7658a03..55ce950 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -75,6 +75,7 @@ static struct omap_uart_port_info omap_serial_default_info[] __initdata = {
 		.dma_rx_poll_rate = DEFAULT_RXDMA_POLLRATE,
 		.dma_rx_timeout = DEFAULT_RXDMA_TIMEOUT,
 		.autosuspend_timeout = DEFAULT_AUTOSUSPEND_DELAY,
+		.use_pm_qos = true,
 	},
 };
 
@@ -87,28 +88,6 @@ static struct omap_device_pm_latency omap_uart_latency[] = {
 };
 
 #ifdef CONFIG_PM
-
-int omap_uart_can_sleep(void)
-{
-	struct omap_uart_state *uart;
-	int can_sleep = 1;
-
-	list_for_each_entry(uart, &uart_list, node) {
-		if (!uart->clocked)
-			continue;
-
-		if (!uart->can_sleep) {
-			can_sleep = 0;
-			continue;
-		}
-
-		/* This UART can now safely sleep. */
-		omap_uart_allow_sleep(uart);
-	}
-
-	return can_sleep;
-}
-
 static void omap_uart_enable_wakeup(struct platform_device *pdev, bool enable)
 {
 	struct omap_device *od = to_omap_device(pdev);
@@ -363,6 +342,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 	omap_up.dma_rx_timeout = info->dma_rx_timeout;
 	omap_up.dma_rx_poll_rate = info->dma_rx_poll_rate;
 	omap_up.autosuspend_timeout = info->autosuspend_timeout;
+	omap_up.use_pm_qos = info->use_pm_qos;
 
 	/* Enable the MDR1 errata for OMAP3 */
 	if (cpu_is_omap34xx() && !cpu_is_ti816x())
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 9a6879c..41eda3c 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -19,6 +19,7 @@
 
 #include <linux/serial_core.h>
 #include <linux/platform_device.h>
+#include <linux/pm_qos_params.h>
 
 #include <plat/mux.h>
 
@@ -68,6 +69,7 @@ struct omap_uart_port_info {
 	unsigned int		dma_rx_timeout;
 	unsigned int		autosuspend_timeout;
 	unsigned int		dma_rx_poll_rate;
+	u8			use_pm_qos;
 
 	u32 (*get_context_loss_count)(struct device *);
 	void (*set_forceidle)(struct platform_device *);
@@ -129,6 +131,12 @@ struct uart_omap_port {
 	u32			context_loss_cnt;
 	u32			errata;
 	u8			wakeups_enabled;
+
+	struct pm_qos_request_list pm_qos_request;
+	u32			latency;
+	struct work_struct	work;
+	u8			request_qos;
+	u8			use_pm_qos;
 };
 
 #endif /* __OMAP_SERIAL_H__ */
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 1714bd2..956736c 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -51,6 +51,8 @@ static void serial_omap_rxdma_poll(unsigned long uart_no);
 static int serial_omap_start_rxdma(struct uart_omap_port *up);
 static void serial_omap_mdr1_errataset(struct uart_omap_port *up, u8 mdr1);
 
+static struct workqueue_struct *serial_omap_uart_wq;
+
 static inline unsigned int serial_in(struct uart_omap_port *up, int offset)
 {
 	offset <<= up->port.regshift;
@@ -674,6 +676,21 @@ serial_omap_configure_xonxoff
 	serial_out(up, UART_LCR, up->lcr);
 }
 
+static void serial_omap_uart_qos_work(struct work_struct *work)
+{
+	struct uart_omap_port *up = container_of(work, struct uart_omap_port,
+						work);
+
+	if (!up->request_qos) {
+		pm_qos_add_request(&up->pm_qos_request,
+			PM_QOS_CPU_DMA_LATENCY, up->latency);
+		up->request_qos = true;
+	} else {
+		pm_qos_remove_request(&up->pm_qos_request);
+		up->request_qos = false;
+	}
+}
+
 static void
 serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 			struct ktermios *old)
@@ -869,6 +886,13 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	serial_omap_configure_xonxoff(up, termios);
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
+
+	if (up->use_pm_qos) {
+		/* calculate wakeup latency constraint */
+		up->latency = (1000000 * up->port.fifosize) / (1000 * baud / 8);
+		schedule_work(&up->work);
+	}
+
 	pm_runtime_put(&up->pdev->dev);
 	dev_dbg(up->port.dev, "serial_omap_set_termios+%d\n", up->pdev->id);
 }
@@ -1144,8 +1168,11 @@ static int serial_omap_suspend(struct device *dev)
 {
 	struct uart_omap_port *up = dev_get_drvdata(dev);
 
-	if (up)
+	if (up) {
 		uart_suspend_port(&serial_omap_reg, &up->port);
+		flush_work_sync(&up->work);
+	}
+
 	return 0;
 }
 
@@ -1368,6 +1395,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 	up->port.uartclk = omap_up_info->uartclk;
 	up->uart_dma.uart_base = mem->start;
 	up->errata = omap_up_info->errata;
+	up->use_pm_qos = omap_up_info->use_pm_qos;
 
 	if (omap_up_info->dma_enabled) {
 		up->uart_dma.uart_dma_tx = dma_tx->start;
@@ -1382,6 +1410,11 @@ static int serial_omap_probe(struct platform_device *pdev)
 		up->uart_dma.rx_dma_channel = OMAP_UART_DMA_CH_FREE;
 	}
 
+	if (up->use_pm_qos) {
+		serial_omap_uart_wq = create_workqueue(up->name);
+		INIT_WORK(&up->work, serial_omap_uart_qos_work);
+	}
+
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev,
 			omap_up_info->autosuspend_timeout);
@@ -1516,6 +1549,9 @@ static int serial_omap_runtime_suspend(struct device *dev)
 	if (up->use_dma && pdata->set_forceidle)
 		pdata->set_forceidle(up->pdev);
 
+	if (up->use_pm_qos && up->request_qos)
+		schedule_work(&up->work);
+
 	return 0;
 }
 
@@ -1535,6 +1571,9 @@ static int serial_omap_runtime_resume(struct device *dev)
 		/* Errata i291 */
 		if (up->use_dma && pdata->set_noidle)
 			pdata->set_noidle(up->pdev);
+
+		if (up->use_pm_qos && !up->request_qos)
+			schedule_work(&up->work);
 	}
 
 	return 0;
-- 
1.7.4.1

