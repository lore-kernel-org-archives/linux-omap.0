From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v4 11/11] Serial: OMAP2+: Make the RX_TIMEOUT for DMA
	configurable for each UART
Date: Wed, 7 Sep 2011 18:23:33 +0530
Message-ID: <1315400013-4849-12-git-send-email-govindraj.raja@ti.com>
References: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1315400013-4849-1-git-send-email-govindraj.raja@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Jon Hunter <jon-hunter@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Jon Hunter <jon-hunter@ti.com>

When using DMA there are two timeouts defined. The first timeout,
rx_timeout, is really a polling rate in which software polls the
DMA status to see if the DMA has finished. This is necessary for
the RX side because we do not know how much data we will receive.
The second timeout, RX_TIMEOUT, is a timeout after which the
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

Acked-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c                  |    5 ++++-
 arch/arm/plat-omap/include/plat/omap-serial.h |    3 ++-
 drivers/tty/serial/omap-serial.c              |   15 ++++++++-------
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index dd4d872..942438c 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -41,14 +41,16 @@
 
 #define MAX_UART_HWMOD_NAME_LEN		16
 
-#define DEFAULT_RXDMA_TIMEOUT		1	/* RX DMA polling rate (us) */
+#define DEFAULT_RXDMA_POLLRATE		1	/* RX DMA polling rate (us) */
 #define DEFAULT_RXDMA_BUFSIZE		4096	/* RX DMA buffer size */
 #define DEFAULT_AUTOSUSPEND_DELAY	3000	/* Runtime autosuspend (msecs)*/
+#define DEFAULT_RXDMA_TIMEOUT		(3 * HZ)/* RX DMA timeout (jiffies) */
 
 static struct omap_uart_port_info omap_serial_default_info[] = {
 	{
 		.dma_enabled	= 0,
 		.dma_rx_buf_size = DEFAULT_RXDMA_BUFSIZE,
+		.dma_rx_poll_rate = DEFAULT_RXDMA_POLLRATE,
 		.dma_rx_timeout = DEFAULT_RXDMA_TIMEOUT,
 		.auto_sus_timeout = DEFAULT_AUTOSUSPEND_DELAY,
 	},
@@ -386,6 +388,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
 	pdata->dma_enabled = info->dma_enabled;
 	pdata->dma_rx_buf_size = info->dma_rx_buf_size;
+	pdata->dma_rx_poll_rate = info->dma_rx_poll_rate;
 	pdata->dma_rx_timeout = info->dma_rx_timeout;
 	pdata->auto_sus_timeout = info->auto_sus_timeout;
 
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 211cb0a..0d4423d 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -51,7 +51,6 @@
 
 #define OMAP_UART_DMA_CH_FREE	-1
 
-#define RX_TIMEOUT		(3 * HZ)
 #define OMAP_MAX_HSUART_PORTS	4
 
 #define MSR_SAVE_FLAGS		UART_MSR_ANY_DELTA
@@ -65,6 +64,7 @@ struct omap_uart_port_info {
 	unsigned int		errata;
 	unsigned int		dma_rx_buf_size;/* DMA Rx Buffer Size */
 	unsigned int		dma_rx_timeout;	/* DMA RX timeout */
+	unsigned int		dma_rx_poll_rate; /* DMA RX timeout */
 	unsigned int		auto_sus_timeout; /* Auto_suspend timeout */
 
 	void __iomem *wk_st;
@@ -97,6 +97,7 @@ struct uart_omap_dma {
 	/* timer to poll activity on rx dma */
 	struct timer_list	rx_timer;
 	unsigned int		rx_buf_size;
+	unsigned int		rx_poll_rate;
 	unsigned int		rx_timeout;
 };
 
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 7e13036..cd79733 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -48,7 +48,7 @@ static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 
 /* Forward declaration of functions */
 static void uart_tx_dma_callback(int lch, u16 ch_status, void *data);
-static void serial_omap_rx_timeout(unsigned long uart_no);
+static void serial_omap_rxdma_poll(unsigned long uart_no);
 static int serial_omap_start_rxdma(struct uart_omap_port *up);
 static void omap_uart_mdr1_errataset(struct uart_omap_port *up, u8 mdr1);
 
@@ -582,7 +582,7 @@ static int serial_omap_startup(struct uart_port *port)
 			(dma_addr_t *)&(up->uart_dma.tx_buf_dma_phys),
 			0);
 		init_timer(&(up->uart_dma.rx_timer));
-		up->uart_dma.rx_timer.function = serial_omap_rx_timeout;
+		up->uart_dma.rx_timer.function = serial_omap_rxdma_poll;
 		up->uart_dma.rx_timer.data = up->pdev->id;
 		/* Currently the buffer size is 4KB. Can increase it */
 		up->uart_dma.rx_buf = dma_alloc_coherent(NULL,
@@ -1199,7 +1199,7 @@ static int serial_omap_resume(struct device *dev)
 	return 0;
 }
 
-static void serial_omap_rx_timeout(unsigned long uart_no)
+static void serial_omap_rxdma_poll(unsigned long uart_no)
 {
 	struct uart_omap_port *up = ui[uart_no];
 	unsigned int curr_dma_pos, curr_transmitted_size;
@@ -1209,9 +1209,9 @@ static void serial_omap_rx_timeout(unsigned long uart_no)
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
@@ -1240,7 +1240,7 @@ static void serial_omap_rx_timeout(unsigned long uart_no)
 		}
 	} else  {
 		mod_timer(&up->uart_dma.rx_timer, jiffies +
-			usecs_to_jiffies(up->uart_dma.rx_timeout));
+			usecs_to_jiffies(up->uart_dma.rx_poll_rate));
 	}
 	up->port_activity = jiffies;
 }
@@ -1279,7 +1279,7 @@ static int serial_omap_start_rxdma(struct uart_omap_port *up)
 	/* FIXME: Cache maintenance needed here? */
 	omap_start_dma(up->uart_dma.rx_dma_channel);
 	mod_timer(&up->uart_dma.rx_timer, jiffies +
-				usecs_to_jiffies(up->uart_dma.rx_timeout));
+				usecs_to_jiffies(up->uart_dma.rx_poll_rate));
 	up->uart_dma.rx_dma_used = true;
 	return ret;
 }
@@ -1418,6 +1418,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 		up->use_dma = 1;
 		up->uart_dma.rx_buf_size = omap_up_info->dma_rx_buf_size;
 		up->uart_dma.rx_timeout = omap_up_info->dma_rx_timeout;
+		up->uart_dma.rx_poll_rate = omap_up_info->dma_rx_poll_rate;
 		spin_lock_init(&(up->uart_dma.tx_lock));
 		spin_lock_init(&(up->uart_dma.rx_lock));
 		up->uart_dma.tx_dma_channel = OMAP_UART_DMA_CH_FREE;
-- 
1.7.4.1
