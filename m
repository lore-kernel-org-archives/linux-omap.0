From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Wed, 7 May 2014 11:12:23 +0300
Message-ID: <5369EAE7.3030705@ti.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com> <1398815562-24113-4-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="njBMUIJkiSwSwLILJCHsCciWP7Kw9FQ7A"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37370 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841AbaEGIMu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 May 2014 04:12:50 -0400
In-Reply-To: <1398815562-24113-4-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

--njBMUIJkiSwSwLILJCHsCciWP7Kw9FQ7A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/04/14 02:52, Tony Lindgren wrote:
> We can pass the GPIO configuration for ls037v7dw01 in a standard
> gpios property.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../bindings/panel/sharp,ls037v7dw01.txt           | 53 ++++++++++++++=

>  .../omap2/displays-new/panel-sharp-ls037v7dw01.c   | 84 ++++++++++++++=
++++++--
>  2 files changed, 133 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/panel/sharp,ls037=
v7dw01.txt
>=20
> diff --git a/Documentation/devicetree/bindings/panel/sharp,ls037v7dw01.=
txt b/Documentation/devicetree/bindings/panel/sharp,ls037v7dw01.txt
> new file mode 100644
> index 0000000..7f6f5e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/panel/sharp,ls037v7dw01.txt
> @@ -0,0 +1,53 @@
> +SHARP LS037V7DW01 TFT-LCD panel
> +
> +Required properties:
> +- compatible: should be "sharp,ls037v7dw01"
> +
> +Optional properties:
> +- reset-gpios: a GPIO spec for the optional reset pin
> +- enable-gpios: a GPIO array for the optional configuration GPIOs
> +  ordered MO, LR, UD, INI as specified in the LS037V7DW01.pdf file.
> +
> +This binding is compatible with the simple-panel binding, which is spe=
cified
> +in simple-panel.txt in this directory.
> +
> +This panel can have zero to five GPIOs to configure
> +to change configuration between QVGA and VGA mode
> +and the scan direction. As these pins can be also
> +configured with external pulls, all the GPIOs are
> +considered optional with holes in the array.
> +
> +Example when connected to a omap2+ based device:
> +
> +	lcd0: display {
> +		compatible =3D "sharp,ls037v7dw01";
> +		power-supply =3D <&lcd_3v3>;
> +		reset-gpios =3D <&gpio5 27 GPIO_ACTIVE_HIGH>;	/* gpio155, lcd RESB *=
/
> +		enable-gpios =3D <&gpio5 26 GPIO_ACTIVE_HIGH	/* gpio154, lcd MO */
> +				&gpio1 2 GPIO_ACTIVE_HIGH	/* gpio2, lcd LR */
> +				&gpio1 3 GPIO_ACTIVE_HIGH	/* gpio3, lcd UD */
> +				&gpio5 24 GPIO_ACTIVE_HIGH>;	/* gpio152, lcd INI */

Why are most of the gpios in 'enable-gpios'? MO, LR and UD don't really
have anything to do with enabling the panel. Why not just have one
'gpios' array with all the gpios, as they are quite a mixed bunch?

 Tomi



--njBMUIJkiSwSwLILJCHsCciWP7Kw9FQ7A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTaernAAoJEPo9qoy8lh71hS8P/AnVbcpWVabEakHTYDcT9cze
OcorYIGkP4O6c4klKlgGRCw2oFJNT1s8Y9obaeuNC1uDAasU24YHS3W5Ulz5h4h9
agAQaWWaBQO06fY/AviYK66WhOGfkPFbI7B02Muep2cclnhT0E9Q3bYnWkSyMUHC
wzkmkhC555M1DNTyjius9JPRXT7/Y0wskMH1v5dIb8SHtbGfDuHZ5vmSSxCz60ts
cwIwog5ShkIIVrBsYBcBkQfbBTE4ESwRvPaitt0GpQJtKtqAwTLQfJW9aGIn0eS4
mXZtnDbBQpKXd4ItKZ6NhvqlSskUPH2/HkfwYLkEPITi4Z/2JUVlWUdS8iAfiXcN
Qid7zZGAEMzCgvYCudFtWuVqr+KX3Z5wAmXcUeyoym9Kx9nsKO5Ip05Jp2lKdeWm
GI3o1rfNJmJim5BuKt9FXE5IqHoqjTwYVN50+B6t8t6e1C8C1NbDc+itiKRer9Lq
mIF3lAVu7U7n9IkPHOwmKluIJ/5cFe3Pt9U2ar73D8JjRhiE2na5yiFe3Qq77kkh
hLeszbIIiJux1zmJh5MBq1pMH5ixPEctmjKb4FD/dbZvxH2vyJjk1matxo9bODxo
uzQBCnKuEyvDX1JdjydBRI9lo4wh/gyB4Z7+RCa3BrhzC5tF9asTlWTp05xhsJj1
oYQnWhLL+7icVPAgxCcd
=/Mat
-----END PGP SIGNATURE-----

--njBMUIJkiSwSwLILJCHsCciWP7Kw9FQ7A--
