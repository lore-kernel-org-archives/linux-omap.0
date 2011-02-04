From: Vasiliy Kulikov <segoon@openwall.com>
Subject: [PATCH 02/20] mach-omap2: pm: world-writable debugfs timer files
Date: Fri,  4 Feb 2011 15:23:16 +0300
Message-ID: <aabede4db6c913bc7ab7c289d09eb272594e2290.1296818921.git.segoon@openwall.com>
References: <cover.1296818921.git.segoon@openwall.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:32973 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535Ab1BDMXU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Feb 2011 07:23:20 -0500
In-Reply-To: <cover.1296818921.git.segoon@openwall.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: security@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Don't allow all users to change timer settings.

Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
---
 Cannot compile the driver, so it is not tested at all.

 arch/arm/mach-omap2/pm-debug.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 125f565..a5a83b3 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -637,14 +637,14 @@ static int __init pm_dbg_init(void)
 
 		}
 
-	(void) debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUGO, d,
+	(void) debugfs_create_file("enable_off_mode", S_IRUGO | S_IWUSR, d,
 				   &enable_off_mode, &pm_dbg_option_fops);
-	(void) debugfs_create_file("sleep_while_idle", S_IRUGO | S_IWUGO, d,
+	(void) debugfs_create_file("sleep_while_idle", S_IRUGO | S_IWUSR, d,
 				   &sleep_while_idle, &pm_dbg_option_fops);
-	(void) debugfs_create_file("wakeup_timer_seconds", S_IRUGO | S_IWUGO, d,
+	(void) debugfs_create_file("wakeup_timer_seconds", S_IRUGO | S_IWUSR, d,
 				   &wakeup_timer_seconds, &pm_dbg_option_fops);
 	(void) debugfs_create_file("wakeup_timer_milliseconds",
-			S_IRUGO | S_IWUGO, d, &wakeup_timer_milliseconds,
+			S_IRUGO | S_IWUSR, d, &wakeup_timer_milliseconds,
 			&pm_dbg_option_fops);
 	pm_dbg_init_done = 1;
 
-- 
1.7.0.4

