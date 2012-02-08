From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 13/14] ARM: OMAP3+: SmartReflex: fix the use of debugfs_create_* API
Date: Wed,  8 Feb 2012 18:43:58 +0100
Message-ID: <1328723039-15952-14-git-send-email-j-pihet@ti.com>
References: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55967 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756610Ab2BHRop (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 12:44:45 -0500
Received: by mail-ww0-f44.google.com with SMTP id dt10so853447wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 09:44:44 -0800 (PST)
In-Reply-To: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>
Cc: balbi@ti.com, nm@ti.com, Jean Pihet <j-pihet@ti.com>

The debugfs_create_* API returns a return code or NULL
in the return ptr in case of problem.
Fix the smartreflex code to take this into account.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index daf8053..f6b8f45 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -989,7 +989,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "%s: SmartReflex driver initialized\n", __func__);
 	if (!sr_dbg_dir) {
 		sr_dbg_dir = debugfs_create_dir("smartreflex", NULL);
-		if (!sr_dbg_dir) {
+		if (IS_ERR_OR_NULL(sr_dbg_dir)) {
 			ret = PTR_ERR(sr_dbg_dir);
 			pr_err("%s:sr debugfs dir creation failed(%d)\n",
 				__func__, ret);
@@ -1006,7 +1006,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	}
 	sr_info->dbg_dir = debugfs_create_dir(name, sr_dbg_dir);
 	kfree(name);
-	if (IS_ERR(sr_info->dbg_dir)) {
+	if (IS_ERR_OR_NULL(sr_info->dbg_dir)) {
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory\n",
 			__func__);
 		ret = PTR_ERR(sr_info->dbg_dir);
@@ -1023,7 +1023,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 			&sr_info->err_minlimit);
 
 	nvalue_dir = debugfs_create_dir("nvalue", sr_info->dbg_dir);
-	if (IS_ERR(nvalue_dir)) {
+	if (IS_ERR_OR_NULL(nvalue_dir)) {
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory"
 			"for n-values\n", __func__);
 		ret = PTR_ERR(nvalue_dir);
-- 
1.7.5.4

