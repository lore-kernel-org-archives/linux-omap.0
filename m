From: Thara Gopinath <thara@ti.com>
Subject: [PATCH v2 01/11] OMAP4: PM debugfs support
Date: Sat, 25 Sep 2010 18:21:16 +0530
Message-ID: <1285419086-13047-2-git-send-email-thara@ti.com>
References: <1285419086-13047-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45499 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083Ab0IYMvh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 25 Sep 2010 08:51:37 -0400
In-Reply-To: <1285419086-13047-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch extends pm debugfs to support OMAP4 debug entries
also. Currently PM register dump support is not added for OMAP4.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 7d95112..29ca4b4 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -617,7 +617,7 @@ static int __init pm_dbg_init(void)
 
 	if (cpu_is_omap34xx())
 		pm_dbg_reg_modules = omap3_pm_reg_modules;
-	else {
+	else if (!cpu_is_omap44xx()) {
 		printk(KERN_ERR "%s: only OMAP3 supported\n", __func__);
 		return -ENODEV;
 	}
@@ -633,20 +633,22 @@ static int __init pm_dbg_init(void)
 
 	pwrdm_for_each(pwrdms_setup, (void *)d);
 
-	pm_dbg_dir = debugfs_create_dir("registers", d);
-	if (IS_ERR(pm_dbg_dir))
-		return PTR_ERR(pm_dbg_dir);
+	if (cpu_is_omap34xx()) {
+		pm_dbg_dir = debugfs_create_dir("registers", d);
+		if (IS_ERR(pm_dbg_dir))
+			return PTR_ERR(pm_dbg_dir);
 
-	(void) debugfs_create_file("current", S_IRUGO,
-		pm_dbg_dir, (void *)0, &debug_reg_fops);
+		(void) debugfs_create_file("current", S_IRUGO,
+			pm_dbg_dir, (void *)0, &debug_reg_fops);
 
-	for (i = 0; i < PM_DBG_MAX_REG_SETS; i++)
-		if (pm_dbg_reg_set[i] != NULL) {
-			sprintf(name, "%d", i+1);
-			(void) debugfs_create_file(name, S_IRUGO,
-				pm_dbg_dir, (void *)(i+1), &debug_reg_fops);
-
-		}
+		for (i = 0; i < PM_DBG_MAX_REG_SETS; i++)
+			if (pm_dbg_reg_set[i] != NULL) {
+				sprintf(name, "%d", i+1);
+				(void) debugfs_create_file(name, S_IRUGO,
+					pm_dbg_dir, (void *)(i+1),
+					&debug_reg_fops);
+			}
+	}
 
 	(void) debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUGO, d,
 				   &enable_off_mode, &pm_dbg_option_fops);
-- 
1.7.0.4

