From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [PATCH] OMAP: DSS: Fix for dsi_pll to dpll4 clk switch
Date: Wed, 30 Jun 2010 14:38:44 +0300
Message-ID: <1277897924.2474.224.camel@tubuntu.research.nokia.com>
References: <FF55437E1F14DA4BAEB721A458B6701706BDB3A5CA@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:54323 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab0F3LjK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 30 Jun 2010 07:39:10 -0400
In-Reply-To: <FF55437E1F14DA4BAEB721A458B6701706BDB3A5CA@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Nagarajan, Rajkumar" <x0133774@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Tue, 2010-06-29 at 16:13 +0200, ext Nagarajan, Rajkumar wrote:
> 
> > -----Original Message-----
> > From: Tomi Valkeinen [mailto:tomi.valkeinen@nokia.com] 
> > Sent: Thursday, June 24, 2010 4:21 PM
> > To: Nagarajan, Rajkumar
> > Cc: linux-omap@vger.kernel.org
> > Subject: Re: [PATCH] OMAP: DSS: Fix for dsi_pll to dpll4 clk switch
> > 
> > On Thu, 2010-06-17 at 07:12 +0200, ext Nagarajan, Rajkumar wrote:
> > > When switching between clocks, The new functional clock is
> > > effective when the next vertical blanking interval occurs.
> > > GOLCD bit has to be set for the new clock to take effect.
> > 
> > Where did you encounter this problem?
> > 
> Raj: The below experiments will make you to understand the significance of the patch:
> 
> 1. Select "dsi_pll" as default clock.
> 2. After the zoom3 display comes up,switch the default screen on LCD to TV using below commands.
> 	echo "0" > /sys/devices/platform/omapdss/overlay0/enabled
> 	echo "720,574" > /sys/devices/platform/omapdss/overlay0/input_size
> 	echo "720,574" > /sys/devices/platform/omapdss/overlay0/output_size
> 	echo "tv" >  /sys/devices/platform/omapdss/overlay0/manager
> 	echo "1" > /sys/devices/platform/omapdss/display1/enabled
> 	echo "1" > /sys/devices/platform/omapdss/overlay0/enabled
> 3. Now the display is appearing on TV.So, Now switch the display back to LCD using the below commands.
> 	echo "0" > /sys/devices/platform/omapdss/overlay0/enabled
> 	echo "800,480" > /sys/devices/platform/omapdss/overlay0/input_size
> 	echo "800,480" > /sys/devices/platform/omapdss/overlay0/output_size
> 	echo "lcd" >  /sys/devices/platform/omapdss/overlay0/manager
> 	echo "1" > /sys/devices/platform/omapdss/display1/enabled
> 	echo "1" > /sys/devices/platform/omapdss/overlay0/enabled
> 4. Now the display will not appear on LCD,if the patch is not included.
>     But,the display will appear on LCD, if the patch is included.

The LCD is never turned off in the sequence above. Was that supposed to
be there somewhere?

> > > Signed-off-by: Kishore Y <kishore.y@ti.com>
> > > Signed-off-by: Mukund Mittal <mmittal@ti.com>
> > > Signed-off-by: Rajkumar N <rajkumar.nagarajan@ti.com>
> > > ---
> > >  drivers/video/omap2/dss/dpi.c |    5 +++++
> > >  1 files changed, 5 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/drivers/video/omap2/dss/dpi.c 
> > b/drivers/video/omap2/dss/dpi.c
> > > index 960e977..5d778d6 100644
> > > --- a/drivers/video/omap2/dss/dpi.c
> > > +++ b/drivers/video/omap2/dss/dpi.c
> > > @@ -214,10 +214,15 @@ void 
> > omapdss_dpi_display_disable(struct omap_dss_device *dssdev)
> > >  
> > >  #ifdef CONFIG_OMAP2_DSS_USE_DSI_PLL
> > >  	dss_select_dispc_clk_source(DSS_SRC_DSS1_ALWON_FCLK);
> > > +	dispc_go(OMAP_DSS_CHANNEL_LCD);
> > 
> > I don't think GO does anything here, as the channel has already been
> > disabled.
> Raj:This is the actual fix.So, the above experiment that I explained will be the usecase to understand the need of this statement.

So, how does the OMAP DSS HW actually work then? My understanding was
that GO bit doesn't do anything if the channel is disabled. It's only
used when the channel is enabled.

Setting the GO bit should make the new register changes to be effective
after next VFP. If the channel is disabled, there's no VFP, thus it
shouldn't do anything...?

Also related to using DSI PLL, there's an OMAP bug that causes glitches
on TV-out if DSI PLL is used for DISPC fclk, basically making DSI PLL
unusable for DISPC fclk. Have you encountered this?

 Tomi


