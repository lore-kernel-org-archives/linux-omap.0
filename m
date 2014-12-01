From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: musb: Fix randconfig build issues for Kconfig
 options
Date: Mon, 1 Dec 2014 13:14:26 -0600
Message-ID: <20141201191425.GH9264@saruman>
References: <20141201191015.GC2817@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jQIvE3yXcK9X9HBh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33742 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753784AbaLATOW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Dec 2014 14:14:22 -0500
Content-Disposition: inline
In-Reply-To: <20141201191015.GC2817@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-usb@vger.kernel.org, Jim Davis <jim.epost@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, linux-omap@vger.kernel.org

--jQIvE3yXcK9X9HBh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 01, 2014 at 11:10:15AM -0800, Tony Lindgren wrote:
> Commit 82c02f58ba3a ("usb: musb: Allow multiple glue layers to be
> built in") enabled selecting multiple glue layers, which in turn
> exposed things more for randconfig builds. If NOP_USB_XCEIV is
> built-in and TUSB6010 is a loadable module, we will get:
>=20
> drivers/built-in.o: In function `tusb_remove':
> tusb6010.c:(.text+0x16a817): undefined reference to `usb_phy_generic_unre=
gister'
> drivers/built-in.o: In function `tusb_probe':
> tusb6010.c:(.text+0x16b24e): undefined reference to `usb_phy_generic_regi=
ster'
> make: *** [vmlinux] Error 1
>=20
> Let's fix this the same way as commit 70c1ff4b3c86 ("usb: musb:
> tusb-dma can't be built-in if tusb is not").
>=20
> And while at it, let's not allow selecting the glue layers except
> on platforms really using them unless COMPILE_TEST is specified:
>=20
> - TUSB6010 is in practise only used on omaps
>=20
> - DSPS is only used on TI platforms
>=20
> - UX500 is only used on STE platforms
>=20
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Reported-by: Jim Davis <jim.epost@gmail.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> ---
>=20
> Felipe, this is against current linux next for v3.19

since this is actually an old bug which just showed up, I'll defer this
to v3.19-rc1.

--=20
balbi

--jQIvE3yXcK9X9HBh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUfL4RAAoJEIaOsuA1yqRESXMP/1iUWrLu0aI/jR8z8M7eKzf8
fe8UP9zBPu2RQ9HGiaJsNAUwFwJkun8/D3X7sMXFMS1omFoer+6H1zgVl8eU5jAY
315ndo+p+rMk0P6DTMxAdkkDOBhN+bdCe22bSUNunaPUvDosXudh/ZO/0lSo+4Pv
w0uSd5ZE01KKlJcBM98g0XtVH7F+v/ENbjdPcFI0qW03dHoC5Ufj7+wu4KhrHmZC
aQr4pj9okPzqgnZ/fIyMAQo5JDPP+F/EDkH25Gy0xO/yiILT9hiymg1XZ1eXWrVg
qNsmQO+AWci3QbQh92MXeSJzBOt10ylpgcXJ2YxyzU2f5c8A/m8/hISPWg6hoQMG
gQqNEoh0JSOYYIRwwZ439jGRVJ0oDaTrGM/TYXxxXB36V2mzbfKWhd0sydkU107F
2Fd5kqykPpyd5FKp/WRygtod+OCYCNGV6TfUa7RN4c2O9RUX7swWxas7P180ksli
YIm1/gMoviHnd6rmHxLS7pSpxcBW3IG+cH/yVBmGbU27fD96abtOCIgA1mQPu9gK
yyXgf5Bhx+vVhiHm1Wy6xP1rmWQJjRe9aEhHNn/fN6SppTeImotYCX7DqUQrioiC
sUdx0DzuFWr2ti5tG2qrpYGzE+ma+jBu0T/49gRglivK3RT4mPHVR7/AIximuw2/
YrsiGtSu4a4r+ckwh2j7
=dUSC
-----END PGP SIGNATURE-----

--jQIvE3yXcK9X9HBh--
