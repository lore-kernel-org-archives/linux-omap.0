From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: Change DSI platform device name from
 "omapdss_dsi1" to "omapdss_dsi"
Date: Wed, 04 May 2011 13:53:28 +0300
Message-ID: <1304506408.2099.21.camel@deskari>
References: <1304494704-7285-1-git-send-email-archit@ti.com>
	 <1304494704-7285-2-git-send-email-archit@ti.com>
	 <20110504094050.GI27860@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:40043 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751120Ab1EDKxd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 May 2011 06:53:33 -0400
Received: by mail-fx0-f52.google.com with SMTP id 6so709280fxm.25
        for <linux-omap@vger.kernel.org>; Wed, 04 May 2011 03:53:32 -0700 (PDT)
In-Reply-To: <20110504094050.GI27860@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
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

I was actually thinking about this earlier today.

All the boards I have seen use vdds_dsi the same way (depending on the
omap version, though). For OMAP3 it comes from VPPL2 and for OMAP4 it's
VCXIO. Optimally a common piece of code would just set up the regulator
properly.

But I think in the end the config has to come from the board data, as I
don't see that the above config would be the only possibility. The
vdds_dsi could be supplied from anywhere (with suitable voltage, of
course), as far as I understand.

What we could do is:

1. The board file tells the common display code which regulator is used
for vdds_dsi, and the common code can setup the regulator supply for all
DSS devices which need it (omapdss_dss, omapdss_dsi1, omapdss_dsi2).

I guess this needs dynamically adding the regulator supply in display.c,
and I'm not quite sure if that's possible. We have to look at this.

2. The common code could default to the power source that is most
commonly used, so the board file would have to config the regulator only
if it uses a non-common one.

Together 1. and 2. would remove the DSS regulator stuff totally from the
board files. But regulators for the panels would still be in the board
files, of course.

 Tomi


