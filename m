From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v4 10/11] OMAP: Serial: Allow UART parameters to be configured
	from board file.
Date: Wed, 7 Sep 2011 18:23:32 +0530
Message-ID: <1315400013-4849-11-git-send-email-govindraj.raja@ti.com>
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
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Deepak K <deepak.k@ti.com>, Partha Basak <p-basak2@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Jon Hunter <jon-hunter@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following UART parameters are defined within the UART driver:

1). Whether the UART uses DMA (dma_enabled), by default set to 0
2). The size of dma buffer (set to 4096 bytes)
3). The time after which the dma should stop if no more data is received.
4). The auto suspend delay that will be passed for pm_runtime_autosuspend
    where uart will be disabled after timeout

Different UARTs may be used for different purpose such as the console,
for interfacing bluetooth chip, for interfacing to a modem chip, etc.
Therefore, it is necessary to be able to customize the above settings
for a given board on a per UART basis.

This change allows these parameters to be configured from the board file
and allows the parameters to be configured for each UART independently.

If a board does not define its own custom parameters for the UARTs, then
use the default parameters in the structure "omap_serial_default_info".
The default parameters are defined to be the same as the current settings
in the UART driver to avoid breaking the UART for any board. By default,
make all boards use the default UART parameters.

Signed-off-by: Deepak K <deepak.k@ti.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/board-4430sdp.c           |    8 ++--
 arch/arm/mach-omap2/board-n8x0.c              |    6 ++--
 arch/arm/mach-omap2/board-omap4panda.c        |    8 ++--
 arch/arm/mach-omap2/serial.c                  |   46 ++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/omap-serial.h |    7 +++-
 arch/arm/plat-omap/include/plat/serial.h      |    5 ++-
 drivers/tty/serial/omap-serial.c              |    8 ++---
 7 files changed, 65 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index c7cef44..41b43cb 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -743,11 +743,11 @@ static inline void board_serial_init(void)
 	bdata.pads_cnt	= 0;
 	bdata.id	= 0;
 	/* pass dummy data for UART1 */
-	omap_serial_init_port(&bdata);
+	omap_serial_init_port(&bdata, NULL);
 
-	omap_serial_init_port(&serial2_data);
-	omap_serial_init_port(&serial3_data);
-	omap_serial_init_port(&serial4_data);
+	omap_serial_init_port(&serial2_data, NULL);
+	omap_serial_init_port(&serial3_data, NULL);
+	omap_serial_init_port(&serial4_data, NULL);
 }
 #else
 #define board_mux	NULL
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index e11f0c5..3408726 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -656,15 +656,15 @@ static inline void board_serial_init(void)
 	bdata.pads_cnt = 0;
 
 	bdata.id = 0;
-	omap_serial_init_port(&bdata);
+	omap_serial_init_port(&bdata, NULL);
 
 	bdata.id = 1;
-	omap_serial_init_port(&bdata);
+	omap_serial_init_port(&bdata, NULL);
 
 	bdata.id = 2;
 	bdata.pads = serial2_pads;
 	bdata.pads_cnt = ARRAY_SIZE(serial2_pads);
-	omap_serial_init_port(&bdata);
+	omap_serial_init_port(&bdata, NULL);
 }
 
 #else
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 9aaa960..fdfac0c 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -425,11 +425,11 @@ static inline void board_serial_init(void)
 	bdata.pads_cnt  = 0;
 	bdata.id        = 0;
 	/* pass dummy data for UART1 */
-	omap_serial_init_port(&bdata);
+	omap_serial_init_port(&bdata, NULL);
 
-	omap_serial_init_port(&serial2_data);
-	omap_serial_init_port(&serial3_data);
-	omap_serial_init_port(&serial4_data);
+	omap_serial_init_port(&serial2_data, NULL);
+	omap_serial_init_port(&serial3_data, NULL);
+	omap_serial_init_port(&serial4_data, NULL);
 }
 #else
 #define board_mux	NULL
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 7117220..dd4d872 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -41,6 +41,19 @@
 
 #define MAX_UART_HWMOD_NAME_LEN		16
 
+#define DEFAULT_RXDMA_TIMEOUT		1	/* RX DMA polling rate (us) */
+#define DEFAULT_RXDMA_BUFSIZE		4096	/* RX DMA buffer size */
+#define DEFAULT_AUTOSUSPEND_DELAY	3000	/* Runtime autosuspend (msecs)*/
+
+static struct omap_uart_port_info omap_serial_default_info[] = {
+	{
+		.dma_enabled	= 0,
+		.dma_rx_buf_size = DEFAULT_RXDMA_BUFSIZE,
+		.dma_rx_timeout = DEFAULT_RXDMA_TIMEOUT,
+		.auto_sus_timeout = DEFAULT_AUTOSUSPEND_DELAY,
+	},
+};
+
 static int uart_idle_hwmod(struct omap_device *od)
 {
 	omap_hwmod_idle(od->hwmods[0]);
@@ -323,6 +336,7 @@ core_initcall(omap_serial_early_init);
 /**
  * omap_serial_init_port() - initialize single serial port
  * @bdata: port specific board data pointer
+ * @info: platform specific data pointer
  *
  * This function initialies serial driver for given port only.
  * Platforms can call this function instead of omap_serial_init()
@@ -331,7 +345,8 @@ core_initcall(omap_serial_early_init);
  * Don't mix calls to omap_serial_init_port() and omap_serial_init(),
  * use only one of the two.
  */
-void __init omap_serial_init_port(struct omap_board_data *bdata)
+void __init omap_serial_init_port(struct omap_board_data *bdata,
+			struct omap_uart_port_info *info)
 {
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
@@ -349,6 +364,9 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	if (!oh)
 		return;
 
+	if (info == NULL)
+		info = omap_serial_default_info;
+
 	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
 	if (!pdata) {
 		pr_err("Memory allocation for UART pdata failed\n");
@@ -366,6 +384,10 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	pdata->enable_wakeup = omap_uart_wakeup_enable;
 	pdata->chk_wakeup = omap_uart_chk_wakeup;
 	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
+	pdata->dma_enabled = info->dma_enabled;
+	pdata->dma_rx_buf_size = info->dma_rx_buf_size;
+	pdata->dma_rx_timeout = info->dma_rx_timeout;
+	pdata->auto_sus_timeout = info->auto_sus_timeout;
 
 	pdev = omap_device_build(name, bdata->id, oh, pdata,
 				sizeof(*pdata),	omap_uart_latency,
@@ -382,13 +404,14 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 }
 
 /**
- * omap_serial_init() - initialize all supported serial ports
+ * omap_serial_board_init() - initialize all supported serial ports
+ * @info: platform specific data pointer
  *
  * Initializes all available UARTs as serial ports. Platforms
  * can call this function when they want to have default behaviour
  * for serial ports (e.g initialize them all as serial ports).
  */
-void __init omap_serial_init(void)
+void __init omap_serial_board_init(struct omap_uart_port_info *info)
 {
 	struct omap_board_data bdata;
 	u8 i;
@@ -402,6 +425,21 @@ void __init omap_serial_init(void)
 		if (cpu_is_omap44xx() || cpu_is_omap34xx())
 			omap_serial_fill_default_pads(&bdata);
 
-		omap_serial_init_port(&bdata);
+		if (info == NULL)
+			omap_serial_init_port(&bdata, NULL);
+		else
+			omap_serial_init_port(&bdata, &info[i]);
 	}
 }
+
+/**
+ * omap_serial_init() - initialize all supported serial ports
+ *
+ * Initializes all available UARTs.
+ * Platforms can call this function when they want to have default behaviour
+ * for serial ports (e.g initialize them all as serial ports).
+ */
+void __init omap_serial_init(void)
+{
+	omap_serial_board_init(NULL);
+}
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 7fc63b8..211cb0a 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -63,6 +63,9 @@ struct omap_uart_port_info {
 	unsigned int		uartclk;	/* UART clock rate */
 	upf_t			flags;		/* UPF_* flags */
 	unsigned int		errata;
+	unsigned int		dma_rx_buf_size;/* DMA Rx Buffer Size */
+	unsigned int		dma_rx_timeout;	/* DMA RX timeout */
+	unsigned int		auto_sus_timeout; /* Auto_suspend timeout */
 
 	void __iomem *wk_st;
 	void __iomem *wk_en;
@@ -93,8 +96,8 @@ struct uart_omap_dma {
 	spinlock_t		rx_lock;
 	/* timer to poll activity on rx dma */
 	struct timer_list	rx_timer;
-	int			rx_buf_size;
-	int			rx_timeout;
+	unsigned int		rx_buf_size;
+	unsigned int		rx_timeout;
 };
 
 struct uart_omap_port {
diff --git a/arch/arm/plat-omap/include/plat/serial.h b/arch/arm/plat-omap/include/plat/serial.h
index 5b8c8f2..9c3e9e3 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -106,11 +106,14 @@
 #ifndef __ASSEMBLER__
 
 struct omap_board_data;
+struct omap_uart_port_info;
 
 extern void omap_serial_init(void);
-extern void omap_serial_init_port(struct omap_board_data *bdata);
 extern void omap_uart_prepare_idle(void);
 extern int omap_uart_resume_idle(void);
+extern void omap_serial_board_init(struct omap_uart_port_info *platform_data);
+extern void omap_serial_init_port(struct omap_board_data *bdata,
+		struct omap_uart_port_info *platform_data);
 #endif
 
 #endif
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 05c2f52..7e13036 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -44,8 +44,6 @@
 #include <plat/omap-serial.h>
 #include <plat/omap_device.h>
 
-#define OMAP_UART_AUTOSUSPEND_DELAY 3000	/* Value is msecs */
-
 static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 
 /* Forward declaration of functions */
@@ -1418,8 +1416,8 @@ static int serial_omap_probe(struct platform_device *pdev)
 		up->uart_dma.uart_dma_tx = dma_tx->start;
 		up->uart_dma.uart_dma_rx = dma_rx->start;
 		up->use_dma = 1;
-		up->uart_dma.rx_buf_size = 4096;
-		up->uart_dma.rx_timeout = 2;
+		up->uart_dma.rx_buf_size = omap_up_info->dma_rx_buf_size;
+		up->uart_dma.rx_timeout = omap_up_info->dma_rx_timeout;
 		spin_lock_init(&(up->uart_dma.tx_lock));
 		spin_lock_init(&(up->uart_dma.rx_lock));
 		up->uart_dma.tx_dma_channel = OMAP_UART_DMA_CH_FREE;
@@ -1428,7 +1426,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev,
-			OMAP_UART_AUTOSUSPEND_DELAY);
+			omap_up_info->auto_sus_timeout);
 
 	pm_runtime_irq_safe(&pdev->dev);
 	if (device_may_wakeup(&pdev->dev)) {
-- 
1.7.4.1
