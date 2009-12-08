From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH] Smartreflex: Avoid unnecessary spam
Date: Tue,  8 Dec 2009 16:16:15 +0200
Message-ID: <1260281775-30361-1-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:57466 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755244AbZLHOTd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 09:19:33 -0500
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx03.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id nB8EJbdg000646
	for <linux-omap@vger.kernel.org>; Tue, 8 Dec 2009 16:19:37 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-da01.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id nB8EJXnS029608
	for <linux-omap@vger.kernel.org>; Tue, 8 Dec 2009 16:19:34 +0200
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

Current warning messages will be constantly printed out during normal operation
if smartreflex autocompensation is disabled.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index be3a1da..db228b2 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -675,13 +675,8 @@ void sr_start_vddautocomap(int srid, u32 target_opp_no)
 		sr_configure(sr);
 	}
 
-	if (sr->is_autocomp_active == 1)
-		pr_warning("SR%d: VDD autocomp is already active\n",
-									srid);
-
 	sr->is_autocomp_active = 1;
 	if (!sr_enable(sr, target_opp_no)) {
-		pr_warning("SR%d: VDD autocomp not activated\n", srid);
 		sr->is_autocomp_active = 0;
 		if (sr->is_sr_reset == 1)
 			sr_clk_disable(sr);
@@ -707,11 +702,8 @@ int sr_stop_vddautocomap(int srid)
 		/* Reset the volatage for current OPP */
 		sr_reset_voltage(srid);
 		return true;
-	} else {
-		pr_warning("SR%d: VDD autocomp is not active\n",
-								srid);
+	} else
 		return false;
-	}
 
 }
 EXPORT_SYMBOL(sr_stop_vddautocomap);
-- 
1.5.4.3

