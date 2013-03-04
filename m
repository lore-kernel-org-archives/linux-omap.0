From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 03/15] ARM: OMAP4+: PM: Consolidate and use OMAP4 PM code
 for OMAP5
Date: Mon, 4 Mar 2013 12:21:01 -0600
Message-ID: <20130304182101.GB14860@kahuna>
References: <1362139864-9233-1-git-send-email-santosh.shilimkar@ti.com>
 <1362139864-9233-4-git-send-email-santosh.shilimkar@ti.com>
 <20130301174300.GA22220@kahuna>
 <51319189.1060302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50862 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758684Ab3CDSVH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Mar 2013 13:21:07 -0500
Content-Disposition: inline
In-Reply-To: <51319189.1060302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, linux-arm-kernel@lists.infradead.org

On 11:13-20130302, Santosh Shilimkar wrote:
> On Friday 01 March 2013 11:13 PM, Nishanth Menon wrote:
> > On 17:40-20130301, Santosh Shilimkar wrote:
> >> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm_omap4plus.c
> >> similarity index 74%
[..]
> >>  	mpuss_clkdm = clkdm_lookup("mpuss_clkdm");
> >>  	emif_clkdm = clkdm_lookup("l3_emif_clkdm");
> >>  	l3_1_clkdm = clkdm_lookup("l3_1_clkdm");
> >>  	l3_2_clkdm = clkdm_lookup("l3_2_clkdm");
> >> +	l4_per_clkdm = clkdm_lookup("l4_per_clkdm");
> >> +	l4wkup = clkdm_lookup("l4_wkup_clkdm");
> > These static dependencies now seems added for OMAP4?
> > Sounds like a separate patch as it is not exactly what $subject claims.
> >>  	ducati_clkdm = clkdm_lookup("ducati_clkdm");
> These are accidently added. I have removed these two in another series.
> Will remove this one from the patch.
Thanks.
> 
> >> -	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) ||
> >> -		(!l3_2_clkdm) || (!ducati_clkdm))
> >> -		goto err2;
> >> +	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm) || (!l4wkup) ||
> >> +		(!l3_2_clkdm) || (!ducati_clkdm) || (!l4_per_clkdm))
> >> +		return -EINVAL;
> >>  
> >>  	ret = clkdm_add_wkdep(mpuss_clkdm, emif_clkdm);
> >>  	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_1_clkdm);
> >>  	ret |= clkdm_add_wkdep(mpuss_clkdm, l3_2_clkdm);
> >> +	ret |= clkdm_add_wkdep(mpuss_clkdm, l4_per_clkdm);
> >> +	ret |= clkdm_add_wkdep(mpuss_clkdm, l4wkup);
> >>  	ret |= clkdm_add_wkdep(ducati_clkdm, l3_1_clkdm);
> >>  	ret |= clkdm_add_wkdep(ducati_clkdm, l3_2_clkdm);
> >>  	if (ret) {
> >>  		pr_err("Failed to add MPUSS -> L3/EMIF/L4PER, DUCATI -> L3 wakeup dependency\n");
> >> +	}
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +/**
> >> + * omap4_pm_init - Init routine for OMAP4+ devices
> >> + *
> >> + * Initializes all powerdomain and clockdomain target states
> >> + * and all PRCM settings.
> >> + */
> >> +int __init omap4_pm_init(void)
> > could we rename it as omap4plus_pm_init while we are at it?
> > This will help differentiate at least functions which are omap4 only and
> > ones which we reuse for omap4plus?
> Not needed. That way we have to rename all our omap2_* varients to
> omap2plus. omap4_* is assumed to be omap4 and onwards just like
> omap2_*
hmm true.. :(
> 
> >> +{
> >> +	int ret;
> >> +
> >> +	if (omap_rev() == OMAP4430_REV_ES1_0) {
> > we have ID detection for OMAP5430_REV_ES1_0 in arch/arm/mach-omap2/id.c
> > However, we do not support PM, so might as well use it to skip init?
> Well the plan is to remove OMAP5 ES1.0 completely so no need to add
> more checks. As already mentioned ES1.0 is not going to be supported
> in mainline kernel.
OK.
-- 
Regards,
Nishanth Menon
