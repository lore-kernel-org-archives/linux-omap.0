From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: omap-mcpdm: Replace legacy driver
Date: Thu, 7 Jul 2011 09:53:29 -0700
Message-ID: <20110707165329.GG16325@opensource.wolfsonmicro.com>
References: <1310041672-18634-1-git-send-email-peter.ujfalusi@ti.com>
 <1310041672-18634-2-git-send-email-peter.ujfalusi@ti.com>
 <20110707155742.GC16325@opensource.wolfsonmicro.com>
 <4E15DFAA.7030508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:36488 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754037Ab1GGQxe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jul 2011 12:53:34 -0400
Content-Disposition: inline
In-Reply-To: <4E15DFAA.7030508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Liam Girdwood <lrg@ti.com>
Cc: "Ujfalusi, Peter" <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lopez Cruz, Misael" <misael.lopez@ti.com>, "Guiriec, Sebastien" <s-guiriec@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>

On Thu, Jul 07, 2011 at 05:32:42PM +0100, Liam Girdwood wrote:
> On 07/07/11 16:57, Mark Brown wrote:
> > On Thu, Jul 07, 2011 at 03:27:50PM +0300, Peter Ujfalusi wrote:

> >> The current McPDM driver design is not suitable to support both
> >> the ABE and Legacy DMA operating modes. Therefore remove most

> > In what way is it not suitable?

> It cant support both the ABE and Legacy DMA modes without adding some
> unnecessary and complicated logic. My preference is 1 driver to
> support both modes of operation and this is the easiest way to do so
> (also keeping the maintenance easier too).

My comment was more that the changelog should say why it's not suitable
given that it involves a near total rewrite of the driver which is a
pretty big step, I'm fine with the actual change.  I guess that the
current McPDM driver configures some things that should be moved to the
DMA driver?

> > It occurs to me that it'd be much simpler to implement this by doing the
> > cleanup in your runtime suspend callback, it looks like you're working
> > around the pm_runtime framework rather than using it.  If you need to do
> > some cleanup when the device goes idle and you can't do it within a
> > framework designed to suspend the device when it goes idle then there's
> > an issue there.

> > Alternatively, why is this deferred?

> There are some power, clock and pop dependencies here between the
> CODEC, ABE and McPDM interface and this deferred work allows us to
> shutwdown McPDM (in a pop free manner) and satisfy the dependencies
> without causing a data abort and/or locking the ABE firmware.

Sounds like runtime PM ought to be able to handle this, though?  If you
need to sync with the ABE can the ABE take PM references to the DAIs
it's talking to?  I guess the ABE will be happier if everything it's
talking to runs for longer than it does.  Or the DAI could switch into
autosuspend mode when it goes idle to do the delay.
