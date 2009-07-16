From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 12/13] DSPBRIDGE: fix resuming problem with dsp
 hibernation
Date: Thu, 16 Jul 2009 10:16:03 +0300 (EEST)
Message-ID: <20090716.101603.226793710.Hiroshi.DOYU@nokia.com>
References: <1247669795-23895-12-git-send-email-ameya.palande@nokia.com>
	<1247669795-23895-13-git-send-email-ameya.palande@nokia.com>
	<496565EC904933469F292DDA3F1663E602A32025E9@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:23035 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987AbZGPHQl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jul 2009 03:16:41 -0400
In-Reply-To: <496565EC904933469F292DDA3F1663E602A32025E9@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: x0095840@ti.com
Cc: ameya.palande@nokia.com, linux-omap@vger.kernel.org, omar.ramirez@ti.com, nm@ti.com

From: "ext Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH 12/13] DSPBRIDGE: fix resuming problem with dsp hibernation
Date: Thu, 16 Jul 2009 01:10:58 +0200

> 
> 
> Hi,
> 
> > -----Original Message-----
> > From: Ameya Palande [mailto:ameya.palande@nokia.com]
> > Sent: Wednesday, July 15, 2009 9:57 AM
> > To: linux-omap@vger.kernel.org
> > Cc: Ramirez Luna, Omar; Guzman Lugo, Fernando; Menon, Nishanth;
> > hiroshi.doyu@nokia.com
> > Subject: [PATCH 12/13] DSPBRIDGE: fix resuming problem with dsp
> > hibernation
> > 
> > From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > 
> > The constraints(opp >= 2) should be set whenever returning from DSP
> > hibernation.
> > 
> > This fixes the problem at the following steps:
> > 1) wait DSP hibernate
> > 2) echo mem > /sys/power/state
> > 3) type key to wakeup
> > 
> 
> The patch looks good, you are removing the check for OPP1 because it
> is suppose that if the DSP is in Hibernation we have a DSP constrain
> in OPP1, so I think the "if" is always true. However I don't see the
> issue the mention could you please tell me what was the problem you
> were seeing?

We haven't found the exact steps to reproduce this, but logically this
is necessary since it has to set *min* OPP2(constraints) in spite of
whatever the current OPP value is.

> 
> 
> > Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> > ---
> >  drivers/dsp/bridge/wmd/tiomap_sm.c |   16 +++++-----------
> >  1 files changed, 5 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/dsp/bridge/wmd/tiomap_sm.c
> > b/drivers/dsp/bridge/wmd/tiomap_sm.c
> > index 02e2675..69f6fb3 100644
> > --- a/drivers/dsp/bridge/wmd/tiomap_sm.c
> > +++ b/drivers/dsp/bridge/wmd/tiomap_sm.c
> > @@ -98,11 +98,6 @@ DSP_STATUS CHNLSM_DisableInterrupt(struct
> > WMD_DEV_CONTEXT *pDevContext)
> >  DSP_STATUS CHNLSM_InterruptDSP2(struct WMD_DEV_CONTEXT *pDevContext,
> >  				u16 wMbVal)
> >  {
> > -#ifdef CONFIG_BRIDGE_DVFS
> > -	struct dspbridge_platform_data *pdata =
> > -		omap_dspbridge_dev->dev.platform_data;
> > -	u32 opplevel = 0;
> > -#endif
> >  	struct CFG_HOSTRES resources;
> >  	DSP_STATUS status = DSP_SOK;
> >  	unsigned long timeout;
> > @@ -116,12 +111,11 @@ DSP_STATUS CHNLSM_InterruptDSP2(struct
> > WMD_DEV_CONTEXT *pDevContext,
> >  	if (pDevContext->dwBrdState == BRD_DSP_HIBERNATION ||
> >  	    pDevContext->dwBrdState == BRD_HIBERNATION) {
> >  #ifdef CONFIG_BRIDGE_DVFS
> > -		if (pdata->dsp_get_opp)
> > -			opplevel = (*pdata->dsp_get_opp)();
> > -		if (opplevel == VDD1_OPP1) {
> > -			if (pdata->dsp_set_min_opp)
> > -				(*pdata->dsp_set_min_opp)(VDD1_OPP2);
> > -		}
> > +		struct dspbridge_platform_data *pdata =
> > +			omap_dspbridge_dev->dev.platform_data;
> > +
> > +		if (pdata->dsp_set_min_opp)
> > +			(*pdata->dsp_set_min_opp)(VDD1_OPP2);
> >  #endif
> >  		/* Restart the peripheral clocks */
> >  		DSP_PeripheralClocks_Enable(pDevContext, NULL);
> > --
> > 1.6.2.4
> > 
> 
> Regards,
> Fernando.
