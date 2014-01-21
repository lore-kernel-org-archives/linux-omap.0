From: Sebastian Reichel <sre@debian.org>
Subject: Re: [PATCHv3 30/41] ARM: omap3-n900.dts: add display information
Date: Tue, 21 Jan 2014 16:26:05 +0100
Message-ID: <20140121152605.GA5983@earth.universe>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com>
 <1390301833-24944-31-git-send-email-tomi.valkeinen@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:44246 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754053AbaAUP0N (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Jan 2014 10:26:13 -0500
Content-Disposition: inline
In-Reply-To: <1390301833-24944-31-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2014 at 12:57:02PM +0200, Tomi Valkeinen wrote:
> Add DT data for OMAP3 N900 board. The board has the following
> displays:
>=20
> lcd: LCD panel connected to OMAP's SDI output
> tv: analog svideo
>=20
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

Your dss-dt-review-3 branch boots on my N900 with working display.

Tested-by: Sebastian Reichel <sre@debian.org>

-- Sebastian

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCAAGBQJS3pGNAAoJENju1/PIO/qaJBYQAIZazWfkbZRnlRcxPTrilj6l
RyeqBYVX7psnzjsisBimGxeTc0K0s8EyzrQxzaAh2d4KlkrXHwJSAn8MxZF/4FLW
7ZPmz4T3tbZbbw5/n9BtcfIbtPtpzw+OHJMKyL4b1i0yIDVPIy6kuOHg+6bvHLV+
yYwcD4jr63IRASZ+ItFn6lp9AwOo7b2Z8hi6mP9HfGA7kcb7VY6hN+adDAJyOzWX
1T+4yCNJhWXaaBXgKytuYIdavLNFYsW/EfbUl8K4GbyEMwpLJU60IpSbMJqxtKXP
5SO/Qzc+8DVMVFNCHvMy3x6UCRqCXeKkWQ9/WeoskdlvJGQL7ShUgusx5cUt07a9
sUVfwkO7Y2QUxsTEMp6NLPOsYmFr6/p0/XMOThw6sCktJUGJ15MDM7Xglkl+sA0N
sx5+8BS1q+EKz7dMM5Bu7ky7ZUtj1YpUAFFv6SM9zMEC+HOadjLo4dkm05+caD6s
Y0i/SNd29iXB4zuC3+ko++8NVlX9g/QI+RRd1eq5miUWSrPtzU2fv+1QnI0YVEym
3A4wYFUHis5ibh2rkDQMdedShI0VkCgoASNYUUQp5pYhfzqI5JFKzHJdv6Mb9C/n
VRh7uaXaV7E/yxlUfJXJ8LNFFlltpzbcMmc+jdHaSO6SS7aT9RLAPHDBPez9VYG8
IJ7tP/46g3By4kbLnfDu
=n51O
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
