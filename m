From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v4 1/8] dmaengine: of_dma: Support for DMA routers
Date: Fri, 10 Apr 2015 09:40:58 +0200
Message-ID: <20150410074058.GN26727@lukather>
References: <1428498892-28471-1-git-send-email-peter.ujfalusi@ti.com>
 <1428498892-28471-2-git-send-email-peter.ujfalusi@ti.com>
 <20150408154251.GE26727@lukather>
 <5526375A.7090708@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/TUrtqMIkCP4YtJm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5526375A.7090708@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, tony@atomide.com, linux@arm.linux.org.uk, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org


--/TUrtqMIkCP4YtJm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 09, 2015 at 11:24:58AM +0300, Peter Ujfalusi wrote:
> On 04/08/2015 06:42 PM, Maxime Ripard wrote:
> >> ---
> >>  Documentation/devicetree/bindings/dma/dma.txt | 28 +++++++++
> >>  drivers/dma/dmaengine.c                       |  7 +++
> >>  drivers/dma/of-dma.c                          | 86 ++++++++++++++++++=
+++++++++
> >>  include/linux/dmaengine.h                     | 17 ++++++
> >>  include/linux/of_dma.h                        | 21 +++++++
> >>  5 files changed, 159 insertions(+)
> >=20
> > Can that be moved to a header / C file of its own?
> >=20
> > There's a lot of various code already in dmaengine.h and dmaengine.c,
> > it would be really great to avoid adding more random stuff in there.
>=20
> This patch adds the core support for DMA signal routers. It adds
> fairly small amount of generic code to the core to achieve this. I
> don't think it would be better to create let's say of-dma-router.c
> and .h just for this and export functions from of-dma.c to be used
> outside of the file.

A lot of "a fairly small amount of generic code" has been added over
time, and we ended up in the current situation.

It's a bit sad if we just end up moving this just after it got merged,
especially if it doesn't have any kind of dependency on any of the
core function.

> >> +int of_dma_router_register(struct device_node *np,
> >> +			   void *(*of_dma_route_allocate)
> >> +			   (struct of_phandle_args *, struct of_dma *),
> >> +			   struct dma_router *dma_router)
> >> +{
> >> +	struct of_dma	*ofdma;
> >> +
> >> +	if (!np || !of_dma_route_allocate || !dma_router) {
> >> +		pr_err("%s: not enough information provided\n", __func__);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	ofdma =3D kzalloc(sizeof(*ofdma), GFP_KERNEL);
> >> +	if (!ofdma)
> >> +		return -ENOMEM;
> >=20
> > Is that expected that you allocate through kzalloc, but never have a
> > matching free function implemented?
>=20
> The free is via the of_dma_router_free() in case the router is removed
> runtime, which is unlikely to happen since it will cause all DMA request =
to fail.

Ok.

> >> diff --git a/include/linux/of_dma.h b/include/linux/of_dma.h
> >> index 56bc026c143f..734e449f87c1 100644
> >> --- a/include/linux/of_dma.h
> >> +++ b/include/linux/of_dma.h
> >> @@ -23,6 +23,9 @@ struct of_dma {
> >>  	struct device_node	*of_node;
> >>  	struct dma_chan		*(*of_dma_xlate)
> >>  				(struct of_phandle_args *, struct of_dma *);
> >> +	void			*(*of_dma_route_allocate)
> >> +				(struct of_phandle_args *, struct of_dma *);
> >> +	struct dma_router	*dma_router;
> >=20
> > I don't really see why this is really tied to the device tree.
>=20
> The signal router is not a DMA device, it is represented in the device tr=
ee
> and the code will do the needed translation, which is transparent for the=
 DMA
> clients and also for the DMA controllers. Neither should know about the s=
ignal
> router.

Yeah, I got that part, and we do agree on that.

> Similar translation can be done for ACPI.

But this argument is exactly why it shouldn't be tied to the device
tree. We wouldn't like to re-do all this all over again for ACPI,
while your code seems to just handle that very well, wouldn't we?

> > Couldn't we use the device_alloc_chan_resources to do that?
>=20
> Not really. The router itself is not a DMA controller. The routing
> need to be configured before the device_alloc_chan_resources can be
> called for the real DMA controller. The signal router (core part +
> the HW driver) need to prepare the route and do the translation so
> the filter function of the DMA driver can validate the translated
> request.

Ah, yes, hence why you need a custom xlate function. Got it, thanks!

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--/TUrtqMIkCP4YtJm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVJ36KAAoJEBx+YmzsjxAgpTsQAJXBAGIZJvdVA4g6CZHrCUQ8
+RUDiPrXR1YzI6hCz96sYJoLlNQZWrbAxUr6XaK5ydj4MeOachnA/BfHn1bErKkS
444Sk+GE5IPZLrpvklWcVopLqxuRyoOMNM5PpIB0d2qeWP4agbHd3Q2RDKHonpJb
eN8Wl1rXFapz6/ElYnLsm9bZof5fy7OQHPTW9AM7qXsuLeb+TG7U/trOA4dZgr4u
Ow5XH7re/QsomnfisTOsivAx2eX2KC2PIlGm+RKh59dQ+YepEz6wFJid7C0BipVT
NW80/7tfLJq+RzJeuVzyqN5cxIKNaCG0m3h8QAuKFp7qupj1U9h9xb+wIgOFljsy
hnvmw8F49yXY/IpVUGeuXUCUIcY5jrBaP2U/akLy9lszyOE4FNFBwnSlnrahUein
gjFJzJRH9ZARQAhP27orwG7VwdmNSSd8wl+TK4Ngfk/cG7JFWTk4Gw/NpeiDJsys
yLxMWI2JnAv1EcZXg7TvWjePFPG0yiyhsYM1/MKfpDGb+WnTd19e+MfjNKP7PNKR
YMYZsxshbERRnNCsqpYPgbkpj9DMB/p6u7aRP6hC3ej6Nb68UZ8aktKHWZlMknOZ
RB5rAHfeO8GjCe6gA+Yo2wgk+cJ5bqEwA1fN3EwC278w35cuVn+4m5nqGBzmf3mD
jQQ+acg1qIUKYeysswf6
=UuNd
-----END PGP SIGNATURE-----

--/TUrtqMIkCP4YtJm--
