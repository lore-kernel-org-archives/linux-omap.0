From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC part1/2 merge v3][PATCH 06/10] omap3: serial: Fix uart4 handling for 3630
Date: Tue,  9 Mar 2010 10:16:50 -0600
Message-ID: <1268151414-17071-7-git-send-email-saaguirre@ti.com>
References: <1268151414-17071-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59122 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754595Ab0CIQQT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 9 Mar 2010 11:16:19 -0500
In-Reply-To: <1268151414-17071-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>, Sergio Aguirre <saaguirre@ti.com>

This patch makes the following:
 - Adds missing wakeup padding register handling.
 - Fixes a hardcode to use PER module ONLY on UART3.
 - Adds UART4 IRQ number define for 36xx chips.
 - Corrects IRQ number for 3630 case.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/serial.c           |    9 ++++++++-
 arch/arm/plat-omap/include/plat/irqs.h |    2 ++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index c9e203b..02f992c 100644
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
+			p->irq = INT_36XX_UART4_IRQ;
 	}
 }
 
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index b65088a..7d3820c 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -358,6 +358,8 @@
 #define INT_35XX_CCDC_VD1_IRQ		92
 #define INT_35XX_CCDC_VD2_IRQ		93
 
+#define INT_36XX_UART4_IRQ	80
+
 /* Max. 128 level 2 IRQs (OMAP1610), 192 GPIOs (OMAP730/850) and
  * 16 MPUIO lines */
 #define OMAP_MAX_GPIO_LINES	192
-- 
1.6.3.3

