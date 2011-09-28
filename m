From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v3 3/6] OMAP3+: use DPLL's round_rate when setting rate
Date: Wed, 28 Sep 2011 01:02:12 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109280059380.4399@utopia.booyaka.com>
References: <1316195281-14988-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60221 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927Ab1I1HCN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Sep 2011 03:02:13 -0400
In-Reply-To: <1316195281-14988-1-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>, Mike Turquette <mturquette@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

Hi,

On Fri, 16 Sep 2011, Jon Hunter wrote:

> From: Mike Turquette <mturquette@ti.com>
> 
> omap3_noncore_dpll_set_rate uses omap2_dpll_round_rate explicitly.  Instead
> use the struct clk pointer's round_rate function to allow for DPLL's with
> special needs.
> 
> Also the rounded rate can differ from target rate, so to better reflect
> reality set clk->rate equal to the rounded rate when setting DPLL frequency.
> This avoids issues where the DPLL frequency is slightly different than what
> debugfs clock tree reports using the old target rate.
> 
> An example of both of these needs is DPLL_ABE on OMAP4 which can have a 4x
> multiplier on top of the usual MN dividers depending on register settings.
> This requires a special round_rate function that might yield a rate
> different from the initial target.
> 
> Signed-off-by: Mike Turquette <mturquette@ti.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

The two separate changes in this patch have been separated out into two 
patches - both included below.  Please let me know if you have any 
comments; otherwise, I'll queue for 3.2.


- Paul

From: Mike Turquette <mturquette@ti.com>
Date: Wed, 28 Sep 2011 00:00:32 -0600
Subject: [PATCH] ARM: OMAP3+: dpll: use DPLL's round_rate when setting rate

omap3_noncore_dpll_set_rate uses omap2_dpll_round_rate explicitly.  Instead
use the struct clk pointer's round_rate function to allow for DPLL's with
special needs.

An example of a clock that requires this is DPLL_ABE on OMAP4 which
can have a 4x multiplier on top of the usual MN dividers depending on
register settings.  This requires a special round_rate function that
might yield a rate different from the initial target.

Signed-off-by: Mike Turquette <mturquette@ti.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
[paul@pwsan.com: split rate assignment portion into a separate patch]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index f77022b..6b0fa37 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -455,7 +455,7 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 			new_parent = dd->clk_bypass;
 	} else {
 		if (dd->last_rounded_rate != rate)
-			omap2_dpll_round_rate(clk, rate);
+			clk->round_rate(clk, rate);
 
 		if (dd->last_rounded_rate == 0)
 			return -EINVAL;
-- 
1.7.6.3


--------------------

From: Mike Turquette <mturquette@ti.com>
Date: Wed, 28 Sep 2011 00:00:32 -0600
Subject: [PATCH] ARM: OMAP3+: dpll: assign clk rate from rounded rate during
 rate set

The rounded rate can differ from target rate, so to better reflect
reality set clk->rate equal to the rounded rate when setting DPLL frequency.
This avoids issues where the DPLL frequency is slightly different than what
debugfs clock tree reports using the old target rate.

An example of a clock that requires this is DPLL_ABE on OMAP4 which
can have a 4x multiplier on top of the usual MN dividers depending on
register settings.  This requires a special round_rate function that
might yield a rate different from the initial target.

Signed-off-by: Mike Turquette <mturquette@ti.com>
Signed-off-by: Jon Hunter <jon-hunter@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 6b0fa37..73a1595 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -455,7 +455,7 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 			new_parent = dd->clk_bypass;
 	} else {
 		if (dd->last_rounded_rate != rate)
-			clk->round_rate(clk, rate);
+			rate = clk->round_rate(clk, rate);
 
 		if (dd->last_rounded_rate == 0)
 			return -EINVAL;
-- 
1.7.6.3

