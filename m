From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 1/3] ARM: dts: overo: Add support for DVI output
Date: Wed, 12 Mar 2014 09:11:16 +0200
Message-ID: <53200894.5020602@ti.com>
References: <1394541257-25605-1-git-send-email-florian.vaussard@epfl.ch> <1394541257-25605-2-git-send-email-florian.vaussard@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="3CIeT7QnUUEEgdgR6VcIpIFbd91mO3lVk"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44471 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756427AbaCLHMG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Mar 2014 03:12:06 -0400
In-Reply-To: <1394541257-25605-2-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Vaussard <florian.vaussard@epfl.ch>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: Ash Charles <ash@gumstix.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--3CIeT7QnUUEEgdgR6VcIpIFbd91mO3lVk
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/03/14 14:34, Florian Vaussard wrote:
> Summit and Tobi expansion boards have a HDMI connector with a TFP410
> encoder. Add a common include file for this configuration, and then
> use it for Summit and Tobi.
>=20
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> ---
>  arch/arm/boot/dts/omap3-overo-common-dvi.dtsi    | 109 +++++++++++++++=
++++++++
>  arch/arm/boot/dts/omap3-overo-summit-common.dtsi |   1 +
>  arch/arm/boot/dts/omap3-overo-tobi-common.dtsi   |   1 +
>  3 files changed, 111 insertions(+)
>  create mode 100644 arch/arm/boot/dts/omap3-overo-common-dvi.dtsi

<snip>

> +&dss {
> +	status =3D "ok";
> +
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&dss_dpi_pins
> +		     &i2c3_pins>;

The i2c3 pins don't belong here, they are not related to dss. The
dvi-connector uses i2c3, but I don't think they belong there either, as
the i2c3 bus can be used by multiple devices. So I guess they should be
set in &i2c3 node.

 Tomi



--3CIeT7QnUUEEgdgR6VcIpIFbd91mO3lVk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTIAiXAAoJEPo9qoy8lh71JFgP/3y2bhnnN+6T6lsPhHEswv5l
oKNTh/PUPnNUrWAMOMe36qmHxOAoowgtUDBlkVahdekAdujPinDY05iL7UQk8kEm
nN65bX9Wk3raLk0ih2dyLYcryS6PuMi07L+jpncOP2wD+6KMHq54PACbb/CNKLKK
+WQtHnRPl5pLe2Mj+XgTWB+gHtFXS/+S9IMKYNvVV94FI168idhze2e6sVcF+Kgb
iLUb8lgs8RHxZWwYALKG99JFHoswMpGAYbzEWzFXlSgT36R4fdTrIelPecbEtGOa
ypQgo3mn8k4tFBK1nn1e21lwKDtI2YZTjTFG+SB4T3MduTCtcadNu9py9V6KiYRp
A9J52TJVYZw9hGPP644fJFStgrpDOuhL5QA6peGHOTe1eaaKSlwlKl+wYTSor0lW
XdGzNsXgwdaj7GY5Lo1BrOnY48TNWNLiayAVZRiRsOOiEdvKqARu/la2Qsf0Jj4K
d+2+d3L2CLnYyaTnJC1MtWPdGcO/5NqZCvQxbH181EQXOb4bxshbDiPWSOacpRqS
cV0XM0ZXrlQpYDrpou97VIDYic+DKgCu9la1V38//a588demxqeVQ64LKfgA8hVK
1FyrNmMwFC2o+AuYqITPHYh4v17Y5UuVkkrbVgHqVaW5XrPPHlJ6EINAGL9/yeQW
35m3zGn6oPqmuP81tDt8
=JITv
-----END PGP SIGNATURE-----

--3CIeT7QnUUEEgdgR6VcIpIFbd91mO3lVk--
