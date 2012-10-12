From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Fri, 12 Oct 2012 13:56:49 +0300
Message-ID: <5077F771.9080308@ti.com>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig17F92F0DA6AFC625D33C1F6E"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36021 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941Ab2JLK4y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Oct 2012 06:56:54 -0400
In-Reply-To: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>

--------------enig17F92F0DA6AFC625D33C1F6E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2012-10-11 18:58, Enric Balletbo Serra wrote:
> Hi all,
>=20
> I see that commit dac8eb5f (OMAPDSS: TFP410: rename dvi files to
> tfp410) and commit 2e6f2ee7 (OMAPDSS: TFP410: rename dvi -> tfp410)
> changes the panel driver used on some boards. I tested current
> linux-next-20101011 kernel with my IGEPv2 board and DSS fails with
> following error (see http://pastebin.com/VjPGCQDt for full log) :
>=20
>    [   21.222808] omapdss OVERLAY error: check_overlay: paddr cannot be=
 0
>    [   21.229583] omapdss OVERLAY error: check_overlay: paddr cannot be=
 0
>    [   21.236236] omapfb omapfb: setup_plane failed
>=20
> Before checking what happens there is a known issue with this ?

Works fine for me, although only with a quite minimal test environment.

Looking at the log, it looks to me that your userspace is trying to
configure the overlays, and that somehow leads to the driver getting
zero as the fb address.

I'm guessing that some wrong value is passed when configuring, or
missing some step in configuring. However, It should be the omapfb that
rejects configuration that would lead to paddr =3D=3D 0, not omapdss, so
there's definitely bug in the error handling of omapfb.

Can you tell me more what's going on there? I presume the error happens
when booting? What userspace component is using omapfb in your setup? X?

If you can, put some debug prints into omapfb-ioctl.c:omapfb_setup_plane
to see what code path it takes, and where it goes wrong.

 Tomi



--------------enig17F92F0DA6AFC625D33C1F6E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQd/dyAAoJEPo9qoy8lh71gtEP/0B0yh0Mhz+aUohomoRz4qH6
R3JRnrB36Ybq5zPe0UfWMwgI7/hedbcM6mkJL/W7FXfwsMa8T15TEi1aB4PlVymC
ZrN+Bz5o7SHNc4YYzzCdDfaAlEpwGp+hYrT6vxXumYVcweZYBv0A3C8hoYhr401I
3yIBnWraGD3QyC60VR8IR0Dy3QoBjynk+V7+E0KG/HdlsNBPlXQDQcpQ4SbQ79sJ
1PMYEUn7HPswr7Czdoc142AT9GifBmBxqzpgE8bCrkkiLAXuqu8ohLzGQ6Iumdhe
qw7cBHt7D8J3air+ycjGOIyX6Rg/SOKn7dSIkTydwW+merrq7LAc8zu3Pj1d3AhT
IlLo+HvIBzQcP+gmfI34mv8I+wVsE2+MeI+fd/PUNXfCiWt8b90PHSMHC+AG4VwW
KmUKRmHmMRLEfOACkO1ueI1EbAJigxkNwpnZ0+TxuqzdlipcgGAlWtlGii6H61kR
NtGBOgNRjtIt2lgxmCC2eEMJMvrqL2/3e/Ey92t3npZD5WjEOFX6WMIObfbqh0tk
Om6M+1/P+88QHWJQzLNlgadevnQGEsQkGtbRmRUE9ZW5HBNE/4Zjs9nw18VnPOOw
BZMjLpPge9P/LB7KfJ4AORsVNrsO8tNxxcd8zZ5vwa0QLKjQUnF0XOYZifkmIEMd
JTv4lHiChDUkL6EP7lQx
=6II8
-----END PGP SIGNATURE-----

--------------enig17F92F0DA6AFC625D33C1F6E--
