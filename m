From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 1/4] OMAP3: PM debug: remove sleep_while_idle feature
Date: Thu, 26 May 2011 16:02:48 -0700
Message-ID: <1306450971-27732-2-git-send-email-khilman@ti.com>
References: <1306450971-27732-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:39683 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756405Ab1EZW4o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 May 2011 18:56:44 -0400
Received: by mail-pw0-f41.google.com with SMTP id 12so690945pwi.14
        for <linux-omap@vger.kernel.org>; Thu, 26 May 2011 15:56:43 -0700 (PDT)
In-Reply-To: <1306450971-27732-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: p-titiano@ti.com

Remove the OMAP-specific PM debug 'sleep_while_idle' feature which is
currently available as an OMAP-specific debugfs entry.

This duplicates existing ARM-generic functionality available as a
boot-time option using the boot cmdline option 'hohlt'.

If runtime configuration of this is needed, then adding a debugfs
entry for the ARM-generic hlt/nohlt interface should be added.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c |    3 ---
 arch/arm/mach-omap2/pm.h       |    2 --
 arch/arm/mach-omap2/pm34xx.c   |    2 --
 3 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index a5a83b3..cf9bc15 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -40,7 +40,6 @@
 
 int omap2_pm_debug;
 u32 enable_off_mode;
-u32 sleep_while_idle;
 u32 wakeup_timer_seconds;
 u32 wakeup_timer_milliseconds;
 
@@ -639,8 +638,6 @@ static int __init pm_dbg_init(void)
 
 	(void) debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUSR, d,
 				   &enable_off_mode, &pm_dbg_option_fops);
-	(void) debugfs_create_file("sleep_while_idle", S_IRUGO | S_IWUSR, d,
-				   &sleep_while_idle, &pm_dbg_option_fops);
 	(void) debugfs_create_file("wakeup_timer_seconds", S_IRUGO | S_IWUSR, d,
 				   &wakeup_timer_seconds, &pm_dbg_option_fops);
 	(void) debugfs_create_file("wakeup_timer_milliseconds",
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 797bfd1..fc2377c 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -64,13 +64,11 @@ extern void omap2_pm_dump(int mode, int resume, unsigned int us);
 extern void omap2_pm_wakeup_on_timer(u32 seconds, u32 milliseconds);
 extern int omap2_pm_debug;
 extern u32 enable_off_mode;
-extern u32 sleep_while_idle;
 #else
 #define omap2_pm_dump(mode, resume, us)		do {} while (0);
 #define omap2_pm_wakeup_on_timer(seconds, milliseconds)	do {} while (0);
 #define omap2_pm_debug				0
 #define enable_off_mode 0
-#define sleep_while_idle 0
 #endif
 
 #if defined(CONFIG_CPU_IDLE)
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 0c5e3a4..991ade6 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -497,8 +497,6 @@ console_still_active:
 
 int omap3_can_sleep(void)
 {
-	if (!sleep_while_idle)
-		return 0;
 	if (!omap_uart_can_sleep())
 		return 0;
 	return 1;
-- 
1.7.4

