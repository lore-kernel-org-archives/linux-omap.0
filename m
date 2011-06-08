From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v3 07/12] OMAP: Serial: Allow UART parameters to be configured from board file.
Date: Wed, 8 Jun 2011 16:53:09 +0530
Message-ID: <1307532194-13039-8-git-send-email-govindraj.raja@ti.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40249 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753440Ab1FHLXv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Jun 2011 07:23:51 -0400
In-Reply-To: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Deepak K <deepak.k@ti.com>, Jon Hunter <jon-hunter@ti.com>

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
 arch/arm/mach-omap2/board-3430sdp.c           |    6 ++--
 arch/arm/mach-omap2/board-4430sdp.c           |    8 ++--
 arch/arm/mach-omap2/board-n8x0.c              |    6 ++--
 arch/arm/mach-omap2/board-omap4panda.c        |    8 ++--
 arch/arm/mach-omap2/serial.c                  |   42 +++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/omap-serial.h |   14 ++++++--
 arch/arm/plat-omap/include/plat/serial.h      |    5 ++-
 drivers/tty/serial/omap-serial.c              |    8 ++---
 8 files changed, 71 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index ae2963a..2b44c86 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -642,9 +642,9 @@ static struct omap_board_data serial3_data = {
 
 static inline void board_serial_init(void)
 {
-	omap_serial_init_port(&serial1_data);
-	omap_serial_init_port(&serial2_data);
-	omap_serial_init_port(&serial3_data);
+	omap_serial_init_port(&serial1_data, NULL);
+	omap_serial_init_port(&serial2_data, NULL);
+	omap_serial_init_port(&serial3_data, NULL);
 }
 #else
 #define board_mux	NULL
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 73fa90b..946a558 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -707,11 +707,11 @@ static inline void board_serial_init(void)
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
index 8d74318..5ab626a 100644
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
index 90485fc..c402d03 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -552,11 +552,11 @@ static inline void board_serial_init(void)
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
index 1651c2c..f38296e 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -44,6 +44,15 @@
 
 static int omap_uart_con_id __initdata = -1;
 
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
@@ -313,6 +322,7 @@ core_initcall(omap_serial_early_init);
 /**
  * omap_serial_init_port() - initialize single serial port
  * @bdata: port specific board data pointer
+ * @info: platform specific data pointer
  *
  * This function initialies serial driver for given port only.
  * Platforms can call this function instead of omap_serial_init()
@@ -321,7 +331,8 @@ core_initcall(omap_serial_early_init);
  * Don't mix calls to omap_serial_init_port() and omap_serial_init(),
  * use only one of the two.
  */
-void __init omap_serial_init_port(struct omap_board_data *bdata)
+void __init omap_serial_init_port(struct omap_board_data *bdata,
+			struct omap_uart_port_info *info)
 {
 	struct omap_hwmod *oh;
 	struct omap_device *od;
@@ -339,6 +350,9 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	if (!oh)
 		return;
 
+	if (info == NULL)
+		info = omap_serial_default_info;
+
 	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
 	if (!pdata) {
 		pr_err("Memory allocation for UART pdata failed\n");
@@ -354,6 +368,10 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	pdata->uartclk = OMAP24XX_BASE_BAUD * 16;
 	pdata->flags = UPF_BOOT_AUTOCONF;
 	pdata->enable_wakeup = omap_uart_wakeup_enable;
+	pdata->dma_enabled = info->dma_enabled;
+	pdata->dma_rx_buf_size = info->dma_rx_buf_size;
+	pdata->dma_rx_timeout = info->dma_rx_timeout;
+	pdata->auto_sus_timeout = info->auto_sus_timeout;
 	if (bdata->id == omap_uart_con_id)
 		pdata->console_uart = true;
 
@@ -371,17 +389,21 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
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
 
+	if (info == NULL)
+		info = omap_serial_default_info;
+
 	for (i = 0; i < OMAP_MAX_HSUART_PORTS; i++) {
 		bdata.id = i;
 		bdata.flags = 0;
@@ -390,5 +412,19 @@ void __init omap_serial_init(void)
 
 		if (cpu_is_omap44xx() || cpu_is_omap34xx())
 			omap_serial_fill_default_pads(&bdata);
+
+		omap_serial_init_port(&bdata, info);
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
index ac30de8..4e2dcdc 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -51,7 +51,12 @@
 
 #define OMAP_UART_DMA_CH_FREE	-1
 
-#define RX_TIMEOUT		(3 * HZ)
+#define RX_TIMEOUT		(3 * HZ)	/* RX DMA timeout (jiffies) */
+#define DEFAULT_RXDMA_TIMEOUT	1		/* RX DMA polling rate (us) */
+#define DEFAULT_RXDMA_BUFSIZE	4096		/* RX DMA buffer size */
+#define DEFAULT_AUTOSUSPEND_DELAY (30 * HZ) /* Runtime autosuspend (msecs) */
+
+
 #define OMAP_MAX_HSUART_PORTS	4
 
 #define MSR_SAVE_FLAGS		UART_MSR_ANY_DELTA
@@ -64,6 +69,9 @@ struct omap_uart_port_info {
 	upf_t			flags;		/* UPF_* flags */
 	unsigned int		errata;
 	unsigned int		console_uart;
+	unsigned int		dma_rx_buf_size;/* DMA Rx Buffer Size */
+	unsigned int		dma_rx_timeout;	/* DMA RX timeout */
+	unsigned int		auto_sus_timeout; /* Auto_suspend timeout */
 
 	void (*enable_wakeup)(struct platform_device *, bool);
 	void __iomem *wk_st;
@@ -92,8 +100,8 @@ struct uart_omap_dma {
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
index ab1761a..ee758d4 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -103,9 +103,12 @@
 #ifndef __ASSEMBLER__
 
 struct omap_board_data;
+struct omap_uart_port_info;
 
 extern void omap_serial_init(void);
-extern void omap_serial_init_port(struct omap_board_data *bdata);
+extern void omap_serial_board_init(struct omap_uart_port_info *platform_data);
+extern void omap_serial_init_port(struct omap_board_data *bdata,
+		struct omap_uart_port_info *platform_data);
 #endif
 
 #endif
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 2ad8fa0..dc2743a 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -44,8 +44,6 @@
 #include <plat/omap-serial.h>
 #include <plat/omap_device.h>
 
-#define OMAP_UART_AUTOSUSPEND_DELAY (30 * HZ) /* Value is msecs */
-
 static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 
 /* Forward declaration of functions */
@@ -1399,8 +1397,8 @@ static int serial_omap_probe(struct platform_device *pdev)
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
@@ -1409,7 +1407,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev,
-			OMAP_UART_AUTOSUSPEND_DELAY);
+			omap_up_info->auto_sus_timeout);
 
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_irq_safe(&pdev->dev);
-- 
1.7.0.4

