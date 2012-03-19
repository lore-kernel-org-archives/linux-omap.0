From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Mon, 19 Mar 2012 14:37:56 +0100
Message-ID: <4F6736B4.4090509@atmel.com>
References: <4F22DEF2.5000807@ti.com> <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com> <20120317094059.7C2333E08E2@localhost> <201203182013.22790.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:33085 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757840Ab2CSNiQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 09:38:16 -0400
In-Reply-To: <201203182013.22790.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Benoit Cousson <b-cousson@ti.com>, Russell King <linux@arm.linux.org.uk>

On 03/18/2012 09:13 PM, Arnd Bergmann :
> On Saturday 17 March 2012, Grant Likely wrote:
>>> +static LIST_HEAD(of_dma_list);
>>> +
>>> +struct of_dma {
>>> +     struct list_head of_dma_controllers;
>>> +     struct device_node *of_node;
>>> +     int of_dma_n_cells;
>>> +     int (*of_dma_xlate)(struct of_phandle_args *dma_spec, void *data);
>>> +};
>>
>> This _xlate is nearly useless as a generic API.  It solves the problem for
>> the specific case where the driver is hard-coded to know which DMA engine
>> to talk to, but since the returned data doesn't provide any context, it
>> isn't useful if there are multiple DMA controllers to choose from.
>>
>> The void *data pointer must be replaced with a typed structure so that
>> context can be returned.
> 
> I've read up a bit more on how the existing drivers use the filter
> functions, it seems there are multiple classes of them, the classes
> that I've encountered are:
> 
> 1. matches on chan->device pointer and/or chan_id

I have the impression that we are now talking about *channel* selection.
It is not the purpose of those helper functions. It is just to retrieve
a *request line* for a particular slave interface. The
selection/filtering of a channel is a different topic (that we can
address in the future).
Maybe some DMA controllers are able to handle several "request lines"
among several DMA controller instances. But I suspect that this case
should be handled in another place, before calling this API.

>    (8 drivers)
> 2. will match anything
>    (6 drivers)
> 3. requires specific dma engine driver, then behaves like 1 or 2
>    (8 drivers, almost all freescale)
> 4. one of a kind, matches resource name string or device->dev_id
>    (two drivers)
> 5. filter function and data both provided by platform code,
>    platform picks dmaengine driver.
>    (4 amba pl* drivers, used on ARM, ux500, ...)
> 
> The last category is interesting because here, the dmaengine
> driver (pl330, coh901318, sirf-dma, ste_dma40) provides the filter
> function while in the other cases that is provided by the device
> driver! Out of these, the ste_dma40 is special because it's the
> only one where the data is a complex data structure describing the
> constraints on the driver, while all others just find the right
> channel.
> 
> Some drivers also pass assign driver specific data to chan->private.
> 
> I would hope that we can all make them use something like
>      struct dma_channel *of_dma_request_channel(struct of_node*,
> 					int index, void *driver_data);
> with an appropriate common definition behind it. In the cases
> where the driver can just match anything, I'd assume that all
> channels are equal, so #dma-cells would be 0. For the ste_dma40,
> #dma-cells needs to cover all of stedma40_chan_cfg. In most
> other cases, #dma-cells can be 1 and just enumerate the channels,
> unless we want to simplify the cases that Russell mentioned where
> we want to keep a two stage mapping channel identifiers and physical
> channel numbers.
> 
> How about an implementation like this:?
> 
> typedef bool dma_filter_simple(struct dma_chan *chan, void *filter_param)
> {
> 	/* zero #dma-cells, accept anything */
> 	return true;
> }
> 
> struct dma_channel *of_dma_request_channel(struct of_node*, int index,
> 					dma_cap_mask_t *mask,
> 					void *driver_data)
> {
> 	struct of_phandle_args dma_spec;
> 	struct dma_device *device;
> 	struct dma_chan *chan = NULL;
> 	dma_filter_fn *filter;
> 
> 	ret = of_parse_phandle_with_args(np, "dma-request", "#dma-cells",
> 					 index, &dma_spec);

Well, this property handles "request lines" not "channels". So if we
move the selection/filtering of channels in DT, we may need to create a
new property of this purpose...


> 
> 	device = dma_find_device(dma_spec->np);
> 	if (!device)
> 		goto out;
> 
> 	if (dma_spec->args_count == 0)
> 		filter = dma_filter_simple;
> 	else
> 		filter = device->dma_dt_filter; /* new member */
> 
> 	chan = private_candidate(mask, device, filter, dma_spec->args);
> 
> 	if (chan && !chan->private)
> 		chan->private = driver_data;
> out:
> 	return chan;
> }
> 
> 	Arnd
> 


-- 
Nicolas Ferre
