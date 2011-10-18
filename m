From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v7 11/21] OMAP2+: UART: Move errata handling from serial.c to omap-serial
Date: Tue, 18 Oct 2011 20:56:06 +0530
Message-ID: <1318951576-10165-12-git-send-email-govindraj.raja@ti.com>
References: <1318951576-10165-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33261 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932556Ab1JRP1C (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Oct 2011 11:27:02 -0400
In-Reply-To: <1318951576-10165-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>

Move the errata handling mechanism from serial.c to omap-serial file
and utilise the same func in driver file.

Errata i202, i291 are moved to be handled with omap-serial
Moving the errata macro from serial.c file to driver header file
as from on errata will be handled in driver file itself.
Corrected errata id from chapter reference 2.15 to errata id i291.

Removed errata and dma_enabled feilds from omap_uart_state struct
as they are no more needed with errata handling done within omap-serial.

Acked-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c                  |   97 +++++++------------------
 arch/arm/plat-omap/include/plat/omap-serial.h |    6 ++
 drivers/tty/serial/omap-serial.c              |   66 ++++++++++++++++-
 3 files changed, 95 insertions(+), 74 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index f220c84..8c6dc85 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -42,8 +42,6 @@
 #include "control.h"
 #include "mux.h"
 
-#define UART_ERRATA_i202_MDR1_ACCESS	(0x1 << 1)
-
 /*
  * NOTE: By default the serial timeout is disabled as it causes lost characters
  * over the serial ports. This means that the UART clocks will stay on until
@@ -61,15 +59,12 @@ struct omap_uart_state {
 	void __iomem *wk_st;
 	void __iomem *wk_en;
 	u32 wk_mask;
-	u32 dma_enabled;
 
 	int clocked;
 
 	struct list_head node;
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
-
-	u32 errata;
 };
 
 static LIST_HEAD(uart_list);
@@ -97,45 +92,6 @@ static struct omap_device_pm_latency omap_uart_latency[] = {
 	},
 };
 
-#if defined(CONFIG_PM) && defined(CONFIG_ARCH_OMAP3)
-
-/*
- * Work Around for Errata i202 (3430 - 1.12, 3630 - 1.6)
- * The access to uart register after MDR1 Access
- * causes UART to corrupt data.
- *
- * Need a delay =
- * 5 L4 clock cycles + 5 UART functional clock cycle (@48MHz = ~0.2uS)
- * give 10 times as much
- */
-static void omap_uart_mdr1_errataset(struct omap_uart_state *uart, u8 mdr1_val,
-		u8 fcr_val)
-{
-	u8 timeout = 255;
-
-	serial_write_reg(uart, UART_OMAP_MDR1, mdr1_val);
-	udelay(2);
-	serial_write_reg(uart, UART_FCR, fcr_val | UART_FCR_CLEAR_XMIT |
-			UART_FCR_CLEAR_RCVR);
-	/*
-	 * Wait for FIFO to empty: when empty, RX_FIFO_E bit is 0 and
-	 * TX_FIFO_E bit is 1.
-	 */
-	while (UART_LSR_THRE != (serial_read_reg(uart, UART_LSR) &
-				(UART_LSR_THRE | UART_LSR_DR))) {
-		timeout--;
-		if (!timeout) {
-			/* Should *never* happen. we warn and carry on */
-			dev_crit(&uart->pdev->dev, "Errata i202: timedout %x\n",
-			serial_read_reg(uart, UART_LSR));
-			break;
-		}
-		udelay(1);
-	}
-}
-
-#endif /* CONFIG_PM && CONFIG_ARCH_OMAP3 */
-
 static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
 {
 	if (uart->clocked)
@@ -178,27 +134,6 @@ static void omap_uart_disable_wakeup(struct omap_uart_state *uart)
 	}
 }
 
-static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
-					       int enable)
-{
-	u8 idlemode;
-
-	if (enable) {
-		/**
-		 * Errata 2.15: [UART]:Cannot Acknowledge Idle Requests
-		 * in Smartidle Mode When Configured for DMA Operations.
-		 */
-		if (uart->dma_enabled)
-			idlemode = HWMOD_IDLEMODE_FORCE;
-		else
-			idlemode = HWMOD_IDLEMODE_SMART;
-	} else {
-		idlemode = HWMOD_IDLEMODE_NO;
-	}
-
-	omap_hwmod_set_slave_idlemode(uart->oh, idlemode);
-}
-
 static void omap_uart_block_sleep(struct omap_uart_state *uart)
 {
 	omap_uart_enable_clocks(uart);
@@ -289,7 +224,28 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	}
 }
 
+/*
+ * Errata i291: [UART]:Cannot Acknowledge Idle Requests
+ * in Smartidle Mode When Configured for DMA Operations.
+ * WA: configure uart in force idle mode.
+ */
+static void omap_uart_set_noidle(struct platform_device *pdev)
+{
+	struct omap_device *od = to_omap_device(pdev);
+
+	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_NO);
+}
+
+static void omap_uart_set_forceidle(struct platform_device *pdev)
+{
+	struct omap_device *od = to_omap_device(pdev);
+
+	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_FORCE);
+}
+
 #else
+static void omap_uart_set_noidle(struct platform_device *pdev) {}
+static void omap_uart_set_forceidle(struct platform_device *pdev) {}
 static void omap_uart_block_sleep(struct omap_uart_state *uart)
 {
 	/* Needed to enable UART clocks when built without CONFIG_PM */
@@ -495,13 +451,18 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 			break;
 
 	oh = uart->oh;
-	uart->dma_enabled = 0;
 	name = DRIVER_NAME;
 
 	omap_up.dma_enabled = uart->dma_enabled;
 	omap_up.uartclk = OMAP24XX_BASE_BAUD * 16;
 	omap_up.flags = UPF_BOOT_AUTOCONF;
 	omap_up.get_context_loss_count = omap_pm_get_dev_context_loss_count;
+	omap_up.set_forceidle = omap_uart_set_forceidle;
+	omap_up.set_noidle = omap_uart_set_noidle;
+
+	/* Enable the MDR1 errata for OMAP3 */
+	if (cpu_is_omap34xx() && !cpu_is_ti816x())
+		omap_up.errata |= UART_ERRATA_i202_MDR1_ACCESS;
 
 	pdata = &omap_up;
 	pdata_size = sizeof(struct omap_uart_port_info);
@@ -542,10 +503,6 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	if (((cpu_is_omap34xx() || cpu_is_omap44xx()) && bdata->pads) ||
 		(pdata->wk_en && pdata->wk_mask))
 		device_init_wakeup(&pdev->dev, true);
-
-	/* Enable the MDR1 errata for OMAP3 */
-	if (cpu_is_omap34xx() && !cpu_is_ti816x())
-		uart->errata |= UART_ERRATA_i202_MDR1_ACCESS;
 }
 
 /**
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index f265bb9..f9baf01 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -58,12 +58,17 @@
 
 #define MSR_SAVE_FLAGS		UART_MSR_ANY_DELTA
 
+#define UART_ERRATA_i202_MDR1_ACCESS	(0x1 << 1)
+
 struct omap_uart_port_info {
 	bool			dma_enabled;	/* To specify DMA Mode */
 	unsigned int		uartclk;	/* UART clock rate */
 	upf_t			flags;		/* UPF_* flags */
+	u32			errata;
 
 	u32 (*get_context_loss_count)(struct device *);
+	void (*set_forceidle)(struct platform_device *);
+	void (*set_noidle)(struct platform_device *);
 };
 
 struct uart_omap_dma {
@@ -117,6 +122,7 @@ struct uart_omap_port {
 	char			name[20];
 	unsigned long		port_activity;
 	u32			context_loss_cnt;
+	u32			errata;
 };
 
 #endif /* __OMAP_SERIAL_H__ */
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 289fa7b..4d020fb 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -51,6 +51,7 @@ static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 static void uart_tx_dma_callback(int lch, u16 ch_status, void *data);
 static void serial_omap_rx_timeout(unsigned long uart_no);
 static int serial_omap_start_rxdma(struct uart_omap_port *up);
+static void serial_omap_mdr1_errataset(struct uart_omap_port *up, u8 mdr1);
 
 static inline unsigned int serial_in(struct uart_omap_port *up, int offset)
 {
@@ -811,7 +812,11 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	/* Protocol, Baud Rate, and Interrupt Settings */
 
-	serial_out(up, UART_OMAP_MDR1, up->mdr1);
+	if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
+		serial_omap_mdr1_errataset(up, up->mdr1);
+	else
+		serial_out(up, UART_OMAP_MDR1, up->mdr1);
+
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 
 	up->efr = serial_in(up, UART_EFR);
@@ -836,7 +841,10 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	else
 		up->mdr1 = UART_OMAP_MDR1_16X_MODE;
 
-	serial_out(up, UART_OMAP_MDR1, up->mdr1);
+	if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
+		serial_omap_mdr1_errataset(up, up->mdr1);
+	else
+		serial_out(up, UART_OMAP_MDR1, up->mdr1);
 
 	/* Hardware Flow Control Configuration */
 
@@ -1361,6 +1369,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 	up->port.flags = omap_up_info->flags;
 	up->port.uartclk = omap_up_info->uartclk;
 	up->uart_dma.uart_base = mem->start;
+	up->errata = omap_up_info->errata;
 
 	if (omap_up_info->dma_enabled) {
 		up->uart_dma.uart_dma_tx = dma_tx->start;
@@ -1414,9 +1423,47 @@ static int serial_omap_remove(struct platform_device *dev)
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
+static void serial_omap_mdr1_errataset(struct uart_omap_port *up, u8 mdr1)
+{
+	u8 timeout = 255;
+
+	serial_out(up, UART_OMAP_MDR1, mdr1);
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
+						serial_in(up, UART_LSR));
+			break;
+		}
+		udelay(1);
+	}
+}
+
 static void serial_omap_restore_context(struct uart_omap_port *up)
 {
-	serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_DISABLE);
+	if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
+		serial_omap_mdr1_errataset(up, UART_OMAP_MDR1_DISABLE);
+	else
+		serial_out(up, UART_OMAP_MDR1, UART_OMAP_MDR1_DISABLE);
+
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B); /* Config B mode */
 	serial_out(up, UART_EFR, UART_EFR_ECB);
 	serial_out(up, UART_LCR, 0x0); /* Operational mode */
@@ -1433,7 +1480,10 @@ static void serial_omap_restore_context(struct uart_omap_port *up)
 	serial_out(up, UART_OMAP_SCR, up->scr);
 	serial_out(up, UART_EFR, up->efr);
 	serial_out(up, UART_LCR, up->lcr);
-	serial_out(up, UART_OMAP_MDR1, up->mdr1);
+	if (up->errata & UART_ERRATA_i202_MDR1_ACCESS)
+		serial_omap_mdr1_errataset(up, up->mdr1);
+	else
+		serial_out(up, UART_OMAP_MDR1, up->mdr1);
 }
 
 #ifdef CONFIG_PM_RUNTIME
@@ -1448,6 +1498,10 @@ static int serial_omap_runtime_suspend(struct device *dev)
 	if (pdata->get_context_loss_count)
 		up->context_loss_cnt = pdata->get_context_loss_count(dev);
 
+	/* Errata i291 */
+	if (up->use_dma && pdata->set_forceidle)
+		pdata->set_forceidle(up->pdev);
+
 	return 0;
 }
 
@@ -1463,6 +1517,10 @@ static int serial_omap_runtime_resume(struct device *dev)
 			if (up->context_loss_cnt != loss_cnt)
 				serial_omap_restore_context(up);
 		}
+
+		/* Errata i291 */
+		if (up->use_dma && pdata->set_noidle)
+			pdata->set_noidle(up->pdev);
 	}
 
 	return 0;
-- 
1.7.4.1

