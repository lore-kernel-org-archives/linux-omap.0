From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 15/16] ARM: OMAP: Move plat/omap-serial.h to
 linux/platform_data/serial-omap.h
Date: Thu, 04 Oct 2012 15:05:08 -0700
Message-ID: <20121004220508.26676.98612.stgit@muffinssi.local>
References: <20121004213950.26676.21898.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20121004213950.26676.21898.stgit@muffinssi.local>
Sender: linux-serial-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

We cannot keep this in plat for ARM common zImage work.
Some of the defines are local to the omap-serial.c driver,
so move the defines there.

Also rename DRIVER_NAME to OMAP_SERIAL_DRIVER_NAME to avoid
confusion.

Note that patch depends on at least omap patch
"ARM: OMAP: Split plat/serial.h for omap1 and omap2+".

Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Govindraj.R <govindraj.raja@ti.com>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/serial.c                  |    5 ++-
 drivers/tty/serial/omap-serial.c              |   35 ++++++++++++++++++++--
 include/linux/platform_data/serial-omap.h     |   40 +------------------------
 3 files changed, 36 insertions(+), 44 deletions(-)
 rename arch/arm/plat-omap/include/plat/omap-serial.h => include/linux/platform_data/serial-omap.h (67%)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 777d504..60374a4 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -26,8 +26,9 @@
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 #include <linux/console.h>
+#include <linux/serial_core.h>
+#include <linux/platform_data/serial-omap.h>
 
-#include <plat/omap-serial.h>
 #include "common.h"
 #include <plat/dma.h>
 #include "omap_hwmod.h"
@@ -293,7 +294,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 		info = omap_serial_default_info;
 
 	oh = uart->oh;
-	name = DRIVER_NAME;
+	name = OMAP_SERIAL_DRIVER_NAME;
 
 	omap_up.dma_enabled = info->dma_enabled;
 	omap_up.uartclk = OMAP24XX_BASE_BAUD * 16;
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6ede6fd..cc431a2 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -38,11 +38,11 @@
 #include <linux/serial_core.h>
 #include <linux/irq.h>
 #include <linux/pm_runtime.h>
+#include <linux/pm_qos.h>
 #include <linux/of.h>
 #include <linux/gpio.h>
 #include <linux/pinctrl/consumer.h>
-
-#include <plat/omap-serial.h>
+#include <linux/platform_data/serial-omap.h>
 
 #define UART_BUILD_REVISION(x, y)	(((x) << 8) | (y))
 
@@ -71,6 +71,35 @@
 #define OMAP_UART_MVR_MAJ_SHIFT		8
 #define OMAP_UART_MVR_MIN_MASK		0x3f
 
+#define OMAP_MODE13X_SPEED	230400
+
+#define OMAP_UART_SCR_TX_EMPTY	0x08
+
+/* WER = 0x7F
+ * Enable module level wakeup in WER reg
+ */
+#define OMAP_UART_WER_MOD_WKUP	0X7F
+
+/* Enable XON/XOFF flow control on output */
+#define OMAP_UART_SW_TX		0x8
+
+/* Enable XON/XOFF flow control on input */
+#define OMAP_UART_SW_RX		0x2
+
+#define OMAP_UART_SYSC_RESET	0X07
+#define OMAP_UART_TCR_TRIG	0X0F
+#define OMAP_UART_SW_CLR	0XF0
+#define OMAP_UART_FIFO_CLR	0X06
+
+#define OMAP_UART_DMA_CH_FREE	-1
+
+#define OMAP_MAX_HSUART_PORTS	6
+
+#define MSR_SAVE_FLAGS		UART_MSR_ANY_DELTA
+
+#define UART_ERRATA_i202_MDR1_ACCESS	BIT(0)
+#define UART_ERRATA_i291_DMA_FORCEIDLE	BIT(1)
+
 struct uart_omap_port {
 	struct uart_port	port;
 	struct uart_omap_dma	uart_dma;
@@ -1588,7 +1617,7 @@ static struct platform_driver serial_omap_driver = {
 	.probe          = serial_omap_probe,
 	.remove         = __devexit_p(serial_omap_remove),
 	.driver		= {
-		.name	= DRIVER_NAME,
+		.name	= OMAP_SERIAL_DRIVER_NAME,
 		.pm	= &serial_omap_dev_pm_ops,
 		.of_match_table = of_match_ptr(omap_serial_of_match),
 	},
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/include/linux/platform_data/serial-omap.h
similarity index 67%
rename from arch/arm/plat-omap/include/plat/omap-serial.h
rename to include/linux/platform_data/serial-omap.h
index f4a4cd0..512aae9 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/include/linux/platform_data/serial-omap.h
@@ -14,14 +14,7 @@
  * (at your option) any later version.
  */
 
-#ifndef __OMAP_SERIAL_H__
-#define __OMAP_SERIAL_H__
-
-#include <linux/serial_core.h>
-#include <linux/device.h>
-#include <linux/pm_qos.h>
-
-#define DRIVER_NAME	"omap_uart"
+#define OMAP_SERIAL_DRIVER_NAME	"omap_uart"
 
 /*
  * Use tty device name as ttyO, [O -> OMAP]
@@ -30,35 +23,6 @@
  */
 #define OMAP_SERIAL_NAME	"ttyO"
 
-#define OMAP_MODE13X_SPEED	230400
-
-#define OMAP_UART_SCR_TX_EMPTY	0x08
-
-/* WER = 0x7F
- * Enable module level wakeup in WER reg
- */
-#define OMAP_UART_WER_MOD_WKUP	0X7F
-
-/* Enable XON/XOFF flow control on output */
-#define OMAP_UART_SW_TX		0x8
-
-/* Enable XON/XOFF flow control on input */
-#define OMAP_UART_SW_RX		0x2
-
-#define OMAP_UART_SYSC_RESET	0X07
-#define OMAP_UART_TCR_TRIG	0X0F
-#define OMAP_UART_SW_CLR	0XF0
-#define OMAP_UART_FIFO_CLR	0X06
-
-#define OMAP_UART_DMA_CH_FREE	-1
-
-#define OMAP_MAX_HSUART_PORTS	6
-
-#define MSR_SAVE_FLAGS		UART_MSR_ANY_DELTA
-
-#define UART_ERRATA_i202_MDR1_ACCESS	BIT(0)
-#define UART_ERRATA_i291_DMA_FORCEIDLE	BIT(1)
-
 struct omap_uart_port_info {
 	bool			dma_enabled;	/* To specify DMA Mode */
 	unsigned int		uartclk;	/* UART clock rate */
@@ -102,5 +66,3 @@ struct uart_omap_dma {
 	unsigned int		rx_poll_rate;
 	unsigned int		rx_timeout;
 };
-
-#endif /* __OMAP_SERIAL_H__ */

