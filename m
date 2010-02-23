From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH] PM-WIP-OPP: Fixing wrong target level being passed
 during Core DVFS.
Date: Mon, 22 Feb 2010 23:28:06 -0600
Message-ID: <A24693684029E5489D1D202277BE894453799477@dlee02.ent.ti.com>
References: <1266481866-10875-1-git-send-email-thara@ti.com>
 <4B7D558D.7000101@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59607 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863Ab0BWF2M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 00:28:12 -0500
In-Reply-To: <4B7D558D.7000101@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>

Nishanth,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Menon, Nishanth
> Sent: Thursday, February 18, 2010 8:58 AM
> To: Gopinath, Thara
> Cc: linux-omap@vger.kernel.org; Kevin Hilman; Kristo Tero (Nokia-
> D/Tampere)
> Subject: Re: [PATCH] PM-WIP-OPP: Fixing wrong target level being passed
> during Core DVFS.
> 
> Gopinath, Thara said the following on 02/18/2010 10:31 AM:
> > As per the current implementaion (u8*)&target_level is being passed
> > to freq_to_opp in set_opp. This would result in updating just the first
> > 8 bits of a u32 variable. Later target_level is passed to
> > resource_set_opp_level as a u32 parameter. This maens
> > a. Initially target_level was 0xabcdefgh.
> > b. freq_to_opp updates the lower eight bits of target_level
> > to 0xXX. Now target_level = 0xabcdefXX.
> > c. We pass 0xabcdefXX as target_level to resource_set_opp_level
> > when we want to pass just 0xXX.
> > This is leading to some corrupted bookkeeping later on in the
> > dvfs path.
> >
> > This patch ensures that target_level passed to resource_set_opp_level
> > is actually the level that is intended by freq_to_opp API.
> 
> Thanks.. good catch.
> [PATCH] PM-WIP-OPP: Fixing wrong target level being passed during Core
> DVFS.
> Suggestion on the subject:
> could you put it something like the following so that git-am will
> throw away PM-WIP-OPP?
> [PATCH] [PM-WIP-OPP] omap3: pm: Fix wrong target level during core dvfs
> 
> ?
> Some suggestion below.
> 
> >
> > Signed-off-by: Thara Gopinath <thara@ti.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > ---
> >  arch/arm/mach-omap2/resource34xx.c |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-
> omap2/resource34xx.c
> > index 3604a38..d2336d8 100644
> > --- a/arch/arm/mach-omap2/resource34xx.c
> > +++ b/arch/arm/mach-omap2/resource34xx.c
> > @@ -463,6 +463,7 @@ int set_opp(struct shared_resource *resp, u32
> target_level)
> >  	} else if (resp == vdd2_resp) {
> >  		unsigned long req_l3_freq;
> >  		struct omap_opp *oppx = NULL;
> > +		u8 opp;
> >
> >  		/* Convert the tput in KiB/s to Bus frequency in MHz */
> >  		req_l3_freq = (target_level * 1000)/4;
> > @@ -478,10 +479,11 @@ int set_opp(struct shared_resource *resp, u32
> target_level)
> >  		/* uh uh.. no OPPs?? */
> >  		BUG_ON(IS_ERR(oppx));
> >
> If you do target_level = 0; here, the entire patch is a oneliner :)

Actually, IMHO will be even more clean, to standardize all OPP value passing to be u8.

Do you really need to be prepared for 2^32 opp values? ;)

Regards,
Sergio

> 
> > -		ret = freq_to_opp((u8 *)&target_level, OPP_L3, req_l3_freq);
> > +		ret = freq_to_opp(&opp, OPP_L3, req_l3_freq);
> >  		/* we dont expect this to fail */
> >  		BUG_ON(ret);
> >
> > +		target_level = opp;
> >  		ret = resource_set_opp_level(VDD2_OPP, target_level, 0);
> >  	}
> >  	return 0;
> 
> --
> Regards,
> Nishanth Menon
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
