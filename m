From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v5 14/15] OMAP2+: UART: Enable back uart clocks with runtime API for early console
Date: Wed, 21 Sep 2011 17:43:51 +0530
Message-ID: <1316607232-21709-5-git-send-email-govindraj.raja@ti.com>
References: <1316607232-21709-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1316607232-21709-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Govindraj R <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

For the early console probing we had avoided hwmod reset and idling
and uart was idled using hwmod API and enabled back using omap_device API
after omap_device registration.

Now since we are using runtime API's to enable back uart move hwmod idling and
use runtime API to enable back UART.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c                  |   26 ++++++++----------------
 arch/arm/plat-omap/include/plat/omap-serial.h |    1 +
 drivers/tty/serial/omap-serial.c              |    1 +
 3 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 57d063a..87696bf 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -24,13 +24,11 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
-#include <linux/console.h>
 
 #include <plat/omap-serial.h>
 #include <plat/common.h>
 #include <plat/board.h>
 #include <plat/dma.h>
-#include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 #include <plat/omap-pm.h>
 
@@ -244,10 +242,16 @@ static void omap_uart_set_forceidle(struct platform_device *pdev)
 	omap_hwmod_set_slave_idlemode(od->hwmods[0], HWMOD_IDLEMODE_FORCE);
 }
 
+static void omap_uart_hwmod_idle(struct platform_device *pdev)
+{
+	struct omap_device *od = to_omap_device(pdev);
+
+	omap_hwmod_idle(od->hwmods[0]);
+}
+
 #else
 static void omap_uart_set_forceidle(struct platform_device *pdev) {}
-static void omap_uart_enable_wakeup(struct platform_device *pdev, bool enable)
-{}
+static void omap_uart_hwmod_idle(struct platform_device *pdev) {}
 #endif /* CONFIG_PM */
 
 struct omap_hwmod *omap_uart_hwmod_lookup(int num)
@@ -338,6 +342,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 	pdata->enable_wakeup = omap_uart_enable_wakeup;
 	pdata->get_context_loss_count = omap_pm_get_dev_context_loss_count;
 	pdata->set_force_idle = omap_uart_set_forceidle;
+	pdata->hwmod_idle = omap_uart_hwmod_idle;
 	pdata->dma_enabled = info->dma_enabled;
 	pdata->dma_rx_buf_size = info->dma_rx_buf_size;
 	pdata->dma_rx_poll_rate = info->dma_rx_poll_rate;
@@ -356,19 +361,6 @@ void __init omap_serial_init_port(struct omap_board_data *bdata,
 
 	oh->mux = omap_hwmod_mux_init(bdata->pads, bdata->pads_cnt);
 
-	console_lock(); /* in case the earlycon is on the UART */
-
-	/*
-	 * Because of early UART probing, UART did not get idled
-	 * on init.  Now that omap_device is ready, ensure full idle
-	 * before doing omap_device_enable().
-	 */
-	omap_hwmod_idle(oh);
-
-	omap_device_enable(pdev);
-
-	console_unlock();
-
 	if ((cpu_is_omap34xx() && bdata->pads))
 		device_init_wakeup(&pdev->dev, true);
 
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index de8de87..800f215 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -71,6 +71,7 @@ struct omap_uart_port_info {
 	void (*enable_wakeup)(struct platform_device *, bool);
 	u32 (*get_context_loss_count)(struct device *);
 	void (*set_force_idle)(struct platform_device *);
+	void (*hwmod_idle)(struct platform_device *);
 };
 
 struct uart_omap_dma {
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 92a1f10..8125a89 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1394,6 +1394,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 	pm_runtime_irq_safe(&pdev->dev);
 	if (device_may_wakeup(&pdev->dev)) {
 		pm_runtime_enable(&pdev->dev);
+		omap_up_info->hwmod_idle(pdev);
 		pm_runtime_get_sync(&pdev->dev);
 	}
 
-- 
1.7.4.1

