From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC v2] dmaengine: omap-dma: Start DMA without delay for
	cyclic channels
Date: Mon, 8 Apr 2013 18:09:56 +0100
Message-ID: <20130408170956.GX30923@n2100.arm.linux.org.uk>
References: <1364987862-14597-1-git-send-email-peter.ujfalusi@ti.com> <51626D88.8020809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:54379 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934769Ab3DHRKh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 13:10:37 -0400
Content-Disposition: inline
In-Reply-To: <51626D88.8020809@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Meerwald <pmeerw@pmeerw.net>

On Mon, Apr 08, 2013 at 09:11:04AM +0200, Peter Ujfalusi wrote:
> Russell,
> 
> On 04/03/2013 01:17 PM, Peter Ujfalusi wrote:
> > cyclic DMA is only used by audio which needs DMA to be started without a
> > delay.
> > If the DMA for audio is started using the tasklet we experience random
> > channel switch (to be more precise: channel shift).
> > 
> > Reported-by: Peter Meerwald <pmeerw@pmeerw.net>
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > ---
> > Hi Russell,
> > 
> > Instead of removing the tasklet we can identify the DMA channel used by audio
> > based on the cyclic flag of the channel.
> > I think this can be used as a short term solution to fix the audio channel shift
> > issue and later when we have the dynamic DMA channel allocation we can adjust
> > the code.
> 
> Could you, please look at this patch?

Now that I'm back from a short 4 day break, then yes, and the answer is
that it's fine.  Who's handling the patch?
