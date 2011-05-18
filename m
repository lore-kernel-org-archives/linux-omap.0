From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP/voltdm_c][PATCH 01/11] OMAP3+: PM: SR: fix debugfs
Date: Wed, 18 May 2011 00:17:24 -0500
Message-ID: <1305695854-9638-2-git-send-email-nm@ti.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44508 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138Ab1ERFRk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 May 2011 01:17:40 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4I5HeSE005407
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:40 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p4I5Hd2Q002957
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:39 -0500 (CDT)
In-Reply-To: <1305695854-9638-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kevin <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

Kevin's patch:
OMAP3+: voltage: remove unneeded debugfs interface

broke SR autocomp enablement - autocomps for all domains are
created now in debugfs/smartreflex instead of debugfs/smartreflex/domain
causing SR not to work.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   21 ++++++++++++++++++++-
 1 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index b100661..372b935 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -62,6 +62,7 @@ static LIST_HEAD(sr_list);
 
 static struct omap_sr_class_data *sr_class;
 static struct omap_sr_pmic_data *sr_pmic_data;
+static struct dentry		*sr_dbg_dir;
 
 static inline void sr_write_reg(struct omap_sr *sr, unsigned offset, u32 value)
 {
@@ -829,6 +830,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	struct dentry *nvalue_dir;
 	struct omap_volt_data *volt_data;
 	int i, ret = 0;
+	char *name;
 
 	if (!sr_info) {
 		dev_err(&pdev->dev, "%s: unable to allocate sr_info\n",
@@ -898,8 +900,25 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 	}
 
 	dev_info(&pdev->dev, "%s: SmartReflex driver initialized\n", __func__);
+	if (!sr_dbg_dir) {
+		sr_dbg_dir = debugfs_create_dir("smartreflex", NULL);
+		if (!sr_dbg_dir) {
+			ret = PTR_ERR(sr_dbg_dir);
+			pr_err("%s:sr debugfs dir creation failed(%d)\n",
+				__func__, ret);
+			goto err_iounmap;
+		}
+	}
 
-	sr_info->dbg_dir = debugfs_create_dir("smartreflex", NULL);
+	name = kasprintf(GFP_KERNEL, "sr_%s", sr_info->voltdm->name);
+	if (!name) {
+		dev_err(&pdev->dev, "%s: Unable to alloc debugfs name\n",
+			__func__);
+		ret = -ENOMEM;
+		goto err_iounmap;
+	}
+	sr_info->dbg_dir = debugfs_create_dir(name, sr_dbg_dir);
+	kfree(name);
 	if (IS_ERR(sr_info->dbg_dir)) {
 		dev_err(&pdev->dev, "%s: Unable to create debugfs directory\n",
 			__func__);
-- 
1.7.0.4

