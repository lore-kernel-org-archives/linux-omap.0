From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 3/3] OMAP: RX-51: Pass cpu idle parameters
Date: Thu, 29 Oct 2009 10:30:20 +0200
Message-ID: <1256805020-7402-4-git-send-email-kalle.jokiniemi@digia.com>
References: <>
 <1256805020-7402-1-git-send-email-kalle.jokiniemi@digia.com>
 <1256805020-7402-2-git-send-email-kalle.jokiniemi@digia.com>
 <1256805020-7402-3-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:12150 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753297AbZJ2IaI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Oct 2009 04:30:08 -0400
In-Reply-To: <1256805020-7402-3-git-send-email-kalle.jokiniemi@digia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, rnayak@ti.com, jouni.hogander@nokia.com, Kalle Jokiniemi <kalle.jokiniemi@digia.com>

Pass cpuidle parameters for RX-51. Numbers based on
measurements made in October 2009 for PM optimized
kernel with CPU freq enabled. Assumes OPP2 (main
idle OPP, and worst case latencies).

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
---
 arch/arm/mach-omap2/board-rx51.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 527f0c6..02fb33b 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -32,11 +32,28 @@
 #include <plat/usb.h>
 
 #include "omap3-opp.h"
+#include "pm.h"
 
 #define RX51_GPIO_SLEEP_IND 162
 
 struct omap_sdrc_params *rx51_get_sdram_timings(void);
 
+static struct cpuidle_params rx51_cpuidle_params[] = {
+	/* C1 */
+	{1, 110, 162, 5},
+	/* C2 */
+	{1, 106, 180, 309},
+	/* C3 */
+	{0, 107, 410, 46057},
+	/* C4 */
+	{0, 121, 3374, 46057},
+	/* C5 */
+	{1, 855, 1146, 46057},
+	/* C6 */
+	{0, 7580, 4134, 484329},
+	/* C7 */
+	{1, 7505, 15274, 484329},
+};
 static struct gpio_led gpio_leds[] = {
 	{
 		.name	= "sleep_ind",
@@ -84,6 +101,7 @@ static void __init rx51_init_irq(void)
 {
 	omap_board_config = rx51_config;
 	omap_board_config_size = ARRAY_SIZE(rx51_config);
+	omap3_pm_init_cpuidle(rx51_cpuidle_params);
 	omap2_init_common_hw(rx51_get_sdram_timings(),
 			     rx51_get_sdram_timings(), omap3_mpu_rate_table,
 			     omap3_dsp_rate_table, omap3_l3_rate_table);
-- 
1.5.4.3

