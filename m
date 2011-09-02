From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 10/10] OMAP: DSS2: DSI Video mode support
Date: Fri, 02 Sep 2011 08:32:46 +0300
Message-ID: <1314941566.1907.16.camel@deskari>
References: <1314701495-11247-1-git-send-email-archit@ti.com>
	 <1314701495-11247-11-git-send-email-archit@ti.com>
	 <1314882869.2169.22.camel@lappyti>  <4E606675.5010403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:37722 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751459Ab1IBFcw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Sep 2011 01:32:52 -0400
Received: by fxg7 with SMTP id 7so2037391fxg.35
        for <linux-omap@vger.kernel.org>; Thu, 01 Sep 2011 22:32:49 -0700 (PDT)
In-Reply-To: <4E606675.5010403@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2011-09-02 at 10:45 +0530, Archit Taneja wrote:
> Hi,
> 
> On Thursday 01 September 2011 06:44 PM, Valkeinen, Tomi wrote:
> > On Tue, 2011-08-30 at 16:21 +0530, Archit Taneja wrote:
> >> Add initial support for DSI video mode panels:
> >> - Add a new structure omap_dss_dsi_videomode_data in the member "panel" in
> >>    omap_dss_device struct. This allows panel driver to configure dsi video_mode
> >>    specific parameters.
> >> - Configure basic DSI video mode timing parameters: HBP, HFP, HSA, VBP, VFP, VSA,
> >>    TL and VACT.
> >> - Configure DSI protocol engine registers for video_mode support.
> >> - Introduce functions dsi_video_mode_enable() and dsi_video_mode_disable() which
> >>    enable/disable video mode for a given virtual channel and a given pixel format
> >>    type.
> >>
> >> Things left for later
> >> - Add functions to check for errors in video mode timings provided by panel.
> >> - Configure timing registers required  for command mode interleaving.
> >>
> >> Signed-off-by: Archit Taneja<archit@ti.com>
> >> ---
> >>   drivers/video/omap2/dss/dsi.c |  256 ++++++++++++++++++++++++++++++++++++-----
> >>   include/video/omapdss.h       |   32 +++++
> >>   2 files changed, 259 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/drivers/video/omap2/dss/dsi.c b/drivers/video/omap2/dss/dsi.c
> >> index 582ae7b..e3d5c38 100644
> >> --- a/drivers/video/omap2/dss/dsi.c
> >> +++ b/drivers/video/omap2/dss/dsi.c
> >> @@ -132,7 +132,7 @@ struct dsi_reg { u16 idx; };
> >>   #define DSI_IRQ_TA_TIMEOUT	(1<<  20)
> >>   #define DSI_IRQ_ERROR_MASK \
> >>   	(DSI_IRQ_HS_TX_TIMEOUT | DSI_IRQ_LP_RX_TIMEOUT | DSI_IRQ_SYNC_LOST | \
> >> -	DSI_IRQ_TA_TIMEOUT)
> >> +	DSI_IRQ_TA_TIMEOUT | DSI_IRQ_SYNC_LOST)
> >>   #define DSI_IRQ_CHANNEL_MASK	0xf
> >>
> >>   /* Virtual channel interrupts */
> >> @@ -2472,6 +2472,12 @@ static int dsi_cio_init(struct omap_dss_device *dssdev)
> >>
> >>   	dsi_cio_timings(dsidev);
> >>
> >> +	if (dssdev->panel.dsi_mode == OMAP_DSS_DSI_VIDEO_MODE) {
> >> +		/* DDR_CLK_ALWAYS_ON */
> >> +		REG_FLD_MOD(dsidev, DSI_CLK_CTRL,
> >> +			dssdev->panel.dsi_vm_data.ddr_clk_always_on, 13, 13);
> >> +	}
> >> +
> >
> > For the DDR clock to start, you need to send a null packet, don't you?
> 
> Yes, we have to send a null packet, but that is for the case when DDR 
> clock is required by the panel to function properly. Hence we need to 
> start the DDR clock right at the beginning(before we start sending 
> DCS/generic commands to configure the panel).
> 
> The panel driver may set DDR_CLK_ALWAYS_ON even if it has its own 
> internal clock to function. In that case, we don't need it to be enabled 
> right at the beginning, i.e, when we send DCS commands to configure the 
> panel. In this case, the signal TxRequestHS will be asserted later on 
> when we enable video mode for a VC, and that will start the DDR clock.

Why would the panel need DDR_CLK_ALWAYS_ON if it has an another fclk?
I'm not that familiar with video mode, but somehow it would sound
logical that if the panel wants DDR clock to be always on, it should be
started right from the beginning. And if the panel doesn't need DDR
clock to be always on, there's no need to even set DDR_CLK_ALWAYS_ON.

> I had left out the "sending null packet" part as I think its a more 
> specific case. Setting DDR_CLK_ALWAYS_ON affects timing calculations, 
> that is why I added it as a configurable parameter for the panel driver.

Ok. But your patches handle the calculations, don't they?

Sending a null packet to start the DDR clk is rather OMAP specific
internal thing, so I don't want to require the panel driver to need to
know that it must send a null packet to start the clock. So if the ddr
clk is not started automatically, I think we should have a function to
do that (dsi_start_ddr_clk or whatever), which will then send the null
packet (and perhaps return an error if DDR_CLK_ALWAYS_ON is not set,
dunno...).

 Tomi


