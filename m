From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH V3 1/2] of: Add generic device tree DMA helpers
Date: Fri, 6 Jul 2012 15:28:58 +0000
Message-ID: <201207061528.58291.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201206252030.56025.arnd@arndb.de>
 <Pine.LNX.4.64.1207061315470.29809@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
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
Cc: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, device-tree <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Friday 06 July 2012, Guennadi Liakhovetski wrote:
> On Mon, 25 Jun 2012, Arnd Bergmann wrote:
> 
> [snip]
> 
> > The channel data in the device tree is still in a format
> > that is specific to that dmaengine driver and interpreted
> > by it. Using the regular dma_filter_fn prototype is not
> > necessary, but it would be convenient because the dmaengine
> > code already knows how to deal with it. If we don't use this
> > method, how about adding another callback to struct dma_device
> > like
> > 
> > bool (*device_match)(struct dma_chan *chan, struct property *req);
> 
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
> ...
> <dmaengine_core>
> 	for_each_channel() {
> 		ret = chan->device->device_alloc_chan_resources(chan, filter_arg);
> 		if (!ret)
> 			return chan;
> 		else if (ret != -ENODEV)
> 			return ret;
> 		/* -ENODEV - try the next channel */
> 	}
> 
> Which is quite similar to my above mentioned proposal. Wouldn't this both 
> improve the present API and prepare it for DT?

How would the individual driver know the size of the filter_arg? In the
device tree code, we would know if from #dma-cells of the engine node,
and that gets checked when reading the property, but when you have
a free-form data structure, it's much less clear.

Also, you could easily have an argument that looks valid for more than one
dmaengine, but really isn't.

I think for your proposal to work, we would need something like the
phandle for the dmaengine device that is at the start of the property
in the DT case.

	Arnd
