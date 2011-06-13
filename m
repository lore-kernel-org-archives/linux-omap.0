From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/9] OMAP: DSS2: Change DSI platform device name from
 "omapdss_dsi1" to "omapdss_dsi"
Date: Mon, 13 Jun 2011 12:54:57 +0300
Message-ID: <1307958897.1847.59.camel@deskari>
References: <1304494704-7285-1-git-send-email-archit@ti.com>
	 <1304494704-7285-2-git-send-email-archit@ti.com>
	 <20110504094050.GI27860@atomide.com>  <1307452303.1858.59.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:44172 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751614Ab1FMJzD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 13 Jun 2011 05:55:03 -0400
Received: by mail-fx0-f41.google.com with SMTP id 18so3210300fxm.0
        for <linux-omap@vger.kernel.org>; Mon, 13 Jun 2011 02:55:02 -0700 (PDT)
In-Reply-To: <1307452303.1858.59.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org

Tony, Ping.

I'd like this DSS regulator issue decided on way or another, as it's
stopping us getting Blaze board's panels working on mainline, and also
preventing me from porting the old omapfb drivers to DSS2.

 Tomi

On Tue, 2011-06-07 at 16:11 +0300, Tomi Valkeinen wrote:
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
> 
>  Tomi
> 
> 
> 
> diff --git a/arch/arm/mach-omap2/board-3430sdp.c
> b/arch/arm/mach-omap2/board-3430sdp.c
> index ae2963a..69b7e6f 100644
> --- a/arch/arm/mach-omap2/board-3430sdp.c
> +++ b/arch/arm/mach-omap2/board-3430sdp.c
> @@ -308,13 +308,12 @@ static struct regulator_consumer_supply
> sdp3430_vaux3_supplies[] = {
>  };
>  
>  static struct regulator_consumer_supply sdp3430_vdda_dac_supplies[] = {
> -	REGULATOR_SUPPLY("vdda_dac", "omapdss_venc"),
> +	OMAP_DSS_VENC_SUPPLIES,
>  };
>  
>  /* VPLL2 for digital video outputs */
>  static struct regulator_consumer_supply sdp3430_vpll2_supplies[] = {
> -	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
> -	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
> +	OMAP_DSS_SUPPLIES,
>  };
>  
>  static struct regulator_consumer_supply sdp3430_vmmc1_supplies[] = {
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c
> b/arch/arm/mach-omap2/board-4430sdp.c
> index 2647a95..80bbf61 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -339,8 +339,7 @@ static struct regulator_consumer_supply
> sdp4430_vmmc_supply[] = {
>  	},
>  };
>  static struct regulator_consumer_supply sdp4430_vcxio_supply[] = {
> -	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dss"),
> -	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1"),
> +	OMAP_DSS_SUPPLIES,
>  };
>  
>  static int omap4_twl6030_hsmmc_late_init(struct device *dev)
> diff --git a/include/video/omapdss.h b/include/video/omapdss.h
> index bb39738..557b400 100644
> --- a/include/video/omapdss.h
> +++ b/include/video/omapdss.h
> @@ -636,4 +636,12 @@ int omap_rfbi_update(struct omap_dss_device
> *dssdev,
>  int omap_rfbi_configure(struct omap_dss_device *dssdev, int pixel_size,
>  		int data_lines);
>  
> +#define OMAP_DSS_SUPPLIES \
> +	REGULATOR_SUPPLY("vdds_sdi", "omapdss_dss"), \
> +	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dss"), \
> +	REGULATOR_SUPPLY("vdds_dsi", "omapdss_dsi1")
> +
> +#define OMAP_DSS_VENC_SUPPLIES \
> +	REGULATOR_SUPPLY("vdda_dac", "omapdss_venc")
> +
>  #endif
> 
> 


