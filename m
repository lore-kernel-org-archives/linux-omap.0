From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 12/19] OMAP3 clock: Remove FreqSel for 3630
Date: Tue, 16 Feb 2010 11:10:38 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1002161108010.28188@utopia.booyaka.com>
References: <20100216011942.1101.14348.stgit@localhost.localdomain> <20100216012453.1101.96664.stgit@localhost.localdomain> <4B7A7AB7.90503@ru.mvista.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45254 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932719Ab0BPSKj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Feb 2010 13:10:39 -0500
In-Reply-To: <4B7A7AB7.90503@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vishwanath BS <vishwanath.bs@ti.com>

Hello Sergei,

On Tue, 16 Feb 2010, Sergei Shtylyov wrote:

> Paul Walmsley wrote:
> 
> > From: Vishwanath BS <vishwanath.bs@ti.com>
> > 
> > diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
> > index 2b559fc..84be81c 100644
> > --- a/arch/arm/mach-omap2/dpll3xxx.c
> > +++ b/arch/arm/mach-omap2/dpll3xxx.c
> > @@ -243,8 +243,11 @@ static int omap3_noncore_dpll_program(struct clk *clk,
> > u16 m, u8 n, u16 freqsel)
> >  	/* 3430 ES2 TRM: 4.7.6.9 DPLL Programming Sequence */
> >  	_omap3_noncore_dpll_bypass(clk);
> >  -	/* Set jitter correction */
> > -	if (!cpu_is_omap44xx()) {
> > +	/*
> > +	 * Set jitter correction. No jitter correction for OMAP4 and 3630
> > +	 * since freqsel is field is no longer present
> >   
> 
>   I can't parse that comment. I guess first "is" is not needed. :-)

Thanks Sergei; fixed in the for_2.6.34_dev branch; revised branch below.


- Paul

From: Vishwanath BS <vishwanath.bs@ti.com>
Date: Fri, 12 Feb 2010 14:25:04 -0700
Subject: [PATCH] OMAP3 clock: Remove FreqSel for 3630

DPLL_FREQSEL field in CLKEN_PLL register is no longer valid for
OMAP3630. So remove references to that.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>
[paul@pwsan.com: added comment fix from Sergei Shtylyov]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/dpll3xxx.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 2b559fc..68268cd 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -243,8 +243,11 @@ static int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
 	/* 3430 ES2 TRM: 4.7.6.9 DPLL Programming Sequence */
 	_omap3_noncore_dpll_bypass(clk);
 
-	/* Set jitter correction */
-	if (!cpu_is_omap44xx()) {
+	/*
+	 * Set jitter correction. No jitter correction for OMAP4 and 3630
+	 * since freqsel field is no longer present
+	 */
+	if (!cpu_is_omap44xx() && !cpu_is_omap3630()) {
 		v = __raw_readl(dd->control_reg);
 		v &= ~dd->freqsel_mask;
 		v |= freqsel << __ffs(dd->freqsel_mask);
@@ -387,8 +390,8 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 		if (dd->last_rounded_rate == 0)
 			return -EINVAL;
 
-		/* No freqsel on OMAP4 */
-		if (!cpu_is_omap44xx()) {
+		/* No freqsel on OMAP4 and OMAP3630 */
+		if (!cpu_is_omap44xx() && !cpu_is_omap3630()) {
 			freqsel = _omap3_dpll_compute_freqsel(clk,
 						dd->last_rounded_n);
 			if (!freqsel)
-- 
1.6.6.GIT

