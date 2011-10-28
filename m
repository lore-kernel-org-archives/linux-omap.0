From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: [PATCH 1/1] omap: serial: Add RS-485 standard support
Date: Sat, 29 Oct 2011 01:04:44 +0200
Message-ID: <1319843084-16948-1-git-send-email-martinez.javier@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Alan Cox <alan@linux.intel.com>, Govindraj Raja <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, Javier Martinez Canillas <martinez.javier@gmail.com>
List-Id: linux-omap@vger.kernel.org

This patch adds TIA/EIA-485 standard support to OMAP-UART controller driver
by adding handlers for TIOCSRS485 and TIOCGRS485 ioctl commands.

This patch is based on Ilya Yanok <yanok@emcraft.com> patch [1] but it changes
the function serial_omap_update_rts() that raises and lows the Ready-to-Send
control signal. Also, it forces to update the RTS signal when the serial-core
calls serial_omap_set_mctrl().

[1]: http://www.spinics.net/lists/linux-omap/msg58546.html

Signed-off-by: Javier Martinez Canillas <martinez.javier@gmail.com>
---
 arch/arm/plat-omap/include/plat/omap-serial.h |    2 +
 drivers/tty/serial/Makefile                   |    2 +-
 drivers/tty/serial/omap-serial.c              |  139 ++++++++++++++++++++++--
 include/linux/serial_reg.h                    |    2 +
 4 files changed, 132 insertions(+), 13 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 2682043..b7c2c29 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -111,6 +111,8 @@ struct uart_omap_port {
 	unsigned char		msr_saved_flags;
 	char			name[20];
 	unsigned long		port_activity;
+	struct serial_rs485     rs485;
+	unsigned int            tx_in_progress:1, tx_wait_end:1;
 };
 
 #endif /* __OMAP_SERIAL_H__ */
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index 83b4da6..865f238 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -71,7 +71,7 @@ obj-$(CONFIG_SERIAL_VR41XX) += vr41xx_siu.o
 obj-$(CONFIG_SERIAL_SGI_IOC4) += ioc4_serial.o
 obj-$(CONFIG_SERIAL_SGI_IOC3) += ioc3_serial.o
 obj-$(CONFIG_SERIAL_ATMEL) += atmel_serial.o
-obj-$(CONFIG_SERIAL_UARTLITE) += uartlite.o
+#obj-$(CONFIG_SERIAL_UARTLITE) += uartlite.o
 obj-$(CONFIG_SERIAL_MSM) += msm_serial.o
 obj-$(CONFIG_SERIAL_MSM_HS) += msm_serial_hs.o
 obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 5e713d3..d1789f4 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -37,6 +37,7 @@
 #include <linux/clk.h>
 #include <linux/serial_core.h>
 #include <linux/irq.h>
+#include <linux/uaccess.h>
 
 #include <plat/dma.h>
 #include <plat/dmtimer.h>
@@ -114,6 +115,56 @@ static void serial_omap_enable_ms(struct uart_port *port)
 	serial_out(up, UART_IER, up->ier);
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
+
+static inline void serial_omap_update_rts(struct uart_omap_port *up)
+{
+	unsigned char mcr = up->mcr;
+	int rts_on_send = up->rs485.flags & SER_RS485_RTS_ON_SEND;
+
+	if (up->rs485.flags & SER_RS485_ENABLED) {
+		if (up->tx_in_progress) {
+			if (rts_on_send)
+				mcr |= UART_MCR_RTS;
+			else
+				mcr &= ~UART_MCR_RTS;
+		} else {
+			if (rts_on_send)
+				mcr &= ~UART_MCR_RTS;
+			else
+				mcr |= ~UART_MCR_RTS;
+		}
+	}
+
+	serial_out(up, UART_MCR, mcr);
+}
+
 static void serial_omap_stop_tx(struct uart_port *port)
 {
 	struct uart_omap_port *up = (struct uart_omap_port *)port;
@@ -131,9 +182,14 @@ static void serial_omap_stop_tx(struct uart_port *port)
 		up->uart_dma.tx_dma_channel = OMAP_UART_DMA_CH_FREE;
 	}
 
-	if (up->ier & UART_IER_THRI) {
-		up->ier &= ~UART_IER_THRI;
-		serial_out(up, UART_IER, up->ier);
+	if (!(up->rs485.flags & SER_RS485_ENABLED))
+		serial_omap_disable_ier_thri(up);
+	else {
+		up->tx_in_progress = 0;
+		serial_omap_update_rts(up);
+		up->tx_wait_end = 1;
+		serial_omap_thri_mode(up);
+		serial_omap_enable_ier_thri(up);
 	}
 }
 
@@ -246,14 +302,6 @@ static void transmit_chars(struct uart_omap_port *up)
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
@@ -261,6 +309,18 @@ static void serial_omap_start_tx(struct uart_port *port)
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
 		serial_omap_enable_ier_thri(up);
 		return;
@@ -343,6 +403,11 @@ static unsigned int check_modem_status(struct uart_omap_port *up)
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
@@ -359,6 +424,16 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	spin_lock_irqsave(&up->port.lock, flags);
+	if (up->tx_wait_end && (iir & UART_IIR_THRI) &&
+	    __serial_omap_tx_empty(up)) {
+		up->tx_wait_end = 0;
+		up->tx_in_progress = 0;
+		serial_omap_thri_mode(up);
+		serial_omap_update_rts(up);
+		serial_omap_disable_ier_thri(up);
+		spin_unlock_irqrestore(&up->port.lock, flags);
+		return IRQ_HANDLED;
+	}
 	lsr = serial_in(up, UART_LSR);
 	if (iir & UART_IIR_RLSI) {
 		if (!up->use_dma) {
@@ -390,7 +465,7 @@ static unsigned int serial_omap_tx_empty(struct uart_port *port)
 
 	dev_dbg(up->port.dev, "serial_omap_tx_empty+%d\n", up->pdev->id);
 	spin_lock_irqsave(&up->port.lock, flags);
-	ret = serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
+	ret = __serial_omap_tx_empty(up);
 	spin_unlock_irqrestore(&up->port.lock, flags);
 
 	return ret;
@@ -434,6 +509,10 @@ static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
 		mcr |= UART_MCR_LOOP;
 
 	mcr |= up->mcr;
+
+	if (up->rs485.flags & SER_RS485_ENABLED)
+		serial_omap_update_rts(up);
+
 	serial_out(up, UART_MCR, mcr);
 }
 
@@ -1028,6 +1107,41 @@ static inline void serial_omap_add_console_port(struct uart_omap_port *up)
 
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
+				   sizeof(rs485conf)))
+			return -EFAULT;
+
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
+				 &(up->rs485), sizeof(rs485conf)))
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
@@ -1041,6 +1155,7 @@ static struct uart_ops serial_omap_pops = {
 	.shutdown	= serial_omap_shutdown,
 	.set_termios	= serial_omap_set_termios,
 	.pm		= serial_omap_pm,
+	.ioctl          = serial_omap_ioctl,
 	.type		= serial_omap_type,
 	.release_port	= serial_omap_release_port,
 	.request_port	= serial_omap_request_port,
diff --git a/include/linux/serial_reg.h b/include/linux/serial_reg.h
index c75bda3..dc6a3f7 100644
--- a/include/linux/serial_reg.h
+++ b/include/linux/serial_reg.h
@@ -362,5 +362,7 @@
 #define UART_OMAP_MDR1_CIR_MODE		0x06	/* CIR mode */
 #define UART_OMAP_MDR1_DISABLE		0x07	/* Disable (default state) */
 
+#define UART_OMAP_SCR_TX_EMPTY_CTL_IT   0x04    /* TX Empty IRQ mode */
+
 #endif /* _LINUX_SERIAL_REG_H */
 
-- 
1.7.4.1

