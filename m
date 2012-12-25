From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: Re: [PATCH 00/15] OMAP SHAM & AES Crypto Updates
Date: Tue, 25 Dec 2012 12:29:37 -0700
Message-ID: <20121225192937.GD4846@animalcreek.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com>
 <alpine.DEB.2.00.1212230836160.16045@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:45014 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137Ab2LYT3i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 25 Dec 2012 14:29:38 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1212230836160.16045@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jon Hunter <jon-hunter@ti.com>

On Sun, Dec 23, 2012 at 08:40:43AM +0000, Paul Walmsley wrote:
> Hi Mark,
> 
> On Fri, 21 Dec 2012, Mark A. Greer wrote:
> 
> > From: "Mark A. Greer" <mgreer@animalcreek.com>
> > 
> > [This series supersedes the hwmod related patches sent in the
> >  "crypto: omap-sham updates" and "crypto: omap-aes updates"
> >  series a few weeks ago.]
> > 
> > This series adds hwmod support for the OMAP SHAM and AES
> > modules on OMAP2, OMAP3, and OMAP4/AM33XX SoCs.  It also
> > adds device tree info for those modules.
> 
> Thanks for working on this, this will get us much closer to being able to 
> convert the hwmod code into an OMAP bus.  I haven't looked closely at 
> these patches yet, but a few comments/questions:
> 
> - Looks like the two DTS patches are the ones with direct dependencies on 
> the DMA Engine support patches that you mentioned.

The patch(es) that convert the drivers to use
dma_request_slave_channel_compat() will cause problems too if the
patch that adds that call isn't in your branch.  AFAIK, this is the
latest version, https://patchwork.kernel.org/patch/1459231/ from
Jon Hunter.

> Any objection to me 
> taking the series without those two patches?  Then once the DMA Engine 
> series goes in, maybe those AM33xx DTS patches can go up?

No, no objections at all.  I will track/resubmit/whatever the ones that
need to go in later.

> - The patch series causes AM3517/3505 to crash.  I'd guess this is due to 
> the SHAM/AES modules being initialized on those chips, but they probably 
> don't exist there.  Can you change the initialization for those on OMAP3 
> to only take place on OMAP34xx/36xx GP?  I guess you'd need to create new 
> lists for those in the hwmod init.

Oh.  :(

Sure, I'll do what you suggest when I'm back to work in the new year.

Thanks Paul.

Mark
--
