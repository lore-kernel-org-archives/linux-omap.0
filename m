From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 10/13 v3] OMAP3: serial: Fix uart4 handling for 3630
Date: Mon, 27 Sep 2010 20:20:41 +0530 (IST)
Message-ID: <43800.10.24.255.17.1285599041.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Sergio Aguirre <saaguirre@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

This patch makes the following:
 - Adds missing wakeup padding register handling.
 - Fixes a hardcode to use PER module ONLY on UART3.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 72b5c98..0bcc9df 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -487,7 +487,7 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 	omap_uart_smart_idle_enable(uart, 0);

 	if (cpu_is_omap34xx()) {
-		u32 mod = (uart->num == 2) ? OMAP3430_PER_MOD : CORE_MOD;
+		u32 mod = (uart->num > 1) ? OMAP3430_PER_MOD : CORE_MOD;
 		u32 wk_mask = 0;
 		u32 padconf = 0;

@@ -506,6 +506,10 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
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
-- 
1.6.3.3


