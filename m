From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP2+: clock: use clock's recalc in DPLL handling
Date: Fri, 7 Oct 2011 01:07:56 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1110070104260.4611@utopia.booyaka.com>
References: <CAJOA=zPq__48SbsKeFHaQ_+J0YQYLLXBP67g2JGXknhWj7PNOA@mail.gmail.com> <1317343888-30892-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:42702 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756902Ab1JGHH5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Oct 2011 03:07:57 -0400
In-Reply-To: <1317343888-30892-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>, jon-hunter@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 29 Sep 2011, Mike Turquette wrote:

> Not all DPLLs are identical; some require special consideration such as
> OMAP4's ABE DPLL, which can have an additional 4x multiplier added to
> it's clock rate based on programming the REGM4XEN bit in it's CLKMODE
> register.
> 
> Unfortunately the clock framework makes a few assumptions that all DPLLs
> can have their rates calculated the same way which has led to incorrect
> rates for OMAP4's DPLL_ABE in some cases.  This patch fixes the same by
> replacing explicit calls to omap2_dpll_get_rate with clk->recalc if
> .recalc is populated for a clock.  If .recalc is NULL then fall back to
> omap2_dpll_get_rate.
> 
> Reported-by: Misael Lopez Cruz <misael.lopez@ti.com>
> Signed-off-by: Mike Turquette <mturquette@ti.com>

I've merged this patch with Jon's "ARM: OMAP3+: dpll: use DPLLs recalc 
function instead of omap2_get_dpll_rate" patch, which does almost exactly 
the same thing, just without the conditionals on clk->recalc.  Updated 
patch below.  Please let me know if you think I should change anything 
about the changelog.


- Paul

From: Jon Hunter <jon-hunter@ti.com>
Date: Fri, 7 Oct 2011 00:53:01 -0600
Subject: [PATCH] ARM: OMAP3+: dpll: use DPLLs recalc function instead of
 omap2_get_dpll_rate

This is a continuation of Mike Turquette's patch "OMAP3+: use
DPLL's round_rate when setting rate".

omap3_noncore_dpll_set_rate() and omap3_noncore_dpll_enable() call
omap2_get_dpll_rate() explicitly. It may be necessary for some
DPLLs to use a different function and so use the DPLLs recalc()
function pointer instead.

An example is the DPLL_ABE on OMAP4 which can have a 4X multiplier
in addition to the usual MN multipler and dividers and therefore
uses a different round_rate and recalc function.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Cc: Mike Turquette <mturquette@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>
[paul@pwsan.com: merged this patch with Mike's "use clock's recalc in DPLL
 handling" patch; also reported by Misael]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 73a1595..fc56745 100644
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
@@ -424,6 +425,7 @@ void omap3_noncore_dpll_disable(struct clk *clk)
 int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 {
 	struct clk *new_parent = NULL;
+	unsigned long hw_rate;
 	u16 freqsel = 0;
 	struct dpll_data *dd;
 	int ret;
@@ -435,7 +437,8 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 	if (!dd)
 		return -EINVAL;
 
-	if (rate == omap2_get_dpll_rate(clk))
+	hw_rate = (clk->recalc) ? clk->recalc(clk) : omap2_get_dpll_rate(clk);
+	if (rate == hw_rate)
 		return 0;
 
 	/*
-- 
1.7.6.3

