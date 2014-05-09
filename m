From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 4/4] ARM: dts: Add LCD panel sharp ls037v7dw01 support
 for omap3-evm and ldp
Date: Fri, 9 May 2014 10:07:19 +0300
Message-ID: <536C7EA7.5000306@ti.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com> <1398815562-24113-5-git-send-email-tony@atomide.com> <CAGhQ9Vwa8xXQEo5dNEKAvmaS9DoBjVSthtd8=owk+atVdFuiiA@mail.gmail.com> <20140430174751.GA12362@atomide.com> <20140505183919.GA15463@atomide.com> <20140508233628.GJ2198@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="W7QJps4rPfqSmWpFEG2BLPMIvKe1ruU0T"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43855 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751918AbaEIHHp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 03:07:45 -0400
In-Reply-To: <20140508233628.GJ2198@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Joachim Eastwood <manabian@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org

--W7QJps4rPfqSmWpFEG2BLPMIvKe1ruU0T
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/05/14 02:36, Tony Lindgren wrote:

> --- /dev/null
> +++ b/arch/arm/boot/dts/omap-panel-sharp-ls037v7dw01.dtsi
> @@ -0,0 +1,82 @@
> +/*
> + * Common file for omap dpi panels with QVGA and reset pins
> + *
> + * Note that the board specifc DTS file needs to specify
> + * at minimum the GPIO enable-gpios for display, and
> + * gpios for gpio-backlight.
> + */

This looks very board specific to me... The regulator and the use of
mcspi1 depend on the board, so this file can't be used on just any omap
board with the same panel. And this can (probably) only be used on
boards with a single display. Do those boards have tv-out?

So I have nothing against having common files, but shouldn't this be
named something more specific? If the boards involved are TI's OMAP3
development boards, maybe this should be something like...
omap3-ti-dev-panel-sharp-ls037v7dw01.dtsi. Well, that's a quite long one.=


> +/ {
> +	aliases {
> +		display0 =3D &lcd0;
> +	};
> +
> +	backlight0: backlight {
> +		compatible =3D "gpio-backlight";
> +	};
> +
> +	/* 3.3V GPIO controlled regulator for LCD_ENVDD */
> +	lcd_3v3: regulator-lcd-3v3 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "lcd_3v3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		startup-delay-us =3D <70000>;
> +		regulator-always-on;

Why always-on?

 Tomi



--W7QJps4rPfqSmWpFEG2BLPMIvKe1ruU0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTbH6nAAoJEPo9qoy8lh71VFEP/iRI8XHZKl275j04dABeqyvZ
CQnPa2OSOBfkVDBgkfRGWES+ifiUQWk6yq+q/RVbXEFlO7wr7VJGXzFMrON0FpY6
gU0QMn/fJitlJYMB6fj+pHy7eeDIzTS0kpit476FUkTzhq9ul0MPPoPRFzI80Lxz
ZXNosfIPsTfAfJ5yOFDMwHihLs0J+eV9cslqe7sqczPtNdT7kyRbKrmHSwYV4PVC
LJzwQzEhXnNfKv8EV65rKO3w7Nlt7awK1X8RdmEUBSxgMH2MuCDD3nm9RiI3ejLq
nuoaLjYhIBE4qSnXGkwnS8w36H7zGgQmQlVoVI2UIC55pj7sxjaj9fyvZ+wjOZFm
PhhjQwguDTDzdp+GV21M4K7sZfFgT2Y6VqxgiKca5G0tLu0SNyCQy2+S+GWZzAcY
DP5P34YIyy9bAWuzcsxlbv16jJkAkwnMLaKyzzjzS0e0tUQG7yzZgX4LCk2fkiCz
Tm6ENbNghVODruj43d6U04ybI22HMfgJinBvnBDro5eKyYgs4SWFJexRUJRJqam9
7F5VTguxTqli5Yv8oX+imMmuPAg7FaeBYMMXqMjQTkt9sEFv7CWnnFLw/owP+GL2
4xC1zVBhokrjcR62YPr4XCxt71H2SQiVR0QFqILYfqtjZclhvEV9wNBy/wGdQ9RR
c6TyvyH1Ya7DBLUKuXmd
=sZB/
-----END PGP SIGNATURE-----

--W7QJps4rPfqSmWpFEG2BLPMIvKe1ruU0T--
