From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv3 19/41] OMAPDSS: panel-dpi: Add DT support
Date: Thu, 24 Apr 2014 16:12:20 +0300
Message-ID: <53590DB4.8080609@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com> <20140418155107.GB5354@atomide.com> <5358DEEA.1000506@ti.com> <3615191.vG5AEQORWJ@avalon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="B41gHLVnFt5HW1He2stQbS0J2dNgub1sQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39342 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754589AbaDXNNM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Apr 2014 09:13:12 -0400
In-Reply-To: <3615191.vG5AEQORWJ@avalon>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tony Lindgren <tony@atomide.com>, Joachim Eastwood <manabian@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>

--B41gHLVnFt5HW1He2stQbS0J2dNgub1sQ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 24/04/14 15:44, Laurent Pinchart wrote:

>> I attached prototype patches (based on -rc2) for panel dpi using that
>> approach. It's a bit messier than I'd like, because for non-DT boot we=

>> need to request the gpio using the old API, and then convert it to
>> gpio_desc. We can remove that code when all the boards use DT.
>=20
> Just FYI, you can use the gpiod API with non-DT platforms if you regist=
er GPIO=20
> lookup entries in board code with gpiod_add_lookup_table().

Right, but as the board files are going away, I'd rather not touch them
at all if possible.

 Tomi



--B41gHLVnFt5HW1He2stQbS0J2dNgub1sQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTWQ20AAoJEPo9qoy8lh71wosQAINxGV+dEYXuJftJ31C22NFB
GWSurt3Ni7qJwxvj7wArkNQiUbTGgRRXuw4Q7hRtt3zPzLdsEl9MUHNu92y/js32
RiF/yGTmnv9C9LkwSgs/Vjz8tAHvbv2v5yY3E2rthWptvVneUiosuqEWkRdGHaQL
gCKfGw4g86euUlisWn+QPCqatSceBxe/EDBwM3NKynUVOhfpsJunF5+JZu5+9oYU
dUuIEswnY+jaDaWGVRZujgRcdfBzKW/BAnRcZ6SRs983g7rG8cgpGEAI4hDuWQ6p
seBXSIkfsTMuc3v/BaWjudQWfE3eo3RCfmWuVnuoB9EuEpkqZ5Y1ajmQ9zFXCiOx
N3IFwn8CAsPDX2iYKRcmCDPfyuPUkMVm9ZrDV6iglvrbw80BCN11zsTAsrGgU3yr
WjPyzASxR6Vopb40VyLLsouzfcXHHwWjmwhcDQFa3PCvj370PQdHjaTk+PWOUMvg
dluEDzrvH/kGaYwLxcK6qHCV2zozFFL0Q1pfembY7em7Rq/Z6eQtC0OwVbbpVoO7
NtMaiRtkojdip89Jaa6/pDDHtitVuwBK6CrW9cY3YpqwHKZS4uLtWe7SjEsSLRF+
hg835NHtAuujff7eQhYfCHANg44ieAfcjtVWo92XL/bqvWzSZzekUpdY+Tu8ndfg
SXZF344mZoTzVQ6Z6T77
=B5Bu
-----END PGP SIGNATURE-----

--B41gHLVnFt5HW1He2stQbS0J2dNgub1sQ--
