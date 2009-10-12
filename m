From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] OMAP3 PM Add sysfs entry for EFuse values
Date: Mon, 12 Oct 2009 17:48:10 +0300
Message-ID: <1255358890-9434-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:23010 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932363AbZJLOtz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Oct 2009 10:49:55 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n9CEm19x016067
	for <linux-omap@vger.kernel.org>; Mon, 12 Oct 2009 17:48:25 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch exports the smartreflex efuse values for all 5 OPPs via
sysfs. This can be useful to track down silicon specific problems.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 9fa033d..3c506d1 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -759,7 +759,24 @@ static struct kobj_attribute sr_vdd2_autocomp = {
 	.store = omap_sr_vdd2_autocomp_store,
 };
 
+static ssize_t omap_sr_opp1_efuse_show(struct kobject *kobj,
+					struct kobj_attribute *attr,
+					char *buf)
+{
+	return sprintf(buf, "%08x\n%08x\n%08x\n%08x\n%08x\n", sr1.opp1_nvalue,
+							sr1.opp2_nvalue,
+							sr1.opp3_nvalue,
+							sr1.opp4_nvalue,
+							sr1.opp5_nvalue);
+}
 
+static struct kobj_attribute sr_efuse = {
+	.attr = {
+	.name = "Efuse",
+	.mode = 0444,
+	},
+	.show = omap_sr_opp1_efuse_show,
+};
 
 static int __init omap3_sr_init(void)
 {
@@ -807,6 +824,11 @@ static int __init omap3_sr_init(void)
 	if (ret)
 		printk(KERN_ERR "sysfs_create_file failed: %d\n", ret);
 
+	ret = sysfs_create_file(power_kobj, &sr_efuse.attr);
+	if (ret)
+		printk(KERN_ERR "sysfs_create_file failed for OPP data: %d\n",
+			ret);
+
 	return 0;
 }
 
-- 
1.6.2.4

