From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv2 1/8] OMAP: PM: Allowing an early init of pm debugfs driver.
Date: Fri, 13 Aug 2010 19:17:04 +0530
Message-ID: <1281707231-3026-2-git-send-email-thara@ti.com>
References: <1281707231-3026-1-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53790 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755198Ab0HMNrZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Aug 2010 09:47:25 -0400
In-Reply-To: <1281707231-3026-1-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, dderrick@ti.com, Thara Gopinath <thara@ti.com>

This patch changes the pm_db_init from arch initcall to a postcore
initcall. With arch initcall, it is impossible for pm driver that
gets initialized prior to this driver to use one of the
pm debug fs entries during its init. Making it a postcore initcall
ensures that this drver gets initialized early on before any pm
drivers. Also now the generir pm_debug directory is made global
so that other drivers can include it and use it.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 723b44e..fed8da1 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -162,7 +162,7 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
 
 static void pm_dbg_regset_store(u32 *ptr);
 
-struct dentry *pm_dbg_dir;
+struct dentry *pm_dbg_dir, *pm_dbg_main_dir;
 
 static int pm_dbg_init_done;
 
@@ -609,10 +609,11 @@ static int __init pm_dbg_init(void)
 				   &sleep_while_idle, &pm_dbg_option_fops);
 	(void) debugfs_create_file("wakeup_timer_seconds", S_IRUGO | S_IWUGO, d,
 				   &wakeup_timer_seconds, &pm_dbg_option_fops);
+	pm_dbg_main_dir = d;
 	pm_dbg_init_done = 1;
 
 	return 0;
 }
-arch_initcall(pm_dbg_init);
+postcore_initcall(pm_dbg_init);
 
 #endif
-- 
1.7.1.GIT

