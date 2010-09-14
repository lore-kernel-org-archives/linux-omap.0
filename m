From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 2/3 v2] omap: pm-debug: Enable wakeup_timer_milliseconds debugfs entry
Date: Wed, 15 Sep 2010 01:04:00 +0530
Message-ID: <1284492841-14858-3-git-send-email-santosh.shilimkar@ti.com>
References: <1284492841-14858-1-git-send-email-santosh.shilimkar@ti.com>
 <1284492841-14858-2-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43915 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754805Ab0INTeK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Sep 2010 15:34:10 -0400
In-Reply-To: <1284492841-14858-2-git-send-email-santosh.shilimkar@ti.com>
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
index 655f9df..af00c17 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -638,6 +638,9 @@ static int __init pm_dbg_init(void)
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

