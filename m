From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/4] ARM: OMAP: Fix debugfs_create_*'s error checking method for arm/plat-omap
Date: Thu, 30 Oct 2008 19:11:16 -0700
Message-ID: <1225419078-32213-3-git-send-email-tony@atomide.com>
References: <1225419078-32213-1-git-send-email-tony@atomide.com>
 <1225419078-32213-2-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54039 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754446AbYJaCLX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 22:11:23 -0400
In-Reply-To: <1225419078-32213-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Zhaolei <zhaolei@cn.fujitsu.com>, Tony Lindgren <tony@atomide.com>

From: Zhaolei <zhaolei@cn.fujitsu.com>

debugfs_create_*() returns NULL if an error occurs, returns -ENODEV
when debugfs is not enabled in the kernel.

Comparing to PATCH v1, because clk_debugfs_init is included in
"#if defined CONFIG_DEBUG_FS", we only need to check NULL return.
Thanks Li Zefan <lizf@cn.fujitsu.com>

debugfs_create_u8() and other function's return value's checking method are
also fixed in this patch.

Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/clock.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index bf6a10c..be6aab9 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -428,23 +428,23 @@ static int clk_debugfs_register_one(struct clk *c)
 	if (c->id != 0)
 		sprintf(p, ":%d", c->id);
 	d = debugfs_create_dir(s, pa ? pa->dent : clk_debugfs_root);
-	if (IS_ERR(d))
-		return PTR_ERR(d);
+	if (!d)
+		return -ENOMEM;
 	c->dent = d;
 
 	d = debugfs_create_u8("usecount", S_IRUGO, c->dent, (u8 *)&c->usecount);
-	if (IS_ERR(d)) {
-		err = PTR_ERR(d);
+	if (!d) {
+		err = -ENOMEM;
 		goto err_out;
 	}
 	d = debugfs_create_u32("rate", S_IRUGO, c->dent, (u32 *)&c->rate);
-	if (IS_ERR(d)) {
-		err = PTR_ERR(d);
+	if (!d) {
+		err = -ENOMEM;
 		goto err_out;
 	}
 	d = debugfs_create_x32("flags", S_IRUGO, c->dent, (u32 *)&c->flags);
-	if (IS_ERR(d)) {
-		err = PTR_ERR(d);
+	if (!d) {
+		err = -ENOMEM;
 		goto err_out;
 	}
 	return 0;
@@ -483,8 +483,8 @@ static int __init clk_debugfs_init(void)
 	int err;
 
 	d = debugfs_create_dir("clock", NULL);
-	if (IS_ERR(d))
-		return PTR_ERR(d);
+	if (!d)
+		return -ENOMEM;
 	clk_debugfs_root = d;
 
 	list_for_each_entry(c, &clocks, node) {
-- 
1.5.6.rc3.21.g8c6b5

