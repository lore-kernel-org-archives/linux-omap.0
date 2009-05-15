From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: [PATCH] OMAP3: PM: Fix Smartreflex when used with PM_NOOP layer
Date: Fri, 15 May 2009 14:55:47 +0300
Message-ID: <1242388547-4241-1-git-send-email-ext-roger.quadros@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:54764 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753198AbZEOL52 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 May 2009 07:57:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, ext-phil.2.carmody@nokia.com

omap_pm_vddX_get_opp() returns 0 if PM layer is PM_NOOP or PM_NONE.
This is not a valid OPP so we must sanity check this correctly before using.

This patch fixes system lockup when we enable smartreflex
"echo 1 > /sys/power/sr_vdd1_autocomp"

Signed-off-by: Roger Quadros <ext-roger.quadros@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 42e16a6..b032366 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -787,8 +787,10 @@ static ssize_t omap_sr_vdd1_autocomp_store(struct kobject *kobj,
 		sr_stop_vddautocomap(SR1);
 	} else {
 		u32 current_vdd1opp_no = omap_pm_vdd1_get_opp();
-		if (IS_ERR_VALUE(current_vdd1opp_no))
-			return -ENODEV;
+		if (!current_vdd1opp_no) {
+			pr_err("sr_vdd1_autocomp: Current VDD1 opp unknown\n");
+			return -EINVAL;
+		}
 		sr_start_vddautocomap(SR1, current_vdd1opp_no);
 	}
 	return n;
@@ -825,8 +827,10 @@ static ssize_t omap_sr_vdd2_autocomp_store(struct kobject *kobj,
 		sr_stop_vddautocomap(SR2);
 	} else {
 		u32 current_vdd2opp_no = omap_pm_vdd2_get_opp();
-		if (IS_ERR_VALUE(current_vdd2opp_no))
-			return -ENODEV;
+		if (!current_vdd2opp_no) {
+			pr_err("sr_vdd2_autocomp: Current VDD2 opp unknown\n");
+			return -EINVAL;
+		}
 		sr_start_vddautocomap(SR2, current_vdd2opp_no);
 	}
 	return n;
-- 
1.6.0.4

