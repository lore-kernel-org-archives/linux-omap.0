From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 11/13] DSPBRIDGE: Set VDD1 OPP1 unconditionally while
 moving to off mode
Date: Wed, 15 Jul 2009 18:17:34 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A32025EF@dlee06.ent.ti.com>
References: <1247669795-23895-11-git-send-email-ameya.palande@nokia.com>
	<1247669795-23895-12-git-send-email-ameya.palande@nokia.com>
	<496565EC904933469F292DDA3F1663E602A32025DC@dlee06.ent.ti.com>
 <20090716.021024.232759103.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34862 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756455AbZGOXRn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Jul 2009 19:17:43 -0400
In-Reply-To: <20090716.021024.232759103.Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "Menon, Nishanth" <nm@ti.com>



> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Wednesday, July 15, 2009 6:10 PM
> To: Guzman Lugo, Fernando
> Cc: ameya.palande@nokia.com; linux-omap@vger.kernel.org; Ramirez Luna,
> Omar; Menon, Nishanth
> Subject: Re: [PATCH 11/13] DSPBRIDGE: Set VDD1 OPP1 unconditionally while
> moving to off mode
> 
> From: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
> Subject: RE: [PATCH 11/13] DSPBRIDGE: Set VDD1 OPP1 unconditionally while
> moving to off mode
> Date: Thu, 16 Jul 2009 00:53:24 +0200
> 
> >
> > Hi,
> >
> > > -----Original Message-----
> > > From: Ameya Palande [mailto:ameya.palande@nokia.com]
> > > Sent: Wednesday, July 15, 2009 9:57 AM
> > > To: linux-omap@vger.kernel.org
> > > Cc: Ramirez Luna, Omar; Guzman Lugo, Fernando; Menon, Nishanth;
> > > hiroshi.doyu@nokia.com
> > > Subject: [PATCH 11/13] DSPBRIDGE: Set VDD1 OPP1 unconditionally while
> > > moving to off mode
> > >
> > > Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> > > ---
> > >  drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   18 ++++++++++--------
> > >  1 files changed, 10 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> > > b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> > > index 7cc29b7..7c7d9c4 100644
> > > --- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> > > +++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> > > @@ -167,17 +167,19 @@ DSP_STATUS handle_hibernation_fromDSP(struct
> > > WMD_DEV_CONTEXT *pDevContext)
> > >  			if (DSP_FAILED(status))
> > >  				return status;
> > >  			IO_SHMsetting(hIOMgr, SHM_GETOPP, &opplevel);
> > > -			/* Set the OPP to low level before moving to OFF mode */
> > >  			if (opplevel != VDD1_OPP1) {
> > >  				DBG_Trace(DBG_LEVEL5,
> > > -					"Tiomap_pwr.c - DSP requested"
> > > -					" OPP = %d, MPU requesting low"
> > > -					" OPP %d instead\n", opplevel,
> > > -					VDD1_OPP1);
> > > -				if (pdata->dsp_set_min_opp)
> > > -					(*pdata->dsp_set_min_opp)(VDD1_OPP1);
> > > -				status = DSP_SOK;
> > > +					" DSP requested OPP = %d, MPU"
> > > +					" requesting low OPP %d instead\n",
> > > +					opplevel, VDD1_OPP1);
> > >  			}
> > > +			/*
> > > +			 * Set the OPP to low level before moving to OFF
> > > +			 * mode
> > > +			 */
> > > +			if (pdata->dsp_set_min_opp)
> > > +				(*pdata->dsp_set_min_opp)(VDD1_OPP1);
> > > +			status = DSP_SOK;
> >
> > I think that the "if statement" is only avoiding setting the OPP1 if
> > the DSP is already in OPP1. Were you seeing an issue without this
> > change?
> 
> We got the different opplevel with the following patch, which means
> that, OPP value stored in SHM isn't equal to the real OPP since we've
> introduce some codes to bump up OPP1 to OPP2, but never written back
> to SHM.

Ok I see the problem, then the patch looks good for me it will resolve the problem.

> 
> 	Modified drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> index 5f7e855..9cde41f 100644
> --- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> +++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> @@ -167,6 +167,10 @@ DSP_STATUS handle_hibernation_fromDSP(struct
> WMD_DEV_CONTEXT *pDevContext)
>  			if (DSP_FAILED(status))
>  				return status;
>  			IO_SHMsetting(hIOMgr, SHM_GETOPP, &opplevel);
> +			pr_info("%s(%d) %d\n", __func__, __LINE__, opplevel);
> +			if (pdata->dsp_get_opp)
> +				opplevel = (*pdata->dsp_get_opp)();
> +			pr_info("%s(%d) %d\n", __func__, __LINE__, opplevel);
>  			/* Set the OPP to low level before moving to OFF mode */
>  			if (opplevel != VDD1_OPP1) {
>  				DBG_Trace(DBG_LEVEL5,
> 
> >
> > >  #endif /* CONFIG_BRIDGE_DVFS */
> > >  		} else {
> > >  			DBG_Trace(DBG_LEVEL7,
> > > --
> > > 1.6.2.4
> > >
> >
> > Regards,
> > Fernando.
> >

Acked-by Fernando Guzman Lugo <x0095840@ti.com>

