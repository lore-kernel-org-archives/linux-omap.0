From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 6/8] OMAP3: PM: Fix linker error without CONFIG_PM option
Date: Fri,  9 Jan 2009 17:49:06 +0200
Message-ID: <1231516148-10260-7-git-send-email-tero.kristo@nokia.com>
References: <>
 <1231516148-10260-1-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-2-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-3-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-4-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-5-git-send-email-tero.kristo@nokia.com>
 <1231516148-10260-6-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:49412 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbZAIP7d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jan 2009 10:59:33 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n09Fx2tO016997
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 17:59:30 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int02.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n09FwtlP031435
	for <linux-omap@vger.kernel.org>; Fri, 9 Jan 2009 17:59:04 +0200
In-Reply-To: <1231516148-10260-6-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

omap3_save_scratchpad_contents() is not available without CONFIG_PM.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 8b375a9..6c5254c 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -1007,7 +1007,9 @@ static int omap3_select_table_rate(struct clk *clk, unsigned long rate)
 		curr_vdd2_prcm_set = prcm_vdd;
 	}
 
+#ifdef CONFIG_PM
 	omap3_save_scratchpad_contents();
+#endif
 
 	return 0;
 }
-- 
1.5.4.3

