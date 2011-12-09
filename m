From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv10 13/14] TEMP: OMAP: serial: remove padconf hacks
Date: Fri, 9 Dec 2011 16:27:36 +0200
Message-ID: <1323440857-385-14-git-send-email-t-kristo@ti.com>
References: <1323440857-385-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59544 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754319Ab1LIO20 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 09:28:26 -0500
In-Reply-To: <1323440857-385-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, b-cousson@ti.com
Cc: "Govindraj.R" <govindraj.raja@ti.com>

These are no longer needed as omap_hwmod takes care of multiplexing of pads.
Should be handled properly with serial runtime PM support patches.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |   25 +------------------------
 1 files changed, 1 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 13008f5..525d2cf 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -73,7 +73,6 @@ struct omap_uart_state {
 	void __iomem *wk_st;
 	void __iomem *wk_en;
 	u32 wk_mask;
-	u32 padconf;
 	u32 dma_enabled;
 
 	struct clk *ick;
@@ -287,13 +286,6 @@ static void omap_uart_enable_wakeup(struct omap_uart_state *uart)
 		v |= uart->wk_mask;
 		__raw_writel(v, uart->wk_en);
 	}
-
-	/* Ensure IOPAD wake-enables are set */
-	if (cpu_is_omap34xx() && uart->padconf) {
-		u16 v = omap_ctrl_readw(uart->padconf);
-		v |= OMAP3_PADCONF_WAKEUPENABLE0;
-		omap_ctrl_writew(v, uart->padconf);
-	}
 }
 
 static void omap_uart_disable_wakeup(struct omap_uart_state *uart)
@@ -304,13 +296,6 @@ static void omap_uart_disable_wakeup(struct omap_uart_state *uart)
 		v &= ~uart->wk_mask;
 		__raw_writel(v, uart->wk_en);
 	}
-
-	/* Ensure IOPAD wake-enables are cleared */
-	if (cpu_is_omap34xx() && uart->padconf) {
-		u16 v = omap_ctrl_readw(uart->padconf);
-		v &= ~OMAP3_PADCONF_WAKEUPENABLE0;
-		omap_ctrl_writew(v, uart->padconf);
-	}
 }
 
 static void omap_uart_smart_idle_enable(struct omap_uart_state *uart,
@@ -456,7 +441,6 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	if (cpu_is_omap34xx() && !cpu_is_ti816x()) {
 		u32 mod = (uart->num > 1) ? OMAP3430_PER_MOD : CORE_MOD;
 		u32 wk_mask = 0;
-		u32 padconf = 0;
 
 		/* XXX These PRM accesses do not belong here */
 		uart->wk_en = OMAP34XX_PRM_REGADDR(mod, PM_WKEN1);
@@ -464,23 +448,18 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 		switch (uart->num) {
 		case 0:
 			wk_mask = OMAP3430_ST_UART1_MASK;
-			padconf = 0x182;
 			break;
 		case 1:
 			wk_mask = OMAP3430_ST_UART2_MASK;
-			padconf = 0x17a;
 			break;
 		case 2:
 			wk_mask = OMAP3430_ST_UART3_MASK;
-			padconf = 0x19e;
 			break;
 		case 3:
 			wk_mask = OMAP3630_ST_UART4_MASK;
-			padconf = 0x0d2;
 			break;
 		}
 		uart->wk_mask = wk_mask;
-		uart->padconf = padconf;
 	} else if (cpu_is_omap24xx()) {
 		u32 wk_mask = 0;
 		u32 wk_en = PM_WKEN1, wk_st = PM_WKST1;
@@ -510,7 +489,6 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 		uart->wk_en = NULL;
 		uart->wk_st = NULL;
 		uart->wk_mask = 0;
-		uart->padconf = 0;
 	}
 
 	uart->irqflags |= IRQF_SHARED;
@@ -810,8 +788,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 
 	console_unlock();
 
-	if ((cpu_is_omap34xx() && uart->padconf) ||
-	    (uart->wk_en && uart->wk_mask)) {
+	if (uart->oh->mux || (uart->wk_en && uart->wk_mask)) {
 		device_init_wakeup(&pdev->dev, true);
 		DEV_CREATE_FILE(&pdev->dev, &dev_attr_sleep_timeout);
 	}
-- 
1.7.4.1

