From: Mohan Kumar <mohankumar718@gmail.com>
Subject: [PATCH] drivers: memory: This patch fix the following checkpatch warning.
Date: Tue, 16 Apr 2019 11:46:12 +0300
Message-ID: <1555404372-3582-1-git-send-email-mohankumar718@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rogerq@ti.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Switch hardcoded function name with a reference to __func__ making the
code more maintainable

WARNING: Prefer using '"%s...", __func__' to using function's name, in a
string

Use pr_warn instead of printk

WARNING: Prefer [subsystem eg: netdev]_err([subsystem]dev, ...
then dev_err(dev, ... then pr_err(...  to printk(KERN_ERR ...

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/memory/omap-gpmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index f629759..685f422 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -795,7 +795,7 @@ int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t,
 #endif
 
 	gpmc_cs_bool_timings(cs, &t->bool_timings);
-	gpmc_cs_show_timings(cs, "after gpmc_cs_set_timings");
+	gpmc_cs_show_timings(cs, "%s", __func__);
 
 	return 0;
 }
@@ -1033,7 +1033,7 @@ void gpmc_cs_free(int cs)
 
 	spin_lock(&gpmc_mem_lock);
 	if (cs >= gpmc_cs_num || cs < 0 || !gpmc_cs_reserved(cs)) {
-		printk(KERN_ERR "Trying to free non-reserved GPMC CS%d\n", cs);
+		pr_err("Trying to free non-reserved GPMC CS%d\n", cs);
 		BUG();
 		spin_unlock(&gpmc_mem_lock);
 		return;
-- 
2.7.4
