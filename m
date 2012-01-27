From: Stephen Warren <swarren@nvidia.com>
Subject: RE: [RFC PATCH 1/2] of: Add generic device tree DMA helpers
Date: Fri, 27 Jan 2012 10:13:45 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178E123E7A@HQMAIL01.nvidia.com>
References: <4F22DEF2.5000807@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:11210 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134Ab2A0SNz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 27 Jan 2012 13:13:55 -0500
In-Reply-To: <4F22DEF2.5000807@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Thomas Abraham <thomas.abraham@linaro.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Cousson, Benoit wrote at Friday, January 27, 2012 10:29 AM:
> Add some basic helpers to retrieve a DMA controller device_node
> and the DMA request line number.
> 
> For legacy reason another API will export the DMA request number
> into a Linux resource of type IORESOURCE_DMA.
> This API is usable only on system with an unique DMA controller.

This binding looks reasonable to me; it's pretty much exactly what I
was expecting the custom Tegra I2S binding might evolve into. A couple
comments inline...

> diff --git a/Documentation/devicetree/bindings/dma/dma.txt

> +* DMA client
> +
> +Client drivers should specify the DMA request numbers using a phandle to
> +the controller + the DMA request number on that controller.
> +
> +Required properties:
> +    - dma-request: List of pair phandle + dma-request per line
> +    - dma-request-names: list of strings in the same order as the dma-request
> +      in the dma-request property.

I think property dma-request-names should be optional; some drives will
simply request by index and hence the property won't be needed. Same as
the common clock binding.

> diff --git a/drivers/of/dma.c b/drivers/of/dma.c

> +int of_get_dma_request(struct device_node *np, int index,
> +		       struct device_node **ctrl_np)
> +{
> +	int ret = -EINVAL;
> +	struct of_phandle_args dma_spec;
> +
> +	ret = of_parse_phandle_with_args(np, "dma-request", "#dma-cells",
> +					 index, &dma_spec);
> +	if (ret) {
> +		pr_debug("%s: can't parse dma property\n", __func__);
> +		goto err0;
> +	}
> +
> +	if (dma_spec.args_count > 0)
> +		ret = dma_spec.args[0];

Doesn't that force #dma-cells > 0? What about a DMA controller that only
supports a single DMA request, in which case you might want #dma-cells==0?

Having an of_xlate for the controller would be useful here in general:

Is a single int really enough here?

Some DMA controllers have N channels that can be used for arbitrary
things. You may need to specify the DMA request once when allocating the
channel, or maybe individual for each transfer if it can vary. Other
controllers may need a special channel ID for each type of request. There
are probably more cases I haven't thought of.

So in general, I think this API should return some kind of cookie that's
meaningful to the DMA controller, and this should be provided back to
the DMA controller with every API that might need it; channel allocation,
DMA transfer request, etc.

I suppose a controller may be able to represent that cookie in a single
int, but perhaps not, e.g. if a binding needs #dma-cells=4 for some
reason. Perhaps returning a void* here would be better, coupled with
of_put_dma_request() to allow the controller to free it if required?

That'd allow individual controller bindings to specify e.g. HW FIFO
width, wrap, FIFO levels for HW flow control, ...
(I vaguely recall that dmaengine addresses some of this already, but
unfortunately I'm not very familiar with it yet)

> diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h

> +#ifdef CONFIG_OF_GPIO

CONFIG_OF_DMA

-- 
nvpublic

