From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 01/13] usb: phy: nop: Add device tree support and binding
 information
Date: Fri, 08 Mar 2013 11:46:12 +0100
Message-ID: <5139C174.7030401@pengutronix.de>
References: <1359993540-20780-1-git-send-email-rogerq@ti.com> <1359993540-20780-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2GLGOPPTHXRVNPTOIUVOG"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36932 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172Ab3CHKqm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Mar 2013 05:46:42 -0500
In-Reply-To: <1359993540-20780-2-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, b-cousson@ti.com, balbi@ti.com, stern@rowland.harvard.edu, linux@arm.linux.org.uk, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, paul@pwsan.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2GLGOPPTHXRVNPTOIUVOG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/04/2013 04:58 PM, Roger Quadros wrote:
> The PHY clock, clock rate, VCC regulator and RESET regulator
> can now be provided via device tree.
>=20
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  .../devicetree/bindings/usb/usb-nop-xceiv.txt      |   34 ++++++++++++=
++++++++
>  drivers/usb/otg/nop-usb-xceiv.c                    |   31 ++++++++++++=
++++++
>  2 files changed, 65 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/usb-nop-xceiv=
=2Etxt
>=20
> diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt b/=
Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> new file mode 100644
> index 0000000..d7e2726
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> @@ -0,0 +1,34 @@
> +USB NOP PHY
> +
> +Required properties:
> +- compatible: should be usb-nop-xceiv
> +
> +Optional properties:
> +- clocks: phandle to the PHY clock. Use as per Documentation/devicetre=
e
> +  /bindings/clock/clock-bindings.txt
> +  This property is required if clock-frequency is specified.
> +
> +- clock-names: Should be "main_clk"
> +
> +- clock-frequency: the clock frequency (in Hz) that the PHY clock must=

> +  be configured to.
> +
> +- vcc-supply: phandle to the regulator that provides RESET to the PHY.=

> +
> +- reset-supply: phandle to the regulator that provides power to the PH=
Y.
> +
> +Example:
> +
> +	hsusb1_phy {
> +		compatible =3D "usb-nop-xceiv";
> +		clock-frequency =3D <19200000>;

Why do you hardcode the clock frequency here? You should use
clk_get_rate() to get the frequency from the clock tree.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2GLGOPPTHXRVNPTOIUVOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlE5wXgACgkQjTAFq1RaXHMTfQCdGkkuce/Ad3ixqfYK5A0746Cw
krEAnjARGcTjqIvk8A5c337Z1gGZVPLG
=wvTc
-----END PGP SIGNATURE-----

------enig2GLGOPPTHXRVNPTOIUVOG--
