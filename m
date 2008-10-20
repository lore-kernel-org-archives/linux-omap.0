From: Grazvydas Ignotas <notasas@gmail.com>
Subject: About EHCI
Date: Mon, 20 Oct 2008 22:40:51 +0300
Message-ID: <1224531651-31926-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.184]:8102 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111AbYJTTl4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Oct 2008 15:41:56 -0400
Received: by gv-out-0910.google.com with SMTP id e6so363102gvc.37
        for <linux-omap@vger.kernel.org>; Mon, 20 Oct 2008 12:41:02 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Grazvydas Ignotas <notasas@gmail.com>

It might already be known, but reverting the following commit
brings EHCI back to life (at least on Pandora):


commit 8b1f0bd44fe490ec631230c8c040753a2bda8caa
Author: Paul Walmsley <paul@pwsan.com>
Date:   Thu Sep 25 08:38:46 2008 -0600

OMAP3 clock: put DPLL into bypass if bypass rate = clk->rate, not hardware rate

[...]

---
 arch/arm/mach-omap2/clock34xx.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index c89d6bc..df258f7 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -281,9 +281,7 @@ static int omap3_noncore_dpll_enable(struct clk *clk)
 	if (!dd)
 		return -EINVAL;
 
-	rate = omap2_get_dpll_rate(clk);
-
-	if (dd->bypass_clk->rate == rate)
+	if (clk->rate == dd->bypass_clk->rate)
 		r = _omap3_noncore_dpll_bypass(clk);
 	else
 		r = _omap3_noncore_dpll_lock(clk);

