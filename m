From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 6 Jul 2012 21:57:31 +0100
Message-ID: <20120706205731.GA31585@n2100.arm.linux.org.uk>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FE896F9.2020806@ti.com> <1340647463.1562.127.camel@vkoul-udesk3>
 <201206252030.56025.arnd@arndb.de>
 <Pine.LNX.4.64.1207061315470.29809@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1207061315470.29809-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jul 06, 2012 at 01:36:32PM +0200, Guennadi Liakhovetski wrote:
> I like this idea, but why don't we extend it to also cover the non-DT 
> case? I.e., why don't we add the above callback (call it "match" or 
> "filter" or anything else) to dmaengine operations and inside (the 
> extended) dma_request_channel(), instead of calling the filter function, 
> passed as a parameter, we loop over all registered DMAC devices and call 
> their filter callbacks, until one of them returns true? In fact, it goes 
> back to my earlier proposal from 
> http://thread.gmane.org/gmane.linux.kernel/1246957
> which I, possibly, failed to explain properly. So, the transformation 
> chain from today's API would be (all code is approximate):
> 
> (today)
> 
> <client driver>
> 	dma_request_channel(mask, filter, filter_arg);
> 
> <dmaengine_core>
> 	for_each_channel() {
> 		ret = (*filter)(chan, filter_arg);
> 		if (ret) {
> 			ret = chan->device->device_alloc_chan_resources(chan);
> 			if (!ret)
> 				return chan;
> 			else
> 				return NULL;
> 		}
> 	}
> 
> (can be transformed to)
> 
> <client driver>
> 	dma_request_channel(mask, filter_arg);
> 
> <dmaengine_core>
> 	for_each_channel() {
> 		ret = chan->device->filter(chan, filter_arg);
> 		if (ret) {
> 			<same as above>
> 		}
> 	}
> 
> (which further could be simplified to)
> 
> <client driver>
> 	dma_request_channel(mask, filter_arg);
> 
> <dmaengine_core>
> 	for_each_channel() {
> 		ret = chan->device->device_alloc_chan_resources(chan, filter_arg);

This looks like you're re-purposing a perfectly good API for something that
it wasn't designed to do, namely providing a channel selection mechanism,
rather than "allocating channel resources".  The hint is in the bloody
name, please take a look sometime!

If you want to call into the DMA engine driver for channel selection,
then create an _explicit_ API for it.  Don't bugger around with existing
APIs.

Moreover, the *big* problem that your proposal above creates is this.
What _type_ is filter_arg?  If it's void *, then your suggestion is
nonsense, even if you associate it with a size argument.  You have no
idea what the bytestream that would be passed via that pointer means,
even if the size just happens to look like it's what you expect.

If it's something else, then your mistake above was not defining it, so
there's no way to evaluate your proposal given that lack of critical
information.  And if you define it, whatever you come up with _must_
be suitable for every single DMA engine driver we have today.
