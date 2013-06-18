From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 1/2] musb: musb: dsps: support multiple instances
Date: Tue, 18 Jun 2013 11:27:25 +0300
Message-ID: <20130618082725.GG5461@arwen.pp.htv.fi>
References: <1371482014-5244-1-git-send-email-bigeasy@linutronix.de>
 <1371482014-5244-2-git-send-email-bigeasy@linutronix.de>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/Zw+/jwnNHcBRYYu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52835 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753602Ab3FRI2y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Jun 2013 04:28:54 -0400
Content-Disposition: inline
In-Reply-To: <1371482014-5244-2-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Felipe Balbi <balbi@ti.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

--/Zw+/jwnNHcBRYYu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2013 at 05:13:33PM +0200, Sebastian Andrzej Siewior wrote:
> If we specify right now more than once instance then we attempt to add
> the platform device twice. The nop driver does not mind the second add
> because it checks for it and returns without a word. At removal time a
> segfault is likely because the first intance clean ups the phy and
> second, well, goes boom.
> This patchs adds two dummy device node to the am33xx for the dummy phy
> which we have now. During probe time, we grab the phy based on the
> device node if we have one. If not, we use the same hack we used so far.
>=20
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/arm/boot/dts/am33xx.dtsi |  8 ++++++++
>  drivers/usb/musb/musb_dsps.c  | 18 +++++++++++++-----
>  include/linux/usb/musb.h      |  1 +
>  3 files changed, 22 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 8e1248f..30d0d45 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -341,6 +341,14 @@
>  			port1-mode =3D <3>;
>  			power =3D <250>;
>  			ti,hwmods =3D "usb_otg_hs";
> +			phys =3D <&nopphy0 &nopphy1>;
> +		};
> +
> +		nopphy0: usbphy@0 {
> +			compatible =3D "usb-nop-xceiv";
> +		};
> +		nopphy1: usbphy@1 {
> +			compatible =3D "usb-nop-xceiv";
>  		};
> =20
>  		mac: ethernet@4a100000 {
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index e1b661d..d9ff390 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -415,9 +415,14 @@ static int dsps_musb_init(struct musb *musb)
>  	/* mentor core register starts at offset of 0x400 from musb base */
>  	musb->mregs +=3D wrp->musb_core_offset;
> =20
> -	/* NOP driver needs change if supporting dual instance */
> -	usb_nop_xceiv_register();
> -	musb->xceiv =3D usb_get_phy(USB_PHY_TYPE_USB2);
> +	if (!glue->dev->of_node) {
> +		/* This hack works only for a single instance. */
> +		usb_nop_xceiv_register();
> +		musb->xceiv =3D usb_get_phy(USB_PHY_TYPE_USB2);

I think you can drop this altogether, am335x is DT-only anyway :-)

> +	} else {
> +		musb->xceiv =3D devm_usb_get_phy_by_phandle(glue->dev, "phys",
> +				musb->config->instance);
> +	}

after doing all this, perhaps we should re-factor phy_get into
musb_core.c, so that we can remove this sort of support from all glue
layers.

--=20
balbi

--/Zw+/jwnNHcBRYYu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRwBnsAAoJEIaOsuA1yqREOfMP/iSdJSMmyZoIRnoQ2zW5b0+X
af/Yk1lkYj1vVsDuLZfx+0J94JCgOC7ZuZlaQug5KzfsCaPcn4c/GTpuW6jhsy2L
UX73PXtgNRRscmkZb5NuV/RYWfj4tz2o3YZ3pNUfBgv9zcS5t2iOVQluUKTziek0
FKhfNk53H+Gk3oa2EixzpMb/zSInRvUgZDERhbnHS2ebFNmn6oTkdioyl3MmA+3H
a989dAtzJlHL/bOrdyF63C3YuANxkaxJKUbAzq7NM0hrULLCnkMhsSOBIgfY4LjJ
d7GFb20UYt7E16l+OXMCx5sz/co5Qf1ZFl6gIKmwio44ah/gHICCsebNeOru+bsM
k5s9fOvnjSczNevr+j6wx+apfdiuydPpr3slPoVN7fHhdJuaet7JlHY+irontjlg
QXb+ZYthgo+IMcF/M2inn8n9XAu8DkqRlf52hNRcsX9n8Ql0CU2eCY/p9NS1anQW
SkqxmnLykucxDsYjoCxQRVdwNmvHulg9jPZRWNKmUHH9Sac7E0asifOllSlJZ9b/
APJJwEjGsLi6yd7yHSgSr++wCZaHpYnX3OmIjEwhC+rlxtCfNA7jUAbcQf/GFEwt
yJTYfu3CLyUrK0mJ3KazuBOflwnYK7PCK4fri9Eb5YbVRC9QnVxbHqiNrc9ETeo9
rd29WkqjCvKBNLwcq5bR
=i24z
-----END PGP SIGNATURE-----

--/Zw+/jwnNHcBRYYu--
