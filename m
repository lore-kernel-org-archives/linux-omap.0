From: Tero Kristo <tero.kristo@nokia.com>
Subject: [PATCH 23/23] OMAP3: PM: Fix linker error without CONFIG_PM option
Date: Thu, 11 Dec 2008 17:52:42 +0200
Message-ID: <1229010762-3150-24-git-send-email-tero.kristo@nokia.com>
References: <>
 <1229010762-3150-1-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-2-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-3-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-4-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-5-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-6-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-7-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-8-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-9-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-10-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-11-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-12-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-13-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-14-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-15-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-16-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-17-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-18-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-19-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-20-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-21-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-22-git-send-email-tero.kristo@nokia.com>
 <1229010762-3150-23-git-send-email-tero.kristo@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:34972 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756221AbYLKP7T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 10:59:19 -0500
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mBBFx9rP021015
	for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 17:59:13 +0200
Received: from localhost.localdomain (sokoban.ntc.nokia.com [172.22.144.95])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id mBBFwci4011022
	for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 17:59:10 +0200
In-Reply-To: <1229010762-3150-23-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

omap3_save_scratchpad_contents() is not available without CONFIG_PM.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 55b1425..b38cb30 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -990,7 +990,9 @@ static int omap3_select_table_rate(struct clk *clk, unsigned long rate)
 		propagate_rate(&core_ck);
 	}
 
+#ifdef CONFIG_PM
 	omap3_save_scratchpad_contents();
+#endif
 
 	return 0;
 }
-- 
1.5.4.3

