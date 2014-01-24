From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv3 30/41] ARM: omap3-n900.dts: add display information
Date: Fri, 24 Jan 2014 13:46:15 +0200
Message-ID: <52E25287.9070201@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com> <1390301833-24944-31-git-send-email-tomi.valkeinen@ti.com> <20140121152605.GA5983@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="gAJL65kDhGdddwPDSCcpIcWBCR5AvWcUr"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49253 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752112AbaAXLrA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Jan 2014 06:47:00 -0500
In-Reply-To: <20140121152605.GA5983@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Tony Lindgren <tony@atomide.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>

--gAJL65kDhGdddwPDSCcpIcWBCR5AvWcUr
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2014-01-21 17:26, Sebastian Reichel wrote:
> On Tue, Jan 21, 2014 at 12:57:02PM +0200, Tomi Valkeinen wrote:
>> Add DT data for OMAP3 N900 board. The board has the following
>> displays:
>>
>> lcd: LCD panel connected to OMAP's SDI output
>> tv: analog svideo
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
>=20
> Your dss-dt-review-3 branch boots on my N900 with working display.
>=20
> Tested-by: Sebastian Reichel <sre@debian.org>

Ok, thanks!

 Tomi



--gAJL65kDhGdddwPDSCcpIcWBCR5AvWcUr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS4lKHAAoJEPo9qoy8lh71S98P/jFlnLDfwch1bSGpEroUk98Q
3LD3accp0ziNan4VW4O6C0nSq0at48Cr/XGCXJhYRzQHPFgZGUp2QiBhZC+4lsX2
j73NGdVoclaS+GaZM+SSM3pjDFa0XJKzDIsS4YajxHaX1RRdn7QwyUJ4rrHupirH
T/URJCjuBSF8wwSdBlDdpiQ/7qg04KIJmL6LgoxrFXoyQ1zRT/jbfDW9WQGp98XX
CjOHbYde7WyVqHvF+SumIXCIpUqW3t4/4Bpb/hPG7qBKvR99piJ0cO9sqOHS+XVI
vuuC4AX4EunxfpqeGEqNW8HdlL+O6WRMWYGjwuDDfDPM/5w7DV7fixOJ69SNWoR5
ULx6Ues3UPLhNYUYBTDH4rGrZFxRxMhHHCcrAz+dUfis11x0IZwJbBomYQPu0+Kd
oTsuDtmwEZ1IY1X7yn0WfuUboEN2HQnURhteodocuL9Rg5G2ObwKbdphnOOkHTMq
BLNwbn4xdlld4c/jQBKvx+Lv/vsi66hFU9GZQXQoIWudKjPVKT/yRphFnKiEub11
OzFVFCqWxrW9PKJZdE34zdqgGsxhrSyV/I9zPtgrNCYBO4voTJ2QIjPlgNAHUoem
clYtW+Mv1CJqGZ4ksDwTWA8QI/fyAtc7FUEw2IgnquCuLXXNU7R2GW4iRH5THAJQ
g+kl4mTUmyMbd8CpjrKs
=fJZZ
-----END PGP SIGNATURE-----

--gAJL65kDhGdddwPDSCcpIcWBCR5AvWcUr--
