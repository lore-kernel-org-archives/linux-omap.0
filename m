From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 1/1] Save sram context after changing MPU, DSP or core clocks
Date: Wed, 19 Nov 2008 13:45:27 +0200
Message-ID: <1227095127-7158-2-git-send-email-peter.de-schrijver@nokia.com>
References: <1227095127-7158-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:26555 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbYKSLpf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Nov 2008 06:45:35 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAJBjHF1003580
	for <linux-omap@vger.kernel.org>; Wed, 19 Nov 2008 05:45:32 -0600
In-Reply-To: <1227095127-7158-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/clock34xx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index d97d5a9..962ce56 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -911,6 +911,9 @@ printk("%s set to %luHz intended rate %luHz\n",dpll2_clk->name,clk_get_rate(dpll
 		clk_set_rate(dpll3_clk, prcm_vdd->rate);
 		curr_vdd2_prcm_set = prcm_vdd;
 	}
+
+	omap3_save_scratchpad_contents();
+
 	return 0;
 }
 
-- 
1.5.6.3

