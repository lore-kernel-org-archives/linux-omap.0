From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: DSS2/PM on 3.2 broken?
Date: Wed, 18 Jan 2012 13:42:20 +0200
Message-ID: <1326886940.1999.5.camel@lappy>
References: <WC20120109124643.880164@terrafix.co.uk>
	 <20120110080849.5a242adf@notabene.brown>
	 <alpine.DEB.2.00.1201110632100.31702@utopia.booyaka.com>
	 <20120112095940.0a54413e@notabene.brown>
	 <alpine.DEB.2.00.1201130253070.3659@utopia.booyaka.com>
	 <20120113222045.37f9b4ec@notabene.brown> <1326870839.1954.23.camel@deskari>
	 <20120118221538.342b4782@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:59599 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756047Ab2ARLnG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jan 2012 06:43:06 -0500
Received: by lahe6 with SMTP id e6so1040455lah.41
        for <linux-omap@vger.kernel.org>; Wed, 18 Jan 2012 03:42:24 -0800 (PST)
In-Reply-To: <20120118221538.342b4782@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Paul Walmsley <paul@pwsan.com>, Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, t-kristo@ti.com, govindraj.r@ti.com, linux-omap@vger.kernel.org

On Wed, 2012-01-18 at 22:15 +1100, NeilBrown wrote:
> On Wed, 18 Jan 2012 09:13:59 +0200 Tomi Valkeinen <tomi.valkeinen@ti.com>
> wrote:
> 
> > On Fri, 2012-01-13 at 22:20 +1100, NeilBrown wrote:
> > > Having CPUIDLE makes the DSS2 problem worse: lots of 
> > > 
> > > [   21.085113] omapdss DISPC error: SYNC_LOST on channel lcd,
> > > restarting the output with video overlays disabled
> > > 
> > > messages whenever the CPU isn't busy.
> > 
> > I'm not sure if it is the case here, but DSS has restrictions about the
> > max DSS clocks on different OPPs. For example, on OMAP4430 LCD clock
> > maximum is 186MHz at OPP100, and 93MHz at OPP50. So it's a quite big
> > drop, causing problems with all but the rather small displays.
> > 
> > And the DSS driver doesn't have any support to handle this at the
> > moment, as there isn't support in the PM framework to do this. I think
> > the only way to handle this at the moment is for the DSS driver to set
> > an arbitrarily high constraint on, say, mem throughput, and hope that it
> > keeps the OMAP in the required OPP.
> > 
> >  Tomi
> > 
> 
> This LCD panel on this device sets:
>    .pixel_clock	= 22000,
> in the "struct omap_video_timings" so I'm guessing that is 22MHz?

No, that's the pixel clock. There are probably limitations on the pix
clock also, but usually the problem is the functional clocks, which need
to be n x pck, where n depends on the needs for scaling.

 Tomi


