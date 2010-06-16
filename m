From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [pm-wip/uart][PATCH 3/5 v2] OMAP3: serial: Fix uart4 handling for
     3630
Date: Wed, 16 Jun 2010 19:44:08 +0530 (IST)
Message-ID: <2232.10.24.255.18.1276697648.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43712 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758799Ab0FPOOK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Jun 2010 10:14:10 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Sergio Aguirre <saaguirre@ti.com>

This patch makes the following:
 - Adds missing wakeup padding register handling.
 - Fixes a hardcode to use PER module ONLY on UART3.
 - Muxmode usage needed for uart4 for 3630, for padconf
   wakeup on uart4_rx line. uart4_rx signal is available
   under mode-2 in gpmc_wait3. Thus have to ensure we are
   in right mux mode before accesing any padconf register.
   So ensure right mux mode for uarti padconf access.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |   43 +++++++++++++++++++++++++++++++++++++----
 1 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index da9fee6..128e19b 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -42,6 +42,7 @@
 #include "prm.h"
 #include "pm.h"
 #include "cm.h"
+#include "mux.h"
 #include "prm-regbits-34xx.h"

 #define UART_OMAP_NO_EMPTY_FIFO_READ_IP_REV	0x52
@@ -68,6 +69,7 @@ struct omap_uart_state {
 	u32 wk_mask;
 	u32 padconf;
 	u32 dma_enabled;
+	u16 muxmode;

 	struct clk *ick;
 	struct clk *fck;
@@ -229,8 +231,20 @@ static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
 	omap_device_idle(uart->pdev);
 }

+static inline void omap_uart_set_muxmode(struct omap_uart_state *uart)
+{
+	u16 w = omap_ctrl_readw(uart->padconf);
+
+	w &= ~0x7;
+	w |= uart->muxmode;
+	omap_ctrl_writew(w, uart->padconf);
+}
+
 static void omap_uart_enable_wakeup(struct omap_uart_state *uart)
 {
+	if (uart->muxmode && uart->padconf)
+		omap_uart_set_muxmode(uart);
+
 	/* Set wake-enable bit */
 	if (uart->wk_en && uart->wk_mask) {
 		u32 v = __raw_readl(uart->wk_en);
@@ -248,6 +262,9 @@ static void omap_uart_enable_wakeup(struct omap_uart_state *uart)

 static void omap_uart_disable_wakeup(struct omap_uart_state *uart)
 {
+	if (uart->muxmode && uart->padconf)
+		omap_uart_set_muxmode(uart);
+
 	/* Clear wake-enable bit */
 	if (uart->wk_en && uart->wk_mask) {
 		u32 v = __raw_readl(uart->wk_en);
@@ -338,6 +355,9 @@ void omap_uart_resume_idle(int num)
 		if (num == uart->num) {
 			omap_uart_enable_clocks(uart);

+			if (uart->muxmode && uart->padconf)
+				omap_uart_set_muxmode(uart);
+
 			/* Check for IO pad wakeup */
 			if (cpu_is_omap34xx() && uart->padconf) {
 				u16 p = omap_ctrl_readw(uart->padconf);
@@ -416,28 +436,41 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	omap_uart_smart_idle_enable(uart, 0);

 	if (cpu_is_omap34xx()) {
-		u32 mod = (uart->num == 2) ? OMAP3430_PER_MOD : CORE_MOD;
+		u32 mod = (uart->num > 1) ? OMAP3430_PER_MOD : CORE_MOD;
 		u32 wk_mask = 0;
-		u32 padconf = 0;
+		u16 padconf = 0;
+		u16 muxmode = 0;

 		uart->wk_en = OMAP34XX_PRM_REGADDR(mod, PM_WKEN1);
 		uart->wk_st = OMAP34XX_PRM_REGADDR(mod, PM_WKST1);
 		switch (uart->num) {
 		case 0:
 			wk_mask = OMAP3430_ST_UART1_MASK;
-			padconf = 0x182;
+			padconf = omap_mux_request_signal("uart1_rx");
 			break;
 		case 1:
 			wk_mask = OMAP3430_ST_UART2_MASK;
-			padconf = 0x17a;
+			padconf = omap_mux_request_signal("uart2_rx");
 			break;
 		case 2:
 			wk_mask = OMAP3430_ST_UART3_MASK;
-			padconf = 0x19e;
+			padconf = omap_mux_request_signal("uart3_rx_irrx");
+			break;
+		case 3:
+			wk_mask = OMAP3630_ST_UART4_MASK;
+			/**
+			 * get uart4_rx mux pin offset.
+			 * uart4_rx signal is available in gpmc_wait3
+			 * in mux_mode 2. Refer to OMAP36XX TRM and
+			 * /mach-omap2/mux34xx.c file for further details.
+			 */
+			padconf = omap_mux_request_signal("gpmc_wait3");
+			muxmode = OMAP_MUX_MODE2;
 			break;
 		}
 		uart->wk_mask = wk_mask;
 		uart->padconf = padconf;
+		uart->muxmode = muxmode;
 	} else if (cpu_is_omap24xx()) {
 		u32 wk_mask = 0;

-- 
1.6.3.3





