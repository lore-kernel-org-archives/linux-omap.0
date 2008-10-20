From: Mans Rullgard <mans@mansr.com>
Subject: [PATCH 1/2] OMAP: Make dpll4_m4_ck programmable with clk_set_rate()
Date: Tue, 21 Oct 2008 00:24:23 +0100
Message-ID: <1224545064-25551-1-git-send-email-mans@mansr.com>
References: <yw1xhc76hmvi.fsf@thrashbarg.mansr.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from agrajag.mansr.com ([78.86.181.102]:33084 "EHLO mail.mansr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753AbYJTXY0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 Oct 2008 19:24:26 -0400
Received: from thrashbarg.mansr.com (thrashbarg.mansr.com [78.86.181.100])
	by mail.mansr.com (Postfix) with ESMTP id 7B98D1C0089
	for <linux-omap@vger.kernel.org>; Tue, 21 Oct 2008 00:24:24 +0100 (BST)
In-Reply-To: <yw1xhc76hmvi.fsf@thrashbarg.mansr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Filling the set_rate and round_rate fields of dpll4_m4_ck makes
this clock programmable through clk_set_rate().  This is needed
to give omapfb control over the dss1_alwon_fck rate.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 arch/arm/mach-omap2/clock34xx.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 4adf78e..e51e182 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -875,6 +875,8 @@ static struct clk dpll4_m6_ck = {
 				PARENT_CONTROLS_CLOCK,
 	.clkdm		= { .name = "dpll4_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
+	.set_rate	= &omap2_clksel_set_rate,
+	.round_rate	= &omap2_clksel_round_rate,
 };
 
 /* The PWRDN bit is apparently only available on 3430ES2 and above */
-- 
1.6.0.2

