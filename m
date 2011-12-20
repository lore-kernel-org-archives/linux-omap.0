From: Ilya Yanok <yanok@emcraft.com>
Subject: [PATCH V2] omap-serial: add RS485 mode support
Date: Tue, 20 Dec 2011 22:23:32 +0100
Message-ID: <1324416212-10012-1-git-send-email-yanok@emcraft.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org
Cc: sasha_d@emcraft.com, Ilya Yanok <yanok@emcraft.com>
List-Id: linux-omap@vger.kernel.org

Add support for asserting RTS line while TX is in progress. OMAP
hardware doesn't support auto-RS485 mode so we control the line from
software. We use TX_EMPTY_CTL_IT bit in SCR register to generate TX
empty interrupt.

We use SER_RS485_RTS_ON_SEND flag to control the polarity of RTS signal
(RTS is asserted high during transmition if this flag is set and low
otherwise) though I'm not sure if this is what this flag is for...

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
Changes from V1:

 - rebased onto current linux-omap/master

 arch/arm/plat-omap/include/plat/omap-serial.h |    3 +
 drivers/tty/serial/omap-serial.c              |  126 ++++++++++++++++++++++---
 include/linux/serial_reg.h                    |    2 +
 3 files changed, 118 insertions(+), 13 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 9ff4444..d6f5eee 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -136,6 +136,9 @@ struct uart_omap_port {
 	u32			latency;
 	u32			calc_latency;
 	struct work_struct	qos_work;
+	struct serial_rs485	rs485;
+	unsigned int		tx_in_progress:1,
+				tx_wait_end:1;
 };
 
 #endif /* __OMAP_SERIAL_H__ */
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index ca24ab3..1483c43 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -39,12 +39,14 @@
 #include <linux/irq.h>
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
+#include <linux/uaccess.h>
 
 #include <plat/dma.h>
 #include <plat/dmtimer.h>
 #include <plat/omap-serial.h>
 
 #define DEFAULT_CLK_SPEED 48000000 /* 48Mhz*/
+#define OMAP_RS485_SUPPORTED	(SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND)
 
 static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 
@@ -126,6 +128,45 @@ static void serial_omap_enable_ms(struct uart_port *port)
 	pm_runtime_put(&up->pdev->dev);
 }
 
+static inline void serial_omap_enable_ier_thri(struct uart_omap_port *up)
+{
+	if (!(up->ier & UART_IER_THRI)) {
+		up->ier |= UART_IER_THRI;
+		serial_out(up, UART_IER, up->ier);
+	}
+}
+
+static inline void serial_omap_disable_ier_thri(struct uart_omap_port *up)
+{
+	if (up->ier & UART_IER_THRI) {
+		up->ier &= ~UART_IER_THRI;
+		serial_out(up, UART_IER, up->ier);
+	}
+}
+
+static inline void serial_omap_thri_mode(struct uart_omap_port *up)
+{
+	unsigned char scr = serial_in(up, UART_OMAP_SCR);
+
+	if (up->tx_wait_end)
+		scr |= UART_OMAP_SCR_TX_EMPTY_CTL_IT;
+	else
+		scr &= ~UART_OMAP_SCR_TX_EMPTY_CTL_IT;
+	serial_out(up, UART_OMAP_SCR, scr);
+}
+
+static inline void serial_omap_update_rts(struct uart_omap_port *up)
+{
+	unsigned char mcr = up->mcr;
+	int rts_on_send = up->rs485.flags & SER_RS485_RTS_ON_SEND;
+
+	if ((up->rs485.flags & SER_RS485_ENABLED) &&
+			((up->tx_in_progress && rts_on_send) ||
+			 !(up->tx_in_progress || rts_on_send)))
+		mcr |= UART_MCR_RTS;
+	serial_out(up, UART_MCR, mcr);
+}
+
 static void serial_omap_stop_tx(struct uart_port *port)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
@@ -146,11 +187,13 @@ static void serial_omap_stop_tx(struct uart_port *port)
 	}
 
 	pm_runtime_get_sync(&up->pdev->dev);
-	if (up->ier & UART_IER_THRI) {
-		up->ier &= ~UART_IER_THRI;
-		serial_out(up, UART_IER, up->ier);
+	if (!(up->rs485.flags & SER_RS485_ENABLED)) {
+		serial_omap_disable_ier_thri(up);
+	} else {
+		up->tx_wait_end = 1;
+		serial_omap_thri_mode(up);
+		serial_omap_enable_ier_thri(up);
 	}
-
 	pm_runtime_mark_last_busy(&up->pdev->dev);
 	pm_runtime_put_autosuspend(&up->pdev->dev);
 }
@@ -268,14 +311,6 @@ static void transmit_chars(struct uart_omap_port *up)
 		serial_omap_stop_tx(&up->port);
 }
 
-static inline void serial_omap_enable_ier_thri(struct uart_omap_port *up)
-{
-	if (!(up->ier & UART_IER_THRI)) {
-		up->ier |= UART_IER_THRI;
-		serial_out(up, UART_IER, up->ier);
-	}
-}
-
 static void serial_omap_start_tx(struct uart_port *port)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
@@ -283,6 +318,18 @@ static void serial_omap_start_tx(struct uart_port *port)
 	unsigned int start;
 	int ret = 0;
 
+	if (up->rs485.flags & SER_RS485_ENABLED) {
+		if (!up->tx_in_progress) {
+			up->tx_in_progress = 1;
+			serial_omap_update_rts(up);
+		}
+		if (up->tx_wait_end) {
+			up->tx_wait_end = 0;
+			serial_omap_thri_mode(up);
+			serial_omap_disable_ier_thri(up);
+		}
+	}
+
 	if (!up->use_dma) {
 		pm_runtime_get_sync(&up->pdev->dev);
 		serial_omap_enable_ier_thri(up);
@@ -369,6 +416,11 @@ static unsigned int check_modem_status(struct uart_omap_port *up)
 	return status;
 }
 
+static inline unsigned int __serial_omap_tx_empty(struct uart_omap_port *up)
+{
+	return serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
+}
+
 /**
  * serial_omap_irq() - This handles the interrupt from one port
  * @irq: uart port irq number
@@ -389,6 +441,17 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
 	}
 
 	spin_lock_irqsave(&up->port.lock, flags);
+	if (up->tx_wait_end && (iir & UART_IIR_THRI) &&
+			__serial_omap_tx_empty(up)) {
+		up->tx_wait_end = 0;
+		up->tx_in_progress = 0;
+		serial_omap_thri_mode(up);
+		serial_omap_update_rts(up);
+		serial_omap_disable_ier_thri(up);
+		spin_unlock_irqrestore(&up->port.lock, flags);
+		return IRQ_HANDLED;
+	}
+
 	lsr = serial_in(up, UART_LSR);
 	if (iir & UART_IIR_RLSI) {
 		if (!up->use_dma) {
@@ -424,7 +487,7 @@ static unsigned int serial_omap_tx_empty(struct uart_port *port)
 	pm_runtime_get_sync(&up->pdev->dev);
 	dev_dbg(up->port.dev, "serial_omap_tx_empty+%d\n", up->port.line);
 	spin_lock_irqsave(&up->port.lock, flags);
-	ret = serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
+	ret = __serial_omap_tx_empty(up);
 	spin_unlock_irqrestore(&up->port.lock, flags);
 	pm_runtime_put(&up->pdev->dev);
 	return ret;
@@ -1128,6 +1191,42 @@ static inline void serial_omap_add_console_port(struct uart_omap_port *up)
 
 #endif
 
+static int
+serial_omap_ioctl(struct uart_port *port, unsigned int cmd, unsigned long arg)
+{
+	struct serial_rs485 rs485conf;
+	struct uart_omap_port *up = (struct uart_omap_port *)port;
+	unsigned long flags;
+
+	switch (cmd) {
+	case TIOCSRS485:
+		if (copy_from_user(&rs485conf, (struct serial_rs485 *) arg,
+					sizeof(rs485conf)))
+			return -EFAULT;
+
+		rs485conf.flags &= OMAP_RS485_SUPPORTED;
+		spin_lock_irqsave(&up->port.lock, flags);
+		if (!(rs485conf.flags & SER_RS485_ENABLED)) {
+			up->tx_in_progress = 0;
+			up->tx_wait_end = 0;
+		}
+		up->rs485 = rs485conf;
+		serial_omap_update_rts(up);
+		serial_omap_thri_mode(up);
+		spin_unlock_irqrestore(&up->port.lock, flags);
+
+	case TIOCGRS485:
+		if (copy_to_user((struct serial_rs485 *) arg,
+					&(up->rs485), sizeof(rs485conf)))
+			return -EFAULT;
+		break;
+
+	default:
+		return -ENOIOCTLCMD;
+	}
+	return 0;
+}
+
 static struct uart_ops serial_omap_pops = {
 	.tx_empty	= serial_omap_tx_empty,
 	.set_mctrl	= serial_omap_set_mctrl,
@@ -1141,6 +1240,7 @@ static struct uart_ops serial_omap_pops = {
 	.shutdown	= serial_omap_shutdown,
 	.set_termios	= serial_omap_set_termios,
 	.pm		= serial_omap_pm,
+	.ioctl		= serial_omap_ioctl,
 	.type		= serial_omap_type,
 	.release_port	= serial_omap_release_port,
 	.request_port	= serial_omap_request_port,
diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index 8ce70d7..8c1083c 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -363,5 +363,7 @@
 #define UART_OMAP_MDR1_CIR_MODE		0x06	/* CIR mode */
 #define UART_OMAP_MDR1_DISABLE		0x07	/* Disable (default state) */
 
+#define UART_OMAP_SCR_TX_EMPTY_CTL_IT	0x04	/* TX Empty IRQ mode */
+
 #endif /* _LINUX_SERIAL_REG_H */
 
-- 
1.7.6.4

