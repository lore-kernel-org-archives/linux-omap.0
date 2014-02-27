From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Help running latest linux-omap kernel on Nokia N810
Date: Thu, 27 Feb 2014 09:19:14 +0200
Message-ID: <530EE6F2.7040903@ti.com>
References: <c57950d5cfbbdcf952b9fceb4cd243d4@doppler.thel33t.co.uk> <20140226185331.GA17632@earth.universe> <20140226212927.GB671@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="LvvcB7c8hIaQM4b7Mcp84RQjSqVsMrFvB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:35461 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbaB0HTw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 27 Feb 2014 02:19:52 -0500
In-Reply-To: <20140226212927.GB671@drone.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@ring0.de>, Leigh Brown <leigh@solinno.co.uk>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

--LvvcB7c8hIaQM4b7Mcp84RQjSqVsMrFvB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26/02/14 23:29, Aaro Koskinen wrote:

> First the bad news: display support is not in the mainline kernel. Also=

> since linux-omap tree follows the mainline, it's not there either anymo=
re.
> Tomi removed the n8x0 panel driver some time ago (I don't know why), bu=
t
> even then it wasn't working as the platform data failed to set up some

It would've been a big effort to keep the panel driver compiling, as we
moved to a new display driver architecture. And, as it wasn't working
anyway, I deemed it simpler to just remove it.

I have no objections to add it back, but it needs to be split into two
separate drivers, blizzard encoder driver and the panel driver. The RFBI
driver also probably needs some love. And, of course, DT support for all
those.

In theory, RFBI is relatively simple. If I recall right, the panel is
also quite simple, although it still needs to be controlled via SPI.
Blizzard was a bit more complex one, but perhaps most of its features
can be just left out.

But getting all those three working fine without being able to make any
measurements between the components, well, one might needs some luck
there =3D).

I do have N800 and N810 (no serial mods), so I might be able to give
some help there at some point, if I'm able to boot the board with usb
gadget ethernet (which hasn't been working for me for omap3 for some time=
).

 Tomi



--LvvcB7c8hIaQM4b7Mcp84RQjSqVsMrFvB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTDubyAAoJEPo9qoy8lh717YIP/jb0VOz7Bu0H8LRoowzyeSRM
7rH1peKDdxCHdroKy7WbsQ4kp2uCWXMZG+ZeYIfHsu+93NHU2jF9eWegHWUps70Z
6YhJ3mPCLwUoxZ2v7BTQED3eqU/Qr3hbzXSg9Dn64nUeKwy1ZodG/P/w0UoQChEF
b4USODfOJiPvlt67lKBFuj23G3Cv6O+GyUhow06PJXJXNgXW/CHUKkI99Bvsc8vG
7SE2k4xR/Jiu/FzRTmsVJHro+eTK06rn8zI8Q8Ph675oxEPVL6CHZZeo1qWtQTZu
JP2BTuT7WIWMjbjWVwqPgGc8TUvPcIJrowninES3T7Cz9pdZYbA8NenfebmgxbXI
CawZHhkdwvy+QyQ85CWN23djaEXJUi/YuPWoDNAsTEML6UTbByULa+42obeEfRs8
t9fNDUXWty81sAbObq/JljMqIKqafu9QKh9OmmwSBWpapEBsC5UoEH2Bj7ims/eq
KSCjPqftAk/rg1/g7msYOANialSgtC6BIGSV8Akf7etpScAsX0TIptqqAUvmRPub
ZcyUO3fv0ejKFiB5Md1/U9yQHDspVcKq5vET3e2A+FzkBbSTLwbl7iNpkoAV2sfg
n6oHrmG7v8s2Znln16VU/neqJNhsaTR8jiHsqcP1R+PbMJAXRWwqDhSOoU10ML03
3qbXUts41XGGGVHGbZya
=I1IO
-----END PGP SIGNATURE-----

--LvvcB7c8hIaQM4b7Mcp84RQjSqVsMrFvB--
