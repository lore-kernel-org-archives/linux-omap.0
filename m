From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] tty: serial: OMAP: transmit FIFO threshold interrupts
 don't wake the chip
Date: Sat, 21 Jan 2012 00:27:41 -0700
Message-ID: <20120121072740.18707.87632.stgit@dusk>
References: <20120121071934.18707.64258.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59311 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751566Ab2AUHaV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 21 Jan 2012 02:30:21 -0500
In-Reply-To: <20120121071934.18707.64258.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Govindraj Raja <govindraj.r@ti.com>, Kevin Hilman <khilman@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, alan@linux.intel.com

It seems that when the transmit FIFO threshold is reached on OMAP
UARTs, it does not result in a PRCM wakeup.  This appears to be a
silicon bug.  This means that if the MPU powerdomain is in a low-power
state, the MPU will not be awakened to refill the FIFO until the next
interrupt from another device.

The best solution, at least for the short term, would be for the OMAP
serial driver to call a OMAP subarchitecture function to prevent the
MPU powerdomain from entering a low power state while the FIFO has
data to transmit.  However, we no longer have a clean way to do this,
since patches that add platform_data function pointers have been
deprecated by the OMAP maintainer.  So we attempt to work around this
as well.  The workarounds depend on the setting of CONFIG_CPU_IDLE.

When CONFIG_CPU_IDLE=n, the driver will now only transmit one byte at
a time.  This causes the transmit FIFO threshold interrupt to stay
active until there is no more data to be sent.  Thus, the MPU
powerdomain stays on during transmits.  Aside from that energy
consumption penalty, each transmitted byte results in a huge number of
UART interrupts -- about five per byte.  This wastes CPU time and is
quite inefficient, but is probably the most expedient workaround in
this case.

When CONFIG_CPU_IDLE=y, there is a slightly more direct workaround:
the PM QoS constraint can be abused to keep the MPU powerdomain on.
This results in a normal number of interrupts, but, similar to the
above workaround, wastes power by preventing the MPU from entering
WFI.

Future patches are planned for the 3.4 merge window to implement more
efficient, but also more disruptive, workarounds to these problems.

DMA operation is unaffected by this patch.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Govindraj Raja <govindraj.r@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/omap-serial.h |    1 
 drivers/tty/serial/omap-serial.c              |   51 +++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 9ff4444..12a64eb 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -131,6 +131,7 @@ struct uart_omap_port {
 	u32			context_loss_cnt;
 	u32			errata;
 	u8			wakeups_enabled;
+	u8			max_tx_count;
 
 	struct pm_qos_request	pm_qos_request;
 	u32			latency;
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 9de7d71..621fde5 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -88,6 +88,49 @@ static inline void serial_omap_clear_fifos(struct uart_omap_port *up)
 	serial_out(up, UART_FCR, 0);
 }
 
+/**
+ * serial_omap_block_cpu_low_power_state - prevent MPU pwrdm from leaving ON
+ * @up: struct uart_omap_port *
+ *
+ * Prevent the MPU powerdomain from entering a power state lower than
+ * ON.  (It should be sufficient to prevent it from entering INACTIVE,
+ * but there is presently no easy way to do this.)  This works around
+ * a suspected silicon bug in the OMAP UART IP blocks.  The UARTs should
+ * wake the PRCM when the transmit FIFO threshold interrupt is raised, but
+ * they do not.   See also serial_omap_allow_cpu_low_power_state().  No
+ * return value.
+ */
+static void serial_omap_block_cpu_low_power_state(struct uart_omap_port *up)
+{
+#ifdef CONFIG_CPU_IDLE
+	up->latency = 1;
+	schedule_work(&up->qos_work);
+#else
+	up->max_tx_count = 1;
+#endif
+}
+
+/**
+ * serial_omap_allow_cpu_low_power_state - remove power state restriction on MPU
+ * @up: struct uart_omap_port *
+ *
+ * Cancel the effects of serial_omap_block_cpu_low_power_state().
+ * This should allow the MPU powerdomain to enter a power state lower
+ * than ON, assuming the rest of the kernel is not restricting it.
+ * This works around a suspected silicon bug in the OMAP UART IP
+ * blocks.  The UARTs should wake the PRCM when the transmit FIFO
+ * threshold interrupt is raised, but they do not.  No return value.
+ */
+static void serial_omap_allow_cpu_low_power_state(struct uart_omap_port *up)
+{
+#ifdef CONFIG_CPU_IDLE
+	up->latency = up->calc_latency;
+	schedule_work(&up->qos_work);
+#else
+	up->max_tx_count = up->port.fifosize / 4;
+#endif
+}
+
 /*
  * serial_omap_get_divisor - calculate divisor value
  * @port: uart port info
@@ -163,6 +206,9 @@ static void serial_omap_stop_tx(struct uart_port *port)
 		serial_out(up, UART_IER, up->ier);
 	}
 
+	if (!up->use_dma)
+		serial_omap_allow_cpu_low_power_state(up);
+
 	pm_runtime_mark_last_busy(&up->pdev->dev);
 	pm_runtime_put_autosuspend(&up->pdev->dev);
 }
@@ -264,7 +310,7 @@ static void transmit_chars(struct uart_omap_port *up)
 		serial_omap_stop_tx(&up->port);
 		return;
 	}
-	count = up->port.fifosize / 4;
+	count = up->max_tx_count;
 	do {
 		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
 		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
@@ -297,6 +343,7 @@ static void serial_omap_start_tx(struct uart_port *port)
 
 	if (!up->use_dma) {
 		pm_runtime_get_sync(&up->pdev->dev);
+		serial_omap_block_cpu_low_power_state(up);
 		serial_omap_enable_ier_thri(up);
 		pm_runtime_mark_last_busy(&up->pdev->dev);
 		pm_runtime_put_autosuspend(&up->pdev->dev);
@@ -1421,6 +1468,8 @@ static int serial_omap_probe(struct platform_device *pdev)
 	up->port.fifosize = 64;
 	up->port.ops = &serial_omap_pops;
 
+	up->max_tx_count = up->port.fifosize / 4;
+
 	if (pdev->dev.of_node)
 		up->port.line = of_alias_get_id(pdev->dev.of_node, "serial");
 	else


