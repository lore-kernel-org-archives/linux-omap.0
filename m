From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Sun, 18 Mar 2012 20:13:22 +0000
Message-ID: <201203182013.22790.arnd@arndb.de>
References: <4F22DEF2.5000807@ti.com>
 <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com>
 <20120317094059.7C2333E08E2@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <20120317094059.7C2333E08E2@localhost>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Saturday 17 March 2012, Grant Likely wrote:
> > +static LIST_HEAD(of_dma_list);
> > +
> > +struct of_dma {
> > +     struct list_head of_dma_controllers;
> > +     struct device_node *of_node;
> > +     int of_dma_n_cells;
> > +     int (*of_dma_xlate)(struct of_phandle_args *dma_spec, void *data);
> > +};
> 
> This _xlate is nearly useless as a generic API.  It solves the problem for
> the specific case where the driver is hard-coded to know which DMA engine
> to talk to, but since the returned data doesn't provide any context, it
> isn't useful if there are multiple DMA controllers to choose from.
> 
> The void *data pointer must be replaced with a typed structure so that
> context can be returned.

I've read up a bit more on how the existing drivers use the filter
functions, it seems there are multiple classes of them, the classes
that I've encountered are:

1. matches on chan->device pointer and/or chan_id
   (8 drivers)
2. will match anything
   (6 drivers)
3. requires specific dma engine driver, then behaves like 1 or 2
   (8 drivers, almost all freescale)
4. one of a kind, matches resource name string or device->dev_id
   (two drivers)
5. filter function and data both provided by platform code,
   platform picks dmaengine driver.
   (4 amba pl* drivers, used on ARM, ux500, ...)

The last category is interesting because here, the dmaengine
driver (pl330, coh901318, sirf-dma, ste_dma40) provides the filter
function while in the other cases that is provided by the device
driver! Out of these, the ste_dma40 is special because it's the
only one where the data is a complex data structure describing the
constraints on the driver, while all others just find the right
channel.

Some drivers also pass assign driver specific data to chan->private.

I would hope that we can all make them use something like
     struct dma_channel *of_dma_request_channel(struct of_node*,
					int index, void *driver_data);
with an appropriate common definition behind it. In the cases
where the driver can just match anything, I'd assume that all
channels are equal, so #dma-cells would be 0. For the ste_dma40,
#dma-cells needs to cover all of stedma40_chan_cfg. In most
other cases, #dma-cells can be 1 and just enumerate the channels,
unless we want to simplify the cases that Russell mentioned where
we want to keep a two stage mapping channel identifiers and physical
channel numbers.

How about an implementation like this:?

typedef bool dma_filter_simple(struct dma_chan *chan, void *filter_param)
{
	/* zero #dma-cells, accept anything */
	return true;
}

struct dma_channel *of_dma_request_channel(struct of_node*, int index,
					dma_cap_mask_t *mask,
					void *driver_data)
{
	struct of_phandle_args dma_spec;
	struct dma_device *device;
	struct dma_chan *chan = NULL;
	dma_filter_fn *filter;

	ret = of_parse_phandle_with_args(np, "dma-request", "#dma-cells",
					 index, &dma_spec);

	device = dma_find_device(dma_spec->np);
	if (!device)
		goto out;

	if (dma_spec->args_count == 0)
		filter = dma_filter_simple;
	else
		filter = device->dma_dt_filter; /* new member */

	chan = private_candidate(mask, device, filter, dma_spec->args);

	if (chan && !chan->private)
		chan->private = driver_data;
out:
	return chan;
}

	Arnd
