From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 3/7] dmaengine: Add driver for TI DMA crossbar on DRA7x
Date: Thu, 26 Mar 2015 21:07:27 +0530
Message-ID: <20150326153727.GN32683@intel.com>
References: <1426080210-841-1-git-send-email-peter.ujfalusi@ti.com>
 <1426080210-841-4-git-send-email-peter.ujfalusi@ti.com>
 <20150326105603.GK32683@intel.com>
 <5513FC22.2030304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5513FC22.2030304@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 26, 2015 at 02:31:30PM +0200, Peter Ujfalusi wrote:
> On 03/26/2015 12:56 PM, Vinod Koul wrote:
> >> +#define TI_XBAR_OUTPUTS	127
> >> +#define TI_XBAR_INPUTS	256
> > Ideally this should be moved to DT. Will next revision of this chip always
> > support these output and inputs?
> 
> They are coming from DT. I'm using these as fall back values in case we can
> not get this from DT and a warning will be printed in case if this unlikely
> event happens.
Oops missed, that. Looks fine then

> 
> >> +
> >> +static DEFINE_IDR(map_idr);
> >> +
> >> +struct ti_dma_xbar_data {
> >> +	struct dma_router dmarouter;
> >> +	struct regmap *regmap;
> >> +
> >> +	uint safe_val; /* Value to rest the crossbar lines */
> >> +	uint xbar_requests; /* number of DMA requests connected to XBAR */
> >> +	uint dma_requests; /* number of DMA requests forwarded to DMA */
> >> +
> >> +	void __iomem *iomem;
> >> +};
> >> +
> >> +struct ti_dma_xbar_map {
> >> +	int xbar_in;
> >> +	int xbar_out;
> >> +};
> >> +
> >> +static void ti_dma_xbar_free(struct device *dev, void *route_data)
> >> +{
> >> +	struct ti_dma_xbar_data *xbar = dev_get_drvdata(dev);
> >> +	struct ti_dma_xbar_map *map = route_data;
> >> +
> >> +	dev_dbg(dev, "Unmapping XBAR%d (was routed to %d)\n",
> >> +		map->xbar_in, map->xbar_out);
> >> +
> >> +	regmap_write(xbar->regmap, map->xbar_out * 2, 0);
> > just out of curiosity how much do you save using regmap :)
> 
> good point, not much I guess. I had it implemented w/o regmap as well, but
> thought why not use regmap if it is available.
Yes but there is overhead involved in setting it up. I though you have some
latency issues. It is okay to have it :)
Cache is anyways fastest :)

> >> +static int ti_dma_xbar_probe(struct platform_device *pdev)
> >> +{
> >> +	struct device_node *node = pdev->dev.of_node;
> >> +	struct device_node *dma_node;
> >> +	struct ti_dma_xbar_data *xbar;
> >> +	struct resource *res;
> >> +	void __iomem *iomem;
> >> +	int i, ret;
> >> +
> >> +	if (!node)
> >> +		return -ENODEV;
> >> +
> >> +	dma_node = of_parse_phandle(node, "dma-device", 0);
> >> +	if (!dma_node) {
> >> +		dev_err(&pdev->dev, "Can't get target DMA node\n");
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +	xbar = devm_kzalloc(&pdev->dev, sizeof(*xbar), GFP_KERNEL);
> >> +	if (!xbar)
> >> +		return -ENOMEM;
> >> +
> >> +	if (of_property_read_u32(dma_node, "dma-requests",
> >> +				 &xbar->dma_requests)) {
> >> +		dev_info(&pdev->dev,
> >> +			 "Missing XBAR output information, using %u.\n",
> >> +			 TI_XBAR_OUTPUTS);
> >> +		xbar->dma_requests = TI_XBAR_OUTPUTS;
> >> +	}
> >> +	of_node_put(dma_node);
> > _put here?
> 
> The code takes the real dma controller's node and it should be put back after
> I have got the information I needed from it (number of DMA requests).
> 
> > 
> >> +int omap_dmaxbar_init(void)
> >> +{
> >> +	return platform_driver_register(&ti_dma_xbar_driver);
> >> +}
> >> +arch_initcall(omap_dmaxbar_init);
> > why arch_initcall?
> 
> It should be on the same init level as the real DMA controller. omap-dma at
> the moment, but in some platforms this can work with the edma as well.
> Since all device in the system (well most of them anyway) uses DMA it is
> better to not delay their probe with deferring because the crossbar driver is
> still not loaded
Deferring if resources not available is the right thing and helps you get rid
of init level ordering magic...

-- 
~Vinod
