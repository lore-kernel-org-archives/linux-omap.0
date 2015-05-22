From: yegorslists@googlemail.com
Subject: [PATCH] tty: serial: omap: use mctrl_gpio helpers
Date: Fri, 22 May 2015 14:16:57 +0200
Message-ID: <1432297017-1264-1-git-send-email-yegorslists@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.visionsystems.de ([213.209.99.202]:41530 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161013AbbEVMRi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2015 08:17:38 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, gregkh@linuxfoundation.org, Yegor Yefremov <yegorslists@googlemail.com>

From: Yegor Yefremov <yegorslists@googlemail.com>

This patch permits to use GPIOs to control the CTS/RTS/DTR/DSR/DCD/RI
signals.

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>
---
 .../devicetree/bindings/serial/omap_serial.txt     |    9 +
 drivers/tty/serial/Kconfig                         |    1 +
 drivers/tty/serial/omap-serial.c                   |  168 +++++++++++++++++++-
 3 files changed, 171 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
index 54c2a15..10fcba8 100644
--- a/Documentation/devicetree/bindings/serial/omap_serial.txt
+++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
@@ -16,6 +16,9 @@ Optional properties:
 - dmas : DMA specifier, consisting of a phandle to the DMA controller
          node and a DMA channel number.
 - dma-names : "rx" for receive channel, "tx" for transmit channel.
+- {rts,cts,dtr,dsr,rng,dcd}-gpios: specify a GPIO for RTS/CTS/DTR/DSR/RI/DCD
+  line respectively. It will use specified PIO instead of the peripheral
+  function pin for the UART feature. If unsure, don't specify this property.
 
 Example:
 
@@ -27,4 +30,10 @@ Example:
                         dma-names = "tx", "rx";
                         ti,hwmods = "uart4";
                         clock-frequency = <48000000>;
+                        cts-gpios = <&gpio3 5 GPIO_ACTIVE_LOW>;
+                        rts-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
+                        dtr-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
+                        dsr-gpios = <&gpio1 13 GPIO_ACTIVE_LOW>;
+                        dcd-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
+                        rng-gpios = <&gpio1 15 GPIO_ACTIVE_LOW>;
                 };
diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index f8120c1..bbe0e06 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1106,6 +1106,7 @@ config SERIAL_OMAP
 	tristate "OMAP serial port support"
 	depends on ARCH_OMAP2PLUS
 	select SERIAL_CORE
+	select SERIAL_MCTRL_GPIO
 	help
 	  If you have a machine based on an Texas Instruments OMAP CPU you
 	  can enable its onboard serial ports by enabling this option.
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 7f49172..42751b0 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -43,9 +43,13 @@
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
 #include <linux/platform_data/serial-omap.h>
+#include <linux/gpio/consumer.h>
+#include <linux/err.h>
 
 #include <dt-bindings/gpio/gpio.h>
 
+#include "serial_mctrl_gpio.h"
+
 #define OMAP_MAX_HSUART_PORTS	10
 
 #define UART_BUILD_REVISION(x, y)	(((x) << 8) | (y))
@@ -164,6 +168,9 @@ struct uart_omap_port {
 	u32			features;
 
 	int			rts_gpio;
+	struct mctrl_gpios	*gpios;
+	int			gpio_irq[UART_GPIO_MAX];
+	bool			ms_irq_enabled;
 
 	struct pm_qos_request	pm_qos_request;
 	u32			latency;
@@ -301,6 +308,27 @@ static void serial_omap_enable_ms(struct uart_port *port)
 	dev_dbg(up->port.dev, "serial_omap_enable_ms+%d\n", up->port.line);
 
 	pm_runtime_get_sync(up->dev);
+
+	/*
+	* Interrupt should not be enabled twice
+	*/
+	if (up->ms_irq_enabled)
+		return;
+
+	up->ms_irq_enabled = true;
+
+	if (up->gpio_irq[UART_GPIO_CTS] >= 0)
+		enable_irq(up->gpio_irq[UART_GPIO_CTS]);
+
+	if (up->gpio_irq[UART_GPIO_DSR] >= 0)
+		enable_irq(up->gpio_irq[UART_GPIO_DSR]);
+
+	if (up->gpio_irq[UART_GPIO_RI] >= 0)
+		enable_irq(up->gpio_irq[UART_GPIO_RI]);
+
+	if (up->gpio_irq[UART_GPIO_DCD] >= 0)
+		enable_irq(up->gpio_irq[UART_GPIO_DCD]);
+
 	up->ier |= UART_IER_MSI;
 	serial_out(up, UART_IER, up->ier);
 	pm_runtime_mark_last_busy(up->dev);
@@ -317,6 +345,11 @@ static void serial_omap_stop_tx(struct uart_port *port)
 	/* Handle RS-485 */
 	if (port->rs485.flags & SER_RS485_ENABLED) {
 		if (up->scr & OMAP_UART_SCR_TX_EMPTY) {
+			struct gpio_desc *rts_gpiod;
+
+			rts_gpiod = mctrl_gpio_to_gpiod(up->gpios,
+					UART_GPIO_RTS);
+
 			/* THR interrupt is fired when both TX FIFO and TX
 			 * shift register are empty. This means there's nothing
 			 * left to transmit now, so make sure the THR interrupt
@@ -328,11 +361,11 @@ static void serial_omap_stop_tx(struct uart_port *port)
 			serial_out(up, UART_OMAP_SCR, up->scr);
 			res = (port->rs485.flags & SER_RS485_RTS_AFTER_SEND) ?
 				1 : 0;
-			if (gpio_get_value(up->rts_gpio) != res) {
+			if (gpiod_get_value(rts_gpiod) != res) {
 				if (port->rs485.delay_rts_after_send > 0)
 					mdelay(
 					port->rs485.delay_rts_after_send);
-				gpio_set_value(up->rts_gpio, res);
+				gpiod_set_value(rts_gpiod, res);
 			}
 		} else {
 			/* We're asked to stop, but there's still stuff in the
@@ -431,14 +464,18 @@ static void serial_omap_start_tx(struct uart_port *port)
 
 	/* Handle RS-485 */
 	if (port->rs485.flags & SER_RS485_ENABLED) {
+		struct gpio_desc *rts_gpiod;
+
+		rts_gpiod = mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_RTS);
+
 		/* Fire THR interrupts when FIFO is below trigger level */
 		up->scr &= ~OMAP_UART_SCR_TX_EMPTY;
 		serial_out(up, UART_OMAP_SCR, up->scr);
 
 		/* if rts not already enabled */
 		res = (port->rs485.flags & SER_RS485_RTS_ON_SEND) ? 1 : 0;
-		if (gpio_get_value(up->rts_gpio) != res) {
-			gpio_set_value(up->rts_gpio, res);
+		if (gpiod_get_value(rts_gpiod) != res) {
+			gpiod_set_value(rts_gpiod, res);
 			if (port->rs485.delay_rts_before_send > 0)
 				mdelay(port->rs485.delay_rts_before_send);
 		}
@@ -587,10 +624,44 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
 	unsigned int type;
 	irqreturn_t ret = IRQ_NONE;
 	int max_count = 256;
+	bool gpio_handled = false;
+	bool gpio_any_delta = false;
 
 	spin_lock(&up->port.lock);
 	pm_runtime_get_sync(up->dev);
 
+	if (!gpio_handled) {
+		/*
+		* Dealing with GPIO interrupt
+		*/
+		if (irq == up->gpio_irq[UART_GPIO_RI]) {
+			up->port.icount.rng++;
+			gpio_any_delta = true;
+		}
+
+		if (irq == up->gpio_irq[UART_GPIO_DSR]) {
+			up->port.icount.dsr++;
+			gpio_any_delta = true;
+		}
+
+		if (irq == up->gpio_irq[UART_GPIO_DCD]) {
+			uart_handle_dcd_change
+				(&up->port, UART_MSR_DCD);
+			gpio_any_delta = true;
+		}
+
+		if (irq == up->gpio_irq[UART_GPIO_CTS]) {
+			uart_handle_cts_change
+				(&up->port, UART_MSR_CTS);
+			gpio_any_delta = true;
+		}
+
+		if (gpio_any_delta)
+			wake_up_interruptible(&up->port.state->port.delta_msr_wait);
+
+		gpio_handled = true;
+	}
+
 	do {
 		iir = serial_in(up, UART_IIR);
 		if (iir & UART_IIR_NO_INT)
@@ -638,6 +709,45 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
 	return ret;
 }
 
+static void serial_omap_free_gpio_irq(struct uart_port *port)
+{
+	struct uart_omap_port *up = to_uart_omap_port(port);
+	enum mctrl_gpio_idx i;
+
+	for (i = 0; i < UART_GPIO_MAX; i++)
+		if (up->gpio_irq[i] >= 0)
+			free_irq(up->gpio_irq[i], port);
+}
+
+static int serial_omap_request_gpio_irq(struct uart_port *port)
+{
+	struct uart_omap_port *up = to_uart_omap_port(port);
+	int *irq = up->gpio_irq;
+	enum mctrl_gpio_idx i;
+	int err = 0;
+
+	for (i = 0; (i < UART_GPIO_MAX) && !err; i++) {
+		if (irq[i] < 0)
+			continue;
+
+		irq_set_status_flags(irq[i], IRQ_NOAUTOEN);
+		err = request_irq(irq[i], serial_omap_irq, IRQ_TYPE_EDGE_BOTH,
+				"omap_serial", port);
+		if (err)
+			dev_err(port->dev, "omap_startup - Can't get %d irq\n",
+				irq[i]);
+	}
+
+	/*
+	 * If something went wrong, rollback.
+	 */
+	while (err && (--i >= 0))
+		if (irq[i] >= 0)
+			free_irq(irq[i], port);
+
+	return err;
+}
+
 static unsigned int serial_omap_tx_empty(struct uart_port *port)
 {
 	struct uart_omap_port *up = to_uart_omap_port(port);
@@ -675,7 +785,8 @@ static unsigned int serial_omap_get_mctrl(struct uart_port *port)
 		ret |= TIOCM_DSR;
 	if (status & UART_MSR_CTS)
 		ret |= TIOCM_CTS;
-	return ret;
+
+	return mctrl_gpio_get(up->gpios, &ret);
 }
 
 static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
@@ -714,6 +825,8 @@ static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
+
+	mctrl_gpio_set(up->gpios, mctrl);
 }
 
 static void serial_omap_break_ctl(struct uart_port *port, int break_state)
@@ -740,6 +853,8 @@ static int serial_omap_startup(struct uart_port *port)
 	unsigned long flags = 0;
 	int retval;
 
+	up->ms_irq_enabled = false;
+
 	/*
 	 * Allocate the IRQ
 	 */
@@ -759,6 +874,15 @@ static int serial_omap_startup(struct uart_port *port)
 		disable_irq(up->wakeirq);
 	}
 
+	retval = serial_omap_request_gpio_irq(port);
+	if (retval) {
+		free_irq(up->port.irq, up);
+		if (up->wakeirq)
+			free_irq(up->wakeirq, up);
+
+		return retval;
+	}
+
 	dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->port.line);
 
 	pm_runtime_get_sync(up->dev);
@@ -847,6 +971,8 @@ static void serial_omap_shutdown(struct uart_port *port)
 	free_irq(up->port.irq, up);
 	if (up->wakeirq)
 		free_irq(up->wakeirq, up);
+	serial_omap_free_gpio_irq(port);
+	up->ms_irq_enabled = false;
 }
 
 static void serial_omap_uart_qos_work(struct work_struct *work)
@@ -1373,6 +1499,9 @@ serial_omap_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
 	struct uart_omap_port *up = to_uart_omap_port(port);
 	unsigned int mode;
 	int val;
+	struct gpio_desc *rts_gpiod;
+
+	rts_gpiod = mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_RTS);
 
 	pm_runtime_get_sync(up->dev);
 
@@ -1388,12 +1517,12 @@ serial_omap_config_rs485(struct uart_port *port, struct serial_rs485 *rs485conf)
 	 * Just as a precaution, only allow rs485
 	 * to be enabled if the gpio pin is valid
 	 */
-	if (gpio_is_valid(up->rts_gpio)) {
+	if (!IS_ERR_OR_NULL(rts_gpiod)) {
 		/* enable / disable rts */
 		val = (port->rs485.flags & SER_RS485_ENABLED) ?
 			SER_RS485_RTS_AFTER_SEND : SER_RS485_RTS_ON_SEND;
 		val = (port->rs485.flags & val) ? 1 : 0;
-		gpio_set_value(up->rts_gpio, val);
+		gpiod_set_value(rts_gpiod, val);
 	} else
 		port->rs485.flags &= ~SER_RS485_ENABLED;
 
@@ -1616,6 +1745,26 @@ static int serial_omap_probe_rs485(struct uart_omap_port *up,
 	return 0;
 }
 
+static int serial_omap_init_gpios(struct uart_omap_port *up, struct device *dev)
+{
+	enum mctrl_gpio_idx i;
+	struct gpio_desc *gpiod;
+
+	up->gpios = mctrl_gpio_init(dev, 0);
+	if (IS_ERR_OR_NULL(up->gpios))
+		return -1;
+
+	for (i = 0; i < UART_GPIO_MAX; i++) {
+		gpiod = mctrl_gpio_to_gpiod(up->gpios, i);
+		if (gpiod && (gpiod_get_direction(gpiod) == GPIOF_DIR_IN))
+			up->gpio_irq[i] = gpiod_to_irq(gpiod);
+		else
+			up->gpio_irq[i] = -EINVAL;
+	}
+
+	return 0;
+}
+
 static int serial_omap_probe(struct platform_device *pdev)
 {
 	struct omap_uart_port_info *omap_up_info = dev_get_platdata(&pdev->dev);
@@ -1682,6 +1831,11 @@ static int serial_omap_probe(struct platform_device *pdev)
 		dev_info(up->port.dev, "no wakeirq for uart%d\n",
 			 up->port.line);
 
+	ret = serial_omap_init_gpios(up, &pdev->dev);
+	if (ret < 0)
+		dev_err(&pdev->dev, "%s",
+			"Failed to initialize GPIOs. The serial port may not work as expected");
+
 	ret = serial_omap_probe_rs485(up, pdev->dev.of_node);
 	if (ret < 0)
 		goto err_rs485;
-- 
1.7.7

