From: Phil Carmody <ext-phil.2.carmody@nokia.com>
Subject: [PATCH 1/2] OMAP3: PM: Don't do unnecessary searches in omap_sr_vdd*_autocomp_store
Date: Mon, 27 Apr 2009 19:26:24 +0300
Message-ID: <9ba9fdeeec0cd47fdcff6b689d2196665ea8bcbf.1240849197.git.ext-phil.2.carmody@nokia.com>
References: <>
 <1240849585-14828-1-git-send-email-ext-phil.2.carmody@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:54415 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423AbZD0QZy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 27 Apr 2009 12:25:54 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n3RGPY99008383
	for <linux-omap@vger.kernel.org>; Mon, 27 Apr 2009 19:25:48 +0300
In-Reply-To: <1240849585-14828-1-git-send-email-ext-phil.2.carmody@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Phil Carmody <ext-phil.2.carmody@nokia.com>

From: Phil Carmody <ext-phil.2.carmody@nokia.com>

When setting to 0, we don't need to do searches for the resource by
its name. In the case where we do search, handle the error condition
cleanly.

Signed-off-by: Phil Carmody <ext-phil.2.carmody@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index ae5c336..ce7d436 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -744,7 +744,6 @@ static ssize_t omap_sr_vdd1_autocomp_store(struct kobject *kobj,
 					struct kobj_attribute *attr,
 					const char *buf, size_t n)
 {
-	u32 current_vdd1opp_no;
 	unsigned short value;
 
 	if (sscanf(buf, "%hu", &value) != 1 || (value > 1)) {
@@ -752,13 +751,14 @@ static ssize_t omap_sr_vdd1_autocomp_store(struct kobject *kobj,
 		return -EINVAL;
 	}
 
-	current_vdd1opp_no = omap_pm_vdd1_get_opp();
-
-	if (value == 0)
+	if (value == 0) {
 		sr_stop_vddautocomap(SR1);
-	else
+	} else {
+		u32 current_vdd1opp_no = omap_pm_vdd1_get_opp();
+		if (IS_ERR_VALUE(current_vdd1opp_no))
+			return -ENODEV;
 		sr_start_vddautocomap(SR1, current_vdd1opp_no);
-
+	}
 	return n;
 }
 
@@ -782,7 +782,6 @@ static ssize_t omap_sr_vdd2_autocomp_store(struct kobject *kobj,
 					struct kobj_attribute *attr,
 					const char *buf, size_t n)
 {
-	u32 current_vdd2opp_no;
 	unsigned short value;
 
 	if (sscanf(buf, "%hu", &value) != 1 || (value > 1)) {
@@ -790,13 +789,14 @@ static ssize_t omap_sr_vdd2_autocomp_store(struct kobject *kobj,
 		return -EINVAL;
 	}
 
-	current_vdd2opp_no = omap_pm_vdd2_get_opp();
-
-	if (value == 0)
+	if (value == 0) {
 		sr_stop_vddautocomap(SR2);
-	else
+	} else {
+		u32 current_vdd2opp_no = omap_pm_vdd2_get_opp();
+		if (IS_ERR_VALUE(current_vdd2opp_no))
+			return -ENODEV;
 		sr_start_vddautocomap(SR2, current_vdd2opp_no);
-
+	}
 	return n;
 }
 
-- 
1.5.4.3

