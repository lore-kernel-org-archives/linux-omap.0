From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Subject: The pm_dbg_init() print does not look like something useful, probably
Date: Thu,  9 Jul 2009 16:23:36 +0300
Message-ID: <1247145816-12586-1-git-send-email-Artem.Bityutskiy@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:60572 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756285AbZGILdS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Jul 2009 07:33:18 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Artem Bityutskiy <Artem.Bityutskiy@nokia.com>

Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
---
 arch/arm/mach-omap2/pm-debug.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 2768510..33cc6b9 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -526,8 +526,6 @@ static int __init pm_dbg_init(void)
 	struct dentry *d;
 	char name[2];
 
-	printk(KERN_INFO "pm_dbg_init()\n");
-
 	d = debugfs_create_dir("pm_debug", NULL);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
-- 
1.6.0.6

