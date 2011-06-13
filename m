From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: Change DSI platform device name from
 "omapdss_dsi1" to "omapdss_dsi"
Date: Mon, 13 Jun 2011 06:27:38 -0700
Message-ID: <20110613132738.GB3352@atomide.com>
References: <1304494704-7285-1-git-send-email-archit@ti.com>
 <1304494704-7285-2-git-send-email-archit@ti.com>
 <20110504094050.GI27860@atomide.com>
 <1307452303.1858.59.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:64730 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752848Ab1FMN1l (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Jun 2011 09:27:41 -0400
Content-Disposition: inline
In-Reply-To: <1307452303.1858.59.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [110607 06:07]:
> Hi Tony,
> 
> On Wed, 2011-05-04 at 12:40 +0300, Tony Lindgren wrote:
> > * Archit Taneja <archit@ti.com> [110504 10:30]:
> > > --- a/arch/arm/mach-omap2/board-3430sdp.c
> > > +++ b/arch/arm/mach-omap2/board-3430sdp.c
> > > @@ -401,7 +401,7 @@ static struct regulator_consumer_supply sdp3430_vdda_dac_supplies[] = {
> > >  /* VPLL2 for digital video outputs */
> > >  static struct regulator_consumer_supply sdp3430_vpll2_supplies[] = {
> > >  	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
> > > -	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
> > > +	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
> > >  };
> > >  
> > >  static struct regulator_consumer_supply sdp3430_vmmc1_supplies[] = {
> > > diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> > > index 570e83f..eafadb4 100644
> > > --- a/arch/arm/mach-omap2/board-4430sdp.c
> > > +++ b/arch/arm/mach-omap2/board-4430sdp.c
> > > @@ -375,7 +375,7 @@ static struct regulator_consumer_supply sdp4430_vmmc_supply[] = {
> > >  };
> > >  static struct regulator_consumer_supply sdp4430_vcxio_supply[] = {
> > >  	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dss"),
> > > -	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
> > > +	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi.0"),
> > >  };
> > ...
> > 
> > Looks like we should first combine all this cut and paste data
> > for each board file into some common init function to cut
> > down the "crazy churn".
> 
> I haven't been able to do this in a clean way. The regulator framework
> is rather static in this area, and adding the data for REGULATOR_SUPPLYs
> dynamically based on OMAP version is something I haven't been able to
> do.
> 
> The best option I've found out is defining helper macros to add those
> consumers. An example patch below with 3430sdp and 4430sdp boards
> modified.
> 
> This would allow boards to setup the regulators whatever way they want,
> but the 99% of the boards could just use the macros.
> 
> It's still not as good as I'd want, because the source regulator is also
> the same for a particular OMAP version for 99% of the boards. So there's
> no real need to use those those macros in the board file, a common
> display file should be able to set everything up. But as I said, I
> haven't found out any way to do this.
> 
> What is your opinion of this approach?

Well I guess the macros are a step in the right direction. Eventually
we should have just one istance of the regulator_consumer_supply and
just populate that instead of cloning it in each board file.

Regards,

Tony
