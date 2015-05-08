From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v5 3/8] dmaengine: Add driver for TI DMA crossbar on DRA7x
Date: Fri, 8 May 2015 09:11:10 +0530
Message-ID: <20150508034110.GW3521@localhost>
References: <1428572154-3548-1-git-send-email-peter.ujfalusi@ti.com>
 <1428572154-3548-4-git-send-email-peter.ujfalusi@ti.com>
 <20150504053851.GY3521@localhost>
 <554B34F2.5050306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <554B34F2.5050306-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, May 07, 2015 at 12:48:34PM +0300, Peter Ujfalusi wrote:
> On 05/04/2015 08:38 AM, Vinod Koul wrote:
> > On Thu, Apr 09, 2015 at 12:35:49PM +0300, Peter Ujfalusi wrote:
> >> +int omap_dmaxbar_init(void)
> >> +{
> >> +	return platform_driver_register(&ti_dma_xbar_driver);
> >> +}
> >> +arch_initcall(omap_dmaxbar_init);
> > All looks fine except this bit, I think I did point out this last time as
> > well, though dont recall your answer. We rather depend on defered probe and
> > not rely on module ordering.
> 
> Can not find my previous response in my mailbox anymore thanks to Thunderbird:
> it corrupted all of my local mbox files when I did a backup from the server :(
> 
> I don't think the deferred probing is working with dmaengine since we return
> NULL in any case when the channel can not be requested for whatever reason.
> The request calls are eating up the error code (if any) which is coming when
> the channel is requested. With the exception of
> dma_request_slave_channel_reason(), which will return the reason for the
> failure, but most drivers are not using this.
Yes that was the reason for this API and I was expecting people ot start
using this and eliminate the init level dependecy

> 
> There is also a fallback in dma_request_slave_channel_compat() if the channel
> can not be requested via of/acpi it will try to get the channel via legacy
> mode also.
> 
> Should all drivers using DMA via dmaengine should return with -EPROBE_DEFER
> from their probe if they can not get the DMA channel? Some drivers uses the
> existence/non existence of the DMA resource as a means to decide to use DMA or
> PIO mode...
Yes we should do that.

> 
> If the crossbar is not in the same initcall level we can have bad race
> conditions also:
> omap-dma can handle up to 127 DMA requests.
> omap-dma is loaded but the crossbar driver is not.
> 
> A driver requests DMA for crossbar line 135:
> We will have failure from of_dma_request_slave_channel() since the CB driver
> is not yet loaded (returning with -EPROBE_DEFER), then the legacy call will
> try to get the channel from the loaded DMA driver, but that is going to fail
> as well (135 is not valid for omap-dma).
> 
> Another driver would request DMA for crossbar line 100:
> The legacy call will actually find it a valid request and get the channel from
> omap-dma driver, but this will not work in reality: the crossbar also need to
> be configured to route the signal to the correct line.
> This driver would think it has valid DMA, but in fact it has non working DMA.
I think you cna start doing the conversion of omap driver thuis you dont
have dependency on others.

Now as far as this series is concerned, rest of it looks good so I am
willing to merge to if you plan to work on defered probe :) I think its a
fair bargain!

-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
