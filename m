From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Tue, 16 Oct 2012 10:30:28 +0300
Message-ID: <507D0D14.3070103@ti.com>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com> <5077F771.9080308@ti.com> <CAFqH_52fKOb1OAqK3O-PkT6j69OOeEF-8LoQg-U+u4dH51V82Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig572F9AEC89B05FCACA4D24E1"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57178 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755063Ab2JPHag (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 16 Oct 2012 03:30:36 -0400
In-Reply-To: <CAFqH_52fKOb1OAqK3O-PkT6j69OOeEF-8LoQg-U+u4dH51V82Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enric Balletbo Serra <eballetbo@gmail.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>

--------------enig572F9AEC89B05FCACA4D24E1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2012-10-15 19:08, Enric Balletbo Serra wrote:
> Hi Tomi,
>=20
> Thanks for your answer.
>=20
> 2012/10/12 Tomi Valkeinen <tomi.valkeinen@ti.com>:
>> On 2012-10-11 18:58, Enric Balletbo Serra wrote:
>>> Hi all,
>>>
>>> I see that commit dac8eb5f (OMAPDSS: TFP410: rename dvi files to
>>> tfp410) and commit 2e6f2ee7 (OMAPDSS: TFP410: rename dvi -> tfp410)
>>> changes the panel driver used on some boards. I tested current
>>> linux-next-20101011 kernel with my IGEPv2 board and DSS fails with
>>> following error (see http://pastebin.com/VjPGCQDt for full log) :
>>>
>>>    [   21.222808] omapdss OVERLAY error: check_overlay: paddr cannot =
be 0
>>>    [   21.229583] omapdss OVERLAY error: check_overlay: paddr cannot =
be 0
>>>    [   21.236236] omapfb omapfb: setup_plane failed
>>>
>>> Before checking what happens there is a known issue with this ?
>>
>> Works fine for me, although only with a quite minimal test environment=
=2E
>>
>=20
> I tried with a minimal environment (without X) and I don't see the
> error, so looks you've reason and the problem is with my userspace
> application (X). OTOH, I don't see the video output. I remember that
> this worked before, but seems now is broken. I'll check mux and others
> hints to try to solve the problem ..

It's not about muxing, but something else. So an earlier kernel works
with the exact same userspace and kernel boot arguments? Then we
probably have a bug in the kernel driver. But I can't say much from the
debug prints, except that probably something goes wrong in the
SETUP_PLANE ioctl.

If you can, please add debug prints to omapfb-ioctl.c's
omapfb_setup_plane() and print out the data in the  omapfb_plane_info
parameter, and also prints to the error code paths in the function.

 Tomi



--------------enig572F9AEC89B05FCACA4D24E1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQfQ0UAAoJEPo9qoy8lh71JPcP/iiIuA45ByWpfLn0AaopkwnA
P+kYRqYs1NZptS2khoYhQTvKv0ygVylhRme+xZO3MP2bkK2NBos/L7Lpsq1uJ0vt
f4wq4d/wgV/yRzu4RDbqxeoXddHQkh4FPSSJbopSep/wEVfIr2OB7LFYRUxpZUy2
q32T0viHAx7fn+CbC9yaiKZau7vfD7gaSoTVfDnd1LgBBz4uL5V/6ID++r66BHSK
te2ReG9CIUrlodO8JiEp2jGIMWzY0Rp/pdGYcKTBBs1cjRhmrTlzQOFxphBDRTh+
fr6xpOUobsgKcld2GagKnpUuf/fQBUHnNnThNpH/B4C2SYzUGB0NXM7+DRlKlNAq
s7y9DRx8C70i2dqzmqHOTDrSyoSIW+ssJ+yRavbRiOSjQjqigfg0L0uwD/08pr2g
Rq2vqI93aIr4NVXaa6ibWOKphCGNitMAWjbem2VBeksynVraUBP1uDi2xivfWN84
C+/0VrozKQ4gCU9vqN6xDqXc0qbz5H6dvl5si/kMSfQlP7dP7EwT7nB2r2pQe+Eq
rPE6W1W+q6NtNtgezoZ96BwoSVIA6zQjre95cbST/9ronZMH9lLYPBOpOJrASMT5
Rxi6kl5dBMNGUFnad2Rt8IEqYpthJeGfZiaTBqB3Wl3zRr3+ZAzWproLLJP0m3c8
uFOrli7IFysYTFW9i3KG
=6/+J
-----END PGP SIGNATURE-----

--------------enig572F9AEC89B05FCACA4D24E1--
