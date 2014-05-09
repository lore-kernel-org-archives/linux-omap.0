From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] OMAPDSS: Fix DSS clock multiplier issue on 3703 and
 probably 3630
Date: Fri, 9 May 2014 07:37:03 -0700
Message-ID: <20140509143703.GA17814@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-2-git-send-email-tony@atomide.com>
 <536C860E.1000501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:44284 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542AbaEIOhY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 May 2014 10:37:24 -0400
Content-Disposition: inline
In-Reply-To: <536C860E.1000501@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [140509 00:39]:
> On 30/04/14 02:52, Tony Lindgren wrote:
> > Otherwise we can get often errors like the following and the
> > display won't come on:
> > 
> > omapdss APPLY error: FIFO UNDERFLOW on gfx, disabling the overlay
> > omapdss APPLY error: SYNC_LOST on channel lcd, restarting
> > the output with video overlays disabled
> > 
> > There are some earlier references to this issue:
> > 
> > http://www.spinics.net/lists/linux-omap/msg59511.html
> > http://www.spinics.net/lists/linux-omap/msg59724.html
> 
> Those don't sound like the same issue, but it's hard to say. What kind
> of clock rates do you get? Cat you paste debugfs/omapdss/clk, with and
> without this patch?

Without this patch:
# cat /sys/kernel/debug/omapdss/clk 
[   24.833831] DSS: dss_runtime_get
[   24.837554] DSS: dss_runtime_put
[   24.840972] DISPC: dispc_runtime_get
[   24.844757] DISPC: dispc_runtime_put
- DSS -
DSS_FCK (DSS1_ALWON_FCLK) = 57600000
- DISPC -
dispc fclk source = DSS_FCK (DSS1_ALWON_FCLK)
fck             57600000        
- LCD -
LCD clk source = DSS_FCK (DSS1_ALWON_FCLK)
lck             57600000        lck div 1
pck             19200000        pck div 3


With this patch:
# cat /sys/kernel/debug/omapdss/clk 
[   34.580688] DSS: dss_runtime_get
[   34.584197] DSS: dss_runtime_put
[   34.587768] DISPC: dispc_runtime_get
[   34.591552] DISPC: dispc_runtime_put
- DSS -
DSS_FCK (DSS1_ALWON_FCLK) = 108000000
- DISPC -
dispc fclk source = DSS_FCK (DSS1_ALWON_FCLK)
fck             108000000       
- LCD -
LCD clk source = DSS_FCK (DSS1_ALWON_FCLK)
lck             108000000       lck div 1
pck             18000000        pck div 6
 
> What resolution do you have? If it's a very high resolution (say, DVI
> output to a monitor), it could just be an issue of
> not-enough-memory-bandwidth.

This is just the 3730-evm with the Sharp VGA panel mentioned in
this series.
 
> > It seems that it's safe to set the lower values even for 3630.
> > If we can confirm that 3630 works with the higher values
> > reliably we can add further detection.
> > 
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > ---
> >  drivers/video/fbdev/omap2/dss/dss.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/omap2/dss/dss.c b/drivers/video/fbdev/omap2/dss/dss.c
> > index d55266c..ad6561f 100644
> > --- a/drivers/video/fbdev/omap2/dss/dss.c
> > +++ b/drivers/video/fbdev/omap2/dss/dss.c
> > @@ -707,9 +707,10 @@ static const struct dss_features omap34xx_dss_feats __initconst = {
> >  	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
> >  };
> >  
> > +/* Supposedly 3630 can use div 32 mult 2, but that needs to be rechecked */
> >  static const struct dss_features omap3630_dss_feats __initconst = {
> > -	.fck_div_max		=	32,
> > -	.dss_fck_multiplier	=	1,
> > +	.fck_div_max		=	16,
> > +	.dss_fck_multiplier	=	2,
> 
> These values tell about the clock hardware, they are not settings that
> can be changed to change the clock. OMAP3630 has a fixed x2 multiplier
> and a divider with maximum value of 16.
> 
>  Tomi
> 
> 


