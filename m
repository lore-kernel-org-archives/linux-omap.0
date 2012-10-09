From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/2] OMAP: VRFB: convert vrfb to platform device
Date: Tue, 09 Oct 2012 11:55:48 +0300
Message-ID: <1349772948.2409.8.camel@deskari>
References: <1349699429-12736-1-git-send-email-tomi.valkeinen@ti.com>
	 <20121008172440.GI3874@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-NNyqc4owim9Q7pSaGLUz"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:51487 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754216Ab2JIIzz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Oct 2012 04:55:55 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so2861239lag.19
        for <linux-omap@vger.kernel.org>; Tue, 09 Oct 2012 01:55:52 -0700 (PDT)
In-Reply-To: <20121008172440.GI3874@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Archit Taneja <archit@ti.com>


--=-NNyqc4owim9Q7pSaGLUz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-10-08 at 10:24 -0700, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [121008 05:31]:
> > This patch converts vrfb library into a platform device, in an effort t=
o
> > remove omap dependencies.
> >=20
> > The platform device is registered in arch/arm/plat-omap/fb.c and
> > assigned resources depending on whether running on omap2 or omap3.
> >=20
> > The vrfb driver will parse those resources and use them to access vrfb
> > configuration registers and the vrfb virtual rotation areas.
> >=20
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > ---
> >  arch/arm/plat-omap/fb.c    |   53 +++++++++++++++++++
> >  drivers/video/omap2/vrfb.c |  124 ++++++++++++++++++++++++++++++++++++=
+-------
> >  2 files changed, 157 insertions(+), 20 deletions(-)
> >=20
> > diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
> > index dd6f92c..d231912 100644
> > --- a/arch/arm/plat-omap/fb.c
> > +++ b/arch/arm/plat-omap/fb.c
> > @@ -35,6 +35,59 @@
> > =20
> >  #include <plat/board.h>
> > =20
> > +#if defined(CONFIG_OMAP2_VRFB)
> > +static const struct resource omap2_vrfb_resources[] =3D {
> > +	DEFINE_RES_MEM(0x68008000u, 0x40),
> > +	DEFINE_RES_MEM(0x70000000u, 0x4000000),
> > +	DEFINE_RES_MEM(0x74000000u, 0x4000000),
> > +	DEFINE_RES_MEM(0x78000000u, 0x4000000),
> > +	DEFINE_RES_MEM(0x7c000000u, 0x4000000),
> > +};
> > +
> > +static const struct resource omap3_vrfb_resources[] =3D {
> > +	DEFINE_RES_MEM(0x6C000180u, 0xc0),
> > +	DEFINE_RES_MEM(0x70000000u, 0x4000000),
> > +	DEFINE_RES_MEM(0x74000000u, 0x4000000),
> > +	DEFINE_RES_MEM(0x78000000u, 0x4000000),
> > +	DEFINE_RES_MEM(0x7c000000u, 0x4000000),
> > +	DEFINE_RES_MEM(0xe0000000u, 0x4000000),
> > +	DEFINE_RES_MEM(0xe4000000u, 0x4000000),
> > +	DEFINE_RES_MEM(0xe8000000u, 0x4000000),
> > +	DEFINE_RES_MEM(0xec000000u, 0x4000000),
> > +	DEFINE_RES_MEM(0xf0000000u, 0x4000000),
> > +	DEFINE_RES_MEM(0xf4000000u, 0x4000000),
> > +	DEFINE_RES_MEM(0xf8000000u, 0x4000000),
> > +	DEFINE_RES_MEM(0xfc000000u, 0x4000000),
> > +};
>=20
> Maybe add comments describing what these register are in case
> we have a framework handling them at some point later on?

Sure.

> > --- a/drivers/video/omap2/vrfb.c
> > +++ b/drivers/video/omap2/vrfb.c
> > +#define SMS_ROT_CONTROL(context)	(0x0 + 0x10 * context)
> > +#define SMS_ROT_SIZE(context)		(0x4 + 0x10 * context)
> > +#define SMS_ROT_PHYSICAL_BA(context)	(0x8 + 0x10 * context)
> > +#define SMS_ROT_VIRT_BASE(rot)		(0x1000000 * (rot))
>=20
> Can you please also remove the old SMS defines and functions
> so other code won't start tinkering with them?

Ok.

> > +static int __init vrfb_probe(struct platform_device *pdev)
> > +{
> > +	struct resource *mem;
> > +	int i;
> > +
> > +	/* first resource is the register res, the rest are vrfb contexts */
> > +
> > +	mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!mem) {
> > +		dev_err(&pdev->dev, "can't get vrfb base address\n");
> > +		return -EINVAL;
> > +	}
>=20
> Now that we assume vrfb is the only user of this, so you must do
> request_mem_region here as that's the only protection we have.
> If that fails here, then we know something is wrong.

Right, I'll add that.

> > +	vrfb_base =3D devm_ioremap(&pdev->dev, mem->start, resource_size(mem)=
);
> > +	if (!vrfb_base) {
> > +		dev_err(&pdev->dev, "can't ioremap vrfb memory\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	num_ctxs =3D pdev->num_resources - 1;
> > +
> > +	ctxs =3D devm_kzalloc(&pdev->dev,
> > +			sizeof(struct vrfb_ctx) * num_ctxs,
> > +			GFP_KERNEL);
> > +
> > +	if (!ctxs)
> > +		return -ENOMEM;
> > +
> > +	for (i =3D 0; i < num_ctxs; ++i) {
> > +		mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 1 + i);
> > +		if (!mem) {
> > +			dev_err(&pdev->dev, "can't get vrfb ctx %d address\n",
> > +					i);
> > +			return -EINVAL;
> > +		}
> > +
> > +		ctxs[i].base =3D mem->start;
> > +	}
>=20
> And request_mem_region must also be done for these registers to make
> sure no other code is using them. Again, if it fails, something is
> wrong.

There's already request_mem_region for the VRFB virtual areas, which is
done later when omapfb or somebody else requests a vrfb context with
omap_vrfb_request_ctx(). The memory areas (they are rotated
framebuffers, not registers as such) are not used until then.

 Tomi


--=-NNyqc4owim9Q7pSaGLUz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQc+aUAAoJEPo9qoy8lh71UTMQAJznfzds1x5TWLhDpeM+14kF
7bGg/tf4sH/ac8oDDzh2i0YyuiOuO+ar10vaNB5U5HrTmZnr6PGHIKYYXtIxED6/
62xqekDVgk1rlA+Tny8CXcrMCJjiFzTUnlZEQ1OdmiHvt4IdqXoLz7nkzjYSPHUJ
cOZ6P97VAl+56DBaIcWWE66Maza1n8j72bjSslNzhReOKIh5cV5x+3825q5bt1Sr
8I2E40entj4WGYnSoJiEn8d64aGcudEFOKlV/GQoGfRsjVQlcfx5DoDB9HFUnm4g
1D4MRe3rRpJv+2Dc8m3GKZRkfDwK/47cD7bTM+bc3q6CSQFwvBXT9/wXR7JSfyO6
6T7sITijcknKjvfxvcOxhTtkrgXm3Uc5hN8M6Z8tpNdZmuwW1eG4SusXskh0OUmX
IgQp+sG0GlRrD/0KCmAZTpP9g96+cRqNSBwKoqt/HdQKIdEgv3iC3lTMLuVzbj+3
aIwF06qvM7jH3/QQJSAcH0QRPPOii9J/WJbZ14MDYuHzo2emK1KalDLwjC+P8wIC
PhfKtmV7TXVWfkX+RHnY3JG58rofd2iqyF8CZWjb3b86HJk+JGB0rfvlJ5Eicx+7
uA6ueEgEEbGLi8plYVmumDesi1Z7yI2kTeFFDm6vb7J0VAE1FJSvkrYjDry/ya51
HEoKnDx+HmlqSgfOXBDK
=UFti
-----END PGP SIGNATURE-----

--=-NNyqc4owim9Q7pSaGLUz--

