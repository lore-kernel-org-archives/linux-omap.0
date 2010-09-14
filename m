From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/3] omap: pm-debug: Enable wakeup_timer_milliseconds debugfs entry
Date: Tue, 14 Sep 2010 19:25:47 +0530
Message-ID: <1284472548-32151-3-git-send-email-santosh.shilimkar@ti.com>
References: <1284472548-32151-1-git-send-email-santosh.shilimkar@ti.com>
 <1284472548-32151-2-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33806 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753655Ab0INNz5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Sep 2010 09:55:57 -0400
In-Reply-To: <1284472548-32151-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, rnayak@ti.com, b-cousson@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Commit 8e2efde9 added milliseconds suspend wakeup time support but
same interface is not exported through debugfs

This patch enables the debugfs hook for wakeup_timer_milliseconds

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm-debug.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 143266d..395763c 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -632,6 +632,9 @@ static int __init pm_dbg_init(void)
 				   &sleep_while_idle, &pm_dbg_option_fops);
 	(void) debugfs_create_file("wakeup_timer_seconds", S_IRUGO | S_IWUGO, d,
 				   &wakeup_timer_seconds, &pm_dbg_option_fops);
+	(void) debugfs_create_file("wakeup_timer_milliseconds",
+			S_IRUGO | S_IWUGO, d, &wakeup_timer_milliseconds,
+			&pm_dbg_option_fops);
 	pm_dbg_init_done = 1;
 
 	return 0;
-- 
1.6.0.4

