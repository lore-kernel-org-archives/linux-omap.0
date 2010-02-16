From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] omap4: clocks: Make Uart driver's clock calls OMAP4 compatible
Date: Tue, 16 Feb 2010 21:11:20 +0530
Message-ID: <1266334896-30686-8-git-send-email-santosh.shilimkar@ti.com>
References: <1266334896-30686-1-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-2-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-3-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-4-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-5-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-6-git-send-email-santosh.shilimkar@ti.com>
 <1266334896-30686-7-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51250 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932564Ab0BPPmD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Feb 2010 10:42:03 -0500
In-Reply-To: <1266334896-30686-7-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, ben@fluff.org.uk, sameo@linux.intel.com, lrg@slimlogic.co.uk, paul@pwsan.com, Abhijit Pagare <abhijitpagare@ti.com>

From: Abhijit Pagare <abhijitpagare@ti.com>

The uart driver has been adapted for the OMAP4 way of clock calls.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
---
 arch/arm/mach-omap2/serial.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index b79bc89..97859b0 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -257,7 +257,8 @@ static inline void omap_uart_enable_clocks(struct omap_uart_state *uart)
 		return;
 
 	clk_enable(uart->ick);
-	clk_enable(uart->fck);
+	if (!cpu_is_omap44xx())
+		clk_enable(uart->fck);
 	uart->clocked = 1;
 	omap_uart_restore_context(uart);
 }
@@ -272,7 +273,8 @@ static inline void omap_uart_disable_clocks(struct omap_uart_state *uart)
 	omap_uart_save_context(uart);
 	uart->clocked = 0;
 	clk_disable(uart->ick);
-	clk_disable(uart->fck);
+	if (!cpu_is_omap44xx())
+		clk_disable(uart->fck);
 }
 
 static void omap_uart_enable_wakeup(struct omap_uart_state *uart)
@@ -669,18 +671,24 @@ void __init omap_serial_early_init(void)
 			continue;
 		}
 
-		sprintf(name, "uart%d_ick", i+1);
+		if (!cpu_is_omap44xx())
+			sprintf(name, "uart%d_ick", i+1);
+		else
+			sprintf(name, "uart%d_ck", i+1);
 		uart->ick = clk_get(NULL, name);
 		if (IS_ERR(uart->ick)) {
 			printk(KERN_ERR "Could not get uart%d_ick\n", i+1);
 			uart->ick = NULL;
 		}
 
-		sprintf(name, "uart%d_fck", i+1);
-		uart->fck = clk_get(NULL, name);
-		if (IS_ERR(uart->fck)) {
-			printk(KERN_ERR "Could not get uart%d_fck\n", i+1);
-			uart->fck = NULL;
+		if (!cpu_is_omap44xx()) {
+			sprintf(name, "uart%d_fck", i+1);
+			uart->fck = clk_get(NULL, name);
+			if (IS_ERR(uart->fck)) {
+				printk(KERN_ERR "Could not get uart%d_fck\n",
+									 i+1);
+				uart->fck = NULL;
+			}
 		}
 
 		/* FIXME: Remove this once the clkdev is ready */
-- 
1.6.0.4

