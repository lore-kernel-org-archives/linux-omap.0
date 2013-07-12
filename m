From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] arm: omap5: dts: fix reg property size
Date: Fri, 12 Jul 2013 15:45:54 +0300
Message-ID: <20130712124554.GA18154@arwen.pp.htv.fi>
References: <1373630285-17389-1-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55097 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932951Ab3GLMqh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Jul 2013 08:46:37 -0400
Content-Disposition: inline
In-Reply-To: <1373630285-17389-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Kishon Vijay Abraham I <kishon@ti.com>, benoit.cousson@linaro.org

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+ Benoit

On Fri, Jul 12, 2013 at 02:58:05PM +0300, Felipe Balbi wrote:
> USB3 block has a 64KiB space, another 64KiB is
> used for the wrapper.
>=20
> Without this change, resource_size() will get
> confused and driver won't probe because size
> will be negative.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>=20
> does anybody know Benoit's knew email address ?
>=20
>  arch/arm/boot/dts/omap5.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index e643620..5c99f19 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -637,7 +637,7 @@
>  		omap_dwc3@4a020000 {
>  			compatible =3D "ti,dwc3";
>  			ti,hwmods =3D "usb_otg_ss";
> -			reg =3D <0x4a020000 0x1000>;
> +			reg =3D <0x4a020000 0x10000>;
>  			interrupts =3D <GIC_SPI 93 IRQ_TYPE_LEVEL_HIGH>;
>  			#address-cells =3D <1>;
>  			#size-cells =3D <1>;
> @@ -645,7 +645,7 @@
>  			ranges;
>  			dwc3@4a030000 {
>  				compatible =3D "synopsys,dwc3";
> -				reg =3D <0x4a030000 0x1000>;
> +				reg =3D <0x4a030000 0x10000>;
>  				interrupts =3D <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
>  				usb-phy =3D <&usb2_phy>, <&usb3_phy>;
>  				tx-fifo-resize;
> --=20
> 1.8.2.1
>=20

--=20
balbi

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR3/qCAAoJEIaOsuA1yqREFuAQAJNgNeh+P9Wo6Y7X8xg8o79E
puI4dZfSQptT6/KXOJVt2/FLrfuj8U+1bvDCNrkpgFbTT2xbJapM+bhQjdmdFnA3
nKqcLI6mwW4cVK7vDa1vF0oKsmO8NSJGK77zrFu8PIOXD2yy7NoHu2QWkhdquw7D
5Dzg1zA02pG8wD5zPguk/ChpMEQu+mq/dKnD3H31i45gNCGE66/qiZLwDRFd3xqa
2Djb5sGtgsKuIuNMQ0Dx7lHn17oEipjsWQfP5FudadS+Q5F/an7GQacGkFTU7Evg
GAHpqeGycwFSXkd9PnSUUVDSdSje0naGAdJLuhllMBREUL1rFsk3lcnedZiJ9neT
htIXgAJ//CdqcK5H3605ZFcQlRfn8HWVjv22nN6FB3qmwHpba18ixQuAhGIYk1ut
8cNLYlcsaMrpHo2csf5jqHoO66ENAkWusQnQsN+n6zrgJEccHw9SUksBcDdOjQ0Y
CtHd6ZtY0X3XfLsqWE1XJ8pJ9BftTmKX0xwmzxP8pFQvgoGs4zU02eE8jXMynsBO
QHYbujT17dzNBWCYPNYVG2d8M1XafqXro5e1qVqpCA3IwIFWexj4DdiwasSHM5p7
i5BnmfhHlm4gRsgcyKRZG1MhrMpe8upRCaOPWnp52xjTS8B/bsYeiC/AJez2o5Ti
W0CHSaG/z13JnRbWBlUF
=575P
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
