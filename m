From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH] OMAP2+: clock: use clock's recalc in DPLL handling
Date: Thu, 29 Sep 2011 17:51:28 -0700
Message-ID: <1317343888-30892-1-git-send-email-mturquette@ti.com>
References: <CAJOA=zPq__48SbsKeFHaQ_+J0YQYLLXBP67g2JGXknhWj7PNOA@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:33402 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751154Ab1I3Axb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Sep 2011 20:53:31 -0400
Received: by mail-yx0-f173.google.com with SMTP id 11so1522286yxl.18
        for <linux-omap@vger.kernel.org>; Thu, 29 Sep 2011 17:53:30 -0700 (PDT)
In-Reply-To: <CAJOA=zPq__48SbsKeFHaQ_+J0YQYLLXBP67g2JGXknhWj7PNOA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@ti.com>

Not all DPLLs are identical; some require special consideration such as
OMAP4's ABE DPLL, which can have an additional 4x multiplier added to
it's clock rate based on programming the REGM4XEN bit in it's CLKMODE
register.

Unfortunately the clock framework makes a few assumptions that all DPLLs
can have their rates calculated the same way which has led to incorrect
rates for OMAP4's DPLL_ABE in some cases.  This patch fixes the same by
replacing explicit calls to omap2_dpll_get_rate with clk->recalc if
.recalc is populated for a clock.  If .recalc is NULL then fall back to
omap2_dpll_get_rate.

Reported-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Mike Turquette <mturquette@ti.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index f77022b..193868d 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -390,7 +390,8 @@ int omap3_noncore_dpll_enable(struct clk *clk)
 	 * propagating?
 	 */
 	if (!r)
-		clk->rate = omap2_get_dpll_rate(clk);
+		clk->rate = (clk->recalc) ? clk->recalc(clk) :
+			omap2_get_dpll_rate(clk);
 
 	return r;
 }
@@ -435,7 +436,8 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 	if (!dd)
 		return -EINVAL;
 
-	if (rate == omap2_get_dpll_rate(clk))
+	if (rate == ((clk->recalc) ? clk->recalc(clk) :
+				omap2_get_dpll_rate(clk)))
 		return 0;
 
 	/*
-- 
1.7.4.1

