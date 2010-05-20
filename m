From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [pm-wip/uart][PATCH 1/6] Serial: Clean up set_uart_globals.
Date: Thu, 20 May 2010 19:08:03 +0530 (IST)
Message-ID: <47579.192.168.10.88.1274362683.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53116 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753220Ab0ETNiF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 May 2010 09:38:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>


Remove set_uart_globals function as this will not be
needed as physical address for uarts will be taken from
hwmod data file.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c             |    5 -----
 arch/arm/plat-omap/common.c              |   17 -----------------
 arch/arm/plat-omap/include/plat/common.h |    1 -
 3 files changed, 0 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index a95bc25..7d0dc3a 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -102,11 +102,6 @@ struct omap_uart_state {
 static LIST_HEAD(uart_list);
 static u8 num_uarts;

-
-void __init omap2_set_globals_uart(struct omap_globals *omap2_globals)
-{
-}
-
 static struct omap_device_pm_latency omap_uart_latency[] = {
 	{
 		.deactivate_func = omap_device_idle_hwmods,
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index f12f0e3..354267e 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -252,7 +252,6 @@ static void __init __omap2_set_globals(struct omap_globals *omap2_globals)
 	omap2_set_globals_sdrc(omap2_globals);
 	omap2_set_globals_control(omap2_globals);
 	omap2_set_globals_prcm(omap2_globals);
-	omap2_set_globals_uart(omap2_globals);
 }

 #endif
@@ -267,9 +266,6 @@ static struct omap_globals omap242x_globals = {
 	.ctrl	= OMAP2420_CTRL_BASE,
 	.prm	= OMAP2420_PRM_BASE,
 	.cm	= OMAP2420_CM_BASE,
-	.uart1_phys	= OMAP2_UART1_BASE,
-	.uart2_phys	= OMAP2_UART2_BASE,
-	.uart3_phys	= OMAP2_UART3_BASE,
 };

 void __init omap2_set_globals_242x(void)
@@ -288,9 +284,6 @@ static struct omap_globals omap243x_globals = {
 	.ctrl	= OMAP243X_CTRL_BASE,
 	.prm	= OMAP2430_PRM_BASE,
 	.cm	= OMAP2430_CM_BASE,
-	.uart1_phys	= OMAP2_UART1_BASE,
-	.uart2_phys	= OMAP2_UART2_BASE,
-	.uart3_phys	= OMAP2_UART3_BASE,
 };

 void __init omap2_set_globals_243x(void)
@@ -309,9 +302,6 @@ static struct omap_globals omap3_globals = {
 	.ctrl	= OMAP343X_CTRL_BASE,
 	.prm	= OMAP3430_PRM_BASE,
 	.cm	= OMAP3430_CM_BASE,
-	.uart1_phys	= OMAP3_UART1_BASE,
-	.uart2_phys	= OMAP3_UART2_BASE,
-	.uart3_phys	= OMAP3_UART3_BASE,
 };

 void __init omap2_set_globals_343x(void)
@@ -321,8 +311,6 @@ void __init omap2_set_globals_343x(void)

 void __init omap2_set_globals_36xx(void)
 {
-	omap3_globals.uart4_phys = OMAP3_UART4_BASE;
-
 	__omap2_set_globals(&omap3_globals);
 }
 #endif
@@ -335,10 +323,6 @@ static struct omap_globals omap4_globals = {
 	.prm	= OMAP4430_PRM_BASE,
 	.cm	= OMAP4430_CM_BASE,
 	.cm2	= OMAP4430_CM2_BASE,
-	.uart1_phys	= OMAP4_UART1_BASE,
-	.uart2_phys	= OMAP4_UART2_BASE,
-	.uart3_phys	= OMAP4_UART3_BASE,
-	.uart4_phys	= OMAP4_UART4_BASE,
 };

 void __init omap2_set_globals_443x(void)
@@ -346,7 +330,6 @@ void __init omap2_set_globals_443x(void)
 	omap2_set_globals_tap(&omap4_globals);
 	omap2_set_globals_control(&omap4_globals);
 	omap2_set_globals_prcm(&omap4_globals);
-	omap2_set_globals_uart(&omap4_globals);
 }
 #endif

diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 7556e27..3167a9d 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -68,7 +68,6 @@ void omap2_set_globals_tap(struct omap_globals *);
 void omap2_set_globals_sdrc(struct omap_globals *);
 void omap2_set_globals_control(struct omap_globals *);
 void omap2_set_globals_prcm(struct omap_globals *);
-void omap2_set_globals_uart(struct omap_globals *);

 /**
  * omap_test_timeout - busy-loop, testing a condition
-- 
1.6.3.3





