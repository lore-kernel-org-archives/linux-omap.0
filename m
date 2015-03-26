From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/7] dmaengine: of_dma: Support for DMA routers
Date: Thu, 26 Mar 2015 16:20:18 +0530
Message-ID: <20150326105018.GJ32683@intel.com>
References: <1426080210-841-1-git-send-email-peter.ujfalusi@ti.com>
 <1426080210-841-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426080210-841-2-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nm-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Mar 11, 2015 at 03:23:24PM +0200, Peter Ujfalusi wrote:
> DMA routers are transparent devices used to mux DMA requests from
> peripherals to DMA controllers. They are used when the SoC integrates more
> devices with DMA requests then their controller can handle.
> DRA7x is one example of such SoC, where the sDMA can hanlde 128 DMA request
> lines, but in SoC level it has 205 DMA requests.
> 
> The of_dma_router will be registered as of_dma_controller with special
> xlate function and additional parameters and the code will translate and
> requests a DMA channel from the real DMA controller.
> This way the router can be transparent for the system while remaining generic
> enough to be used in different environments.
> 
Looks fine, was expecting a Documentation updates as well, but that can come
as follow up patch too

-- 
~Vinod

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/dma/dma.txt | 28 ++++++++
>  drivers/dma/dmaengine.c                       |  7 ++
>  drivers/dma/of-dma.c                          | 92 +++++++++++++++++++++++++++
>  include/linux/dmaengine.h                     | 17 +++++
>  include/linux/of_dma.h                        | 21 ++++++
>  5 files changed, 165 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt
> index 82104271e754..f728b978178e 100644
> --- a/Documentation/devicetree/bindings/dma/dma.txt
> +++ b/Documentation/devicetree/bindings/dma/dma.txt
> @@ -31,6 +31,34 @@ Example:
>  		dma-requests = <127>;
>  	};
>  
> +* DMA router
> +
> +DMA routers are transparent IP blocks used to route DMA request lines from
> +devices to the DMA controller. Some SoCs (like TI DRA7x) have more peripherals
> +integrated with DMA requests than what the DMA controller can handle directly.
> +
> +Required property:
> +- dma-device:		phandle of the DMA controller. The router is modifying
> +			the DMA requests for this controller.
> +- #dma-cells: 		Must be at least 1. Used to provide DMA router specific
> +			information. See DMA client binding below for more
> +			details.
> +
> +Optional properties:
> +- dma-requests: 	Number of incoming request lines the router can handle.
> +- dma-device
> +	- dma-requests:	The router driver might need to look for this in order
> +			to configure the routing.
> +
> +Example:
> +	sdma_xbar: dma-router@4a002b78 {
> +		compatible = "ti,dra7-dma-crossbar";
> +		reg = <0x4a002b78 0xfc>;
> +		#dma-cells = <1>;
> +		dma-requests = <205>;
> +		ti,dma-safe-map = <0>;
> +		dma-device = <&sdma>;
> +	};
>  
>  * DMA client
>  
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 344b0ac6d985..1bb67dae5880 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -271,6 +271,13 @@ static void dma_chan_put(struct dma_chan *chan)
>  	/* This channel is not in use anymore, free it */
>  	if (!chan->client_count && chan->device->device_free_chan_resources)
>  		chan->device->device_free_chan_resources(chan);
> +
> +	/* If the channel is used via a DMA request router, free the mapping */
> +	if (chan->router && chan->router->route_free) {
> +		chan->router->route_free(chan->router->dev, chan->route_data);
> +		chan->router = NULL;
> +		chan->route_data = NULL;
> +	}
>  }
>  
>  enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie)
> diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
> index ca31f1b45366..c86f8823da0d 100644
> --- a/drivers/dma/of-dma.c
> +++ b/drivers/dma/of-dma.c
> @@ -45,6 +45,53 @@ static struct of_dma *of_dma_find_controller(struct of_phandle_args *dma_spec)
>  }
>  
>  /**
> + * of_dma_router_xlate - translation function for router devices
> + * @dma_spec:	pointer to DMA specifier as found in the device tree
> + * @of_dma:	pointer to DMA controller data (router information)
> + *
> + * The function creates new dma_spec to be passed to the router driver's
> + * of_dma_route_allocate() function to prepare a dma_spec which will be used
> + * to request channel from the real DMA controller.
> + */
> +static struct dma_chan *of_dma_router_xlate(struct of_phandle_args *dma_spec,
> +					    struct of_dma *ofdma)
> +{
> +	struct dma_chan		*chan;
> +	struct of_dma		*ofdma_target;
> +	struct device_node	*dma_target;
> +	struct of_phandle_args	dma_spec_target;
> +	void			*route_data;
> +
> +	dma_target = of_parse_phandle(dma_spec->np, "dma-device", 0);
> +	if (!dma_target) {
> +		pr_err("%s: Can't get target DMA\n", __func__);
> +		return NULL;
> +	}
> +
> +	/* translate the request for the real DMA controller */
> +	memcpy(&dma_spec_target, dma_spec, sizeof(dma_spec_target));
> +	dma_spec_target.np = dma_target;
> +	route_data = ofdma->of_dma_route_allocate(&dma_spec_target, ofdma);
> +
> +	ofdma_target = of_dma_find_controller(&dma_spec_target);
> +	if (!ofdma_target) {
> +		pr_err("%s: Can't get target ofDMA\n", __func__);
> +		return NULL;
> +	}
> +
> +	chan = ofdma_target->of_dma_xlate(&dma_spec_target, ofdma_target);
> +	if (chan) {
> +		chan->router = ofdma->dma_router;
> +		chan->route_data = route_data;
> +	} else {
> +		ofdma->dma_router->route_free(ofdma->dma_router->dev, route_data);
> +	}
> +
> +	of_node_put(dma_target);
> +	return chan;
> +}
> +
> +/**
>   * of_dma_controller_register - Register a DMA controller to DT DMA helpers
>   * @np:			device node of DMA controller
>   * @of_dma_xlate:	translation function which converts a phandle
> @@ -110,6 +157,51 @@ void of_dma_controller_free(struct device_node *np)
>  EXPORT_SYMBOL_GPL(of_dma_controller_free);
>  
>  /**
> + * of_dma_router_register - Register a DMA router to DT DMA helpers as a
> + *			    controller
> + * @np:				device node of DMA router
> + * @of_dma_route_allocate:	setup function for the router which need to
> + *				modify the dma_spec for the DMA controller to
> + *				use and to set up the requested route.
> + * @dma_router:			pointer to dma_router structure to be used when
> + *				the route need to be free up.
> + *
> + * Returns 0 on success or appropriate errno value on error.
> + *
> + * Allocated memory should be freed with appropriate of_dma_controller_free()
> + * call.
> + */
> +int of_dma_router_register(struct device_node *np,
> +			   void *(*of_dma_route_allocate)
> +			   (struct of_phandle_args *, struct of_dma *),
> +			   struct dma_router *dma_router)
> +{
> +	struct of_dma	*ofdma;
> +
> +	if (!np || !of_dma_route_allocate || !dma_router) {
> +		pr_err("%s: not enough information provided\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	ofdma = kzalloc(sizeof(*ofdma), GFP_KERNEL);
> +	if (!ofdma)
> +		return -ENOMEM;
> +
> +	ofdma->of_node = np;
> +	ofdma->of_dma_xlate = of_dma_router_xlate;
> +	ofdma->of_dma_route_allocate = of_dma_route_allocate;
> +	ofdma->dma_router = dma_router;
> +
> +	/* Now queue of_dma controller structure in list */
> +	mutex_lock(&of_dma_lock);
> +	list_add_tail(&ofdma->of_dma_controllers, &of_dma_list);
> +	mutex_unlock(&of_dma_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_dma_router_register);
> +
> +/**
>   * of_dma_match_channel - Check if a DMA specifier matches name
>   * @np:		device node to look for DMA channels
>   * @name:	channel name to be matched
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 2bff9abc162a..b6a0e59f1887 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -226,6 +226,16 @@ struct dma_chan_percpu {
>  };
>  
>  /**
> + * struct dma_router - DMA router structure
> + * @dev: pointer to the DMA router device
> + * @route_free: function to be called when the route can be disconnected
> + */
> +struct dma_router {
> +	struct device *dev;
> +	void (*route_free)(struct device *dev, void *route_data);
> +};
> +
> +/**
>   * struct dma_chan - devices supply DMA channels, clients use them
>   * @device: ptr to the dma device who supplies this channel, always !%NULL
>   * @cookie: last cookie value returned to client
> @@ -236,6 +246,8 @@ struct dma_chan_percpu {
>   * @local: per-cpu pointer to a struct dma_chan_percpu
>   * @client_count: how many clients are using this channel
>   * @table_count: number of appearances in the mem-to-mem allocation table
> + * @router: pointer to the DMA router structure
> + * @route_data: channel specific data for the router
>   * @private: private data for certain client-channel associations
>   */
>  struct dma_chan {
> @@ -251,6 +263,11 @@ struct dma_chan {
>  	struct dma_chan_percpu __percpu *local;
>  	int client_count;
>  	int table_count;
> +
> +	/* DMA router */
> +	struct dma_router *router;
> +	void *route_data;
> +
>  	void *private;
>  };
>  
> diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
> index 56bc026c143f..734e449f87c1 100644
> --- a/include/linux/of_dma.h
> +++ b/include/linux/of_dma.h
> @@ -23,6 +23,9 @@ struct of_dma {
>  	struct device_node	*of_node;
>  	struct dma_chan		*(*of_dma_xlate)
>  				(struct of_phandle_args *, struct of_dma *);
> +	void			*(*of_dma_route_allocate)
> +				(struct of_phandle_args *, struct of_dma *);
> +	struct dma_router	*dma_router;
>  	void			*of_dma_data;
>  };
>  
> @@ -37,12 +40,20 @@ extern int of_dma_controller_register(struct device_node *np,
>  		(struct of_phandle_args *, struct of_dma *),
>  		void *data);
>  extern void of_dma_controller_free(struct device_node *np);
> +
> +extern int of_dma_router_register(struct device_node *np,
> +		void *(*of_dma_route_allocate)
> +		(struct of_phandle_args *, struct of_dma *),
> +		 struct dma_router *dma_router);
> +#define of_dma_router_free of_dma_controller_free
> +
>  extern struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
>  						     const char *name);
>  extern struct dma_chan *of_dma_simple_xlate(struct of_phandle_args *dma_spec,
>  		struct of_dma *ofdma);
>  extern struct dma_chan *of_dma_xlate_by_chan_id(struct of_phandle_args *dma_spec,
>  		struct of_dma *ofdma);
> +
>  #else
>  static inline int of_dma_controller_register(struct device_node *np,
>  		struct dma_chan *(*of_dma_xlate)
> @@ -56,6 +67,16 @@ static inline void of_dma_controller_free(struct device_node *np)
>  {
>  }
>  
> +static inline int of_dma_router_register(struct device_node *np,
> +		void *(*of_dma_route_allocate)
> +		(struct of_phandle_args *, struct of_dma *),
> +		 struct dma_router *dma_router)
> +{
> +	return -ENODEV;
> +}
> +
> +#define of_dma_router_free of_dma_controller_free
> +
>  static inline struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
>  						     const char *name)
>  {
> -- 
> 2.3.0
> 

-- 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
