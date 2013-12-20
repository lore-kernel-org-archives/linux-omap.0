From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP display subsystem - does it work?
Date: Fri, 20 Dec 2013 09:45:18 +0200
Message-ID: <52B3F58E.8060806@ti.com>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk> <52B1A922.6020901@ti.com> <20131218180240.GG27438@atomide.com> <52B282BE.9050705@ti.com> <20131219165607.GN27438@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Upui4NUgjcIhNr3ClDBAi0sw2C7kousBU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39172 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754099Ab3LTHqO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Dec 2013 02:46:14 -0500
In-Reply-To: <20131219165607.GN27438@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

--Upui4NUgjcIhNr3ClDBAi0sw2C7kousBU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-19 18:56, Tony Lindgren wrote:

>>> Russell, maybe all you're missing is just omapfb.vram=3D0:2M,1:5M or =
similar
>>> from your kernel cmdline?
>>
>> Nothing like that should be required for normal operation.
>=20
> Hmm maybe these instructions need some updating then:
>=20
> http://omappedia.org/wiki/Bootargs_for_enabling_display

The page says omapfb.vram "can" be used, and "If the size is not
specified, frame buffers with default size are created". You only need
omapfb.vram option if you want to allocate extra memory for the fb.

The plain 'vram' option has no function anymore, now that we're using
normal dma alloc. So that part should be updated.

 Tomi



--Upui4NUgjcIhNr3ClDBAi0sw2C7kousBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSs/WOAAoJEPo9qoy8lh71vdQP/1+08Ss2MgngSSQZ2y4b0HZ0
fdcLqKwZgGv9WwPaR7VrhuHhVafDknLQWEPdj5KExpgYrXqgWiUK4GYPRBh8znq+
9+vDBcv/XCJr3KNLUqfLm9AgJc5+BVOoSfWeBOXn5ujo3o/79jpy8pvRzflb3jT0
7AKYm0vE3mKMZ8W9A0dkvQSieD318XPXhBOR1uRc2lKB6vrFcSGAchkE1tBKzCD5
W4ICf6sFRGLhyiR3eM68cMq3pzrOaILA+BJnXhN3ZaBvHviFtN/16IcQL66RHA1b
xjvo/eh2F/8B/75EnMKtWk6YY+okYpHnBx42PA9p1k6uSxkDnAvbpQJmrao8KGRy
MUbxT1bE7q0N1Bt41Q8dU2gaBe8EWqYNp1m5k3zJc6YS5nsbaBw0QFanWumtiFfH
CF1f8/JUHhiyBDJjyNA7QnJws8CQpRJM+WA36u29p7w6UMRh4vRNWNsYgQbOsTdy
epIXlhjOr2b0xhBniQ5CWaFsBEnOOXnTqErj2FMlyT/zECQ4N6QttZ6S4xE+FkSd
GwiIRNGi8NcFcShPA/+RfCKn+xLILhVoP+X9A2pTGE4alwhgmv8idWryxG/JkJum
hLKz9c03HH1licVkZ3M088Oto9kPManerAbeHNtQCcLheS7QvHD9CoHUwTb7/quM
i4TqlJn+16JMQkL7Mp35
=tKxO
-----END PGP SIGNATURE-----

--Upui4NUgjcIhNr3ClDBAi0sw2C7kousBU--
