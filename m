From: Adam Ford <aford173@gmail.com>
Subject: [PATCH] serial: 8250_omap: Fix gpio check for auto RTS and CTS
Date: Sat,  5 Oct 2019 21:32:52 -0500
Message-ID: <20191006023254.23841-1-aford173@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: adam.ford@logicpd.com, linux-omap@vger.kernel.org, Adam Ford <aford173@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Vignesh R <vigneshr@ti.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Yegor Yefremov <yegorslists@googlemail.com>, Tony Lindgren <tony@atomide.com>, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

There are two checks to see if the manual gpio is configured, but
these the check is seeing if the structure is NULL instead it
should check to see if there are CTS and/or RTS pins defined.

This patch uses checks for those individual pins instead of
checking for the structure itself.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index c68e2b3a1634..836e736ae188 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -141,7 +141,7 @@ static void omap8250_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 	serial8250_do_set_mctrl(port, mctrl);
 
-	if (!up->gpios) {
+	if (!mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_RTS)) {
 		/*
 		 * Turn off autoRTS if RTS is lowered and restore autoRTS
 		 * setting if RTS is raised
@@ -456,7 +456,8 @@ static void omap_8250_set_termios(struct uart_port *port,
 	up->port.status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS | UPSTAT_AUTOXOFF);
 
 	if (termios->c_cflag & CRTSCTS && up->port.flags & UPF_HARD_FLOW &&
-	    !up->gpios) {
+	    !mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_RTS) &&
+	    !mctrl_gpio_to_gpiod(up->gpios, UART_GPIO_CTS)) {
 		/* Enable AUTOCTS (autoRTS is enabled when RTS is raised) */
 		up->port.status |= UPSTAT_AUTOCTS | UPSTAT_AUTORTS;
 		priv->efr |= UART_EFR_CTS;
-- 
2.17.1
