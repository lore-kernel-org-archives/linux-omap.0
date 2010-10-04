From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: RE: [PATCH v4 4/4] OMAP3: DMA: Errata i541: sDMA FIFO draining does
 not finish
Date: Mon, 4 Oct 2010 16:34:01 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CB67@dbde02.ent.ti.com>
References: <1286180294-32618-1-git-send-email-peter.ujfalusi@nokia.com>
 <1286180294-32618-5-git-send-email-peter.ujfalusi@nokia.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CA49@dbde02.ent.ti.com>
 <201010041342.33238.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49761 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754711Ab0JDLEN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 07:04:13 -0400
In-Reply-To: <201010041342.33238.peter.ujfalusi@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jarkko Nikula <jhnikula@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>



> -----Original Message-----
> From: Peter Ujfalusi [mailto:peter.ujfalusi@nokia.com] 
> Sent: Monday, October 04, 2010 4:13 PM
> To: G, Manjunath Kondaiah
> Cc: Tony Lindgren; linux-omap@vger.kernel.org; Jarkko Nikula; 
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v4 4/4] OMAP3: DMA: Errata i541: sDMA 
> FIFO draining does not finish
> 
> On Monday 04 October 2010 12:17:41 ext G, Manjunath Kondaiah wrote:
> > 
> > ...
> > 
> > > +	/* OMAP3 Errata i541: sDMA FIFO draining does not finish */
> > 
> > This logic is required for multiple erratas.
> 
> As Tony requested, I have added a variable for flags to 
> handle the different erratas. I even added a macro to check 
> that the errata applies, so one can use:
> if (IS_DMA_ERRATA(DMA_ERRATA_XXXXX))
> 
> > Can we have seperate
> > function for handling this logic. More details at:
> > https://patchwork.kernel.org/patch/126271/
> 
> I see. That patch is for hwmod converted dma code, right?
> We need this fix without the hwmod to applied, and than 
> backport it to earlier kernel releases.
> 
> > As I mentioned in other mail, if you are introducing this 
> feature, it 
> > is better to convert existing erratas also to use this feature.
> 
> The upcoming hwmod conversion will take care of the cleanup.

If this is the case, not sure about intention of having dma_errata only
for these two erratas since all the erratas are not handled.

All the erratas will get cleaned up and errata handling feature
will be introduced along with dma hwmod changes.

If feel v3 version is better so that I can use these changes along 
dma hwmod.

It is upto Tony to decide.

> We _need_ these two small fixes ASAP, since it is fixing 
> serious problem in audio (and the same issue might bite other 
> areas as well).
> It is not the intention of this series to clean up the 
> arc/arm/plat-omap/dma.c.

Tony, 
How about having v3 series + review comments fixed(except comments
related errata handling). Errata handling will be done as part dma
hwmod. I am waiting for these patches so that I can rebase these
patches in DMA hwmod.

-Manjunath