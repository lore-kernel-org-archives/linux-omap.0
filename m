From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V4 1/2] of: Add generic device tree DMA helpers
Date: Fri, 14 Sep 2012 09:43:49 +0000
Message-ID: <201209140943.49904.arnd@arndb.de>
References: <1347573629-21299-1-git-send-email-jon-hunter@ti.com> <1347573629-21299-2-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61912 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114Ab2INJoM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Sep 2012 05:44:12 -0400
In-Reply-To: <1347573629-21299-2-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Benoit Cousson <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <djbw@fb.com>

On Thursday 13 September 2012, Jon Hunter wrote:
> This is based upon the work by Benoit Cousson [1] and Nicolas Ferre [2]
> to add some basic helpers to retrieve a DMA controller device_node and the
> DMA request/channel information.

I think we're getting very close now, I only have a few small comments left
that should all be uncontroversial.

> +
> +Client drivers should specify the DMA property using a phandle to the controller
> +followed by DMA controller specific data.
> +
> +Required property:
> +- dmas:			List of one or more DMA specifiers, each consisting of
> +			- A phandle pointing to DMA controller node
> +			- A single integer cell containing DMA controller
> +			  specific information. This typically contains a dma
> +			  request line number or a channel number, but can
> +			  contain any data that is used required for configuring
> +			  a channel.
> +- dma-names: 		Contains one identifier string for each dma specifier in
> +			the dmas property. The specific strings that can be used
> +			are defined in the binding of the DMA client device.

I think here we need to clarify that listing the same name multiple times implies
having multiple alternatives for the same channel.

> +Example:
> +
> +- One DMA write channel, one DMA read/write channel:
> +
> +	i2c1: i2c@1 {
> +		...
> +		dmas = <&sdma 2		/* read channel */
> +			&sdma 3>;	/* write channel */
> +		dma-names = "rx", "tx"
> +		...
> +	};

And please add an example documenting this case.

> +/**
> + * of_dma_find_channel - Find a DMA channel by name
> + * @np:		device node to look for DMA channels
> + * @name:	name of desired channel
> + * @dma_spec:	pointer to DMA specifier as found in the device tree
> + *
> + * Find a DMA channel by the name. Returns 0 on success or appropriate
> + * errno value on error.
> + */
> +static int of_dma_find_channel(struct device_node *np, char *name,
> +			       struct of_phandle_args *dma_spec)
> +{
> +	int count, i;
> +	const char *s;
> +
> +	count = of_property_count_strings(np, "dma-names");
> +	if (count < 0)
> +		return count;
> +
> +	for (i = 0; i < count; i++) {
> +		of_property_read_string_index(np, "dma-names", i, &s);
> +
> +		if (strcmp(name, s))
> +			continue;
> +
> +		return of_parse_phandle_with_args(np, "dmas", "#dma-cells",
> +							i, dma_spec);
> +	}
> +
> +	return -ENODEV;
> +}

I think we should at least keep trying the other channels with the same name when 
of_parse_phandle_with_args fails. We might want to do something smarter in
the long run, e.g. to spread channel allocations across the avaialable controllers.

> +/**
> + * of_dma_request_slave_channel - Get the DMA slave channel
> + * @np:		device node to get DMA request from
> + * @name:	name of desired channel
> + *
> + * Returns pointer to appropriate dma channel on success or NULL on error.
> + */
> +struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
> +					      char *name)
> +{
> ...
> +}
> +EXPORT_SYMBOL_GPL(of_dma_request_slave_channel);

I think this no longer needs to be exported, with patch 2 on top.

> +/**
> + * of_dma_simple_xlate - Simple DMA engine translation function
> + * @dma_spec:	pointer to DMA specifier as found in the device tree
> + * @of_dma:	pointer to DMA controller data
> + *
> + * A simple translation function for devices that use a 32-bit value for the
> + * filter_param when calling the DMA engine dma_request_channel() function.
> + * Note that this translation function requires that #dma-cells is equal to 1
> + * and the argument of the dma specifier is the 32-bit filter_param. Returns
> + * pointer to appropriate dma channel on success or NULL on error.
> + */
> +struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
> +						struct of_dma *ofdma)
> +{
> +	int count = dma_spec->args_count;
> +	struct of_dma_filter_info *info = ofdma->of_dma_data;
> +
> +	if (!info || !info->filter_fn)
> +		return NULL;
> +
> +	if (count != 1)
> +		return NULL;
> +
> +	return dma_request_channel(info->dma_cap, info->filter_fn,
> +			&dma_spec->args[0]);
> +}

But this one does.

	Arnd
