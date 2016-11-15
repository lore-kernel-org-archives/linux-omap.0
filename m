From: Cor Peters <cpeters-JQzsJ8WnmGqc6Wr4J9gsBQC/G2K4zDHf@public.gmane.org>
Subject: [PATCH 1/2] Watchdog: omap_wdt: Retrieve bootstatus via syscon
Date: Tue, 15 Nov 2016 09:44:03 +0100
Message-ID: <2736782.ivGPcGWbll@corpeters>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-watchdog-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The current way to retrieve the bootstatus does not work with
device-tree based systems. This patch uses syscon to retrieve the
watchdog boot status from the PRM_DEV registers.

Signed-off-by: Cor Peters <cpeters-JQzsJ8WnmGqc6Wr4J9gsBQC/G2K4zDHf@public.gmane.org>
---
 drivers/watchdog/omap_wdt.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 1b02bfa..fed3f9c 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -41,6 +41,8 @@
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_data/omap-wd-timer.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
 
 #include "omap_wdt.h"
 
@@ -230,9 +232,11 @@ static unsigned int omap_wdt_get_timeleft(struct watchdog_device *wdog)
 static int omap_wdt_probe(struct platform_device *pdev)
 {
        struct omap_wd_timer_platform_data *pdata = dev_get_platdata(&pdev->dev);
+       struct regmap *rm = syscon_regmap_lookup_by_compatible("ti,omap3-prcm-dev");
        struct resource *res;
        struct omap_wdt_dev *wdev;
        int ret;
+       u32 rs = 0;
 
        wdev = devm_kzalloc(&pdev->dev, sizeof(*wdev), GFP_KERNEL);
        if (!wdev)
@@ -267,9 +271,17 @@ static int omap_wdt_probe(struct platform_device *pdev)
 
        if (pdata && pdata->read_reset_sources) {
                u32 rs = pdata->read_reset_sources();
-               if (rs & (1 << OMAP_MPU_WD_RST_SRC_ID_SHIFT))
-                       wdev->wdog.bootstatus = WDIOF_CARDRESET;
        }
+       else if (!IS_ERR(rm)) {
+               if (regmap_read(rm, 2 * sizeof(u32), &rs) >= 0) {
+                       /* reset register */
+                       regmap_write(rm, 2 * sizeof(u32),
+                               (1 << OMAP_MPU_WD_RST_SRC_ID_SHIFT) );
+               }
+       }
+
+       if (rs & (1 << OMAP_MPU_WD_RST_SRC_ID_SHIFT))
+               wdev->wdog.bootstatus = WDIOF_CARDRESET;
 
        if (!early_enable)
                omap_wdt_disable(wdev);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
