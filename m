From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC v3][PATCH 6/6] omap3: serial: Fix uart4 handling for 3630
Date: Sat, 27 Feb 2010 14:46:11 -0600
Message-ID: <1267303571-3674-7-git-send-email-saaguirre@ti.com>
References: <1267303571-3674-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38020 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030848Ab0B0UqA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 27 Feb 2010 15:46:00 -0500
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1RKjxKG008416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 27 Feb 2010 14:45:59 -0600
In-Reply-To: <1267303571-3674-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sergio Aguirre <saaguirre@ti.com>

This patch makes the following:
 - Adds missing wakeup padding register handling.
 - Fixes a hardcode to use PER module ONLY on UART3.
 - Corrects IRQ number to 80 for 3630 case.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/serial.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 605422e..d7cea8a 100644
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
@@ -689,6 +693,10 @@ void __init omap_serial_early_init(void)
 
 		if (cpu_is_omap44xx())
 			p->irq += 32;
+
+		/* IRQ for UART4 in omap3630 is 80 */
+		if (cpu_is_omap3630() && (i == 3))
+			p->irq = 80;
 	}
 }
 
-- 
1.6.3.3

