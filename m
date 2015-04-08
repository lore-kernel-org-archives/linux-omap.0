From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v4 3/8] dmaengine: Add driver for TI DMA crossbar on DRA7x
Date: Wed, 8 Apr 2015 17:23:49 +0200
Message-ID: <20150408152349.GD26727@lukather>
References: <1428498892-28471-1-git-send-email-peter.ujfalusi@ti.com>
 <1428498892-28471-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428498892-28471-4-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, tony@atomide.com, linux@arm.linux.org.uk, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 08, 2015 at 04:14:47PM +0300, Peter Ujfalusi wrote:
> The DRA7x has more peripherals with DMA requests than the sDMA can handle:
> 205 vs 127. All DMA requests are routed through the DMA crossbar, which c=
an
> be configured to route selected incoming DMA requests to specific sDMA
> request.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/Kconfig           |   4 +
>  drivers/dma/Makefile          |   1 +
>  drivers/dma/ti-dma-crossbar.c | 185 ++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 190 insertions(+)
>  create mode 100644 drivers/dma/ti-dma-crossbar.c
>=20
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 91eced044321..33a7401597be 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -234,6 +234,9 @@ config TI_EDMA
>  	  Enable support for the TI EDMA controller. This DMA
>  	  engine is found on TI DaVinci and AM33xx parts.
> =20
> +config TI_DMA_CROSSBAR
> +	bool
> +
>  config ARCH_HAS_ASYNC_TX_FIND_CHANNEL
>  	bool
> =20
> @@ -319,6 +322,7 @@ config DMA_OMAP
>  	depends on ARCH_OMAP
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
> +	select TI_DMA_CROSSBAR if SOC_DRA7XX
> =20
>  config DMA_BCM2835
>  	tristate "BCM2835 DMA engine support"
> diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
> index 7e8301cb489d..19ac70b8af0a 100644
> --- a/drivers/dma/Makefile
> +++ b/drivers/dma/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_EP93XX_DMA) +=3D ep93xx_dma.o
>  obj-$(CONFIG_DMA_SA11X0) +=3D sa11x0-dma.o
>  obj-$(CONFIG_MMP_TDMA) +=3D mmp_tdma.o
>  obj-$(CONFIG_DMA_OMAP) +=3D omap-dma.o
> +obj-$(CONFIG_TI_DMA_CROSSBAR) +=3D ti-dma-crossbar.o
>  obj-$(CONFIG_DMA_BCM2835) +=3D bcm2835-dma.o
>  obj-$(CONFIG_MMP_PDMA) +=3D mmp_pdma.o
>  obj-$(CONFIG_DMA_JZ4740) +=3D dma-jz4740.o
> diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
> new file mode 100644
> index 000000000000..5cb1eb7e86d2
> --- /dev/null
> +++ b/drivers/dma/ti-dma-crossbar.c
> @@ -0,0 +1,185 @@
> +/*
> + *  Copyright (C) 2015 Texas Instruments Incorporated - http://www.ti.com
> + *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + */
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/list.h>
> +#include <linux/io.h>
> +#include <linux/idr.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
> +#include <linux/of_dma.h>
> +
> +#define TI_XBAR_OUTPUTS	127
> +#define TI_XBAR_INPUTS	256
> +
> +static DEFINE_IDR(map_idr);
> +
> +struct ti_dma_xbar_data {
> +	void __iomem *iomem;
> +
> +	struct dma_router dmarouter;
> +
> +	uint safe_val; /* Value to rest the crossbar lines */
> +	uint xbar_requests; /* number of DMA requests connected to XBAR */
> +	uint dma_requests; /* number of DMA requests forwarded to DMA */
> +};
> +
> +struct ti_dma_xbar_map {
> +	int xbar_in;
> +	int xbar_out;
> +};
> +
> +static inline void ti_dma_xbar_write(void __iomem *iomem, int xbar, int =
val)
> +{
> +	writew_relaxed(val, iomem + (xbar * 2));

Silently casting val (an integer) to a u16 isn't really nice I
guess. At least you could be upfront about it in the prototype.

> +}
> +
> +static void ti_dma_xbar_free(struct device *dev, void *route_data)
> +{
> +	struct ti_dma_xbar_data *xbar =3D dev_get_drvdata(dev);
> +	struct ti_dma_xbar_map *map =3D route_data;
> +
> +	dev_dbg(dev, "Unmapping XBAR%d (was routed to %d)\n",
> +		map->xbar_in, map->xbar_out);
> +
> +	ti_dma_xbar_write(xbar->iomem, map->xbar_out, xbar->safe_val);
> +	idr_remove(&map_idr, map->xbar_out);
> +	kfree(map);
> +}
> +
> +static void *ti_dma_xbar_route_allocate(struct of_phandle_args *dma_spec,
> +					struct of_dma *ofdma)
> +{
> +	struct platform_device *pdev =3D of_find_device_by_node(ofdma->of_node);
> +	struct ti_dma_xbar_data *xbar =3D platform_get_drvdata(pdev);
> +	struct ti_dma_xbar_map *map;
> +
> +	if (dma_spec->args[0] >=3D xbar->xbar_requests) {
> +		dev_err(&pdev->dev, "Invalid XBAR request number: %d\n",
> +			dma_spec->args[0]);
> +		return NULL;
> +	}
> +
> +	dma_spec->np =3D of_parse_phandle(ofdma->of_node, "dma-masters", 0);
> +	if (!dma_spec->np) {
> +		dev_err(&pdev->dev, "Can't get DMA master\n");
> +		return NULL;
> +	}
> +
> +	map =3D kzalloc(sizeof(*map), GFP_KERNEL);
> +	if (!map)
> +		return NULL;

You're leaking dma_spec->np.

> +
> +	map->xbar_out =3D idr_alloc(&map_idr, NULL, 0, xbar->dma_requests,
> +				  GFP_KERNEL);
> +	map->xbar_in =3D dma_spec->args[0];
> +
> +	/* The DMA request is 1 based in sDMA */
> +	dma_spec->args[0] =3D map->xbar_out + 1;
> +
> +	dev_dbg(&pdev->dev, "Mapping XBAR%d to DMA%d\n",
> +		map->xbar_in, map->xbar_out);
> +
> +	ti_dma_xbar_write(xbar->iomem, map->xbar_out, map->xbar_in);
> +
> +	return map;
> +}
> +
> +static int ti_dma_xbar_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node =3D pdev->dev.of_node;
> +	struct device_node *dma_node;
> +	struct ti_dma_xbar_data *xbar;
> +	struct resource *res;
> +	void __iomem *iomem;
> +	int i, ret;
> +
> +	if (!node)
> +		return -ENODEV;
> +
> +	dma_node =3D of_parse_phandle(node, "dma-masters", 0);
> +	if (!dma_node) {
> +		dev_err(&pdev->dev, "Can't get DMA master node\n");
> +		return -ENODEV;
> +	}
> +
> +	xbar =3D devm_kzalloc(&pdev->dev, sizeof(*xbar), GFP_KERNEL);
> +	if (!xbar)
> +		return -ENOMEM;

And here too.

> +	if (of_property_read_u32(dma_node, "dma-requests",
> +				 &xbar->dma_requests)) {
> +		dev_info(&pdev->dev,
> +			 "Missing XBAR output information, using %u.\n",
> +			 TI_XBAR_OUTPUTS);
> +		xbar->dma_requests =3D TI_XBAR_OUTPUTS;
> +	}
> +	of_node_put(dma_node);
> +
> +	if (of_property_read_u32(node, "dma-requests", &xbar->xbar_requests)) {
> +		dev_info(&pdev->dev,
> +			 "Missing XBAR input information, using %u.\n",
> +			 TI_XBAR_INPUTS);
> +		xbar->xbar_requests =3D TI_XBAR_INPUTS;
> +	}
> +
> +	if (of_property_read_u32(node, "ti,dma-safe-map", &xbar->safe_val))
> +		xbar->safe_val =3D 0;
> +
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENODEV;
> +
> +	if (!devm_request_mem_region(&pdev->dev, res->start, resource_size(res),
> +				     dev_name(&pdev->dev)))
> +		return -ENODEV;
> +
> +	iomem =3D devm_ioremap(&pdev->dev, res->start, resource_size(res));
> +	if (!iomem)
> +		return -ENOMEM;

You can use devm_ioremap_resource here.

> +	xbar->iomem =3D iomem;
> +
> +	xbar->dmarouter.dev =3D &pdev->dev;
> +	xbar->dmarouter.route_free =3D ti_dma_xbar_free;
> +
> +	platform_set_drvdata(pdev, xbar);
> +
> +	ret =3D of_dma_router_register(node, ti_dma_xbar_route_allocate,
> +				     &xbar->dmarouter);
> +	if (ret)
> +		return -ENODEV;

Starting here, I'd expect that your driver can be used....

> +
> +	/* Reset the crossbar */
> +	for (i =3D 0; i < xbar->dma_requests; i++)
> +		ti_dma_xbar_write(xbar->iomem, i, xbar->safe_val);

=2E.. however, the hardware doesn't seem ready. Isn't it a race?


> +	return 0;
> +}
> +
> +static const struct of_device_id ti_dma_xbar_match[] =3D {
> +	{ .compatible =3D "ti,dra7-dma-crossbar" },
> +	{},
> +};
> +
> +static struct platform_driver ti_dma_xbar_driver =3D {
> +	.driver =3D {
> +		.name =3D "ti-dma-crossbar",
> +		.of_match_table =3D of_match_ptr(ti_dma_xbar_match),
> +	},
> +	.probe	=3D ti_dma_xbar_probe,
> +};
> +
> +int omap_dmaxbar_init(void)
> +{
> +	return platform_driver_register(&ti_dma_xbar_driver);
> +}
> +arch_initcall(omap_dmaxbar_init);

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVJUgFAAoJEBx+YmzsjxAg+z0P/itU07/W23Ad4LdqSi482rOj
rUR5Nm/ui0rK+aJcRLL/nskybcD+XdpNskX1wsWeqgAge66nQllMQrN8DlCDfGLx
9DXbbEYsbJlzvXFPqgz0H5IiFLkinvTguXO4ptTMR5Z83e/Vc8aczSawpNPlXSgS
82HEINAhNxZujydU8OTBqnVp6E020aE/TKKnkOoGoULOe8YdLZdoJOZOa9UZK5/2
JjLFQyCtUx33tSTCxZi6NoZTUpmLwZKSDirn9opNeFuGfisw5dGsJGHD96olLhvr
15DUSHJKWFpCjlnErhnJSCQ74Q7lXYvKiX35gC2vf4OTNOmZBrYX0OOLC8WbI1tl
twOkVWG49nWhQl4uX3P/fDxkNnoROyJ+O8lbEff3soJ8NuSrKlRUqm5TPDPmzlRn
+ustTfy1FH12q52/9jN3zF0v5XGSl5u/FbqKBJ6SCOOviz3wTM2ncWaGeBCq9fAZ
Nyuxgy73ftcJUpw/5/PvzWmd3Tnx4i106Lcjwm6EJbn/ofqYHWFkjqnryviVAiYz
VGtd1wcrYfRvrKgaD8nPWeQLrr6jE2Kj3SzSbJegtn6myvX4XkQX6OMta/iGos2f
5rpydU/hyalcGN5n3ldN/mjFnu6JcWL9dcrcHMMLeAjr87XOJrFjgGVhL18Bafii
i6d25NUx1s/V/XwZMR4L
=ba92
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
