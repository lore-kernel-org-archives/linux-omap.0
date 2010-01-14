From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 15/13] PM debug: Fix warning when no CONFIG_DEBUG_FS
Date: Thu, 14 Jan 2010 10:51:27 -0800
Message-ID: <1263495087-2104-1-git-send-email-khilman@deeprootsystems.com>
References: <1262973571-25796-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:50785 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282Ab0ANSve (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Jan 2010 13:51:34 -0500
Received: by pwj9 with SMTP id 9so256907pwj.21
        for <linux-omap@vger.kernel.org>; Thu, 14 Jan 2010 10:51:32 -0800 (PST)
In-Reply-To: <1262973571-25796-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Aguirre, Sergio" <saaguirre@ti.com>

From: Aguirre, Sergio <saaguirre@ti.com>

>From ec3f04ec8cf4851fceb249acf832755b7aad1766 Mon Sep 17 00:00:00 2001
From: Sergio Aguirre <saaguirre@ti.com>
Date: Thu, 14 Jan 2010 11:01:15 -0600
Subject: [PATCH] PM debug: Fix warning when no CONFIG_DEBUG_FS

Fix following warning when CONFIG_DEBUG_FS wasn't selected:

arch/arm/mach-omap2/pm-debug.c:57: warning: 'pm_dbg_init' declared 'static' but never defined

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
OK, this should be the last of the PM fixes for this round.

 arch/arm/mach-omap2/pm-debug.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 562d190..a086626 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -54,8 +54,6 @@ int omap2_pm_debug;
 	regs[reg_count++].val = \
 			 __raw_readl(OMAP2_L4_IO_ADDRESS(0x480fe000 + (off)))
 
-static int __init pm_dbg_init(void);
-
 void omap2_pm_dump(int mode, int resume, unsigned int us)
 {
 	struct reg {
@@ -167,6 +165,8 @@ struct dentry *pm_dbg_dir;
 
 static int pm_dbg_init_done;
 
+static int __init pm_dbg_init(void);
+
 enum {
 	DEBUG_FILE_COUNTERS = 0,
 	DEBUG_FILE_TIMERS,
-- 
1.6.6

