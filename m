From: Paul Walmsley <paul@booyaka.com>
Subject: Re: status of USB on omap35xx ?
Date: Thu, 11 Dec 2008 09:49:40 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812110947000.26754@utopia.booyaka.com>
References: <1228870250.32014.148.camel@localhost.localdomain>  <1228926833.32014.162.camel@localhost.localdomain>  <20081210174030.GD9799@frodo> <200812101028.25235.david-b@pacbell.net>  <5e088bd90812101502r1d01880co3d54e99982db3589@mail.gmail.com>
 <20081211005733.GZ18138@atomide.com> <6ed0b2680812110238w130d708j615c3d7e0a381f24@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49512 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757342AbYLKQtl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 11:49:41 -0500
In-Reply-To: <6ed0b2680812110238w130d708j615c3d7e0a381f24@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Steve Sakoman <sakoman@gmail.com>, David Brownell <david-b@pacbell.net>, me@felipebalbi.com, Jeff Steele <jsteele@coloradocollege.edu>, linux-omap <linux-omap@vger.kernel.org>

Hi Grazvydas, Steve,

On Thu, 11 Dec 2008, Grazvydas Ignotas wrote:

> > Can you please post whatever patches you need to apply to make it work
> > occasionally so others can also look at the issue?
> 
> For pandora, making infinite while loops finite doesn't help much,
> kernel crashes later on. Steve had this too:
> http://marc.info/?l=linux-omap&m=122378604027303&w=2
> 
> I did bisect and found that commit
> 8b1f0bd44fe490ec631230c8c040753a2bda8caa is causing the hang for me.
> Reverting this makes EHCI work again on pandora.
> http://marc.info/?l=linux-omap&m=122453174024860&w=2

Would one of you be willing to run with this patch and send back any debug 
output relating to dpll5_ck ?  (Unfortunately, I don't have access to any 
boards with EHCI hardware, so cannot try it myself)

This will help determine what fix should be applied


- Paul



Add debugging in omap3_noncore_dpll_enable() - for testing only.

---
 arch/arm/mach-omap2/clock34xx.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 2c655be..3b80667 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -275,6 +275,10 @@ static int omap3_noncore_dpll_enable(struct clk *clk)
 	if (!dd)
 		return -EINVAL;
 
+	pr_info("clock: %s: clk->rate = %ld, hdwr rate = %d, parent "
+		"rate = %ld\n", clk->name, clk->rate, 
+		omap2_get_dpll_rate(clk), dd->bypass_clk->rate);
+
 	if (clk->rate == dd->bypass_clk->rate)
 		r = _omap3_noncore_dpll_bypass(clk);
 	else


