From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 10/10] OMAP: DSS2: DSI Video mode support
Date: Mon, 05 Sep 2011 09:52:13 +0300
Message-ID: <1315205533.2130.17.camel@deskari>
References: <1314701495-11247-1-git-send-email-archit@ti.com>
	 <1314701495-11247-11-git-send-email-archit@ti.com>
	 <1314882869.2169.22.camel@lappyti>  <4E606675.5010403@ti.com>
	 <1314941566.1907.16.camel@deskari>  <4E6073FC.3070107@ti.com>
	 <1314950143.3374.30.camel@deskari>  <4E646397.9030107@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:53783 "EHLO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750744Ab1IEGwS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Sep 2011 02:52:18 -0400
Received: by bkbzs2 with SMTP id zs2so4030457bkb.25
        for <linux-omap@vger.kernel.org>; Sun, 04 Sep 2011 23:52:16 -0700 (PDT)
In-Reply-To: <4E646397.9030107@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, 2011-09-05 at 11:22 +0530, Archit Taneja wrote:
> On Friday 02 September 2011 01:25 PM, Valkeinen, Tomi wrote:
> > On Fri, 2011-09-02 at 11:43 +0530, Archit Taneja wrote:
> >>> Sending a null packet to start the DDR clk is rather OMAP specific
> >>> internal thing, so I don't want to require the panel driver to need
> >> to
> >>> know that it must send a null packet to start the clock. So if the
> >> ddr
> >>> clk is not started automatically, I think we should have a function
> >> to
> >>> do that (dsi_start_ddr_clk or whatever), which will then send the
> >> null
> >>> packet (and perhaps return an error if DDR_CLK_ALWAYS_ON is not set,
> >>> dunno...).
> >>
> >> Okay, If we can confirm that a panel asks for DDR_CLK_ALWAYS_ON
> >> mainly
> >> because it doesn't have its own fclk, then the dsi driver surely
> >> needs
> >> to start the DDR clock by sending a NULL packet.
> >>
> >> If this is to be done, one thing that has to be thought of is:
> >>
> >> - We need one of the requested VC's to be in HS mode for this. Do we
> >> enable HS for a VC in the dsi driver itself? Currently, its the job
> >> of
> >> the panel driver to enable HSmode for a VC. Is this a clean approach?
> >
> > I have to say I don't have any idea what would be the best approach...
> >
> > What comes to my mind is that the DSI driver could automatically send
> > the null packet, when:
> >
> > a) ddr_clk_always_on is set
> > b) a channel is changed to HS and enabled (I guess it needs to be
> > enabled also, does it?)
> 
> This approach sounds fine. The only drawback is that we send a NULL 
> packet each time we enable a high speed channel. So if a panel is using 
> 2 VCs, and it wants high speed for both channels(for some reason), we 
> will be sending a NULL packet unnecessarily.

True. I don't see that doing any harm, though, so I guess it's ok.

> One observation was that the DDR clock has to be enabled only after the 
> bridge chip is reset. Enabling HS, and sending a NULL packet before 
> doing a hw reset of the bridge chip doesn't bring up the panel(that is a 
> bit peculiar). So we can't do this within omapdss_dsi_display_enable().

Well that does sound strange. What happens there? Any errors? Commands
still going through?

Hmm, although... Well, I'm guessing, but if the HW reset for the chip
causes the chip to pull down the DSI lanes, or something similar, it
could cause errors in the OMAP side. But is that happening or something
else?

 Tomi


