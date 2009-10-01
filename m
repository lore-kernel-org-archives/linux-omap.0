From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [PATCH] OMAP3 : PM : Functions to get freq from opp and
 vice-versa
Date: Thu, 1 Oct 2009 18:01:13 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301DDB71326@dbde02.ent.ti.com>
References: <1252495499-8455-1-git-send-email-premi@ti.com>
 <87fxa4mh4t.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:40860 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932171AbZJAMbP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 08:31:15 -0400
In-Reply-To: <87fxa4mh4t.fsf@deeprootsystems.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Kevin Hilman
> Sent: Wednesday, September 30, 2009 11:48 PM
> To: Premi, Sanjeev
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP3 : PM : Functions to get freq from 
> opp and vice-versa
> 
> Sanjeev Premi <premi@ti.com> writes:
> 
> > There is no generic function to get OPP corresponding to frequency
> > and vice versa.
> >
> > Function get_opp() - in resource34xx.c - is included only when
> > CONFIG_OMAP_PM_SRF is enabled. Moreover, it is always called with
> > an explicit addition of MAX_VDDn_OPP e.g.
> >   opp = get_opp(mpu_opps + MAX_VDD1_OPP, clk->rate);
> >   opp = get_opp(l3_opps + MAX_VDD2_OPP, clk->rate);
> >
> > This is 'addition' is required as there is no encapsulation of
> > MIN and MAX VDDs associated to the table.
> >
> > This patch fixes the issue by creating a 'table' object that
> > encapsulates the MIN and MAX values and the existing rate table.
> >
> > Signed-off-by: Sanjeev Premi <premi@ti.com>
> 
> Looks ok, minor comment below...

[sp] Will take care of the comments in the next patch.

Best regards,
Sanjeev

> 
> [...]
> 
> > diff --git a/arch/arm/plat-omap/include/mach/omap-pm.h 
> b/arch/arm/plat-omap/include/mach/omap-pm.h
> > index 583e540..cf910ef 100644
> > --- a/arch/arm/plat-omap/include/mach/omap-pm.h
> > +++ b/arch/arm/plat-omap/include/mach/omap-pm.h
> > @@ -33,6 +33,20 @@ struct omap_opp {
> >  	u16 vsel;
> >  };
> >  
> > +/* struct omap_opp_table - View OPP table as an object
> > + * @min: Minimum OPP id
> > + * @max: Maximim OPP id
> > + * @opps: Pointer to array defining the OPPs.
> > + *
> > + * An OPP table has varied length. Knowing minimum and maximum
> > + * OPP ids allow easy traversal.
> > + */
> > +struct omap_opp_table {
> > +	u8	min;
> > +	u8	max;
> > +	struct omap_opp* opps;
> > +};
> > +
> >  extern struct omap_opp *mpu_opps;
> >  extern struct omap_opp *dsp_opps;
> >  extern struct omap_opp *l3_opps;
> > @@ -49,6 +63,17 @@ extern struct omap_opp *l3_opps;
> >  #define OCP_INITIATOR_AGENT		2
> >  
> >  /**
> > + *
> > + */
> 
> Either add a useful comment or remove the comment block 
> (preferably the latter)
> 
> > +int opp_to_freq(unsigned long* freq, const struct 
> omap_opp_table* table, u8 opp);
> > +
> > +/**
> > + *
> > + */
> 
> ditto
> 
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 