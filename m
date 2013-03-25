From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [alsa-devel] channel swapping issue on OMAP3/TWL4030 is back
Date: Mon, 25 Mar 2013 17:15:40 +0000
Message-ID: <20130325171540.GO30923@n2100.arm.linux.org.uk>
References: <alpine.DEB.2.01.1303220932150.7975@pmeerw.net> <alpine.DEB.2.01.1303221023070.7975@pmeerw.net> <514C2E5E.2040909@gmail.com> <alpine.DEB.2.01.1303221348250.7975@pmeerw.net> <514C56EA.7020304@ti.com> <20130322163506.GL30923@n2100.arm.linux.org.uk> <51504581.10400@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44135 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756524Ab3CYRQH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 Mar 2013 13:16:07 -0400
Content-Disposition: inline
In-Reply-To: <51504581.10400@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Peter Meerwald <pmeerw@pmeerw.net>, Daniel Mack <zonque@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org

On Mon, Mar 25, 2013 at 01:39:29PM +0100, Peter Ujfalusi wrote:
> On 03/22/2013 05:35 PM, Russell King - ARM Linux wrote:
> > On Fri, Mar 22, 2013 at 02:04:42PM +0100, Peter Ujfalusi wrote:
> >> Russell: can we remove the tasklet use from dma-omap and start the DMA right
> >> away in omap_dma_issue_pending()? This is the only way to prevent channel
> >> swap when starting audio.
> > 
> > What I fear is that we may run up against having too many DMA channels
> > tied up to the peripherals.  I structured the driver in this way to
> > allow us to move the physical DMA channel allocation to that tasklet
> > when that becomes a problem.
> > 
> > Not only that but I was hoping to lift some more of this code out of
> > DMA engine drivers, so DMA engine drivers had even less code in them.
> 
> Not sure what you mean by this. Move dmaengine core's issue_pending to a
> tasklet or is only OMAP internal restructuring?

There isn't any "core" issue_pending code.  DMA engine is nothing much
beyond a collection of drivers sort-of implementing a common API.  Very
little code is shared between drivers.

What I'm talking about is having a physical channel scheduler in place
across DMA engines which have more virtual channels than physical
channels.  Some DMA engine implementations sort of do this already (eg,
AMBA PL08x stuff) but again, every driver implements this kind of thing
by themselves.

> > I guess we could keep the tasklet, but mark the audio DMA channels as
> > "pre-reserved" and arrange for pre-reserved channels to avoid the
> > tasklet, rather than throwing the tasklet out completely.
> 
> Not sure if we really want to pre-reserve the DMA channels for audio:
> on OMAP3 we have 5 McBSP -> 10 DMA channels
> on OMAP4 we have 4 McBSP, one McPDM, one DMIC and one McASP + we have the
> AESS/ABE -> 8 + 2 + 1 + 1 + 8 (AESS/ABE).
> Do we really want to pre-allocate DMA channel for all of these?

Well, at the moment we are effectively pre-allocating a physical channel
for every virtual channel - as each virtual channel gets allocated.  So,
the physical channels are currently being permanently tied up.

With a scheduling core, we need some way to dynamically reallocate
physical channels depending on the workload presented on the virtual
channels.  However, as we're still having to deal with the OMAP private
DMA API, we can only change physical channels from task (or tasklet)
context.

So, the only way to have audio channels in a condition where they can
be startable immediately in issue_pending is to avoid the tasklet, and
the only way to avoid that tasklet (where that tasklet eventually
becomes the channel scheduler) is to have pre-allocated the physical
channel.

> I have a patch which removes the tasklet from omap-dma.c and it is working
> fine on my systems (OMAP3 Zoom2, BeagleBoard, OMAP4 PandBoard, OMAP4 Blaze).

I'm sure you have, but that breaks the future direction of the driver
to dynamically allocate the physical channels.

Had TI not effectively terminated my contract, I might be further forward
with this.  As things are, lack of contract and such like, all the OMAP
work I was doing got shelved around Christmas time.  If you stop paying
people, they generally stop doing useful work for you...
