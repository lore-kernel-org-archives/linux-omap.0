From: Frans Klaver <frans.klaver@xsens.com>
Subject: [RFC PATCH 3/4] tty: omap-serial: use threaded interrupt handler
Date: Tue, 19 Aug 2014 14:14:47 +0200
Message-ID: <1408450488-4083-4-git-send-email-frans.klaver@xsens.com>
References: <1406645577-18620-1-git-send-email-frans.klaver@xsens.com>
 <1408450488-4083-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408450488-4083-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Frans Klaver <frans.klaver@xsens.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexey Pelykh <alexey.pelykh@gmail.com>, Jiri Slaby <jslaby@suse.cz>, Frans Klaver <fransklaver@gmail.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

At 3.6Mbaud, with slightly over 2Mbit/s data coming in, we see 1600 uart
rx buffer overflows within 30 seconds. Threading the interrupt handling reduces
this to about 170 overflows in 10 minutes.

In practice this therefore reduces the need for hardware flow control,
meaning the sending side doesn't have to buffer as much either.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 drivers/tty/serial/omap-serial.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 14a0167..57664b9 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -575,6 +575,21 @@ static void serial_omap_rdi(struct uart_omap_port *up, unsigned int lsr)
 }
 
 /**
+ * serial_omap_fast_irq() - schedule interrupt handling
+ */
+static irqreturn_t serial_omap_fast_irq(int irq, void *dev_id)
+{
+	struct uart_omap_port *up = dev_id;
+	unsigned int iir = serial_in(up, UART_IIR);
+
+	if (iir & UART_IIR_NO_INT)
+		return IRQ_NONE;
+
+	disable_irq_nosync(up->port.irq);
+	return IRQ_WAKE_THREAD;
+}
+
+/**
  * serial_omap_irq() - This handles the interrupt from one port
  * @irq: uart port irq number
  * @dev_id: uart port info
@@ -584,7 +599,6 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
 	struct uart_omap_port *up = dev_id;
 	unsigned int iir, lsr;
 	unsigned int type;
-	irqreturn_t ret = IRQ_NONE;
 	int max_count = 256;
 
 	spin_lock(&up->port.lock);
@@ -595,7 +609,6 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
 		if (iir & UART_IIR_NO_INT)
 			break;
 
-		ret = IRQ_HANDLED;
 		lsr = serial_in(up, UART_LSR);
 
 		/* extract IRQ type from IIR register */
@@ -630,11 +643,13 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
 
 	tty_flip_buffer_push(&up->port.state->port);
 
+	enable_irq(up->port.irq);
+
 	pm_runtime_mark_last_busy(up->dev);
 	pm_runtime_put_autosuspend(up->dev);
 	up->port_activity = jiffies;
 
-	return ret;
+	return IRQ_HANDLED;
 }
 
 static unsigned int serial_omap_tx_empty(struct uart_port *port)
@@ -731,15 +746,17 @@ static int serial_omap_startup(struct uart_port *port)
 	/*
 	 * Allocate the IRQ
 	 */
-	retval = request_irq(up->port.irq, serial_omap_irq, up->port.irqflags,
-				up->name, up);
+	retval = request_threaded_irq(up->port.irq, serial_omap_fast_irq,
+					serial_omap_irq, up->port.irqflags,
+					up->name, up);
 	if (retval)
 		return retval;
 
 	/* Optional wake-up IRQ */
 	if (up->wakeirq) {
-		retval = request_irq(up->wakeirq, serial_omap_irq,
-				     up->port.irqflags, up->name, up);
+		retval = request_threaded_irq(up->wakeirq, serial_omap_fast_irq,
+					serial_omap_irq, up->port.irqflags,
+					up->name, up);
 		if (retval) {
 			free_irq(up->port.irq, up);
 			return retval;
-- 
1.9.3
