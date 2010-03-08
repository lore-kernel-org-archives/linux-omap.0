From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC part1/2 merge v2][PATCH 07/11] omap3: serial: Fix uart4 handling for 3630
Date: Mon,  8 Mar 2010 11:20:50 -0600
Message-ID: <1268068854-13429-8-git-send-email-saaguirre@ti.com>
References: <1268068854-13429-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48362 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752412Ab0CHRUC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Mar 2010 12:20:02 -0500
In-Reply-To: <1268068854-13429-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Sergio Aguirre <saaguirre@ti.com>

This patch makes the following:
 - Adds missing wakeup padding register handling.
 - Fixes a hardcode to use PER module ONLY on UART3.
 - Corrects IRQ number to 80 for 3630 case.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/serial.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 351ba62..4ad1c6c 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -444,7 +444,7 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	omap_uart_smart_idle_enable(uart, 0);
 
 	if (cpu_is_omap34xx()) {
-		u32 mod = (uart->num == 2) ? OMAP3430_PER_MOD : CORE_MOD;
+		u32 mod = (uart->num > 1) ? OMAP3430_PER_MOD : CORE_MOD;
 		u32 wk_mask = 0;
 		u32 padconf = 0;
 
@@ -463,6 +463,10 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 			wk_mask = OMAP3430_ST_UART3_MASK;
 			padconf = 0x19e;
 			break;
+		case 3:
+			wk_mask = OMAP3630_ST_UART4_MASK;
+			padconf = 0x0d2;
+			break;
 		}
 		uart->wk_mask = wk_mask;
 		uart->padconf = padconf;
@@ -694,6 +698,9 @@ void __init omap_serial_early_init(void)
 
 		if (cpu_is_omap44xx())
 			p->irq += 32;
+
+		if (cpu_is_omap3630() && (i == 3))
+			p->irq = INT_34XX_UART4_IRQ;
 	}
 }
 
-- 
1.6.3.3

