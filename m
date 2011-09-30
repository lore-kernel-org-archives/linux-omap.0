From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v6 12/16] OMAP2+: UART: Allow UART parameters to be configured from board file.
Date: Fri, 30 Sep 2011 16:32:37 +0530
Message-ID: <1317380561-661-3-git-send-email-govindraj.raja@ti.com>
References: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46262 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758312Ab1I3LC7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 30 Sep 2011 07:02:59 -0400
In-Reply-To: <1317380561-661-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>, Deepak K <deepak.k@ti.com>, Jon Hunter <jon-hunter@ti.com>

From: Deepak K <deepak.k@ti.com>

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
in the UART driver to avoid breaking the UART for any cuurnelty supported
boards. By default, make all boards use the default UART parameters.

Signed-off-by: Deepak K <deepak.k@ti.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
This patch is derived and reworked from a custom 2.6.35 kernel
Available here:
http://git.omapzoom.org/?p=kernel/omap.git;
a=commitdiff;h=584ef316542f77312be7ba96a0f3013c8f64852b;
hp=7233a76cb362c0fc603f773274159adff91d3513

 arch/arm/mach-omap2/board-n8x0.c              |    6 +-
 arch/arm/mach-omap2/serial.c                  |   56 ++++++++++++++++++++----
 arch/arm/plat-omap/include/plat/omap-serial.h |    7 ++-
 arch/arm/plat-omap/include/plat/serial.h      |    5 ++-
 drivers/tty/serial/omap-serial.c              |    8 +--
 5 files changed, 61 insertions(+), 21 deletions(-)

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
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 0731575..78f7051 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -43,17 +43,29 @@
 #include "mux.h"
 
 /*
- * NOTE: By default the serial timeout is disabled as it causes lost characters
- * over the serial ports. This means that the UART clocks will stay on until
- * disabled via sysfs. This also causes that any deeper omap sleep states are
- * blocked. 
+ * NOTE: By default the serial auto_suspend timeout is disabled as it causes
+ * lost characters over the serial ports. This means that the UART clocks will
+ * stay on until power/autosuspend_delay is set for the uart from sysfs.
+ * This also causes that any deeper omap sleep states are blocked.
  */
-#define DEFAULT_TIMEOUT 0
+#define DEFAULT_AUTOSUSPEND_DELAY	-1
 
 #define MAX_UART_HWMOD_NAME_LEN		16
 
 static u8 num_uarts;
 
+#define DEFAULT_RXDMA_TIMEOUT		1	/* RX DMA polling rate (us) */
+#define DEFAULT_RXDMA_BUFSIZE		4096	/* RX DMA buffer size */
+
+static struct omap_uart_port_info omap_serial_default_info[] = {
+	{
+		.dma_enabled	= 0,
+		.dma_rx_buf_size = DEFAULT_RXDMA_BUFSIZE,
+		.dma_rx_timeout = DEFAULT_RXDMA_TIMEOUT,
+		.autosuspend_timeout = DEFAULT_AUTOSUSPEND_DELAY,
+	},
+};
+
 static int uart_idle_hwmod(struct omap_device *od)
 {
 	omap_hwmod_idle(od->hwmods[0]);
@@ -298,6 +310,7 @@ core_initcall(omap_serial_early_init);
 /**
  * omap_serial_init_port() - initialize single serial port
  * @bdata: port specific board data pointer
+ * @info: platform specific data pointer
  *
  * This function initialies serial driver for given port only.
  * Platforms can call this function instead of omap_serial_init()
@@ -306,7 +319,8 @@ core_initcall(omap_serial_early_init);
  * Don't mix calls to omap_serial_init_port() and omap_serial_init(),
  * use only one of the two.
  */
-void __init omap_serial_init_port(struct omap_board_data *bdata)
+void __init omap_serial_init_port(struct omap_board_data *bdata,
+			struct omap_uart_port_info *info)
 {
 	struct omap_hwmod *oh;
 	struct platform_device *pdev;
@@ -325,6 +339,9 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	if (!oh)
 		return;
 
+	if (info == NULL)
+		info = omap_serial_default_info;
+
 	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
 	if (!pdata) {
 		pr_err("Memory allocation for UART pdata failed\n");
@@ -338,6 +355,10 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	pdata->enable_wakeup = omap_uart_enable_wakeup;
 	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
 	pdata->set_force_idle = omap_uart_set_forceidle;
+	pdata->dma_enabled = info->dma_enabled;
+	pdata->dma_rx_buf_size = info->dma_rx_buf_size;
+	pdata->dma_rx_timeout = info->dma_rx_timeout;
+	pdata->autosuspend_timeout = info->autosuspend_timeout;
 
 	/* Enable the MDR1 errata for OMAP3 */
 	if (cpu_is_omap34xx() && !cpu_is_ti816x())
@@ -371,13 +392,14 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
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
@@ -391,7 +413,21 @@ void __init omap_serial_init(void)
 		if (cpu_is_omap44xx() || cpu_is_omap34xx())
 			omap_serial_fill_default_pads(&bdata);
 
-		omap_serial_init_port(&bdata);
-
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
index 12f5262..a40a41a 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -64,6 +64,9 @@ struct omap_uart_port_info {
 	upf_t			flags;		/* UPF_* flags */
 
 	u32			errata;
+	unsigned int		dma_rx_buf_size;
+	unsigned int		dma_rx_timeout;
+	unsigned int		autosuspend_timeout;
 
 	void (*enable_wakeup)(struct platform_device *, bool);
 	u32 (*get_context_loss_count)(struct device *);
@@ -91,8 +94,8 @@ struct uart_omap_dma {
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
index a8bc1f1..d71e2c7 100644
--- a/arch/arm/plat-omap/include/plat/serial.h
+++ b/arch/arm/plat-omap/include/plat/serial.h
@@ -106,10 +106,13 @@
 #ifndef __ASSEMBLER__
 
 struct omap_board_data;
+struct omap_uart_port_info;
 
 extern void omap_serial_init(void);
-extern void omap_serial_init_port(struct omap_board_data *bdata);
 extern int omap_uart_can_sleep(void);
+extern void omap_serial_board_init(struct omap_uart_port_info *platform_data);
+extern void omap_serial_init_port(struct omap_board_data *bdata,
+		struct omap_uart_port_info *platform_data);
 #endif
 
 #endif
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 817443e..15e0655 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -43,8 +43,6 @@
 #include <plat/dmtimer.h>
 #include <plat/omap-serial.h>
 
-#define OMAP_UART_AUTOSUSPEND_DELAY -1
-
 static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
 
 /* Forward declaration of functions */
@@ -1364,8 +1362,8 @@ static int serial_omap_probe(struct platform_device *pdev)
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
@@ -1374,7 +1372,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 
 	pm_runtime_use_autosuspend(&pdev->dev);
 	pm_runtime_set_autosuspend_delay(&pdev->dev,
-			OMAP_UART_AUTOSUSPEND_DELAY);
+			omap_up_info->autosuspend_timeout);
 
 	pm_runtime_irq_safe(&pdev->dev);
 	if (device_may_wakeup(&pdev->dev)) {
-- 
1.7.4.1

