From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 1/8] dmaengine: of_dma: Support for DMA routers
Date: Thu, 9 Apr 2015 11:24:58 +0300
Message-ID: <5526375A.7090708@ti.com>
References: <1428498892-28471-1-git-send-email-peter.ujfalusi@ti.com> <1428498892-28471-2-git-send-email-peter.ujfalusi@ti.com> <20150408154251.GE26727@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:42468 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932657AbbDIIZp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Apr 2015 04:25:45 -0400
In-Reply-To: <20150408154251.GE26727@lukather>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: vinod.koul@intel.com, tony@atomide.com, linux@arm.linux.org.uk, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com, arnd@arndb.de

On 04/08/2015 06:42 PM, Maxime Ripard wrote:
>> ---
>>  Documentation/devicetree/bindings/dma/dma.txt | 28 +++++++++
>>  drivers/dma/dmaengine.c                       |  7 +++
>>  drivers/dma/of-dma.c                          | 86 ++++++++++++++++=
+++++++++++
>>  include/linux/dmaengine.h                     | 17 ++++++
>>  include/linux/of_dma.h                        | 21 +++++++
>>  5 files changed, 159 insertions(+)
>=20
> Can that be moved to a header / C file of its own?
>=20
> There's a lot of various code already in dmaengine.h and dmaengine.c,
> it would be really great to avoid adding more random stuff in there.

This patch adds the core support for DMA signal routers. It adds fairly=
 small
amount of generic code to the core to achieve this. I don't think it wo=
uld be
better to create let's say of-dma-router.c and .h just for this and exp=
ort
functions from of-dma.c to be used outside of the file.

>> +	chan =3D ofdma_target->of_dma_xlate(&dma_spec_target, ofdma_target=
);
>> +	if (chan) {
>> +		chan->router =3D ofdma->dma_router;
>> +		chan->route_data =3D route_data;
>> +	} else {
>> +		ofdma->dma_router->route_free(ofdma->dma_router->dev, route_data)=
;
>=20
> This line is over 80 characters.

Oh, true.

>> +int of_dma_router_register(struct device_node *np,
>> +			   void *(*of_dma_route_allocate)
>> +			   (struct of_phandle_args *, struct of_dma *),
>> +			   struct dma_router *dma_router)
>> +{
>> +	struct of_dma	*ofdma;
>> +
>> +	if (!np || !of_dma_route_allocate || !dma_router) {
>> +		pr_err("%s: not enough information provided\n", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	ofdma =3D kzalloc(sizeof(*ofdma), GFP_KERNEL);
>> +	if (!ofdma)
>> +		return -ENOMEM;
>=20
> Is that expected that you allocate through kzalloc, but never have a
> matching free function implemented?

The free is via the of_dma_router_free() in case the router is removed
runtime, which is unlikely to happen since it will cause all DMA reques=
t to fail.

>> diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
>> index 56bc026c143f..734e449f87c1 100644
>> --- a/include/linux/of_dma.h
>> +++ b/include/linux/of_dma.h
>> @@ -23,6 +23,9 @@ struct of_dma {
>>  	struct device_node	*of_node;
>>  	struct dma_chan		*(*of_dma_xlate)
>>  				(struct of_phandle_args *, struct of_dma *);
>> +	void			*(*of_dma_route_allocate)
>> +				(struct of_phandle_args *, struct of_dma *);
>> +	struct dma_router	*dma_router;
>=20
> I don't really see why this is really tied to the device tree.

The signal router is not a DMA device, it is represented in the device =
tree
and the code will do the needed translation, which is transparent for t=
he DMA
clients and also for the DMA controllers. Neither should know about the=
 signal
router.
Similar translation can be done for ACPI.

> Couldn't we use the device_alloc_chan_resources to do that?

Not really. The router itself is not a DMA controller. The routing need=
 to be
configured before the device_alloc_chan_resources can be called for the=
 real
DMA controller. The signal router (core part + the HW driver) need to p=
repare
the route and do the translation so the filter function of the DMA driv=
er can
validate the translated request.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
