From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] of: Modify c_can binding documentation
Date: Thu, 06 Sep 2012 11:42:29 +0200
Message-ID: <50487005.6090700@pengutronix.de>
References: <1346648074-27025-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigADB9DB2D7D6AFBE89CB2B2A8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44024 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab2IFJmh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Sep 2012 05:42:37 -0400
In-Reply-To: <1346648074-27025-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: AnilKumar Ch <anilkumar@ti.com>
Cc: wg@grandegger.com, swarren@wwwdotorg.org, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, anantgole@ti.com, nsekhar@ti.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigADB9DB2D7D6AFBE89CB2B2A8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/03/2012 06:54 AM, AnilKumar Ch wrote:
> Modify c_can binding documentation according to recent review comments
> on device tree data addition patches.
>=20
> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
> ---
> Changes from v1:
> 	- Separated from "Add DT for AM33XX devices" patch series
> 	- Incorporated Stephen Warren's review comments on v1
> 	  * Removed status and interrupt-parent description from
> 	    c_can.txt file because these are device specific
> 	    parameters.
>=20
>  .../devicetree/bindings/net/can/c_can.txt          |   24 ++++++++++++=
+++-----
>  1 file changed, 18 insertions(+), 6 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/net/can/c_can.txt b/Docu=
mentation/devicetree/bindings/net/can/c_can.txt
> index a43f083..2c420c2 100644
> --- a/Documentation/devicetree/bindings/net/can/c_can.txt
> +++ b/Documentation/devicetree/bindings/net/can/c_can.txt
> @@ -10,7 +10,6 @@ Required properties:
>  			  number
> =20
>  Optional properties:
> -- interrupt-parent	: The parent interrupt controller
>  - ti,hwmods		: Must be "d_can<n>" or "c_can<n>", n being the
>  			  instance number
> =20
> @@ -20,18 +19,31 @@ Future plan is to migrate hwmod data base contents =
into device tree
>  blob so that, all the required data will be used from device tree dts
>  file.
> =20
> -Examples:
> +Example:
> =20
> -	d_can@481D0000 {
> +Step1: SoC common .dtsi file
> +
> +	d_can1: d_can@481d0000 {
>  		compatible =3D "bosch,d_can";
> -		reg =3D <0x481D0000 0x1000>;
> -		interrupts =3D <55 0x4>;
> +		reg =3D <0x481d0000 0x2000>;
> +		interrupts =3D <55>;
>  		interrupt-parent =3D <&intc>;
> +		status =3D "disabled";
>  	};
> =20
>  (or)
> =20
> -	d_can@481D0000 {
> +	d_can1: d_can@481d0000 {
>  		compatible =3D "bosch,d_can";
>  		ti,hwmods =3D "d_can1";
> +		reg =3D <0x481d0000 0x2000>;
> +		interrupts =3D <55>;
> +		interrupt-parent =3D <&intc>;
> +		status =3D "disabled";
> +	};
> +
> +Step 2: board specific .dts file
> +
> +	&dcan1 {
        ^^^^^^

Is there an alias for dcan1 =3D=3D d_can1 or is this a typo?

Marc

> +		status =3D "okay";
>  	};
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigADB9DB2D7D6AFBE89CB2B2A8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBIcAUACgkQjTAFq1RaXHPnfwCfa9hfPBSP8G0e0ZTlvgTDP/2w
xUYAoIV9M3kp+k5FQkGfyloo7V+oMMP3
=p5gR
-----END PGP SIGNATURE-----

--------------enigADB9DB2D7D6AFBE89CB2B2A8--
