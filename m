From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH] PM-WIP-OPP: Fixing wrong target level being passed
 during Core DVFS.
Date: Tue, 23 Feb 2010 06:42:17 -0600
Message-ID: <A24693684029E5489D1D202277BE8944537994FE@dlee02.ent.ti.com>
References: <1266481866-10875-1-git-send-email-thara@ti.com>
 <4B7D558D.7000101@ti.com>
 <A24693684029E5489D1D202277BE894453799477@dlee02.ent.ti.com>
 <7A436F7769CA33409C6B44B358BFFF0C013114623A@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48545 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281Ab0BWMmX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Feb 2010 07:42:23 -0500
In-Reply-To: <7A436F7769CA33409C6B44B358BFFF0C013114623A@dlee02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Menon, Nishanth" <nm@ti.com>, "Gopinath, Thara" <thara@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, "Kristo Tero (Nokia-D/Tampere)" <Tero.Kristo@nokia.com>



> -----Original Message-----
> From: Menon, Nishanth
> Sent: Monday, February 22, 2010 11:31 PM
> To: Aguirre, Sergio; Gopinath, Thara
> Cc: linux-omap@vger.kernel.org; Kevin Hilman; Kristo Tero (Nokia-
> D/Tampere)
> Subject: RE: [PATCH] PM-WIP-OPP: Fixing wrong target level being passed
> during Core DVFS.
> 
> > From: Aguirre, Sergio
> > Sent: Tuesday, February 23, 2010 7:28 AM
> > To: Menon, Nishanth; Gopinath, Thara
> [...]
> > >
> > > >
> > > > Signed-off-by: Thara Gopinath <thara@ti.com>
> > > > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > > > ---
> > > >  arch/arm/mach-omap2/resource34xx.c |    4 +++-
> > > >  1 files changed, 3 insertions(+), 1 deletions(-)
> > > >
> > > > diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-
> > > omap2/resource34xx.c
> > > > index 3604a38..d2336d8 100644
> > > > --- a/arch/arm/mach-omap2/resource34xx.c
> > > > +++ b/arch/arm/mach-omap2/resource34xx.c
> > > > @@ -463,6 +463,7 @@ int set_opp(struct shared_resource *resp, u32
> > > target_level)
> > > >  	} else if (resp == vdd2_resp) {
> > > >  		unsigned long req_l3_freq;
> > > >  		struct omap_opp *oppx = NULL;
> > > > +		u8 opp;
> > > >
> > > >  		/* Convert the tput in KiB/s to Bus frequency in MHz */
> > > >  		req_l3_freq = (target_level * 1000)/4;
> > > > @@ -478,10 +479,11 @@ int set_opp(struct shared_resource *resp, u32
> > > target_level)
> > > >  		/* uh uh.. no OPPs?? */
> > > >  		BUG_ON(IS_ERR(oppx));
> > > >
> > > If you do target_level = 0; here, the entire patch is a oneliner :)
> >
> > Actually, IMHO will be even more clean, to standardize all OPP value
> > passing to be u8.
> >
> > Do you really need to be prepared for 2^32 opp values? ;)
> >
> Using OPP ID has to be completely removed from resource34xx.c -> this
> action is still pending. In this case, using u8 OR initing the
> target_level to 0 has the same impact. Why add code that will be removed
> later on anyways?

Well, I'm not proposing for code addition, but to fix that code just by changing opp level parameters to u8, instead of u32, like this:

-int set_opp(struct shared_resource *resp, u32 target_level)
+int set_opp(struct shared_resource *resp, u8 target_level)

If you're going to replace all this in the near future, then it's understandable to hold even this patch (target_level = 0).

Regards,
Sergio
> 
> Regards,
> Nishanth Menon

