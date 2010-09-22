From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 05/13 v2] OMAP: UART: don't do automatic bus-level
	suspend/resume
Date: Wed, 22 Sep 2010 20:43:51 +0530 (IST)
Message-ID: <37596.172.24.137.131.1285168431.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Kevin Hilman <khilman@deeprootsystems.com>

Since the omap_device for UART is currently managed inside the idle
path itself,  don't let the bus-level code suspend/resume the UART.

To prevent this, pm_runtime_get() is used when preparing for suspend
and pm_runtime_put() is used when finished with suspend.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 6ffbc92..ff83e91 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/serial_8250.h>
+#include <linux/pm_runtime.h>

 #ifdef CONFIG_SERIAL_OMAP
 #include <plat/omap-serial.h>
@@ -530,14 +531,17 @@ void omap_uart_enable_irqs(int enable)
 	struct omap_uart_state *uart;

 	list_for_each_entry(uart, &uart_list, node) {
-		if (enable)
+		if (enable) {
+			pm_runtime_put_sync(&uart->pdev->dev);
 			ret = request_threaded_irq(uart->irq, NULL,
 						   omap_uart_interrupt,
 						   IRQF_SHARED,
 						   "serial idle",
 						   (void *)uart);
-		else
+		} else {
+			pm_runtime_get_noresume(&uart->pdev->dev);
 			free_irq(uart->irq, (void *)uart);
+		}
 	}
 }

-- 
1.6.3.3
