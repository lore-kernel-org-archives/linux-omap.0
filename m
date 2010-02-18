From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 5/7] OMAP3: RX-51: Pass cpu idle parameters
Date: Wed, 17 Feb 2010 18:02:28 -0600
Message-ID: <1266451350-4480-6-git-send-email-khilman@deeprootsystems.com>
References: <1266451350-4480-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1266451350-4480-1-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Kalle Jokiniemi <kalle.jokiniemi@digia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

Pass cpuidle parameters for RX-51. Numbers based on
measurements made in October 2009 for PM optimized
kernel with CPU freq enabled. Assumes OPP2 (main
idle OPP, and worst case latencies).

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/board-rx51.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 26b70da..acfb898 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -31,6 +31,7 @@
 #include <plat/usb.h>
 
 #include "mux.h"
+#include "pm.h"
 
 #define RX51_GPIO_SLEEP_IND 162
 
@@ -56,6 +57,23 @@ static struct platform_device leds_gpio = {
 	},
 };
 
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
+
 static struct omap_lcd_config rx51_lcd_config = {
 	.ctrl_name	= "internal",
 };
@@ -85,6 +103,7 @@ static void __init rx51_init_irq(void)
 
 	omap_board_config = rx51_config;
 	omap_board_config_size = ARRAY_SIZE(rx51_config);
+	omap3_pm_init_cpuidle(rx51_cpuidle_params);
 	sdrc_params = rx51_get_sdram_timings();
 	omap2_init_common_hw(sdrc_params, sdrc_params);
 	omap_init_irq();
-- 
1.6.6
