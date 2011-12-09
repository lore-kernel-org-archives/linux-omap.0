From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv10 12/14] TEMP: OMAP3: serial: made serial to work properly with PRCM chain handler
Date: Fri, 9 Dec 2011 16:27:35 +0200
Message-ID: <1323440857-385-13-git-send-email-t-kristo@ti.com>
References: <1323440857-385-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59536 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754138Ab1LIO2Y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 09:28:24 -0500
In-Reply-To: <1323440857-385-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com
Cc: "Govindraj.R" <govindraj.raja@ti.com>

This patch is just a temporary hack to allow serial to work properly with
the PRCM chain handler. Should be replaced with a proper implementation
by serial runtime PM support.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c     |   29 +++++++++--------------------
 drivers/tty/serial/omap-serial.c |    2 ++
 2 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index b479b3f..13008f5 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -39,6 +39,7 @@
 #include <plat/dma.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
+#include <plat/prcm.h>
 
 #include "prm2xxx_3xxx.h"
 #include "pm.h"
@@ -358,6 +359,7 @@ static void omap_uart_allow_sleep(struct omap_uart_state *uart)
 	omap_uart_smart_idle_enable(uart, 1);
 	uart->can_sleep = 1;
 	del_timer(&uart->timer);
+	omap_uart_disable_clocks(uart);
 }
 
 static void omap_uart_idle_timer(unsigned long data)
@@ -369,36 +371,23 @@ static void omap_uart_idle_timer(unsigned long data)
 
 void omap_uart_prepare_idle(int num)
 {
-	struct omap_uart_state *uart;
-
-	list_for_each_entry(uart, &uart_list, node) {
-		if (num == uart->num && uart->can_sleep) {
-			omap_uart_disable_clocks(uart);
-			return;
-		}
-	}
 }
 
 void omap_uart_resume_idle(int num)
 {
 	struct omap_uart_state *uart;
+	u32 wkst;
 
 	list_for_each_entry(uart, &uart_list, node) {
 		if (num == uart->num && uart->can_sleep) {
-			omap_uart_enable_clocks(uart);
+			omap_uart_block_sleep(uart);
 
-			/* Check for IO pad wakeup */
-			if (cpu_is_omap34xx() && uart->padconf) {
-				u16 p = omap_ctrl_readw(uart->padconf);
-
-				if (p & OMAP3_PADCONF_WAKEUPEVENT0)
-					omap_uart_block_sleep(uart);
+			/* Check for normal UART wakeup (and clear it) */
+			if (uart->wk_st && uart->wk_mask) {
+				wkst = __raw_readl(uart->wk_st) & uart->wk_mask;
+				if (wkst)
+					__raw_writel(wkst, uart->wk_st);
 			}
-
-			/* Check for normal UART wakeup */
-			if (__raw_readl(uart->wk_st) & uart->wk_mask)
-				omap_uart_block_sleep(uart);
-			return;
 		}
 	}
 }
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 5e713d3..84548ca 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -51,12 +51,14 @@ static int serial_omap_start_rxdma(struct uart_omap_port *up);
 
 static inline unsigned int serial_in(struct uart_omap_port *up, int offset)
 {
+	omap_uart_resume_idle(up->pdev->id);
 	offset <<= up->port.regshift;
 	return readw(up->port.membase + offset);
 }
 
 static inline void serial_out(struct uart_omap_port *up, int offset, int value)
 {
+	omap_uart_resume_idle(up->pdev->id);
 	offset <<= up->port.regshift;
 	writew(value, up->port.membase + offset);
 }
-- 
1.7.4.1

