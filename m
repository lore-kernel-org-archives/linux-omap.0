From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP2+: clock: use clock's recalc in DPLL handling
Date: Thu, 29 Sep 2011 19:26:35 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109291925120.26728@utopia.booyaka.com>
References: <CAJOA=zPq__48SbsKeFHaQ_+J0YQYLLXBP67g2JGXknhWj7PNOA@mail.gmail.com> <1317343888-30892-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41664 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751961Ab1I3B0g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Sep 2011 21:26:36 -0400
In-Reply-To: <1317343888-30892-1-git-send-email-mturquette@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@ti.com>
Cc: jon-hunter@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

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

The conditional in the second hunk of this patch has been simplified for 
readability.  Updated patch below.  Please let me know if I screwed 
something up.  Otherwise, queued for 3.2 fixes.

thanks


- Paul

From: Mike Turquette <mturquette@ti.com>
Date: Thu, 29 Sep 2011 17:51:28 -0700
Subject: [PATCH] ARM: OMAP2+: clock: use clock's recalc in DPLL handling

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
[paul@pwsan.com: simplified conditional]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index f77022b..fe4533f 100644
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
@@ -425,6 +426,7 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 {
 	struct clk *new_parent = NULL;
 	u16 freqsel = 0;
+	unsigned long hw_rate;
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

