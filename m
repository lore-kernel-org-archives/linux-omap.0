From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 19/19] ARM: OMAP3+: SmartReflex: fix the use of debugfs_create_* API
Date: Tue, 31 Jan 2012 10:58:32 +0100
Message-ID: <1328003912-11709-20-git-send-email-j-pihet@ti.com>
References: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:61170 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753859Ab2AaJ70 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 04:59:26 -0500
Received: by mail-wi0-f174.google.com with SMTP id s10so4219621wic.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 01:59:25 -0800 (PST)
In-Reply-To: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

The debugfs_create_* API returns a NULL ptr in case of problem.
Fix the smartreflex code to take this into account.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 2fe882f..a9afaf7 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1169,7 +1169,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	if (!sr_dbg_dir) {
 		sr_dbg_dir = debugfs_create_dir("smartreflex", NULL);
 		if (!sr_dbg_dir) {
-			ret = PTR_ERR(sr_dbg_dir);
+			ret = -ENOMEM;
 			pr_err("%s:sr debugfs dir creation failed(%d)\n",
 				__func__, ret);
 			goto err_iounmap;
@@ -1185,10 +1185,10 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	}
 	sr_info->dbg_dir = debugfs_create_dir(name, sr_dbg_dir);
 	kfree(name);
-	if (IS_ERR(sr_info->dbg_dir)) {
+	if (!sr_info->dbg_dir) {
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory\n",
 			__func__);
-		ret = PTR_ERR(sr_info->dbg_dir);
+		ret = -ENOMEM;
 		goto err_iounmap;
 	}
 
@@ -1202,10 +1202,10 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 			&sr_info->err_minlimit);
 
 	nvalue_dir = debugfs_create_dir("nvalue", sr_info->dbg_dir);
-	if (IS_ERR(nvalue_dir)) {
+	if (!nvalue_dir) {
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory"
 			"for n-values\n", __func__);
-		ret = PTR_ERR(nvalue_dir);
+		ret = -ENOMEM;
 		goto err_debugfs;
 	}
 
-- 
1.7.5.4

