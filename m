From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 2/3] OMAP3630: PM: implement Foward Body-Bias for OPP1G
Date: Fri, 23 Apr 2010 10:03:16 +0300
Message-ID: <20100423070316.GI16011@besouro.research.nokia.com>
References: <1271453603-21929-1-git-send-email-mturquette@ti.com>
 <1271453603-21929-3-git-send-email-mturquette@ti.com>
 <20100419074636.GC5325@besouro.research.nokia.com>
 <4BCF6C6F.3030406@ti.com>
 <4BD055A5.1050206@ti.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:61227 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756092Ab0DWHD4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 03:03:56 -0400
Content-Disposition: inline
In-Reply-To: <4BD055A5.1050206@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <nm@ti.com>
Cc: "Turquette, Mike" <mturquette@ti.com>, "Valentin Eduardo (Nokia-D/Helsinki)" <eduardo.valentin@nokia.com>, ext Mike Turquette <mturquette@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "Gopinath, Thara" <thara@ti.com>, "Gulati, Shweta" <shweta.gulati@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

On Thu, Apr 22, 2010 at 03:56:53PM +0200, ext Nishanth Menon wrote:
> Turquette, Mike had written, on 04/21/2010 04:21 PM, the following:
> [...]
> 
> >>>  
> >>>  /**
> >>> + * voltscale_adaptive_body_bias - controls ABB ldo during voltage scaling
> >>> + * @target_volt: target voltage determines if ABB ldo is active or bypassed
> >>> + *
> >>> + * Adaptive Body-Bias is a technique in all OMAP silicon that uses the 45nm
> >>> + * process.  ABB can boost voltage in high OPPs for silicon with weak
> >>> + * characteristics (forward Body-Bias) as well as lower voltage in low OPPs
> >>> + * for silicon with strong characteristics (Reverse Body-Bias).
> >>> + *
> >>> + * Only Foward Body-Bias for operating at high OPPs is implemented below, per
> >>> + * recommendations from silicon team.
> >>> + * Reverse Body-Bias for saving power in active cases and sleep cases is not
> >>> + * yet implemented.
> >>> + * OMAP4 hardward also supports ABB ldo, but no recommendations have been made
> >>> + * to implement it yet.
> >>> + */
> >>> +int voltscale_adaptive_body_bias(unsigned long target_volt)
> >>> +{
> >>> +	u32 sr2en_enabled;
> >>> +	int timeout;
> >>> +	int sr2_wtcnt_value;
> >>> +
> >>> +	/* calculate SR2_WTCNT_VALUE settling time */
> >>> +	sr2_wtcnt_value = (ABB_MAX_SETTLING_TIME *
> >>> +			(clk_get_rate("sys_ck") / 1000000) / 8);
> >>> +
> >>> +	/* has SR2EN been enabled previously? */
> >>> +	sr2en_enabled = (prm_read_mod_reg(OMAP3430_GR_MOD,
> >>> +				OMAP3_PRM_LDO_ABB_CTRL_OFFSET) &
> >>> +			OMAP3630_SR2EN);
> >>> +
> >>> +	/* select fast, nominal or slow OPP for ABB ldo */
> >>> +	/* FIXME: include OMAP4 once recommendations are complete */
> >>> +	if (cpu_is_omap3630() && (target_volt >= 1350000)) {
> >> You are creating two steps to decide if you apply or not FBB.
> >> Here and also bellow (omap voltage scale). Would it make sense to bind it
> >> per opp? I mean just a flag on opp dat then you apply or not based on that flag.
> >> Same for RBB.
> > 
> > Eduardo,
> > 
> > Thanks for reviewing.
> > 
> > There has been some offline discussion about the best way to handle the 
> > the relationship between FBB enable flags and OPPs:
> > 
> > 1) extend OPP table
> > 2) piggyback on Thara's SR hwmod structures
> > 	This probably won't work given Paul's review comments
> > 3) other wacky stuff
> > 
> > After some discussion about the best way to do this I will definitely 
> > lose the duplicate checks and replace with some nice table look-up.
> > 
> > Extending the OPP table is gross for OMAP2 and OMAP3430.  Piggybacking 
> > on SR stuff is just a hack and there is no real relationship between ABB 
> > ldo and SR.  The crux of the issue is how to relate FBB enable flags to 
> > OPP table.  hwmod?  Ideas on this are very welcome.
> > 
> might be a good idea for using
> I vote for 2) omap_volt_data in voltage.c and using the flag there.

This was actually what I was also thinking. if you stick your flag on omap_volt_data
should be enough.

> 
> 1) is a bad idea as ABB is not present in older silicon and opp table 
> should ideally be independent of silicon and contain only common data..

indeed.

> 
> [...]
> 
> -- 
> Regards,
> Nishanth Menon
