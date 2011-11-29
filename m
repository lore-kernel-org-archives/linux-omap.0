From: Carlos Chinea <carlos.chinea@nokia.com>
Subject: Re: [PATCH 06/13] OMAPDSS: DSI: Use new lane config in
 dsi_set_lane_config
Date: Tue, 29 Nov 2011 11:09:07 +0200
Message-ID: <1322557747.17335.77.camel@groo>
References: <1322141381-5395-1-git-send-email-tomi.valkeinen@ti.com>
	 <1322141381-5395-7-git-send-email-tomi.valkeinen@ti.com>
	 <1322471339.17335.73.camel@groo> <1322495015.2364.12.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.26]:50936 "EHLO mgw-da02.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753200Ab1K2JJe (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Nov 2011 04:09:34 -0500
In-Reply-To: <1322495015.2364.12.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com

On Mon, 2011-11-28 at 17:43 +0200, ext Tomi Valkeinen wrote:
> On Mon, 2011-11-28 at 11:08 +0200, Carlos Chinea wrote:
> > Hi Tomi,
> > 
> > Just a question/suggestion, bellow:
> > 
> > On Thu, 2011-11-24 at 15:29 +0200, ext Tomi Valkeinen wrote:
> > > Use the new lane config in dsi_set_lane_config().
> > > 
> > > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > > ---
> > >  drivers/video/omap2/dss/dsi.c |   84 +++++++++++++++++++---------------------
> > >  1 files changed, 40 insertions(+), 44 deletions(-)
> > > 
> > > diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> > > index aea110c..ba8d6b3 100644
> > > --- a/drivers/video/omap2/dss/dsi.c
> > > +++ b/drivers/video/omap2/dss/dsi.c
> > > @@ -2154,59 +2154,53 @@ static int dsi_parse_lane_config(struct omap_dss_device *dssdev)
> > >  	return 0;
> > >  }
> > >  
> > > -static void dsi_set_lane_config(struct omap_dss_device *dssdev)
> > > +static int dsi_set_lane_config(struct omap_dss_device *dssdev)
> > >  {
> > >  	struct platform_device *dsidev = dsi_get_dsidev_from_dssdev(dssdev);
> > > +	struct dsi_data *dsi = dsi_get_dsidrv_data(dsidev);
> > > +	static const u8 offsets[] = { 0, 4, 8, 12, 16 };
> > > +	static const enum dsi_lane_function functions[] = {
> > > +		DSI_LANE_CLK,
> > > +		DSI_LANE_DATA1,
> > > +		DSI_LANE_DATA2,
> > > +		DSI_LANE_DATA3,
> > > +		DSI_LANE_DATA4,
> > > +	};
> > 
> > Patch 05 of the series has a function (dsi_parse_lane_config) with
> > exactly the same static local declaration. Wouldn't be better to have an
> > static global declaration instead to save some space ? or are the values
> > from those functions going to differ in the near future ? 
> 
> True, the array could be a global, and no, I don't think they'll change
> in the near future.
> 
> But the data is more like function internal stuff than global data. The
> functions want to parse and set the lane configs in particular order,
> and use the array for that.
> 
> While the order happens to be the same in both functions, I still felt
> the array is internal to each function rather than global data.

Fine for me then.

Br,
Carlos

>  Looking
> from outside the function, the order doesn't matter. It's just an
> internal detail.
> 
>  Tomi
> 


