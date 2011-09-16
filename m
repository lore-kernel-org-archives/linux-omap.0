From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 14/16] TEMP: OMAP: serial: remove padconf hacks
Date: Fri, 16 Sep 2011 19:05:48 +0300
Message-ID: <1316189150-21448-15-git-send-email-t-kristo@ti.com>
References: <1316189150-21448-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53672 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755293Ab1IPQG2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Sep 2011 12:06:28 -0400
Content-Class: urn:content-classes:message
In-Reply-To: <1316189150-21448-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm@lists.arm.linux.org.uk, "Govindraj.R" <govindraj.raja@ti.com>

These are no longer needed as omap_hwmod takes care of multiplexing of pads.
Should be handled properly with serial runtime PM support patches.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |   25 +------------------------
 1 files changed, 1 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 0cc5434..cdcdd83 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -73,7 +73,6 @@ struct omap_uart_state {
 	void __iomem *wk_st;
 	void __iomem *wk_en;
 	u32 wk_mask;
-	u32 padconf;
 	u32 dma_enabled;
 
 	struct clk *ick;
@@ -309,13 +308,6 @@ static void omap_uart_enable_wakeup(struct omap_uart_state *uart)
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
@@ -326,13 +318,6 @@ static void omap_uart_disable_wakeup(struct omap_uart_state *uart)
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
@@ -478,7 +463,6 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	if (cpu_is_omap34xx() && !cpu_is_ti816x()) {
 		u32 mod = (uart->num > 1) ? OMAP3430_PER_MOD : CORE_MOD;
 		u32 wk_mask = 0;
-		u32 padconf = 0;
 
 		/* XXX These PRM accesses do not belong here */
 		uart->wk_en = OMAP34XX_PRM_REGADDR(mod, PM_WKEN1);
@@ -486,23 +470,18 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
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
@@ -532,7 +511,6 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 		uart->wk_en = NULL;
 		uart->wk_st = NULL;
 		uart->wk_mask = 0;
-		uart->padconf = 0;
 	}
 
 	uart->irqflags |= IRQF_SHARED;
@@ -833,8 +811,7 @@ void __init omap_serial_init_port(struct omap_board_data *bdata)
 
 	console_unlock();
 
-	if ((cpu_is_omap34xx() && uart->padconf) ||
-	    (uart->wk_en && uart->wk_mask)) {
+	if (uart->oh->mux || (uart->wk_en && uart->wk_mask)) {
 		device_init_wakeup(&pdev->dev, true);
 		DEV_CREATE_FILE(&pdev->dev, &dev_attr_sleep_timeout);
 	}
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 

