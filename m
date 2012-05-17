From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Thu, 17 May 2012 15:16:24 +0100
Message-ID: <20120517141624.GA20096@n2100.arm.linux.org.uk>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com> <4FB3D294.4020505@wwwdotorg.org> <CAJe_Zhe6uT7u-+0VEx2XCieuynmK5nOO=4DSpDDS_Q=N8-QtPA@mail.gmail.com> <201205161942.20296.arnd@arndb.de> <20120517132223.GB9650@n2100.arm.linux.org.uk> <20120517135236.GA5807@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:53893 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761223Ab2EQOQu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 May 2012 10:16:50 -0400
Content-Disposition: inline
In-Reply-To: <20120517135236.GA5807@sirena.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Arnd Bergmann <arnd@arndb.de>, device-tree <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, Jassi Brar <jaswinder.singh@linaro.org>, Jon Hunter <jon-hunter@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>

On Thu, May 17, 2012 at 02:52:36PM +0100, Mark Brown wrote:
> On Thu, May 17, 2012 at 02:22:23PM +0100, Russell King - ARM Linux wrote:
> 
> > DMA on the other hand seems to have cases where you can make a choice
> > between two or more providers of the service.  The impression that I'm
> > getting from this thread is that it's difficult to describe that kind
> > of relationship in DT - DT is good at describing "A provides X to C"
> > but not "A _or_ B provides X to C and you can chose either A or B
> > depending on <something> to satisfy X".
> 
> A similar thing exists in a lot of clock trees - often the final clock
> block before an IP block includes a mux which could come from one of a
> number of sources.

At least there, the problem is easier, because we have in place a way
to represent muxes separately from everything else.

DMA engine is totally different; there is no representation of this, and
I don't see a sane way that it _could_ be represented given the existing
structure - certainly not without a major rework.

The first problem is that there is no support for any kind of layering in
dma engine at all.

The second problem is that you're actually dealing with muxes at two
levels - when you have an external mux to the DMA engine, you normally
already have a mux internally within the DMA engine.  And you need to
set these muxes dynamically according to the next DMA activity that the
physical DMA channel is about to process.

That becomes even more fun when you have setups like on the Realview
platforms where you have one set of bits which multiplex several
different DMA request signals, so changing the mux for one signal
changes others.  What this means is that you may only find out that
you can't route the DMA request when you try to change the muxes to
route your DMA request into the DMA controller.

It's all _very_ icky and horrible.  Clock muxes are much saner.

That said, I'm quite prepared to say "ok, we just don't bother dealing
with that DMA issue on platforms like Realview, hard luck if your
hardware team thought it was a good idea, we don't support it."
