From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCHv3 19/41] OMAPDSS: panel-dpi: Add DT support
Date: Tue, 8 Apr 2014 08:38:13 +0300
Message-ID: <53438B45.2090209@ti.com>
References: <1390301833-24944-1-git-send-email-tomi.valkeinen@ti.com> <1390301833-24944-20-git-send-email-tomi.valkeinen@ti.com> <20140408001339.GA15842@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="d8WsVtOgQBImHRjjGmeMfFuTWOeX7IdQj"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45801 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbaDHFjj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Apr 2014 01:39:39 -0400
In-Reply-To: <20140408001339.GA15842@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Archit Taneja <archit@ti.com>, Darren Etheridge <detheridge@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Stefan Roese <stefan.roese@gmail.com>, Sebastian Reichel <sre@debian.org>, Robert Nelson <robertcnelson@gmail.com>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Marek Belisko <marek@goldelico.com>, Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, Enric Balletbo Serra <eballetbo@gmail.com>, Florian Vaussard <florian.vaussard@epfl.ch>

--d8WsVtOgQBImHRjjGmeMfFuTWOeX7IdQj
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/04/14 03:13, Tony Lindgren wrote:
> Tomi,
>=20
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [140121 03:01]:
>> Add DT support for panel-dpi.
>=20
> Looks like this patch did not get merged or am I missing
> something?

Yes, I dropped it. None of the boards that I converted used panel-dpi.
There was so much discussions about the display bindings, so I thought
it's better to leave out all but the needed patches.

> As you probably are aware, we have at least these boards
> needing it before we can remove the omap3 legacy support:
>=20
> board-am3517evm.c
> board-cm-t35.c
> board-devkit8000.c
> board-ldp.c
> board-overo.c
>=20
> We could probably set the display timings based on the
> compatible flag in the driver if that's an issue?

The timings shouldn't be an issue. But there's the backlight GPIO,
currently handled by panel-dpi, which should be removed from the panel.
We should use gpio-backlight for that one.

> And then board-omap3pandora.c also needs support for
> panel_tpo_td043mtea1_platform_data.

Yep, there's still much to do for DSS DT support. Hopefully it will be
easier now that the core support is there. I'll continue working on the
remaining boards and panels. However, I don't have any of the remaining
boards, so help is of course appreciated.

 Tomi



--d8WsVtOgQBImHRjjGmeMfFuTWOeX7IdQj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTQ4tJAAoJEPo9qoy8lh71drAP/RXIVWMBoFi2dySEsTzaWJ0b
gIHhGMNypFPv7q73ZQj7ay1PxLvryA72PWJQvIahJZZ4c9HL4f+yKHGm6j4k+4nz
AKncGVPmvEjfUc/Js6kWg5OxoVEA5nTZw0NTURIQFs2ImxhazCmSMAUy403knuHX
/S7/JiARVGkgHo7n3a20bTcXUgBJWVEHuT/3aOzzoZl61NSy+sVnJoFeK0GUMO6T
uS+/cYdKkyv3rNds23XjXuHn/o0dMQC7P/4G7wvDkMqk9fh1vAdvuRqnRepg1CN4
i2UbvOt+TC6dPoBlUrTZOPru77g7Evy6Alv5u/AhCbbzuSwbqNQPGKeQEzm/mUJr
U9VOkTaGtYtgy5Why8OGx0zjhZ95zF3xUfldC+i+RH6UBT/agJ13SM4RngTHQGJh
O2lCk06T1ynT1Bks7ZcdPDWYVPlMzfAsKRr/Wpf0SZSnT/QuTCKb977aF8YVUj/8
cfLAg7J1veMUyQeGCOIzUW4pvfMzrvfLHJj7IrUCH+bQ9FPMnshGMmUJw2YcRu79
iP1Q6hfAimyrWQfL4tBLobZOoNdNX/5YjugVhEuwd7VTdCWmSEdwdfF+lyBHuj53
Eo6Ft+4RV5iQmmT2wudI0U0OJzE2nhAjRhu80Di1eEtVn9ROsE3n8go0POBz4afg
utlYWnPGDPFWOe5X3lgc
=1d5G
-----END PGP SIGNATURE-----

--d8WsVtOgQBImHRjjGmeMfFuTWOeX7IdQj--
