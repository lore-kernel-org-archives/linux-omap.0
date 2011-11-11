From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v8 10/20] OMAP2+: UART: Get context loss count to context restore
Date: Fri, 11 Nov 2011 15:29:08 +0530
Message-ID: <1321005551-21786-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>
List-Id: linux-omap@vger.kernel.org

Avoid unconditional context restore every time we gate uart
clocks. Check whether context loss happened based on which
we can context restore uart regs from uart_port structure.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c                  |    2 ++
 arch/arm/plat-omap/include/plat/omap-serial.h |    3 +++
 drivers/tty/serial/omap-serial.c              |   20 ++++++++++++++++++--
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 06887d3..98e2666 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -33,6 +33,7 @@
 #include <plat/dma.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
+#include <plat/omap-pm.h>
 
 #include "prm2xxx_3xxx.h"
 #include "pm.h"
@@ -478,6 +479,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 	omap_up.dma_enabled = uart->dma_enabled;
 	omap_up.uartclk = OMAP24XX_BASE_BAUD * 16;
 	omap_up.flags = UPF_BOOT_AUTOCONF;
+	omap_up.get_context_loss_count = omap_pm_get_dev_context_loss_count;
 
 	pdata = &omap_up;
 	pdata_size = sizeof(struct omap_uart_port_info);
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 5b913c7..348c9ea 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -62,6 +62,8 @@ struct omap_uart_port_info {
 	bool			dma_enabled;	/* To specify DMA Mode */
 	unsigned int		uartclk;	/* UART clock rate */
 	upf_t			flags;		/* UPF_* flags */
+
+	int (*get_context_loss_count)(struct device *);
 };
 
 struct uart_omap_dma {
@@ -114,6 +116,7 @@ struct uart_omap_port {
 	unsigned char		msr_saved_flags;
 	char			name[20];
 	unsigned long		port_activity;
+	u32			context_loss_cnt;
 };
 
 #endif /* __OMAP_SERIAL_H__ */
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index f5a5ed6..ea4c24a 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1440,15 +1440,31 @@ static void serial_omap_restore_context(struct uart_omap_port *up)
 #ifdef CONFIG_PM_RUNTIME
 static int serial_omap_runtime_suspend(struct device *dev)
 {
+	struct uart_omap_port *up = dev_get_drvdata(dev);
+	struct omap_uart_port_info *pdata = dev->platform_data;
+
+	if (!up)
+		return -EINVAL;
+
+	if (pdata->get_context_loss_count)
+		up->context_loss_cnt = pdata->get_context_loss_count(dev);
+
 	return 0;
 }
 
 static int serial_omap_runtime_resume(struct device *dev)
 {
 	struct uart_omap_port *up = dev_get_drvdata(dev);
+	struct omap_uart_port_info *pdata = dev->platform_data;
 
-	if (up)
-		serial_omap_restore_context(up);
+	if (up) {
+		if (pdata->get_context_loss_count) {
+			u32 loss_cnt = pdata->get_context_loss_count(dev);
+
+			if (up->context_loss_cnt != loss_cnt)
+				serial_omap_restore_context(up);
+		}
+	}
 
 	return 0;
 }
-- 
1.7.4.1

