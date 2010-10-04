From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 4/4] OMAP3: DMA: Errata i541: sDMA FIFO draining
 does not finish
Date: Mon, 4 Oct 2010 09:55:16 -0700
Message-ID: <20101004165515.GS3117@atomide.com>
References: <1286180294-32618-1-git-send-email-peter.ujfalusi@nokia.com>
 <1286180294-32618-5-git-send-email-peter.ujfalusi@nokia.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CA49@dbde02.ent.ti.com>
 <201010041342.33238.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53890 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419Ab0JDQzS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 12:55:18 -0400
Content-Disposition: inline
In-Reply-To: <201010041342.33238.peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "ext G, Manjunath Kondaiah" <manjugk@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

* Peter Ujfalusi <peter.ujfalusi@nokia.com> [101004 03:33]:
> On Monday 04 October 2010 12:17:41 ext G, Manjunath Kondaiah wrote:
> > 
> > ...
> > 
> > > +	/* OMAP3 Errata i541: sDMA FIFO draining does not finish */
> > 
> > This logic is required for multiple erratas.
> 
> As Tony requested, I have added a variable for flags to handle the different 
> erratas. I even added a macro to check that the errata applies, so one can use:
> if (IS_DMA_ERRATA(DMA_ERRATA_XXXXX))
> 
> > Can we have seperate
> > function for handling this logic. More details at:
> > https://patchwork.kernel.org/patch/126271/
> 
> I see. That patch is for hwmod converted dma code, right?
> We need this fix without the hwmod to applied, and than backport it to earlier 
> kernel releases.
> 
> > As I mentioned in other mail, if you are introducing this feature,
> > it is better to convert existing erratas also to use this feature.
> 
> The upcoming hwmod conversion will take care of the cleanup.
> We _need_ these two small fixes ASAP, since it is fixing serious problem in 
> audio (and the same issue might bite other areas as well).
> It is not the intention of this series to clean up the arc/arm/plat-omap/dma.c.
> 
> I have added the dma_errata variable, since Tony asked for it, but even that 
> addition is a bigger change than what I was planning to do here.

Yeah.. Let's just use your original patch for the fix, then queue
adding the errata flag for the upcoming merge window.

Regards,

Tony
