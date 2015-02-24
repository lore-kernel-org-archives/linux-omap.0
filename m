From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] OMAPDSS: restore "name" sysfs entry.
Date: Tue, 24 Feb 2015 12:40:32 +0200
Message-ID: <54EC5520.1020105@ti.com>
References: <20150224203706.1eafa129@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="LuqB6ELf0qC6l4VTV5lTMQE5nx79wTjeu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39032 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbbBXKkr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Feb 2015 05:40:47 -0500
In-Reply-To: <20150224203706.1eafa129@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, GTA04 owners <gta04-owner@goldelico.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>

--LuqB6ELf0qC6l4VTV5lTMQE5nx79wTjeu
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 24/02/15 11:37, NeilBrown wrote:
>=20
>=20
> commit 303e4697e762dc92a40405f4e4b8aac02cd0d70b
>     OMAPDSS: rename display-sysfs 'name' entry
>=20
> broke the xorg X server on my device as it couldn't find the display
> any more.  It needs the 'name' file and now there isn't one.
>=20
> That commit claims that 'name' is not compatible with i2c or spi.
> i2c does register it own 'name' file, but spi does not, hence my
> problem - I have an spi display.
>=20
> So create a special case for i2c: add the name attribute for non-i2c
> devices.

What X driver is that? What's it doing with the display name? Is it just
using the display name to show something for the user, and the returned
value can be essentially any string?

 Tomi



--LuqB6ELf0qC6l4VTV5lTMQE5nx79wTjeu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU7FUgAAoJEPo9qoy8lh71pPgQAKv/B5ahAlSN916J/jDT8GpP
fjgCEzIJ7V2HYMl2wO5PLE50Lo3lYDlK7+NOtjREctKzERQwMnmCzcrVg9VXKe2X
9gBINHFWgEqhqFXOtFB2WRwWIwauko0U1pAgwmpo2sBxQfLgQvpGpr8quPekZUWH
8/Cgplbc/lhdSVhAOIMNZ6cKEHeDpBdzB4CwyjtB/dy9cQe7Vm1sReDz6SXcmLr5
5pXl8vcOARfGmqn7jRMYXNi+C0Ib71+QZXXF8h4Kb81W516NVcuuhZoXh+hsL2lQ
Vi+FCj2mRGyLGqv8U2LLZmD4GUlDaR7KuG432C2LuVsXCAWzTGbsYvXvx2XNbe19
U7MfbNh6ija0ZG51C7gpMPQa3QSyxnoXuK/kkKXiP0qtYxKPr919yKmlobRy9avU
ArS+XHJYafkQriU09hzvv2CdJGG/gN7IZLIaVOH1jCWtWnkfa1vsqPdDNofIv+vB
LNfZqRFY0r09FZuD/ELJ0DD9fcbncst40rEBB40nPrw/opEvd9+UwUZtmPmwcvZG
sDF99S/SUhhYq6IGrPP5wZ+gLxal/uGe2PVfdreEYWr4vce62f0z3oumSlabxiYl
yukLjes0t1Jq+njctV1rRLwstnjDmpKAc3PRPdIAkHU2JYShgnDXutQC+Kan2h76
wrSAjoVQQhe4y/sgpgda
=lkZB
-----END PGP SIGNATURE-----

--LuqB6ELf0qC6l4VTV5lTMQE5nx79wTjeu--
