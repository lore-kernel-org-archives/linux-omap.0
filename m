From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Audio support on OMAP 3430LDP or 4430SDP boards
Date: Fri, 27 Apr 2012 16:09:01 +0100
Message-ID: <20120427150901.GB28062@n2100.arm.linux.org.uk>
References: <20120427135802.GA28062@n2100.arm.linux.org.uk> <CAMQu2gw0pYcb5SoVLbWPL4rfda24EZVPPUUziU8gxZxviDBLZg@mail.gmail.com> <1335538602.4150.12.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42722 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760359Ab2D0PJM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Apr 2012 11:09:12 -0400
Content-Disposition: inline
In-Reply-To: <1335538602.4150.12.camel@odin>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>
Cc: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

On Fri, Apr 27, 2012 at 03:56:42PM +0100, Liam Girdwood wrote:
> On Fri, 2012-04-27 at 19:45 +0530, Shilimkar, Santosh wrote:
> > + Peter and Liam to comment
> > 
> > On Fri, Apr 27, 2012 at 7:28 PM, Russell King - ARM Linux
> > <linux@arm.linux.org.uk> wrote:
> > > Can someone please hint on what audio is supported on these two OMAP
> > > boards?  From what I can tell, the answer is either "nothing" or "hdmi",
> > > both of which are useless to me if someone wants me to convert the OMAP
> > > ASoC driver to DMA engine.
> > >
> > > From what I can see on the 4430SDP, there's a 3.5mm headset jack,
> > > microphones and speakers on the board, so the board does have audio
> > > hardware.  However, it seems (as, I'm afraid to say, seems to be pretty
> > > much standard practice with OMAP) there's a total lack of software
> > > support in mainline.
> > >
> > > This kind'a prevents me testing changes to the DMA support for OMAP
> > > ASoC...
> > >
> > > What can be done to remedy this situation?
> > >
> 
> Peter now has has the final patches for Legacy mode (i.e. without ABE)
> now upstream in 3.4-rc. Legacy mode gives a direct SDMA -> McPDM ->
> twl6040 audio path so would be a good starting point for DMA testing.

Sorry, what's ABE?  Association of Business Executives?  Association of
Building Engineers?

I had noticed that there's sound/soc/omap/snd-soc-omap-abe-twl6040.ko
which needs a bunch of other modules, but even this doesn't cause any
cards to show up.

So, I'm guessing that the real answer to my problem is that there is no
functional audio support on any OMAP board I have, and, therefore, I am
unable to continue with the work which TI would like me to do.  That's
great.  That's really bloody well great.

I'm going to leave this in Santosh's hands to deal with, and arrange to
get more complete and functional board support for any board that TI send
me into mainline - for example, I _still_ don't have any working video
output on the 4430SDP board.  Utter crap.

In fact, the only things that do work on the 4430SDP are serial and
network.  At least the 3430LDP has video output on its LCD.

When will support for OMAP based platforms become a reasonable reality?
When will people stop pissing around with utterly shit incomplete board
support?

I'm shelving further OMAP work until board support for these targets
improves to a state where a reasonable amount of the platform is
supported.  Until that time I'm not wasting any more of my time trying
to work out what I can do to assist OMAP along.
