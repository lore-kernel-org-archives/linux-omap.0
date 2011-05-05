From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: Change DSI platform device name from
 "omapdss_dsi1" to "omapdss_dsi"
Date: Thu, 05 May 2011 14:36:48 +0300
Message-ID: <1304595408.30935.16.camel@deskari>
References: <1304494704-7285-1-git-send-email-archit@ti.com>
	 <1304494704-7285-2-git-send-email-archit@ti.com>
	 <20110504094050.GI27860@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:58879 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751689Ab1EELg4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 07:36:56 -0400
Received: by mail-wy0-f179.google.com with SMTP id 36so1740535wyg.38
        for <linux-omap@vger.kernel.org>; Thu, 05 May 2011 04:36:53 -0700 (PDT)
In-Reply-To: <20110504094050.GI27860@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org

On Wed, 2011-05-04 at 12:40 +0300, Tony Lindgren wrote:
> * Archit Taneja <archit@ti.com> [110504 10:30]:
> > --- a/arch/arm/mach-omap2/board-3430sdp.c
> > +++ b/arch/arm/mach-omap2/board-3430sdp.c
> > @@ -401,7 +401,7 @@ static struct regulator_consumer_supply sdp3430_vdda_dac_supplies[] = {
> >  /* VPLL2 for digital video outputs */
> >  static struct regulator_consumer_supply sdp3430_vpll2_supplies[] = {
> >  	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
> > -	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
> > +	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
> >  };
> >  
> >  static struct regulator_consumer_supply sdp3430_vmmc1_supplies[] = {
> > diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> > index 570e83f..eafadb4 100644
> > --- a/arch/arm/mach-omap2/board-4430sdp.c
> > +++ b/arch/arm/mach-omap2/board-4430sdp.c
> > @@ -375,7 +375,7 @@ static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
> >  };
> >  static struct regulator_consumer_supply sdp4430_vcxio_supply[] = {
> >  	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dss"),
> > -	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
> > +	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
> >  };
> ...
> 
> Looks like we should first combine all this cut and paste data
> for each board file into some common init function to cut
> down the "crazy churn".

Sorry, I don't see how this would be possible with the regulator
framework. What we would need is to setup some
regulator_consumer_supplies dynamically depending on the omap and on the
given parameters.

Adding Liam and Mark for possible comments. A short summary of the
situation:

OMAP display subsystem (DSS) HW needs a few power supplies (vdds_dsi,
vdds_sdi, vdda_dac), depending on the OMAP version. All the known boards
have the standard TWL power chip which provides these powers, and they
are connected almost always the same way. However, there's no reason
that the powers for DSS couldn't be provided from some other source.

As an example, on OMAP3 we could have:
(regulator -> name -> driver)
VDDA_DAC -> "vdda_dac" -> omapdss_venc
VPLL2 -> "vdds_dsi" -> omapdss
VPLL2 -> "vdds_dsi" -> omapdss_dsi

So currently we have REGULATOR_SUPPLY defines for each board in all the
board files which support display. It would be much better to have an
overrideable standard setup for the DSS powers, but this would require
dynamically setting up the regulator_consumer_supplies. And I can't see
how this could be done, except dynamically creating the
regulator_consumer_supply array before initializing the TWL chip, but as
DSS is not the only user of those powers the end result could be quite a
mess with changes needed in every board file.

 Tomi


