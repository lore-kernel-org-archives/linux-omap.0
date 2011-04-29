From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v2 08/12] Serial: OMAP2+: Make the RX_TIMEOUT for DMA configurable for each UART
Date: Fri, 29 Apr 2011 18:09:52 +0530
Message-ID: <1304080796-625-9-git-send-email-govindraj.raja@ti.com>
References: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57585 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755574Ab1D2Mmd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Apr 2011 08:42:33 -0400
In-Reply-To: <1304080796-625-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jon Hunter <jon-hunter@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

When using DMA there are two timeouts defined. The first timeout,
rx_timeout, is really a polling rate in which software polls the
DMA status to see if the DMA has finished. This is necessary for
the RX side because we do not know how much data we will receive.
The secound timeout, RX_TIMEOUT, is a timeout after which the
DMA will be stopped if no more data is received. To make this
clearer, rename rx_timeout as rx_poll_rate and rename the
function serial_omap_rx_timeout() to serial_omap_rxdma_poll().

The OMAP-Serial driver defines an RX_TIMEOUT of 3 seconds that is
used to indicate when the DMA for UART can be stopped if no more
data is received. The value is a global definition that is applied
to all instances of the UART.

Each UART may be used for a different purpose and so the timeout
required may differ. Make this value configurable for each UART so
that this value can be optimised for power savings.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c                  |    2 ++
 arch/arm/plat-omap/include/plat/omap-serial.h |    6 ++++--
 drivers/tty/serial/omap-serial.c              |   15 ++++++++-------
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index b1b7ad6..84f3ad1 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -48,6 +48,7 @@ static struct omap_uart_port_info omap_serial_default_info[] = {
 	{
 		.dma_enabled	= 0,
 		.dma_rx_buf_size = DEFAULT_RXDMA_BUFSIZE,
+		.dma_rx_poll_rate = DEFAULT_RXDMA_POLLRATE,
 		.dma_rx_timeout = DEFAULT_RXDMA_TIMEOUT,
 		.auto_sus_timeout = DEFAULT_AUTOSUSPEND_DELAY,
 	},
@@ -364,6 +365,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 	pdata->enable_wakeup = omap_uart_wakeup_enable;
 	pdata->dma_enabled = info->dma_enabled;
 	pdata->dma_rx_buf_size = info->dma_rx_buf_size;
+	pdata->dma_rx_poll_rate = info->dma_rx_poll_rate;
 	pdata->dma_rx_timeout = info->dma_rx_timeout;
 	pdata->auto_sus_timeout = info->auto_sus_timeout;
 	if (bdata->id == omap_uart_con_id)
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 4e2dcdc..c5f4dd9 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -51,8 +51,8 @@
 
 #define OMAP_UART_DMA_CH_FREE	-1
 
-#define RX_TIMEOUT		(3 * HZ)	/* RX DMA timeout (jiffies) */
-#define DEFAULT_RXDMA_TIMEOUT	1		/* RX DMA polling rate (us) */
+#define DEFAULT_RXDMA_TIMEOUT	(3 * HZ)	/* RX DMA timeout (jiffies) */
+#define DEFAULT_RXDMA_POLLRATE	1		/* RX DMA polling rate (us) */
 #define DEFAULT_RXDMA_BUFSIZE	4096		/* RX DMA buffer size */
 #define DEFAULT_AUTOSUSPEND_DELAY (30 * HZ) /* Runtime autosuspend (msecs) */
 
@@ -71,6 +71,7 @@ struct omap_uart_port_info {
 	unsigned int		console_uart;
 	unsigned int		dma_rx_buf_size;/* DMA Rx Buffer Size */
 	unsigned int		dma_rx_timeout;	/* DMA RX timeout */
+	unsigned int		dma_rx_poll_rate; /* DMA RX timeout */
 	unsigned int		auto_sus_timeout; /* Auto_suspend timeout */
 
 	void (*enable_wakeup)(struct platform_device *, bool);
@@ -101,6 +102,7 @@ struct uart_omap_dma {
 	/* timer to poll activity on rx dma */
 	struct timer_list	rx_timer;
 	unsigned int		rx_buf_size;
+	unsigned int		rx_poll_rate;
 	unsigned int		rx_timeout;
 };
 
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index c525537..9ed993c 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -48,7 +48,7 @@ static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 
 /* Forward declaration of functions */
 static void uart_tx_dma_callback(int lch, u16 ch_status, void *data);
-static void serial_omap_rx_timeout(unsigned long uart_no);
+static void serial_omap_rxdma_poll(unsigned long uart_no);
 static int serial_omap_start_rxdma(struct uart_omap_port *up);
 static void omap_uart_mdr1_errataset(struct uart_omap_port *up);
 
@@ -543,7 +543,7 @@ static int serial_omap_startup(struct uart_port *port)
 			(dma_addr_t *)&(up->uart_dma.tx_buf_dma_phys),
 			0);
 		init_timer(&(up->uart_dma.rx_timer));
-		up->uart_dma.rx_timer.function = serial_omap_rx_timeout;
+		up->uart_dma.rx_timer.function = serial_omap_rxdma_poll;
 		up->uart_dma.rx_timer.data = up->pdev->id;
 		/* Currently the buffer size is 4KB. Can increase it */
 		up->uart_dma.rx_buf = dma_alloc_coherent(NULL,
@@ -1162,7 +1162,7 @@ static int serial_omap_resume(struct device *dev)
 	return 0;
 }
 
-static void serial_omap_rx_timeout(unsigned long uart_no)
+static void serial_omap_rxdma_poll(unsigned long uart_no)
 {
 	struct uart_omap_port *up = ui[uart_no];
 	unsigned int curr_dma_pos, curr_transmitted_size;
@@ -1172,9 +1172,9 @@ static void serial_omap_rx_timeout(unsigned long uart_no)
 	if ((curr_dma_pos == up->uart_dma.prev_rx_dma_pos) ||
 			     (curr_dma_pos == 0)) {
 		if (jiffies_to_msecs(jiffies - up->port_activity) <
-							RX_TIMEOUT) {
+						up->uart_dma.rx_timeout) {
 			mod_timer(&up->uart_dma.rx_timer, jiffies +
-				usecs_to_jiffies(up->uart_dma.rx_timeout));
+				usecs_to_jiffies(up->uart_dma.rx_poll_rate));
 		} else {
 			serial_omap_stop_rxdma(up);
 			up->ier |= (UART_IER_RDI | UART_IER_RLSI);
@@ -1204,7 +1204,7 @@ static void serial_omap_rx_timeout(unsigned long uart_no)
 		}
 	} else  {
 		mod_timer(&up->uart_dma.rx_timer, jiffies +
-			usecs_to_jiffies(up->uart_dma.rx_timeout));
+			usecs_to_jiffies(up->uart_dma.rx_poll_rate));
 	}
 	up->port_activity = jiffies;
 }
@@ -1246,7 +1246,7 @@ static int serial_omap_start_rxdma(struct uart_omap_port *up)
 	/* FIXME: Cache maintenance needed here? */
 	omap_start_dma(up->uart_dma.rx_dma_channel);
 	mod_timer(&up->uart_dma.rx_timer, jiffies +
-				usecs_to_jiffies(up->uart_dma.rx_timeout));
+				usecs_to_jiffies(up->uart_dma.rx_poll_rate));
 	up->uart_dma.rx_dma_used = true;
 	return ret;
 }
@@ -1386,6 +1386,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 		up->use_dma = 1;
 		up->uart_dma.rx_buf_size = omap_up_info->dma_rx_buf_size;
 		up->uart_dma.rx_timeout = omap_up_info->dma_rx_timeout;
+		up->uart_dma.rx_poll_rate = omap_up_info->dma_rx_poll_rate;
 		spin_lock_init(&(up->uart_dma.tx_lock));
 		spin_lock_init(&(up->uart_dma.rx_lock));
 		up->uart_dma.tx_dma_channel = OMAP_UART_DMA_CH_FREE;
-- 
1.7.1

