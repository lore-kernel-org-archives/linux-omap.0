From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 19/20] ARM: OMAP3+: SmartReflex: fix the use of debugfs_create_* API
Date: Wed,  1 Feb 2012 09:49:58 +0100
Message-ID: <1328086199-28486-20-git-send-email-j-pihet@ti.com>
References: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:45673 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab2BAIuu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 03:50:50 -0500
Received: by mail-wi0-f174.google.com with SMTP id s10so697604wic.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Feb 2012 00:50:50 -0800 (PST)
In-Reply-To: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

The debugfs_create_* API returns a return code or NULL
in the return ptr in case of problem.
Fix the smartreflex code to take this into account.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 2fe882f..96a97c1 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1168,7 +1168,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	dev_info(&pdev->dev, "%s: SmartReflex driver initialized\n", __func__);
 	if (!sr_dbg_dir) {
 		sr_dbg_dir = debugfs_create_dir("smartreflex", NULL);
-		if (!sr_dbg_dir) {
+		if (IS_ERR_OR_NULL(sr_dbg_dir)) {
 			ret = PTR_ERR(sr_dbg_dir);
 			pr_err("%s:sr debugfs dir creation failed(%d)\n",
 				__func__, ret);
@@ -1185,7 +1185,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	}
 	sr_info->dbg_dir = debugfs_create_dir(name, sr_dbg_dir);
 	kfree(name);
-	if (IS_ERR(sr_info->dbg_dir)) {
+	if (IS_ERR_OR_NULL(sr_info->dbg_dir)) {
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory\n",
 			__func__);
 		ret = PTR_ERR(sr_info->dbg_dir);
@@ -1202,7 +1202,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 			&sr_info->err_minlimit);
 
 	nvalue_dir = debugfs_create_dir("nvalue", sr_info->dbg_dir);
-	if (IS_ERR(nvalue_dir)) {
+	if (IS_ERR_OR_NULL(nvalue_dir)) {
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory"
 			"for n-values\n", __func__);
 		ret = PTR_ERR(nvalue_dir);
-- 
1.7.5.4

