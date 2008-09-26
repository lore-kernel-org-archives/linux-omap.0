From: <Tero.Kristo@nokia.com>
Subject: RE: [PATCH] OMAP3 clock: put DPLL into bypass if bypass rate = clk->rate, not hardware rate
Date: Fri, 26 Sep 2008 11:17:38 +0300
Message-ID: <B71CE868F2BC2847B3F23C5A8EE394308CF03D@vaebe110.NOE.Nokia.com>
References: <alpine.DEB.2.00.0809250837350.14535@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22122 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbYIZIYc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Sep 2008 04:24:32 -0400
Content-class: urn:content-classes:message
In-Reply-To: <alpine.DEB.2.00.0809250837350.14535@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, linux-omap@vger.kernel.org
Cc: rnayak@ti.com

Hi,

The three patches you sent (fix CONFIG_OMAP_RESET_CLOCKS, fix
dss1_alwon_clk and this one) seem to fix problems I was seeing with
retention.

-Tero

>-----Original Message-----
>From: ext Paul Walmsley [mailto:paul@pwsan.com] 
>Sent: 25 September, 2008 17:39
>To: linux-omap@vger.kernel.org
>Cc: Kristo Tero (Nokia-D/Tampere); rnayak@ti.com
>Subject: [PATCH] OMAP3 clock: put DPLL into bypass if bypass 
>rate = clk->rate, not hardware rate
>
>
>When a non-CORE DPLL is enabled via 
>omap3_noncore_dpll_enable(), use the user's desired rate in 
>clk->rate to determine whether to put the DPLL into bypass or 
>lock mode, rather than reading the DPLL's current idle state 
>from its hardware registers.
>
>This fixes a bug observed when leaving retention. Non-CORE 
>DPLLs were not being relocked when downstream clocks 
>re-enabled; rather, the DPLL entered bypass mode.
>
>Problem reported by Tero Kristo <tero.kristo@nokia.com>.
>
>Signed-off-by: Paul Walmsley <paul@pwsan.com>
>---
> arch/arm/mach-omap2/clock34xx.c |    4 +---
> 1 files changed, 1 insertions(+), 3 deletions(-)
>
>diff --git a/arch/arm/mach-omap2/clock34xx.c 
>b/arch/arm/mach-omap2/clock34xx.c index c89d6bc..df258f7 100644
>--- a/arch/arm/mach-omap2/clock34xx.c
>+++ b/arch/arm/mach-omap2/clock34xx.c
>@@ -281,9 +281,7 @@ static int 
>omap3_noncore_dpll_enable(struct clk *clk)
> 	if (!dd)
> 		return -EINVAL;
> 
>-	rate = omap2_get_dpll_rate(clk);
>-
>-	if (dd->bypass_clk->rate == rate)
>+	if (clk->rate == dd->bypass_clk->rate)
> 		r = _omap3_noncore_dpll_bypass(clk);
> 	else
> 		r = _omap3_noncore_dpll_lock(clk);
>
