From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v3 0/2] arm: dts: add support for am437x sk
Date: Mon, 30 Jun 2014 11:45:43 -0500
Message-ID: <20140630164543.GA31442@saruman.home>
References: <1403547659-24558-1-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38757 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbaF3Qqa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Jun 2014 12:46:30 -0400
Content-Disposition: inline
In-Reply-To: <1403547659-24558-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, robh+dt@kernel.org, galak@codeaurora.org, Tony Lindgren <tony@atomide.com>, linux@arm.linux.org.uk, Rajendra Nayak <rnayak@ti.com>, Nishanth Menon <nm@ti.com>, r.sricharan@ti.com, devicetree@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Andrew Morton <akpm@linux-foundation.org>

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 23, 2014 at 01:20:57PM -0500, Felipe Balbi wrote:
> Hi,
>=20
> here's v3 of am437x sk support. Patches tested on top of next-20140617.
>=20
> Note that this series was tested with the following extra patches:
>=20
> http://marc.info/?l=3Dlinux-omap&m=3D140299431732700&w=3D2
> http://marc.info/?l=3Dlinux-omap&m=3D140300146503126&w=3D2
> http://marc.info/?l=3Dlinux-omap&m=3D140299231232123
> http://marc.info/?l=3Dlinux-omap&m=3D140310472709968&w=3D2
> http://marc.info/?l=3Dlinux-omap&m=3D140310471409959&w=3D2
>=20
> A branch is also available with all these patches at [1].
>=20
> [1] http://git.kernel.org/cgit/linux/kernel/git/balbi/usb.git/log/?h=3Dam=
437x-starterkit
>=20
> Felipe Balbi (2):
>   arm: dts: am4372: let boards access all nodes through phandles
>   arm: dts: add support for AM437x StarterKit

ping on this series, it has been tested by several folks and still no
updates from anybody in the DT land.

--=20
balbi

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTsZQ3AAoJEIaOsuA1yqRE3oQQAIJLCr/mtQmrjDhoYuRmzOJJ
ndO3BscqveeEP2MGxNtsI6M+hSn90TlaM99pa8tS64XsxGdI/i3h/kPdSK7sN8K+
nwKX727p/cgUwk9p+5z8kbM5WirzesepC5D/Zlg8KjnLAmxVpVKnvs9hkdUlFH/E
oGTaDySIiX3iZixl4TfdVdXO4RUXbdTpW0waGRPPZrd/Z0xaYcQxW5U72/X1m9wO
RZlou39FqBNFPQ7KNt52BfkasQkYVLh6LP0SL5rg0zPmXHHxa1amiygmYQDHV/Le
TB+bjUJ1eFppsUfLYwQg3JFUOOFaB1KMuNrfcxbotG2XSwwQLLPsAUC0pPybot5V
i7Ru7PXHs3KkPi+WmwAfhjiTpO4i3CSQoHCCfxdqtBKWBEUAX/UpFerhdcVdnsX/
2uKzLYn4ImNi3KQfNI5lM/672E/B3PRcCzehbYR0BwEwltkqBagSPfTcFUT+SP/3
xVTBs4Tar3Q+N1ZPZ0pZk2sLC61u5W5WhXRtdGi9k6fIOwR5ZogHd8McoDOnSUXq
wXKgXvg2nq15WwBcTC5B2byuWwIsFjeE3hHTYV3066dTKXLJtf6j2KMO1XpDLGmg
5ovL9nhg3z5FoLmlLCEaKwoM5Pw5Au4vDlO48V+uFp1WenpNz9CNpEu81OBNLRz5
smAnqXY7GFYS8SamOhCN
=Kkmj
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
