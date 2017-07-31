From: yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org
Subject: [PATCH v2 2/3] tty/serial/8250: use mctrl_gpio helpers
Date: Mon, 31 Jul 2017 09:13:22 +0200
Message-ID: <1501485203-13185-3-git-send-email-yegorslists@googlemail.com>
References: <1501485203-13185-1-git-send-email-yegorslists@googlemail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1501485203-13185-1-git-send-email-yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, julia.lawall-L2FTfq7BK8M@public.gmane.org, peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org, Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>

This patch permits the usage for GPIOs to control
the CTS/RTS/DTR/DSR/DCD/RI signals.

Signed-off-by: Yegor Yefremov <yegorslists-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
---
 drivers/tty/serial/8250/8250.h      | 35 ++++++++++++++++++++++++++++++++++-
 drivers/tty/serial/8250/8250_core.c | 12 ++++++++++++
 drivers/tty/serial/8250/8250_omap.c | 31 ++++++++++++++++++-------------
 drivers/tty/serial/8250/8250_port.c |  7 ++++++-
 drivers/tty/serial/8250/Kconfig     |  1 +
 include/linux/serial_8250.h         |  1 +
 6 files changed, 72 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index b2bdc35..c47ef69 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -15,6 +15,8 @@
 #include <linux/serial_reg.h>
 #include <linux/dmaengine.h>
 
+#include "../serial_mctrl_gpio.h"
+
 struct uart_8250_dma {
 	int (*tx_dma)(struct uart_8250_port *p);
 	int (*rx_dma)(struct uart_8250_port *p);
@@ -145,12 +147,43 @@ void serial8250_em485_destroy(struct uart_8250_port *p);
 
 static inline void serial8250_out_MCR(struct uart_8250_port *up, int value)
 {
+	int mctrl_gpio = 0;
+
 	serial_out(up, UART_MCR, value);
+
+	if (value & UART_MCR_RTS)
+		mctrl_gpio |= TIOCM_RTS;
+	if (value & UART_MCR_DTR)
+		mctrl_gpio |= TIOCM_DTR;
+
+	mctrl_gpio_set(up->gpios, mctrl_gpio);
 }
 
 static inline int serial8250_in_MCR(struct uart_8250_port *up)
 {
-	return serial_in(up, UART_MCR);
+	int mctrl, mctrl_gpio = 0;
+
+	mctrl = serial_in(up, UART_MCR);
+
+	/* save current MCR values */
+	if (mctrl & UART_MCR_RTS)
+		mctrl_gpio |= TIOCM_RTS;
+	if (mctrl & UART_MCR_DTR)
+		mctrl_gpio |= TIOCM_DTR;
+
+	mctrl_gpio = mctrl_gpio_get_outputs(up->gpios, &mctrl_gpio);
+
+	if (mctrl_gpio & TIOCM_RTS)
+		mctrl |= UART_MCR_RTS;
+	else
+		mctrl &= ~UART_MCR_RTS;
+
+	if (mctrl_gpio & TIOCM_DTR)
+		mctrl |= UART_MCR_DTR;
+	else
+		mctrl &= ~UART_MCR_DTR;
+
+	return mctrl;
 }
 
 #if defined(__alpha__) && !defined(CONFIG_PCI)
diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index b5def35..3371c5c 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -975,6 +975,8 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 
 	uart = serial8250_find_match_or_unused(&up->port);
 	if (uart && uart->port.type != PORT_8250_CIR) {
+		struct mctrl_gpios *gpios;
+
 		if (uart->port.dev)
 			uart_remove_one_port(&serial8250_reg, &uart->port);
 
@@ -1012,6 +1014,15 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		if (up->port.flags & UPF_FIXED_TYPE)
 			uart->port.type = up->port.type;
 
+		gpios = mctrl_gpio_init(&uart->port, 0);
+		if (IS_ERR(gpios)) {
+			if (PTR_ERR(gpios) != -ENOSYS) {
+				ret = PTR_ERR(gpios);
+				goto out;
+			}
+		} else
+			uart->gpios = gpios;
+
 		serial8250_set_defaults(uart);
 
 		/* Possibly override default I/O functions.  */
@@ -1051,6 +1062,7 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 		if (ret == 0)
 			ret = uart->port.line;
 	}
+out:
 	mutex_unlock(&serial_mutex);
 
 	return ret;
diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 833771b..93fe5b9 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -134,18 +134,21 @@ static void omap8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 	serial8250_do_set_mctrl(port, mctrl);
 
-	/*
-	 * Turn off autoRTS if RTS is lowered and restore autoRTS setting
-	 * if RTS is raised
-	 */
-	lcr = serial_in(up, UART_LCR);
-	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-	if ((mctrl & TIOCM_RTS) && (port->status & UPSTAT_AUTORTS))
-		priv->efr |= UART_EFR_RTS;
-	else
-		priv->efr &= ~UART_EFR_RTS;
-	serial_out(up, UART_EFR, priv->efr);
-	serial_out(up, UART_LCR, lcr);
+	if (IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(up->gpios,
+						UART_GPIO_RTS))) {
+		/*
+		 * Turn off autoRTS if RTS is lowered and restore autoRTS
+		 * setting if RTS is raised
+		 */
+		lcr = serial_in(up, UART_LCR);
+		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+		if ((mctrl & TIOCM_RTS) && (port->status & UPSTAT_AUTORTS))
+			priv->efr |= UART_EFR_RTS;
+		else
+			priv->efr &= ~UART_EFR_RTS;
+		serial_out(up, UART_EFR, priv->efr);
+		serial_out(up, UART_LCR, lcr);
+	}
 }
 
 /*
@@ -446,7 +449,9 @@ static void omap_8250_set_termios(struct uart_port *port,
 	priv->efr = 0;
 	up->port.status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
 
-	if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW) {
+	if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW
+		&& IS_ERR_OR_NULL(mctrl_gpio_to_gpiod(up->gpios,
+							UART_GPIO_RTS))) {
 		/* Enable AUTOCTS (autoRTS is enabled when RTS is raised) */
 		up->port.status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
 		priv->efr |= UART_EFR_CTS;
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index a5fe0e6..f173cda 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1631,6 +1631,8 @@ static void serial8250_disable_ms(struct uart_port *port)
 	if (up->bugs & UART_BUG_NOMSR)
 		return;
 
+	mctrl_gpio_disable_ms(up->gpios);
+
 	up->ier &= ~UART_IER_MSI;
 	serial_port_out(port, UART_IER, up->ier);
 }
@@ -1643,6 +1645,8 @@ static void serial8250_enable_ms(struct uart_port *port)
 	if (up->bugs & UART_BUG_NOMSR)
 		return;
 
+	mctrl_gpio_enable_ms(up->gpios);
+
 	up->ier |= UART_IER_MSI;
 
 	serial8250_rpm_get(up);
@@ -1946,7 +1950,8 @@ unsigned int serial8250_do_get_mctrl(struct uart_port *port)
 		ret |= TIOCM_DSR;
 	if (status & UART_MSR_CTS)
 		ret |= TIOCM_CTS;
-	return ret;
+
+	return mctrl_gpio_get(up->gpios, &ret);
 }
 EXPORT_SYMBOL_GPL(serial8250_do_get_mctrl);
 
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index a1161ec..c0e51b0 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -6,6 +6,7 @@
 config SERIAL_8250
 	tristate "8250/16550 and compatible serial support"
 	select SERIAL_CORE
+	select SERIAL_MCTRL_GPIO if GPIOLIB
 	---help---
 	  This selects whether you want to include the driver for the standard
 	  serial ports.  The standard answer is Y.  People who might say N
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 61fbb44..23b6ab1 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -113,6 +113,7 @@ struct uart_8250_port {
 						 *   if no_console_suspend
 						 */
 	unsigned char		probe;
+	struct mctrl_gpios	*gpios;
 #define UART_PROBE_RSA	(1 << 0)
 
 	/*
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
