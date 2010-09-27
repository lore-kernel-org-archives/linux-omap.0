From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [PATCH 04/13 v3] OMAP2: UART: remove set_uart_globals
Date: Mon, 27 Sep 2010 20:19:46 +0530 (IST)
Message-ID: <43516.10.24.255.17.1285598986.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

Remove set_uart_globals function as this will not be needed as
physical address for uarts will be taken from hwmod data file.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c             |    5 -----
 arch/arm/plat-omap/common.c              |   16 ----------------
 arch/arm/plat-omap/include/plat/common.h |    1 -
 3 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index e6c4027..6ffbc92 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -104,11 +104,6 @@ struct omap_uart_state {
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
index 3008e71..ab04dad 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -257,7 +257,6 @@ static void __init __omap2_set_globals(struct omap_globals *omap2_globals)
 	omap2_set_globals_sdrc(omap2_globals);
 	omap2_set_globals_control(omap2_globals);
 	omap2_set_globals_prcm(omap2_globals);
-	omap2_set_globals_uart(omap2_globals);
 }

 #endif
@@ -272,9 +271,6 @@ static struct omap_globals omap242x_globals = {
 	.ctrl	= OMAP2420_CTRL_BASE,
 	.prm	= OMAP2420_PRM_BASE,
 	.cm	= OMAP2420_CM_BASE,
-	.uart1_phys	= OMAP2_UART1_BASE,
-	.uart2_phys	= OMAP2_UART2_BASE,
-	.uart3_phys	= OMAP2_UART3_BASE,
 };

 void __init omap2_set_globals_242x(void)
@@ -293,9 +289,6 @@ static struct omap_globals omap243x_globals = {
 	.ctrl	= OMAP243X_CTRL_BASE,
 	.prm	= OMAP2430_PRM_BASE,
 	.cm	= OMAP2430_CM_BASE,
-	.uart1_phys	= OMAP2_UART1_BASE,
-	.uart2_phys	= OMAP2_UART2_BASE,
-	.uart3_phys	= OMAP2_UART3_BASE,
 };

 void __init omap2_set_globals_243x(void)
@@ -314,10 +307,6 @@ static struct omap_globals omap3_globals = {
 	.ctrl	= OMAP343X_CTRL_BASE,
 	.prm	= OMAP3430_PRM_BASE,
 	.cm	= OMAP3430_CM_BASE,
-	.uart1_phys	= OMAP3_UART1_BASE,
-	.uart2_phys	= OMAP3_UART2_BASE,
-	.uart3_phys	= OMAP3_UART3_BASE,
-	.uart4_phys	= OMAP3_UART4_BASE,	/* Only on 3630 */
 };

 void __init omap2_set_globals_3xxx(void)
@@ -340,10 +329,6 @@ static struct omap_globals omap4_globals = {
 	.prm	= OMAP4430_PRM_BASE,
 	.cm	= OMAP4430_CM_BASE,
 	.cm2	= OMAP4430_CM2_BASE,
-	.uart1_phys	= OMAP4_UART1_BASE,
-	.uart2_phys	= OMAP4_UART2_BASE,
-	.uart3_phys	= OMAP4_UART3_BASE,
-	.uart4_phys	= OMAP4_UART4_BASE,
 };

 void __init omap2_set_globals_443x(void)
@@ -351,7 +336,6 @@ void __init omap2_set_globals_443x(void)
 	omap2_set_globals_tap(&omap4_globals);
 	omap2_set_globals_control(&omap4_globals);
 	omap2_set_globals_prcm(&omap4_globals);
-	omap2_set_globals_uart(&omap4_globals);
 }
 #endif

diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index c45dbb9..159e45c 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -66,7 +66,6 @@ void omap2_set_globals_tap(struct omap_globals *);
 void omap2_set_globals_sdrc(struct omap_globals *);
 void omap2_set_globals_control(struct omap_globals *);
 void omap2_set_globals_prcm(struct omap_globals *);
-void omap2_set_globals_uart(struct omap_globals *);

 void omap3_map_io(void);

-- 
1.6.3.3


