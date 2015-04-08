From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v4 1/8] dmaengine: of_dma: Support for DMA routers
Date: Wed, 8 Apr 2015 17:42:51 +0200
Message-ID: <20150408154251.GE26727@lukather>
References: <1428498892-28471-1-git-send-email-peter.ujfalusi@ti.com>
 <1428498892-28471-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xA/XKXTdy9G3iaIz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1428498892-28471-2-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, tony@atomide.com, linux@arm.linux.org.uk, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org


--xA/XKXTdy9G3iaIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 08, 2015 at 04:14:45PM +0300, Peter Ujfalusi wrote:
> DMA routers are transparent devices used to mux DMA requests from
> peripherals to DMA controllers. They are used when the SoC integrates more
> devices with DMA requests then their controller can handle.
> DRA7x is one example of such SoC, where the sDMA can hanlde 128 DMA reque=
st
> lines, but in SoC level it has 205 DMA requests.
>=20
> The of_dma_router will be registered as of_dma_controller with special
> xlate function and additional parameters. The driver for the router is
> responsible to craft the dma_spec (in the of_dma_route_allocate callback)
> which can be used to requests a DMA channel from the real DMA controller.
> This way the router can be transparent for the system while remaining gen=
eric
> enough to be used in different environments.
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  Documentation/devicetree/bindings/dma/dma.txt | 28 +++++++++
>  drivers/dma/dmaengine.c                       |  7 +++
>  drivers/dma/of-dma.c                          | 86 +++++++++++++++++++++=
++++++
>  include/linux/dmaengine.h                     | 17 ++++++
>  include/linux/of_dma.h                        | 21 +++++++
>  5 files changed, 159 insertions(+)

Can that be moved to a header / C file of its own?

There's a lot of various code already in dmaengine.h and dmaengine.c,
it would be really great to avoid adding more random stuff in there.

>=20
> diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentatio=
n/devicetree/bindings/dma/dma.txt
> index 82104271e754..6312fb00ce8d 100644
> --- a/Documentation/devicetree/bindings/dma/dma.txt
> +++ b/Documentation/devicetree/bindings/dma/dma.txt
> @@ -31,6 +31,34 @@ Example:
>  		dma-requests =3D <127>;
>  	};
> =20
> +* DMA router
> +
> +DMA routers are transparent IP blocks used to route DMA request lines fr=
om
> +devices to the DMA controller. Some SoCs (like TI DRA7x) have more perip=
herals
> +integrated with DMA requests than what the DMA controller can handle dir=
ectly.
> +
> +Required property:
> +- dma-masters:		phandle of the DMA controller or list of phandles for
> +			the DMA controllers the router can direct the signal to.
> +- #dma-cells: 		Must be at least 1. Used to provide DMA router specific
> +			information. See DMA client binding below for more
> +			details.
> +
> +Optional properties:
> +- dma-requests: 	Number of incoming request lines the router can handle.
> +- In the node pointed by the dma-masters:
> +	- dma-requests:	The router driver might need to look for this in order
> +			to configure the routing.
> +
> +Example:
> +	sdma_xbar: dma-router@4a002b78 {
> +		compatible =3D "ti,dra7-dma-crossbar";
> +		reg =3D <0x4a002b78 0xfc>;
> +		#dma-cells =3D <1>;
> +		dma-requests =3D <205>;
> +		ti,dma-safe-map =3D <0>;
> +		dma-masters =3D <&sdma>;
> +	};
> =20
>  * DMA client
> =20
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index 24967c89f5d4..c7aa232b4a59 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -267,6 +267,13 @@ static void dma_chan_put(struct dma_chan *chan)
>  	/* This channel is not in use anymore, free it */
>  	if (!chan->client_count && chan->device->device_free_chan_resources)
>  		chan->device->device_free_chan_resources(chan);
> +
> +	/* If the channel is used via a DMA request router, free the mapping */
> +	if (chan->router && chan->router->route_free) {
> +		chan->router->route_free(chan->router->dev, chan->route_data);
> +		chan->router =3D NULL;
> +		chan->route_data =3D NULL;
> +	}
>  }
> =20
>  enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie)
> diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
> index cbd4a8aff120..98b3b61624f0 100644
> --- a/drivers/dma/of-dma.c
> +++ b/drivers/dma/of-dma.c
> @@ -45,6 +45,47 @@ static struct of_dma *of_dma_find_controller(struct of=
_phandle_args *dma_spec)
>  }
> =20
>  /**
> + * of_dma_router_xlate - translation function for router devices
> + * @dma_spec:	pointer to DMA specifier as found in the device tree
> + * @of_dma:	pointer to DMA controller data (router information)
> + *
> + * The function creates new dma_spec to be passed to the router driver's
> + * of_dma_route_allocate() function to prepare a dma_spec which will be =
used
> + * to request channel from the real DMA controller.
> + */
> +static struct dma_chan *of_dma_router_xlate(struct of_phandle_args *dma_=
spec,
> +					    struct of_dma *ofdma)
> +{
> +	struct dma_chan		*chan;
> +	struct of_dma		*ofdma_target;
> +	struct of_phandle_args	dma_spec_target;
> +	void			*route_data;
> +
> +	/* translate the request for the real DMA controller */
> +	memcpy(&dma_spec_target, dma_spec, sizeof(dma_spec_target));
> +	route_data =3D ofdma->of_dma_route_allocate(&dma_spec_target, ofdma);
> +
> +	ofdma_target =3D of_dma_find_controller(&dma_spec_target);
> +	if (!ofdma_target)
> +		return NULL;
> +
> +	chan =3D ofdma_target->of_dma_xlate(&dma_spec_target, ofdma_target);
> +	if (chan) {
> +		chan->router =3D ofdma->dma_router;
> +		chan->route_data =3D route_data;
> +	} else {
> +		ofdma->dma_router->route_free(ofdma->dma_router->dev, route_data);

This line is over 80 characters.

> +	}
> +
> +	/*
> +	 * Need to put the node back since the ofdma->of_dma_route_allocate
> +	 * has taken it for generating the new, translated dma_spec
> +	 */
> +	of_node_put(dma_spec_target.np);
> +	return chan;
> +}
> +
> +/**
>   * of_dma_controller_register - Register a DMA controller to DT DMA help=
ers
>   * @np:			device node of DMA controller
>   * @of_dma_xlate:	translation function which converts a phandle
> @@ -110,6 +151,51 @@ void of_dma_controller_free(struct device_node *np)
>  EXPORT_SYMBOL_GPL(of_dma_controller_free);
> =20
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
> + * Allocated memory should be freed with appropriate of_dma_controller_f=
ree()
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
> +	ofdma =3D kzalloc(sizeof(*ofdma), GFP_KERNEL);
> +	if (!ofdma)
> +		return -ENOMEM;

Is that expected that you allocate through kzalloc, but never have a
matching free function implemented?

> +	ofdma->of_node =3D np;
> +	ofdma->of_dma_xlate =3D of_dma_router_xlate;
> +	ofdma->of_dma_route_allocate =3D of_dma_route_allocate;
> +	ofdma->dma_router =3D dma_router;
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
> index ad419757241f..abf63ceabef9 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -222,6 +222,16 @@ struct dma_chan_percpu {
>  };
> =20
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
>   * @device: ptr to the dma device who supplies this channel, always !%NU=
LL
>   * @cookie: last cookie value returned to client
> @@ -232,6 +242,8 @@ struct dma_chan_percpu {
>   * @local: per-cpu pointer to a struct dma_chan_percpu
>   * @client_count: how many clients are using this channel
>   * @table_count: number of appearances in the mem-to-mem allocation table
> + * @router: pointer to the DMA router structure
> + * @route_data: channel specific data for the router
>   * @private: private data for certain client-channel associations
>   */
>  struct dma_chan {
> @@ -247,6 +259,11 @@ struct dma_chan {
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
> =20
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

I don't really see why this is really tied to the device tree.

Couldn't we use the device_alloc_chan_resources to do that?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--xA/XKXTdy9G3iaIz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVJUx7AAoJEBx+YmzsjxAgevgP/1D5CHAXWmOjCXLmvt37/nw+
yVf+7H1DtR+ZMJm+UBOu02i42I7psPrA7eS/29RDgadZo7k5D9Bf5X8Bd8wQmlSK
4hvqUvFkA8F1pfUsqFLctcHDkHU8JiNkJ1Z/RNilcCqCWis45mu2rKwKsjF5PTch
jORF5QzPNQh+/2HW2I5J10dZWv52DrIifq5aAKAvuFJ3GRjNIHcAVClxOjLrQBd1
bYBpMxugR+tTq72LwSfeIMq5tUhQkepXRqNdejNalZDs72zHmdiyquFBnwp6K2eH
yBPSqW6GQbmrcWfe0JjOVzAgXY1Q2cq84fQopFIBgSL2KYFepJYQ8N7wC5TZbjMH
Sv6+EL/0SovMR6cPoHv04/Z5jd2FcJv26gqz7CqGtzzKMjEV1b2QuDbSfKvwg4co
FvsJ4vgesMi6b8rs1XnuLRoq7lXbUvEzKI8NZBLVJHFO/UlSPBA/Ctl2zu9kA67m
ZGxUkXikrAX8aa7SwydKBwvKtjXlAHUMnq+GWjW2WXC3ktiDSga4Qjj316xXwQXS
UBgav88yqhxH+B5YIaYHYY6PVMBaClq/Vcy7KE4BQ0BjpOTpvXlmp+pJlPeXQ1dz
KmlXZLltXHgpM7D6Vj9M8PYK8H0yhSvJ6f3NYoUewahbF8O+9rZPSxZGgrVTrdtM
7JC2dwsG2oxzOYwYXUJR
=7qwu
-----END PGP SIGNATURE-----

--xA/XKXTdy9G3iaIz--
