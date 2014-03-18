From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] ARM: DTS: AM43x: Add sii9022 dt information
Date: Tue, 18 Mar 2014 12:31:30 +0200
Message-ID: <53282082.1000208@ti.com>
References: <1395137278-5065-1-git-send-email-sathyap@ti.com> <1395137278-5065-3-git-send-email-sathyap@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="IJLiqjmghuFji9GuB2hTMXsgoV8npPna8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58006 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754580AbaCRKbl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Mar 2014 06:31:41 -0400
In-Reply-To: <1395137278-5065-3-git-send-email-sathyap@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sathya Prakash M R <sathyap@ti.com>
Cc: tony@atomide.com, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, pawel.moll@arm.com, paul@pwsan.com

--IJLiqjmghuFji9GuB2hTMXsgoV8npPna8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 18/03/14 12:07, Sathya Prakash M R wrote:
> AM43x-epos and AM437x-gp device use external sii9022
> DPI to HDMI encoder.
> Sii9022 use i2c for communication.
> Sii9022 dt entries are added to corresponding dts.
>=20
> Signed-off-by: Sathya prakash M R <sathyap@ti.com>
> ---
>  arch/arm/boot/dts/am437x-gp-evm.dts  |   58 ++++++++++++++++++++++++++=
+++++--
>  arch/arm/boot/dts/am43x-epos-evm.dts |   59 ++++++++++++++++++++++++++=
++++++--
>  2 files changed, 111 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am=
437x-gp-evm.dts
> index a178e8d..c4225b1 100644
> --- a/arch/arm/boot/dts/am437x-gp-evm.dts
> +++ b/arch/arm/boot/dts/am437x-gp-evm.dts
> @@ -51,6 +51,41 @@
>  			remote-endpoint =3D <&dpi_out>;
>  		};
>  	};
> +
> +	sii9022: encoder@0 {
> +		compatible =3D "sii,sii9022";

See Documentation/devicetree/bindings/vendor-prefixes.txt

The vendor prefix is "sil".

> +		reset-gpio =3D <&gpio5 8 GPIO_ACTIVE_LOW>;/* 'SelLCDorHDMI' Gpio, LO=
W to select HDMI */
> +
> +		ports {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			port@0 {
> +				reg =3D <0>;
> +
> +				sii9022_in: endpoint@0 {
> +					remote-endpoint =3D <&dpi_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg =3D <1>;
> +
> +				sii9022_out: endpoint@0 {
> +					remote-endpoint =3D <&hdmi_connector_in>;
> +				};
> +			};
> +		};
> +	};
> +
> +	hdmi0: connector@0 {
> +		compatible =3D "hdmi-connector";
> +		label =3D "hdmi";
> +
> +		hdmi_connector_in: endpoint {
> +			remote-endpoint =3D <&sil9022_out>;
> +		};
> +	};
>  };
> =20
>  &am43xx_pinmux {
> @@ -119,6 +154,9 @@
>          status =3D "okay";
>          pinctrl-names =3D "default";
>          pinctrl-0 =3D <&i2c1_pins>;
> +	&sii9022 {
> +		reg =3D <0x3b>;
> +	}

This looks very very odd... The whole sii9022 node should be here.

>  };
> =20
>  &epwmss0 {
> @@ -141,8 +179,22 @@
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&dss_pinctrl>;
> =20
> -	dpi_out: endpoint@0 {
> -		remote-endpoint =3D <&lcd_in>;
> -		data-lines =3D <24>;
> +	ports {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		port@0 {
> +			reg =3D <0>;
> +			dpi_out: endpoint@0 {
> +				remote-endpoint =3D <&lcd_in>;
> +				data-lines =3D <24>;
> +			};
> +
> +			dpi_out:endpoint@1 {
> +				remote-endpoint =3D <&sii9022_in>;
> +				data-lines =3D <24>;
> +
> +			};

You add the same label, "dpi_out" to both endpoints. Does this even compi=
le?

As there's just one port, you can leave out the 'ports' node.

 Tomi



--IJLiqjmghuFji9GuB2hTMXsgoV8npPna8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTKCCCAAoJEPo9qoy8lh713PQQALFlOYEHv2+kMt1ZaRxMuGMB
EMhWTIdRxhgYqL0XStFzy7nwxU6cvHvMC8dKzn6wGFrBxMo3PbYG/TD5dNySjVgE
v2xOAfC9h2+/KxdOhThbmMs+6BnSY9PuCfMe94h95PVDC+l0k0c3FZ8u5uAw6ZHw
Da+w3T/jGvGt43g5dAz8UNI7bP3uZZhn1Z7R2+tPOhdlMMgo76TYYpBRy03+F1aa
dssikp65A9YGMdAjvkrW4Z8xy6fXw6r4ut+BYuC13JAPSGtchGuPuQ0X2DA5vyeY
QdayfNB4aNjAKkTkQI/mOBKejPYTjIljoS0Pt0SMg9EKERFuepFGUdkZ+2x2v4Tr
be35c/gy5ujINBHHhyYL9pNvEAz1FgdgBqCprvw45iy+PPXgMx8wQ7SHqHgoT9tP
Fs2H9cATTo0bbSStWpZQ3u4LDu9msyU99ZKkXivHDBYd4ioqi6TUm23OlEI8yLcm
a3AVi4i3l7JT9qVqCp5qqgISNPkQSaAF9AbYDU5kpykRuqWH6z/6tjexZQ2tkjxb
2s2buXx810h/wfYzWdWYlnGj+o/BR8Gbs0+u/JHUxX7ubIT9KJu+sKXejxgkxeLW
LN0sWquY85D2Is1WYQCZwh7y14gD2xh4WhksVU9REEICPLBh1jRIPc4gJJ7CEelm
Vrizfr821BN4bdABFp69
=nvFA
-----END PGP SIGNATURE-----

--IJLiqjmghuFji9GuB2hTMXsgoV8npPna8--
