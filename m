From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 3/7] dmaengine: Add driver for TI DMA crossbar on DRA7x
Date: Thu, 26 Mar 2015 14:31:30 +0200
Message-ID: <5513FC22.2030304@ti.com>
References: <1426080210-841-1-git-send-email-peter.ujfalusi@ti.com> <1426080210-841-4-git-send-email-peter.ujfalusi@ti.com> <20150326105603.GK32683@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35179 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751774AbbCZMcI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 26 Mar 2015 08:32:08 -0400
In-Reply-To: <20150326105603.GK32683@intel.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com

On 03/26/2015 12:56 PM, Vinod Koul wrote:
>> +#define TI_XBAR_OUTPUTS	127
>> +#define TI_XBAR_INPUTS	256
> Ideally this should be moved to DT. Will next revision of this chip a=
lways
> support these output and inputs?

They are coming from DT. I'm using these as fall back values in case we=
 can
not get this from DT and a warning will be printed in case if this unli=
kely
event happens.

>> +
>> +static DEFINE_IDR(map_idr);
>> +
>> +struct ti_dma_xbar_data {
>> +	struct dma_router dmarouter;
>> +	struct regmap *regmap;
>> +
>> +	uint safe_val; /* Value to rest the crossbar lines */
>> +	uint xbar_requests; /* number of DMA requests connected to XBAR */
>> +	uint dma_requests; /* number of DMA requests forwarded to DMA */
>> +
>> +	void __iomem *iomem;
>> +};
>> +
>> +struct ti_dma_xbar_map {
>> +	int xbar_in;
>> +	int xbar_out;
>> +};
>> +
>> +static void ti_dma_xbar_free(struct device *dev, void *route_data)
>> +{
>> +	struct ti_dma_xbar_data *xbar =3D dev_get_drvdata(dev);
>> +	struct ti_dma_xbar_map *map =3D route_data;
>> +
>> +	dev_dbg(dev, "Unmapping XBAR%d (was routed to %d)\n",
>> +		map->xbar_in, map->xbar_out);
>> +
>> +	regmap_write(xbar->regmap, map->xbar_out * 2, 0);
> just out of curiosity how much do you save using regmap :)

good point, not much I guess. I had it implemented w/o regmap as well, =
but
thought why not use regmap if it is available.

>> +static int ti_dma_xbar_probe(struct platform_device *pdev)
>> +{
>> +	struct device_node *node =3D pdev->dev.of_node;
>> +	struct device_node *dma_node;
>> +	struct ti_dma_xbar_data *xbar;
>> +	struct resource *res;
>> +	void __iomem *iomem;
>> +	int i, ret;
>> +
>> +	if (!node)
>> +		return -ENODEV;
>> +
>> +	dma_node =3D of_parse_phandle(node, "dma-device", 0);
>> +	if (!dma_node) {
>> +		dev_err(&pdev->dev, "Can't get target DMA node\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	xbar =3D devm_kzalloc(&pdev->dev, sizeof(*xbar), GFP_KERNEL);
>> +	if (!xbar)
>> +		return -ENOMEM;
>> +
>> +	if (of_property_read_u32(dma_node, "dma-requests",
>> +				 &xbar->dma_requests)) {
>> +		dev_info(&pdev->dev,
>> +			 "Missing XBAR output information, using %u.\n",
>> +			 TI_XBAR_OUTPUTS);
>> +		xbar->dma_requests =3D TI_XBAR_OUTPUTS;
>> +	}
>> +	of_node_put(dma_node);
> _put here?

The code takes the real dma controller's node and it should be put back=
 after
I have got the information I needed from it (number of DMA requests).

>=20
>> +int omap_dmaxbar_init(void)
>> +{
>> +	return platform_driver_register(&ti_dma_xbar_driver);
>> +}
>> +arch_initcall(omap_dmaxbar_init);
> why arch_initcall?

It should be on the same init level as the real DMA controller. omap-dm=
a at
the moment, but in some platforms this can work with the edma as well.
Since all device in the system (well most of them anyway) uses DMA it i=
s
better to not delay their probe with deferring because the crossbar dri=
ver is
still not loaded

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
