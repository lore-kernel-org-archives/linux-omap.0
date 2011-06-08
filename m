From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH v3 11/12] OMAP2: Serial: Add has_async_wake flag.
Date: Wed, 8 Jun 2011 16:53:13 +0530
Message-ID: <1307532194-13039-12-git-send-email-govindraj.raja@ti.com>
References: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41861 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753398Ab1FHLXt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 8 Jun 2011 07:23:49 -0400
In-Reply-To: <1307532194-13039-1-git-send-email-govindraj.raja@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>

Prior to this patch the uart_clock was cut using prepare/resume calls since
these funcs are no more available with runtime changes use has_async_wake
flag to keep clock active during bootup otherwise uart port will disabled
during boot-up and cannot be enabled back. Also based on this flag we can
disable uart port during suspend and enable back during resume for omap_socs
that have not set has_async_wake.

Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c                  |    1 +
 arch/arm/plat-omap/include/plat/omap-serial.h |    3 +++
 drivers/tty/serial/omap-serial.c              |   14 ++++++++++++++
 3 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 4bc5914..0a95c95 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -266,6 +266,7 @@ static void omap_uart_idle_init(struct omap_uart_port_info *uart,
 			break;
 		}
 		uart->wk_mask = wk_mask;
+		uart->has_async_wake = true;
 	} else if (cpu_is_omap24xx()) {
 		u32 wk_mask = 0;
 		u32 wk_en = PM_WKEN1, wk_st = PM_WKST1;
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index b5117bd..69e6d4b 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -79,6 +79,7 @@ struct omap_uart_port_info {
 	void __iomem *wk_st;
 	void __iomem *wk_en;
 	u32 wk_mask;
+	bool			has_async_wake;
 };
 
 struct uart_omap_dma {
@@ -134,6 +135,8 @@ struct uart_omap_port {
 	unsigned int		errata;
 	void (*enable_wakeup)(struct platform_device *, bool);
 	bool (*chk_wakeup)(struct platform_device *);
+
+	bool			has_async_wake;
 };
 
 #endif /* __OMAP_SERIAL_H__ */
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index c3561dd..dbe76f3 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1181,6 +1181,13 @@ static int serial_omap_suspend(struct device *dev)
 		uart_suspend_port(&serial_omap_reg, &up->port);
 		console_trylock();
 		serial_omap_pm(&up->port, 3, 0);
+
+		/* OMAP2 dont have async wakeup from prcm.
+		 * For such socs clocks will be kept active from probe and
+		 * cut only in suspend path.
+		 */
+		if (!up->has_async_wake)
+			serial_omap_port_disable(up);
 	}
 	return 0;
 }
@@ -1192,6 +1199,9 @@ static int serial_omap_resume(struct device *dev)
 	if (up) {
 		uart_resume_port(&serial_omap_reg, &up->port);
 		console_unlock();
+
+		if (!up->has_async_wake)
+			serial_omap_port_enable(up);
 	}
 
 	return 0;
@@ -1415,6 +1425,7 @@ static int serial_omap_probe(struct platform_device *pdev)
 	up->errata = omap_up_info->errata;
 	up->enable_wakeup = omap_up_info->enable_wakeup;
 	up->chk_wakeup = omap_up_info->chk_wakeup;
+	up->has_async_wake = omap_up_info->has_async_wake;
 
 	if (omap_up_info->dma_enabled) {
 		up->uart_dma.uart_dma_tx = dma_tx->start;
@@ -1443,6 +1454,9 @@ static int serial_omap_probe(struct platform_device *pdev)
 		serial_omap_port_disable(up);
 	}
 
+	if (!up->has_async_wake)
+		serial_omap_port_enable(up);
+
 	ui[pdev->id] = up;
 	serial_omap_add_console_port(up);
 
-- 
1.7.0.4

