From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH 3/3] OMAP36xx PM: Updated C state latencies for OMAP3630
Date: Wed, 16 Feb 2011 14:31:14 +0530
Message-ID: <1297846874-18286-4-git-send-email-vishwanath.bs@ti.com>
References: <1297846874-18286-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49637 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755636Ab1BPI6R (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 03:58:17 -0500
In-Reply-To: <1297846874-18286-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: patches@linaro.org, Vishwanath BS <vishwanath.bs@ti.com>

This patch has changes to update the C state latencies for OMAP3630 and
disables the useless C-States, keeping only the optimized ones with their
corresponding measured latencies. Only 4 C-states are kept instead of 7
C-States:
* C1 . MPU WFI clock gated + Core autogating
* C3 . MPU CSWR + Core inactive
* C5 . MPU CSWR + Core CSWR
* C7 . MPU OFF + Core OFF

Thanks to Nicole Chaloub<n-chalhoub@ti.com> and Vincent Bour <v-bour@ti.com>
for their investigation.

Tested on ZOOM3 board using latest pm branch.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/board-3630sdp.c |   19 +++++++++++++++++++
 arch/arm/mach-omap2/board-zoom.c    |   19 +++++++++++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index 6264564..8d05fc9
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -25,6 +25,24 @@
 #include "board-flash.h"
 #include "mux.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
+#include "pm.h"
+
+static struct cpuidle_params omap36xx_cpuidle_params_table[] = {
+	/* C1 */
+	{1, 74, 78, 152},
+	/* C2 */
+	{0, 165, 90, 255},
+	/* C3 */
+	{1, 163, 180, 345},
+	/* C4 */
+	{0, 2852, 605, 3457},
+	/* C5 */
+	{1, 800, 366, 2120},
+	/* C6 */
+	{0, 4080, 801, 4881},
+	/* C7 */
+	{1, 4300, 8794, 159000},
+};
 
 #if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE)
 
@@ -212,6 +230,7 @@ static void __init omap_sdp_init(void)
 	board_flash_init(sdp_flash_partitions, chip_sel_sdp);
 	enable_board_wakeup_source();
 	usb_ehci_init(&ehci_pdata);
+	omap3_pm_init_cpuidle(omap36xx_cpuidle_params_table);
 }
 
 MACHINE_START(OMAP_3630SDP, "OMAP 3630SDP board")
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index e26754c..6bd364a
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -30,6 +30,24 @@
 #include "mux.h"
 #include "sdram-micron-mt46h32m32lf-6.h"
 #include "sdram-hynix-h8mbx00u0mer-0em.h"
+#include "pm.h"
+
+static struct cpuidle_params omap36xx_cpuidle_params_table[] = {
+	/* C1 */
+	{1, 74, 78, 152},
+	/* C2 */
+	{0, 165, 90, 255},
+	/* C3 */
+	{1, 163, 180, 345},
+	/* C4 */
+	{0, 2852, 605, 3457},
+	/* C5 */
+	{1, 800, 366, 2120},
+	/* C6 */
+	{0, 4080, 801, 4881},
+	/* C7 */
+	{1, 4300, 8794, 159000},
+};
 
 #define ZOOM3_EHCI_RESET_GPIO		64
 
@@ -126,6 +144,7 @@ static void __init omap_zoom_init(void)
 		usb_ehci_init(&ehci_pdata);
 	}
 
+	omap3_pm_init_cpuidle(omap36xx_cpuidle_params_table);
 	board_nand_init(zoom_nand_partitions,
 			ARRAY_SIZE(zoom_nand_partitions), ZOOM_NAND_CS);
 	zoom_debugboard_init();
-- 
1.7.0.4

