From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC] dmaengine: omap-dma: Allow DMA controller to prefetch
	data
Date: Fri, 19 Oct 2012 00:33:35 +0100
Message-ID: <20121018233335.GC28061@n2100.arm.linux.org.uk>
References: <20121018222046.GA28541@animalcreek.com> <20121018225540.GB28061@n2100.arm.linux.org.uk> <20121018232405.GA29064@animalcreek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55226 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932324Ab2JRXeR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Oct 2012 19:34:17 -0400
Content-Disposition: inline
In-Reply-To: <20121018232405.GA29064@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Ujfalusi <peter.ujfalusi@ti.com>

On Thu, Oct 18, 2012 at 04:24:05PM -0700, Mark A. Greer wrote:
> On Thu, Oct 18, 2012 at 11:55:40PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Oct 18, 2012 at 03:20:46PM -0700, Mark A. Greer wrote:
> > > This patch seems fairly stable but I've only tested omap-sham (crypto)
> > > and omap_hsmmc (mmc) on an am37x EVM.  I also enabled burst mode but
> > > that made the system unstable when exercising either omap-sham or
> > > omap_hsmmc.  I'm unaware of any errata that would make this an unwanted
> > > modification but I haven't checked all of the SoCs.  Are there other
> > > reasons that this should be applied??
> > 
> > It definitely needs checking with audio, because it will affect the
> > pointer position in relation to audio output, and it will have an
> > effect on how much audio data is lost over a pause/resume event.
> > 
> > Unfortunately, the OMAP DMA hardware has no way to do a proper "pause",
> > it can only do a "stop" which involves dumping its FIFOs on the floor
> > in the case of anything but a DEV->MEM transfer.  So the more data
> > held in the DMA hardware, the more is lost on pause.
> 
> Hmm, interesting.
> 
> Is there a way to tweak DMA params like this on a per logical channel
> basis using the dmaengine API?  I don't see any but I could have missed it.
> 
> If not, are you open to adding such a thing (e.g., extend 'enum dma_ctrl_flags'
> with DMA_ENABL_PREFETCH)?

I would suggest getting some feedback from the ASoC people first, before
trying to invent new APIs to work around this stuff.  If they can live
with having prefetch enabled on OMAP then there isn't an issue here.  If
not, we need a solution to this.

I do not believe that precisely stopping and starting playback across a
suspend/resume event is really necessary (it's desirable but the world
doesn't collapse if you miss a few samples.)  It could be more of an
issue for pause/resume though, but as I say, that's for ASoC people to
comment on.

I'm merely pointing out here that we need their feedback here before
deciding if there's anything further that needs to happen.
