From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Mon, 19 Mar 2012 14:45:17 +0000
Message-ID: <20120319144517.C19E93E05A5@localhost>
References: <4F22DEF2.5000807@ti.com> <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com> <20120317094059.7C2333E08E2@localhost> <4F6734DD.3020203@atmel.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:44001 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757263Ab2CSOpY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Mar 2012 10:45:24 -0400
Received: by wibhj6 with SMTP id hj6so3907620wib.1
        for <linux-omap@vger.kernel.org>; Mon, 19 Mar 2012 07:45:21 -0700 (PDT)
In-Reply-To: <4F6734DD.3020203@atmel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, Benoit Cousson <b-cousson@ti.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@arm.linux.org.uk>, devicetree-discuss@lists.ozlabs.org, rob.herring@calxeda.com, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, 19 Mar 2012 14:30:05 +0100, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> On 03/17/2012 10:40 AM, Grant Likely :
> > On Thu, 15 Mar 2012 09:38:10 +0100, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> >> +struct of_dma {
> >> +	struct list_head of_dma_controllers;
> >> +	struct device_node *of_node;
> >> +	int of_dma_n_cells;
> >> +	int (*of_dma_xlate)(struct of_phandle_args *dma_spec, void *data);
> >> +};
> > 
> > This _xlate is nearly useless as a generic API.  It solves the problem for
> > the specific case where the driver is hard-coded to know which DMA engine
> > to talk to, but since the returned data doesn't provide any context, it
> > isn't useful if there are multiple DMA controllers to choose from.
> 
> You mean, if there is no DMA controller phandle specified in the
> property?

No; I'm assuming that dma-channel properties will alwasy have a
phandle to the dma controller node.

> I think that it is not the purpose of this API to choose a DMA
> controller, Nor to provide a channel. The only purpose of this API is to
> give a HW request to be used by a DMA slave driver. This slave should
> already have a channel to use and a controller to talk to.

Then where is the function that finds the reference to the DMA
controller?  I don't understand why it would be useful to decode that
separately.

> > The void *data pointer must be replaced with a typed structure so that
> > context can be returned.
> 
> I am not sure to follow you entirely... How do I address the fact that
> several types of request value can be returned then?
> 
> BTW, can we imagine a phandle property with a sting as a argument?
> should it be written this way?
> dma-request = <&testdmac1>, "slave-rx", "slave-tx";

No, I'm not suggesting that.  Mixing phandles and strings in a single
property is possible but ugly.  The phandle-args pattern which uses
zero or more cells as arguments should be used.

> 
> If yes, the of_parse_phandle_with_args() is not working on this type...

Right; of_parse_phandle_with_args() should do the job.

> 
> (I realize that there seems to be no way out for a generic API: maybe we
> should move to one or two cases to address and concentrate on them).

The way I read this patch, the xlate function returns a single
integer representing the DMA request number, but it doesn't provide
any data about *which* dma controller is associated with that channel.
The result of xlate needs to be something like a dma_chan reference
that identifies both the DMA engine and the channel/request on that
dma engine.

[...]
> >> +/**
> >> + * of_dma_xlate_onenumbercell() - Generic DMA xlate for direct one cell bindings
> >> + *
> >> + * Device Tree DMA translation function which works with one cell bindings
> >> + * where the cell values map directly to the hardware request number understood
> >> + * by the DMA controller.
> >> + */
> >> +int of_dma_xlate_onenumbercell(struct of_phandle_args *dma_spec, void *dma_req)
> >> +{
> >> +	if (!dma_spec)
> >> +		return -EINVAL;
> >> +	if (WARN_ON(dma_spec->args_count != 1))
> >> +		return -EINVAL;
> >> +	*(int *)dma_req = dma_spec->args[0];
> > 
> > Following on from comment above; the void *dma_req parameter is dangerous.  How
> > does this function know that it has been passed an int* pointer?
> 
> Well, that is a drawback that comes from having to address generic
> cases.

Not if you do it right.  If a specific data structure is returned,
then there can be context attached as to what the data means and which
dma controller knows how to parse it.

> But anyway, if the DMA controller decide to register a .xlate()
> function that returns an integer, the slave driver that will ask a
> "request line" to this DMA controller will be aware that an integer has
> to be passed to of_get_dma_request().

The problem still remains; I don't see how the dma slave can figure
out *which* dma controller it needs to talk to.

g.

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.
