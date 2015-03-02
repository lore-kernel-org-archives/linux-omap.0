From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH RFC 6/6] ARM: dts: am335x-boneblack: Use new binding for
 HDMI
Date: Mon, 2 Mar 2015 14:28:40 +0200
Message-ID: <54F45778.6050406@ti.com>
References: <cover.1424961754.git.jsarha@ti.com> <6d6653416fd87c678a80df1d422420877261c4a5.1424961754.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="0qWfa5kxeXnk54xaclR0Nar0scnPTXHh0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49566 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751864AbbCBM3C (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 2 Mar 2015 07:29:02 -0500
In-Reply-To: <6d6653416fd87c678a80df1d422420877261c4a5.1424961754.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, detheridge@ti.com, moinejf@free.fr, linux@arm.linux.org.uk

--0qWfa5kxeXnk54xaclR0Nar0scnPTXHh0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 26/02/15 16:55, Jyri Sarha wrote:
> Use new binding for the external tda19988 HDMI encoder.
>=20
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>  arch/arm/boot/dts/am335x-boneblack.dts | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts=
/am335x-boneblack.dts
> index 5c42d25..eadbba3 100644
> --- a/arch/arm/boot/dts/am335x-boneblack.dts
> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
> @@ -68,16 +68,26 @@
> =20
>  &lcdc {
>  	status =3D "okay";
> +	port {
> +		lcdc_0: endpoint@0 {
> +			remote-endpoint =3D <&hdmi_0>;
> +		};
> +	};
>  };
> =20
> -/ {
> -	hdmi {
> -		compatible =3D "ti,tilcdc,slave";
> -		i2c =3D <&i2c0>;
> +&i2c0 {
> +	tda19988 {
> +		compatible =3D "nxp,tda998x";
> +		reg =3D <0x70>;
>  		pinctrl-names =3D "default", "off";
>  		pinctrl-0 =3D <&nxp_hdmi_bonelt_pins>;
>  		pinctrl-1 =3D <&nxp_hdmi_bonelt_off_pins>;
> -		status =3D "okay";
> +
> +		port {
> +			hdmi_0: endpoint@0 {
> +				remote-endpoint =3D <&lcdc_0>;
> +			};
> +		};
>  	};
>  };

This is missing the output of tda998x. It should have two ports, input
and output, output going to hdmi-connector.

 Tomi



--0qWfa5kxeXnk54xaclR0Nar0scnPTXHh0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU9Fd4AAoJEPo9qoy8lh71/HgQAJO/M5J/UOm47rX7CMTx6OkX
AoFo/cJtMXCxi2Sx1VDTTrW5zSeIp54B8zmvgVuRdPY/hG/wIU/1MNtIBPqTVTHq
t8NIR2mtS3ClXtl9lg4xtAMKpIYthr76mnuzXUldHAxXfapb6BbHaYj8eflO+y6K
4BkPvdTTBt+sipulmZ8vpIko1IKgdmM7zOaWGUUGHZzdVdgczSX7OgrEPLAKkoCH
2pkAaDWNXU1NVK8pVMR1HiB2EpzB0mK59L2q06DoalJf18213rOSDlqmBxMmhnF/
DVVnPfxaapl91I05h9cJ/jloYXUff24H+kAA7Vf7YCOThd9BiIS2ZHRF25M5EW6c
+CkVryEh660ce3xS84ePHtqz9pUN6he8LQf8VEzHB6VKouw7L2T8kohCa1iXvmyn
IJ/5aF/bfmAIoszv3iYPLCD6wLG/59mAVxQn2BX2Q8oWpT+pocj9NBOXYUoC8Rcy
KfibYEmW/tb2JTBpucibyj8Aub3NAGOEy5vU021Oe7nZIo0lbkv1Q3cVSInMf4J8
AmKLtbe4Bu6KK3Zby4xdW67DQBsOLcSZ1Zj+8fulj5qWHmxUBDK05zLnMk8G3rbL
jSFTL71ishcTcbk7g2cGXYKAzOuQ5GUJLbasP3Z2JcGalOVpbv+9dTEdaGG0BXrp
64AE6q6OFCZ2+SXJddpJ
=UTR6
-----END PGP SIGNATURE-----

--0qWfa5kxeXnk54xaclR0Nar0scnPTXHh0--
