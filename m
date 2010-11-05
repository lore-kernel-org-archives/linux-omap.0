From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v5 0/3] OMAP2/3: DMA: FIFO drain errata fixes
Date: Fri, 5 Nov 2010 14:29:02 -0700
Message-ID: <20101105212902.GU9264@atomide.com>
References: <1286261141-1039-1-git-send-email-peter.ujfalusi@nokia.com>
 <20101005181525.GL3117@atomide.com>
 <20101008221746.GS7558@atomide.com>
 <201010211305.17559.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:60483 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751893Ab0KEV32 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 17:29:28 -0400
Content-Disposition: inline
In-Reply-To: <201010211305.17559.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King <rmk+kernel@arm.linux.org.uk>, Peter Ujfalusi <peter.ujfalusi@nokia.com>

Hi Greg,

Considering below..

* Peter Ujfalusi <peter.ujfalusi@nokia.com> [101021 02:56]:
> Sorry, I did missed this mail...
> 
> On Saturday 09 October 2010 01:17:46 ext Tony Lindgren wrote:
> 
> > Guys, as we're so late into getting 2.6.36 tagged, I'm thinking about just
> > queueing these for 2.6.37 for the following reasons:
> > 
> > - The 24xx patch is a fix for commit c12abc0 that's was merged over a
> >   year ago. We've lived with it for over a year now. What difference does
> >   extra few more months make if we have it in 2.6.37 instead of 2.6.36?
> > 
> > - The second 34xx fix seems to happen only when disabling DMA on the fly.
> >   Again, we've had support for 34xx in the mainline kernel for a few
> >   years, and we're not seeing unrecoverable issues with MMC or USB or
> >   any other code calling omap_dma_stop().
> > 
> > Sure these fix major issues with the DMA, but are these really critical
> > for 2.6.36?
> > 
> > So if you really want me to argue for merging these into 2.6.36, please let
> > me know some oops causing cases or data corruption that happens without
> > these patches.
> 
> Well 2.6.36 is released.
> I still would like to see this to be part of the 2.6.36.1 release. We can 
> reproduce the DMA error in 2.6.36 with audio.
> 
> Tony: can you make sure it is going to part of 2.6.36.1?

..are you interested in these two patches for stable kernels?

The two patches in question are the following mainline commits:

3e57f1626b5febe5cc99aa6870377deef3ae03cc
0e4905c0199d683497833be60a428c784d7575b8

Regards,

Tony
