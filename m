From: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
Subject: Re: [PATCH] gpio/omap: implement irq_enable/disable using
 mask/unmask.
Date: Mon, 25 Mar 2013 23:24:37 +0100
Message-ID: <20130325222437.GB6817@blumentopf>
References: <1355736437-14186-1-git-send-email-andreas.fenkart@streamunlimited.com>
 <50D2A94A.6060100@ti.com>
 <50D339F8.6050200@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.20]:57558 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933432Ab3CYWYm (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Mar 2013 18:24:42 -0400
Received: from mailout-de.gmx.net ([10.1.76.16]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0Ldb0m-1V2hAo3sG2-00incs for
 <linux-omap@vger.kernel.org>; Mon, 25 Mar 2013 23:24:40 +0100
Content-Disposition: inline
In-Reply-To: <50D339F8.6050200@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, Andreas Fenkart <andreas.fenkart@streamunlimited.com>, Kevin Hilman <khilman@deeprootsystems.com>, grant.likely@secretlab.ca, linus.walleij@linaro.org, linux-omap@vger.kernel.org, Daniel Mack <daniel@zonque.org>

Hi,

On Thu, Dec 20, 2012 at 10:16:56AM -0600, Jon Hunter wrote:
> 
> On 12/19/2012 11:59 PM, Santosh Shilimkar wrote:
> > On Monday 17 December 2012 02:57 PM, Andreas Fenkart wrote:
> > 
> > Please add some changelog here too.

::

In pm suspend the omap_hsmmc driver can't detect SDIO IRQs. This
is worked around by reconfiguring the SDIO IRQ pin (dat1) as a
GPIO before entering suspend and back upon resume. This requires
low overhead functions for enable/disable of GPIO IRQs.

> > 
> >> Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
> >> ---
> > Patch seems straight forward thought will be interesting where you found
> > the need of it.
> 
> The only item that I was thinking of if the behaviour of mask/unmask
> should be different from enable/disable?
> 
> When a gpio interrupt is masked, the gpio event will still be latched in
> the interrupt status register so when you unmask it later you may get an
> interrupt straight away. However, if the interrupt is disabled then gpio
> events occurring will not be latched/stored.

Thanks for clarification.

The HW seems to support this, see Fig 25-3 in the manual. 
https://www.google.com/search?q=spruh73c

This problem though, applies only to edge triggered irqs.

In the case of level triggered the mask/unmask implementation
clears irqs upon resume. This is safe, because if the level still
indicates irq, it will be latched again and if not, the HW needs
no service.

For edge triggered the current implementation of mask/unmask
seems to behave more like enable/disable:

- irq detection is disabled during the masking period, which is
  like disable according above description. But leaves a small
  window for latching another one that is not served immediately,
  which is more like masking

	static void gpio_mask_irq(struct irq_data *d)                                                      
	{
													   
		spin_lock_irqsave(&bank->lock, flags);
		_set_gpio_irqenable(bank, gpio, 0);
                <--- new irqs latched here --->
		_set_gpio_triggering(bank, GPIO_INDEX(bank, gpio), IRQ_TYPE_NONE);
		spin_unlock_irqrestore(&bank->lock, flags);
	}

- does not clear latched irqs upon resume. So not all irq raised
  after unmask are new, on the other hand some irqs that
  occured during the masking period might be lost.

> I am also interested in the need for this, and if we should have a true
> enable/disable here.

Since SDIO irqs are level triggered, I'm still okay with my patch.
For edge triggered though, it probably needs some more thoughts.

Suggestions? Should I split masking/disabling functions and make
them behave properly according above semantics or are you fine with
the interim solution of mapping enable/disable to mask/unmask?


rgds,
Andi


> >>   drivers/gpio/gpio-omap.c |    2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> >> index d335af1..c1951ec 100644
> >> --- a/drivers/gpio/gpio-omap.c
> >> +++ b/drivers/gpio/gpio-omap.c
> >> @@ -815,6 +815,8 @@ static struct irq_chip gpio_irq_chip = {
> >>       .irq_unmask    = gpio_unmask_irq,
> >>       .irq_set_type    = gpio_irq_type,
> >>       .irq_set_wake    = gpio_wake_enable,
> >> +    .irq_disable    = gpio_mask_irq,
> >> +    .irq_enable     = gpio_unmask_irq,
> >>   };
> >>
