From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [RFC PATCH] of: DMA helpers: manage generic requests
 specification
Date: Mon, 5 Mar 2012 08:36:48 -0700
Message-ID: <20120305153648.GG27229@ponder.secretlab.ca>
References: <4F22DEF2.5000807@ti.com>
 <1330527248-4350-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f52.google.com ([209.85.210.52]:65257 "EHLO
	mail-pz0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935Ab2CEPgt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 10:36:49 -0500
Received: by dadp12 with SMTP id p12so5246129dad.11
        for <linux-omap@vger.kernel.org>; Mon, 05 Mar 2012 07:36:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1330527248-4350-1-git-send-email-nicolas.ferre@atmel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: b-cousson@ti.com, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, swarren@nvidia.com, plagnioj@jcrosoft.com, Russell King <linux@arm.linux.org.uk>

On Wed, Feb 29, 2012 at 03:54:08PM +0100, Nicolas Ferre wrote:
> By making DMA controllers register a generic translation
> function, we allow the management of any type of DMA requests
> specification.
> The void * output of an of_dma_xlate() function that will be implemented
> by the DMA controller can carry any type of "dma-request" argument.
> 
> The DMA client will search its associated DMA controller in the list
> and call the registered of_dam_xlate() function to retrieve the
> request values.
> 
> One simple xlate function is provided for the "single number" type
> of request biding.
> 
> This implementation is independent from dmaengine so it can also be
> used by legacy drivers.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Rob Herring <rob.herring@calxeda.com>
> ---
> Hi all,
> 
> Here are my thoughts about the DMA helpers for device tree.
> This patch goes on top of Benoit's ones. My goal was to keep this separated
> from any DMA infrastructure (dmaengine not needed, nor any other DMA
> implementation).
> 
> It is to keep the ball rolling, so do not hesitate to comment.
> 
> Best regards,
> 
> 
>  Documentation/devicetree/bindings/dma/dma.txt |   29 +++--
>  drivers/of/dma.c                              |  161 ++++++++++++++++++++++---
>  include/linux/of_dma.h                        |   33 +++++-
>  3 files changed, 186 insertions(+), 37 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt
> index 7f2a301..c49e98d 100644
> --- a/Documentation/devicetree/bindings/dma/dma.txt
> +++ b/Documentation/devicetree/bindings/dma/dma.txt
> @@ -6,9 +6,8 @@ DMA request line that goes from an IP to a DMA controller.
>  
>  * DMA controller
>  
> -Required properties:
> -    - dma-controller: Mark the device as a DMA controller
> -    - #dma-cells: Number of cell for each DMA line, must be one.
> +Required property:
> +    - #dma-cells: Number of cells for each DMA line.
>  
>  
>  Example:
> @@ -17,7 +16,6 @@ Example:
>  		compatible = "ti,sdma-omap4"
>  		reg = <0x48000000 0x1000>;
>  		interrupts = <12>;
> -        dma-controller;
>  		#dma-cells = <1>;
>  	};
>  
> @@ -25,20 +23,23 @@ Example:
>  
>  * DMA client
>  
> -Client drivers should specify the DMA request numbers using a phandle to
> -the controller + the DMA request number on that controller.
> +Client drivers should specify the DMA request property using a phandle to
> +the controller. If needed, the DMA request identity on that controller is then
> +added followed by optional request specifications.
>  
> -Required properties:
> -    - dma-request: List of pair phandle + dma-request per line
> +Required property:
> +    - dma-request: List of phandle + dma-request + request specifications,
> +      one group per request "line".
> +Optional property:
>      - dma-request-names: list of strings in the same order as the dma-request
>        in the dma-request property.
>  
>  
>  Example:
>  
> -    i2c1: i2c@1 {
> -        ...
> -        dma-request = <&sdma 2 &sdma 3>;
> -        dma-request-names = "tx", "rx";
> -        ...
> -    };
> +	i2c1: i2c@1 {
> +		...
> +		dma-request = <&sdma 2 &sdma 3>;
> +		dma-request-names = "tx", "rx";
> +		...
> +	};
> diff --git a/drivers/of/dma.c b/drivers/of/dma.c
> index d4927e2..e0c6fd9 100644
> --- a/drivers/of/dma.c
> +++ b/drivers/of/dma.c
> @@ -13,41 +13,145 @@
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> +#include <linux/rculist.h>
> +#include <linux/slab.h>
>  #include <linux/of.h>
>  #include <linux/of_dma.h>
>  
> +static LIST_HEAD(of_dma_list);
> +
> +/**
> + * of_dma_find_controller() - Find a DMA controller in DT DMA helpers list
> + * @np:		device node of DMA controller
> + */
> +static struct of_dma *of_dma_find_controller(struct device_node *np)
> +{
> +	struct of_dma	*ofdma;
> +
> +	list_for_each_entry_rcu(ofdma, &of_dma_list, of_dma_controllers) {
> +		if (ofdma->of_node == np)
> +			return ofdma;
> +	}
> +
> +	return NULL;
> +}
> +
>  /**
> - * of_get_dma_request() - Get a DMA request number and dma-controller node
> + * of_dma_controller_register() - Register a DMA controller to DT DMA helpers
> + * @np:			device node of DMA controller
> + * @of_dma_xlate:	generic translation function which converts a phandle
> + *			arguments list into a generic output value
> + *
> + * Returns 0 on success or appropriate errno value on error.
> + *
> + * If #dma-cells is not specified in DMA controller device tree node, we assume
> + * that the DMA controller phandle will come without argument.
> + *
> + * Allocated memory sould be freed with apropriate of_dma_controller_free()
> + * call.
> + */
> +int of_dma_controller_register(struct device_node *np,
> +			int (*of_dma_xlate)(struct of_phandle_args *, void *))
> +{
> +	struct of_dma	*ofdma;
> +	int		*nbcells;
> +
> +	if (!np || !of_dma_xlate) {
> +		pr_err("%s: not enouth information provided\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	ofdma = kzalloc(sizeof(*ofdma), GFP_KERNEL);
> +	if (!ofdma)
> +		return -ENOMEM;
> +
> +	nbcells = (int *)of_get_property(np, "#dma-cells", NULL);

No cast required; but nbcells should be a (const __be32 *) instead of an int*.

> +	if (!nbcells)
> +		/*
> +		 * no #dma-cells properties: assume no argument to
> +		 * dma-request property on slave side
> +		 */
> +		ofdma->of_dma_n_cells = 0;
> +	else
> +		ofdma->of_dma_n_cells = be32_to_cpup(nbcells);
> +
> +	ofdma->of_node = np;
> +	ofdma->of_dma_xlate = of_dma_xlate;
> +
> +	/* Now queue of_dma controller structure in list */
> +	list_add_tail_rcu(&ofdma->of_dma_controllers, &of_dma_list);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(of_dma_controller_register);

EXPORT_SYMBOL_GPL

> +
> +/**
> + * of_dma_controller_free() - Remove a DMA controller from DT DMA helpers list
> + * @np:		device node of DMA controller
> + *
> + * Memory allocated by of_dma_controller_register() is freed here.
> + */
> +void of_dma_controller_free(struct device_node *np)
> +{
> +	struct of_dma	*ofdma;
> +
> +	ofdma = of_dma_find_controller(np);
> +	if (ofdma) {
> +		list_del_rcu(&ofdma->of_dma_controllers);
> +		kfree(ofdma);
> +	}
> +}
> +EXPORT_SYMBOL(of_dma_controller_free);
> +
> +/**
> + * of_get_dma_request() - Get the associated DMA request data
>   * @np:		device node to get DMA request from
> - * @propname:	property name containing DMA specifier(s)
>   * @index:	index of the DMA request
> - * @ctrl_np:	a device_node pointer to fill in
> + * @out_data:	a output that can be filled in by the of_dma_xlate() function
>   *
> - * Returns DMA number along to the dma controller node, or one of the errno
> - * value on the error condition. If @ctrl_np is not NULL the function also
> - * fills in the DMA controller device_node pointer.
> + * Returns return value of of_dma_xlate() and fills out_data (if provided).
> + * On error returns the appropriate errno value.
>   */
>  int of_get_dma_request(struct device_node *np, int index,
> -		       struct device_node **ctrl_np)
> +		       void *out_data)
>  {
> -	int ret = -EINVAL;
> -	struct of_phandle_args dma_spec;
> +	struct of_phandle_args	dma_spec;
> +	struct of_dma		*ofdma;
> +	int			ret;
>  
>  	ret = of_parse_phandle_with_args(np, "dma-request", "#dma-cells",
>  					 index, &dma_spec);
>  	if (ret) {
> -		pr_debug("%s: can't parse dma property\n", __func__);
> +		pr_err("%s: can't parse dma property\n", np->full_name);
>  		goto err0;
>  	}
>  
> -	if (dma_spec.args_count > 0)
> -		ret = dma_spec.args[0];
> +	if (list_empty(&of_dma_list)) {
> +		pr_debug("%s: empty DMA controller list\n",
> +			 np->full_name);
> +		ret = -ENOENT;
> +		goto err1;
> +	}
>  
> -	if (ctrl_np)
> -		*ctrl_np = dma_spec.np;
> -	else
> -		of_node_put(dma_spec.np);
> +	ofdma = of_dma_find_controller(dma_spec.np);
> +	if (!ofdma) {
> +		pr_debug("%s: DMA controller %s isn't registered\n",
> +			 np->full_name, dma_spec.np->full_name);
> +		ret = -ENODEV;
> +		goto err1;
> +	}
>  
> +	if (dma_spec.args_count != ofdma->of_dma_n_cells) {
> +		pr_debug("%s: wrong #dma-cells for %s\n",
> +			 np->full_name, dma_spec.np->full_name);
> +		ret = -EINVAL;
> +		goto err1;
> +	}
> +
> +	ret = ofdma->of_dma_xlate(&dma_spec, out_data);
> +
> +err1:
> +	of_node_put(dma_spec.np);
>  err0:
>  	pr_debug("%s exited with status %d\n", __func__, ret);
>  	return ret;
> @@ -55,6 +159,24 @@ err0:
>  EXPORT_SYMBOL(of_get_dma_request);
>  
>  /**
> + * of_dma_xlate_onenumbercell() - Generic DMA xlate for direct one cell bindings
> + *
> + * Device Tree DMA translation function which works with one cell bindings
> + * where the cell values map directly to the hardware request number understood
> + * by the DMA controller.
> + */
> +int of_dma_xlate_onenumbercell(struct of_phandle_args *dma_spec, void *req_nbr)
> +{
> +	if (!dma_spec)
> +		return -EINVAL;
> +	if (WARN_ON(dma_spec->args_count != 1))
> +		return -EINVAL;
> +	*(int *)req_nbr = dma_spec->args[0];
> +	return 0;
> +}
> +EXPORT_SYMBOL(of_dma_xlate_onenumbercell);
> +
> +/**
>   * of_dma_count - Count DMA requests for a device
>   * @np:		device node to count DMAs for
>   *
> @@ -105,13 +227,14 @@ int of_dma_to_resource(struct device_node *dev, int index, struct resource *r)
>  {
>  	const char *name = NULL;
>  	int dma;
> +	int ret;
>  
>  	if (!r)
>  		return -EINVAL;
>  
> -	dma = of_get_dma_request(dev, index, NULL);
> -	if (dma < 0)
> -		return dma;
> +	ret = of_get_dma_request(dev, index, &dma);
> +	if (ret < 0)
> +		return ret;
>  
>  	/*
>  	 * Get optional "dma-request-names" property to add a name
> diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
> index 575163d..fbf98de 100644
> --- a/include/linux/of_dma.h
> +++ b/include/linux/of_dma.h
> @@ -17,18 +17,38 @@
>  
>  struct device_node;
>  
> -#ifdef CONFIG_OF_GPIO
> +#ifdef CONFIG_OF_DMA
>  
> +struct of_dma {
> +	struct list_head of_dma_controllers;
> +	struct device_node *of_node;
> +	int of_dma_n_cells;
> +	int (*of_dma_xlate)(struct of_phandle_args *dma_spec, void *data);
> +};

The api makes struct of_dma private; so this should be moved to the .c
file.

Otherwise, this looks okay to me.

g.


> +
> +extern int of_dma_controller_register(struct device_node *np,
> +			int (*of_dma_xlate)(struct of_phandle_args *, void *));
> +extern void of_dma_controller_free(struct device_node *np);
>  extern int of_get_dma_request(struct device_node *np, int index,
> -		       struct device_node **ctrl_np);
> +			      void *out_data);
>  extern unsigned int of_dma_count(struct device_node *np);
>  extern int of_dma_to_resource(struct device_node *dev, int index,
>  			      struct resource *r);
>  
> +extern int of_dma_xlate_onenumbercell(struct of_phandle_args *dma_spec,
> +				      void *req_nbr);
>  #else /* CONFIG_OF_DMA */
>  
> -static int of_get_dma_request(struct device_node *np, int index,
> -			      struct device_node **ctrl_np);
> +static int of_dma_controller_register(struct device_node *np,
> +			int (*of_dma_xlate)(struct of_phandle_args *, void *))
> +{
> +	return -ENOSYS;
> +}
> +
> +static void of_dma_controller_free(struct device_node *np) {}
> +
> +extern int of_get_dma_request(struct device_node *np, int index,
> +			      void *out_data)
>  {
>  	return -ENOSYS;
>  }
> @@ -44,6 +64,11 @@ static int of_dma_to_resource(struct device_node *dev, int index,
>  	return -ENOSYS;
>  }
>  
> +static int of_dma_xlate_onenumbercell(struct of_phandle_args *dma_spec,
> +				      void *req_nbr)
> +{
> +	return -ENOSYS;
> +}
>  #endif /* CONFIG_OF_DMA */
>  
>  #endif /* __LINUX_OF_DMA_H */
> -- 
> 1.7.9
> 
