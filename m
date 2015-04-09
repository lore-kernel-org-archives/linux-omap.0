From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 3/8] dmaengine: Add driver for TI DMA crossbar on DRA7x
Date: Thu, 9 Apr 2015 11:09:07 +0300
Message-ID: <552633A3.3070909@ti.com>
References: <1428498892-28471-1-git-send-email-peter.ujfalusi@ti.com> <1428498892-28471-4-git-send-email-peter.ujfalusi@ti.com> <20150408152349.GD26727@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35656 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754988AbbDIIK0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Apr 2015 04:10:26 -0400
In-Reply-To: <20150408152349.GD26727@lukather>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: vinod.koul@intel.com, tony@atomide.com, linux@arm.linux.org.uk, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com, arnd@arndb.de

>> +static inline void ti_dma_xbar_write(void __iomem *iomem, int xbar,=
 int val)
>> +{
>> +	writew_relaxed(val, iomem + (xbar * 2));
>=20
> Silently casting val (an integer) to a u16 isn't really nice I
> guess. At least you could be upfront about it in the prototype.

The value in val is guarantied not to overflow the u16, but sure, I can=
 change
this.

>> +	dma_spec->np =3D of_parse_phandle(ofdma->of_node, "dma-masters", 0=
);
>> +	if (!dma_spec->np) {
>> +		dev_err(&pdev->dev, "Can't get DMA master\n");
>> +		return NULL;
>> +	}
>> +
>> +	map =3D kzalloc(sizeof(*map), GFP_KERNEL);
>> +	if (!map)
>> +		return NULL;
>=20
> You're leaking dma_spec->np.

If kzalloc fails we have other things to worry about, but true, I'll
restructure the code to avoid leaking the node.

>> +	dma_node =3D of_parse_phandle(node, "dma-masters", 0);
>> +	if (!dma_node) {
>> +		dev_err(&pdev->dev, "Can't get DMA master node\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	xbar =3D devm_kzalloc(&pdev->dev, sizeof(*xbar), GFP_KERNEL);
>> +	if (!xbar)
>> +		return -ENOMEM;
>=20
> And here too.

same here, I'll change the code to not leak.

>=20
>> +	if (of_property_read_u32(dma_node, "dma-requests",
>> +				 &xbar->dma_requests)) {
>> +		dev_info(&pdev->dev,
>> +			 "Missing XBAR output information, using %u.\n",
>> +			 TI_XBAR_OUTPUTS);
>> +		xbar->dma_requests =3D TI_XBAR_OUTPUTS;
>> +	}
>> +	of_node_put(dma_node);
>> +
>> +	if (of_property_read_u32(node, "dma-requests", &xbar->xbar_request=
s)) {
>> +		dev_info(&pdev->dev,
>> +			 "Missing XBAR input information, using %u.\n",
>> +			 TI_XBAR_INPUTS);
>> +		xbar->xbar_requests =3D TI_XBAR_INPUTS;
>> +	}
>> +
>> +	if (of_property_read_u32(node, "ti,dma-safe-map", &xbar->safe_val)=
)
>> +		xbar->safe_val =3D 0;
>> +
>> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res)
>> +		return -ENODEV;
>> +
>> +	if (!devm_request_mem_region(&pdev->dev, res->start, resource_size=
(res),
>> +				     dev_name(&pdev->dev)))
>> +		return -ENODEV;
>> +
>> +	iomem =3D devm_ioremap(&pdev->dev, res->start, resource_size(res))=
;
>> +	if (!iomem)
>> +		return -ENOMEM;
>=20
> You can use devm_ioremap_resource here.

I tend to forgot about this...

>> +	xbar->iomem =3D iomem;
>> +
>> +	xbar->dmarouter.dev =3D &pdev->dev;
>> +	xbar->dmarouter.route_free =3D ti_dma_xbar_free;
>> +
>> +	platform_set_drvdata(pdev, xbar);
>> +
>> +	ret =3D of_dma_router_register(node, ti_dma_xbar_route_allocate,
>> +				     &xbar->dmarouter);
>> +	if (ret)
>> +		return -ENODEV;
>=20
> Starting here, I'd expect that your driver can be used....
>=20
>> +
>> +	/* Reset the crossbar */
>> +	for (i =3D 0; i < xbar->dma_requests; i++)
>> +		ti_dma_xbar_write(xbar->iomem, i, xbar->safe_val);
>=20
> ... however, the hardware doesn't seem ready. Isn't it a race?

True, will change the order.

Thanks,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
