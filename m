From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 06/10] omap: pm-debug: Enable wakeup_timer_milliseconds debugfs entry
Date: Wed, 15 Sep 2010 16:55:42 -0700
Message-ID: <1284594946-28963-7-git-send-email-khilman@deeprootsystems.com>
References: <1284594946-28963-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44824 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472Ab0IOX4B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Sep 2010 19:56:01 -0400
Received: by mail-gx0-f174.google.com with SMTP id 23so239006gxk.19
        for <linux-omap@vger.kernel.org>; Wed, 15 Sep 2010 16:56:01 -0700 (PDT)
In-Reply-To: <1284594946-28963-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: Santosh Shilimkar <santosh.shilimkar@ti.com>

Commit 8e2efde9 added milliseconds suspend wakeup time support but
same interface is not exported through debugfs

This patch enables the debugfs hook for wakeup_timer_milliseconds

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
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
1.7.2.1

