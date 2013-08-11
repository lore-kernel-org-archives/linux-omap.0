From: Mark Jackson <mpfj-list@newflow.co.uk>
Subject: [RFC] OMAP: add RS485 support
Date: Sun, 11 Aug 2013 13:56:54 +0100
Message-ID: <52078A16.7010907@newflow.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 217-155-41-104.dsl.in-addr.zen.co.uk ([217.155.41.104]:54381
	"EHLO centos1.newflow.co.uk" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753425Ab3HKM44 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 11 Aug 2013 08:56:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, gregkh@linuxfoundation.org, Tony Lindgren <tony@atomide.com>

This patch adds RS485 support to the OMAP serial driver, as
defined in:-

Documentation/devicetree/bindings/serial/rs485.txt

When a UART transmitter is connected to (eg) a RS485 driver, it is
necessary to turn the driver on/off as quickly as possible.  This is
best achieved in the serial driver itself (rather than in userspace
where the latency can be quite large).

This patch allows a GPIO pin to be defined (via DT) that controls
the enabling of the driver at the start of a message, and disables
the driver when the message has been completed.

When RS485 is disabled, the RTS pin is set to on.

Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
---
 drivers/tty/serial/omap-serial.c |  177 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index b6d1728..a1d8d47 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -40,9 +40,12 @@
 #include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/gpio.h>
+#include <linux/of_gpio.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_data/serial-omap.h>
 
+#include <dt-bindings/gpio/gpio.h>
+
 #define OMAP_MAX_HSUART_PORTS	6
 
 #define UART_BUILD_REVISION(x, y)	(((x) << 8) | (y))
@@ -156,6 +159,9 @@ struct uart_omap_port {
 	int			DTR_inverted;
 	int			DTR_active;
 
+	struct serial_rs485	rs485;
+	int			rts_gpio;
+
 	struct pm_qos_request	pm_qos_request;
 	u32			latency;
 	u32			calc_latency;
@@ -272,13 +278,42 @@ static void serial_omap_enable_ms(struct uart_port *port)
 static void serial_omap_stop_tx(struct uart_port *port)
 {
 	struct uart_omap_port *up = to_uart_omap_port(port);
+	struct circ_buf *xmit = &up->port.state->xmit;
+	int res;
 
 	pm_runtime_get_sync(up->dev);
+
+	/* handle rs485 */
+	if (up->rs485.flags & SER_RS485_ENABLED) {
+		/* do nothing if current tx not yet completed */
+		res = serial_in(up, UART_LSR) & UART_LSR_TEMT;
+		if (!res)
+			return;
+
+		/* if there's no more data to send, turn off rts */
+		if (uart_circ_empty(xmit)) {
+			/* if rts not already disabled */
+			res = (up->rs485.flags & SER_RS485_RTS_AFTER_SEND) ? 1 : 0;
+			if (gpio_get_value(up->rts_gpio) != res) {
+				if (up->rs485.delay_rts_after_send > 0) {
+					mdelay(up->rs485.delay_rts_after_send);
+				}
+				gpio_set_value(up->rts_gpio, res);
+			}
+		}
+	}
+
 	if (up->ier & UART_IER_THRI) {
 		up->ier &= ~UART_IER_THRI;
 		serial_out(up, UART_IER, up->ier);
 	}
 
+	if ((up->rs485.flags & SER_RS485_ENABLED) &&
+	    !(up->rs485.flags & SER_RS485_RX_DURING_TX)) {
+		up->ier = UART_IER_RLSI | UART_IER_RDI;
+		serial_out(up, UART_IER, up->ier);
+	}
+
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
 }
@@ -340,8 +375,26 @@ static inline void serial_omap_enable_ier_thri(struct uart_omap_port *up)
 static void serial_omap_start_tx(struct uart_port *port)
 {
 	struct uart_omap_port *up = to_uart_omap_port(port);
+	int res;
 
 	pm_runtime_get_sync(up->dev);
+
+	/* handle rs485 */
+	if (up->rs485.flags & SER_RS485_ENABLED) {
+		/* if rts not already enabled */
+		res = (up->rs485.flags & SER_RS485_RTS_ON_SEND) ? 1 : 0;
+		if (gpio_get_value(up->rts_gpio) != res) {
+			gpio_set_value(up->rts_gpio, res);
+			if (up->rs485.delay_rts_before_send > 0) {
+				mdelay(up->rs485.delay_rts_before_send);
+			}
+		}
+	}
+
+	if ((up->rs485.flags & SER_RS485_ENABLED) &&
+	    !(up->rs485.flags & SER_RS485_RX_DURING_TX))
+		serial_omap_stop_rx(port);
+
 	serial_omap_enable_ier_thri(up);
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
@@ -1254,6 +1307,77 @@ static inline void serial_omap_add_console_port(struct uart_omap_port *up)
 
 #endif
 
+/* Enable or disable the rs485 support */
+static void
+serial_omap_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
+{
+	struct uart_omap_port *up = to_uart_omap_port(port);
+	unsigned long flags;
+	unsigned int mode;
+	int val;
+
+	pm_runtime_get_sync(up->dev);
+	spin_lock_irqsave(&up->port.lock, flags);
+
+	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
+	serial_out(up, UART_IER, up->ier);
+
+	/* Disable interrupts from this port */
+	mode = up->ier;
+	up->ier = 0;
+	serial_out(up, UART_IER, 0);
+
+	/* store new config */
+	up->rs485 = *rs485conf;
+
+	/*
+	 * Just as a precaution, only allow rs485
+	 * to be enabled if the gpio pin is valid
+	 */
+	if (!gpio_is_valid(up->rts_gpio))
+		up->rs485.flags &= ~SER_RS485_ENABLED;
+
+	/* enable / disable rts */
+	val = (up->rs485.flags & SER_RS485_ENABLED) ?
+		SER_RS485_RTS_ON_SEND : SER_RS485_RTS_AFTER_SEND;
+	gpio_set_value(up->rts_gpio, val);
+
+	/* Enable interrupts */
+	up->ier = mode;
+	serial_out(up, UART_IER, up->ier);
+
+	spin_unlock_irqrestore(&up->port.lock, flags);
+	pm_runtime_mark_last_busy(up->dev);
+	pm_runtime_put_autosuspend(up->dev);
+}
+
+static int
+serial_omap_ioctl(struct uart_port *port, unsigned int cmd, unsigned long arg)
+{
+	struct serial_rs485 rs485conf;
+
+	switch (cmd) {
+	case TIOCSRS485:
+		if (copy_from_user(&rs485conf, (struct serial_rs485 *) arg,
+					sizeof(rs485conf)))
+			return -EFAULT;
+
+		serial_omap_config_rs485(port, &rs485conf);
+		break;
+
+	case TIOCGRS485:
+		if (copy_to_user((struct serial_rs485 *) arg,
+					&(to_uart_omap_port(port)->rs485),
+					sizeof(rs485conf)))
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
@@ -1275,6 +1399,7 @@ static struct uart_ops serial_omap_pops = {
 	.request_port	= serial_omap_request_port,
 	.config_port	= serial_omap_config_port,
 	.verify_port	= serial_omap_verify_port,
+	.ioctl		= serial_omap_ioctl,
 #ifdef CONFIG_CONSOLE_POLL
 	.poll_put_char  = serial_omap_poll_put_char,
 	.poll_get_char  = serial_omap_poll_get_char,
@@ -1395,6 +1520,53 @@ static struct omap_uart_port_info *of_get_uart_port_info(struct device *dev)
 	return omap_up_info;
 }
 
+static int serial_omap_probe_rs485(struct uart_omap_port *up,
+				   struct device_node *np)
+{
+	struct serial_rs485 *rs485conf = &up->rs485;
+	u32 rs485_delay[2];
+	enum of_gpio_flags flags;
+	int ret;
+
+	rs485conf->flags = 0;
+	up->rts_gpio = -EINVAL;
+
+	if (!np)
+		return 0;
+
+	if (of_property_read_bool(np, "rs485-rts-active-high"))
+		rs485conf->flags |= SER_RS485_RTS_ON_SEND;
+	else
+		rs485conf->flags |= SER_RS485_RTS_AFTER_SEND;
+
+	/* check for tx enable gpio */
+	up->rts_gpio = of_get_named_gpio_flags(np, "rts-gpio", 0, &flags);
+	if (gpio_is_valid(up->rts_gpio)) {
+		ret = gpio_request(up->rts_gpio, "omap-serial");
+		if (ret < 0)
+			return ret;
+		ret = gpio_direction_output(up->rts_gpio,
+					    flags & SER_RS485_RTS_AFTER_SEND);
+		if (ret < 0)
+			return ret;
+	} else
+		up->rts_gpio = -EINVAL;
+
+	if (of_property_read_u32_array(np, "rs485-rts-delay",
+				    rs485_delay, 2) == 0) {
+		rs485conf->delay_rts_before_send = rs485_delay[0];
+		rs485conf->delay_rts_after_send = rs485_delay[1];
+	}
+
+	if (of_property_read_bool(np, "rs485-rx-during-tx"))
+		rs485conf->flags |= SER_RS485_RX_DURING_TX;
+
+	if (of_property_read_bool(np, "linux,rs485-enabled-at-boot-time"))
+		rs485conf->flags |= SER_RS485_ENABLED;
+
+	return 0;
+}
+
 static int serial_omap_probe(struct platform_device *pdev)
 {
 	struct uart_omap_port	*up;
@@ -1468,6 +1640,10 @@ static int serial_omap_probe(struct platform_device *pdev)
 		goto err_port_line;
 	}
 
+	ret = serial_omap_probe_rs485(up, pdev->dev.of_node);
+	if (ret < 0)
+		goto err_rs485;
+
 	up->pins = devm_pinctrl_get_select_default(&pdev->dev);
 	if (IS_ERR(up->pins)) {
 		dev_warn(&pdev->dev, "did not get pins for uart%i error: %li\n",
@@ -1529,6 +1705,7 @@ err_add_port:
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 err_ioremap:
+err_rs485:
 err_port_line:
 	dev_err(&pdev->dev, "[UART%d]: failure [%s]: %d\n",
 				pdev->id, __func__, ret);
-- 
1.7.9.5

