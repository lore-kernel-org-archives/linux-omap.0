From: NeilBrown <neilb@suse.de>
Subject: Re: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
Date: Sat, 4 Feb 2012 14:09:23 +1100
Message-ID: <20120204140923.063706c8@notabene.brown>
References: <13274430881471@kroah.org>
	<alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
	<20120126042155.GA3185@suse.de>
	<alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
	<20120126191604.GA15516@suse.de>
	<alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
	<alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
	<20120203150708.386951d2@notabene.brown>
	<alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com>
	<20120203205401.5ddf241d@notabene.brown>
	<alpine.DEB.2.00.1202031255330.27947@utopia.booyaka.com>
	<20120204085940.2de44594@notabene.brown>
	<alpine.DEB.2.00.1202031532540.27947@utopia.booyaka.com>
	<20120204110131.7378b8fe@notabene.brown>
	<alpine.DEB.2.00.1202031900460.9453@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/gExCDCQEHPg4LT4ONZ.7L8p"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58944 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752943Ab2BDDJh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 3 Feb 2012 22:09:37 -0500
In-Reply-To: <alpine.DEB.2.00.1202031900460.9453@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: greg@kroah.com, khilman@ti.com, govindraj.raja@ti.com, tomi.valkeinen@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--Sig_/gExCDCQEHPg4LT4ONZ.7L8p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Feb 2012 19:06:19 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrot=
e:

> Hi Neil
>=20
> On Sat, 4 Feb 2012, NeilBrown wrote:
>=20
> > Guess what happens if I set autosuspend_delay_ms to 0?
> > Massive transmit problems.  Driver can hardly get anything out before t=
he
> > UART's fclk is cut...
>=20
> Just reproduced this on 35xx BeagleBoard.  Looks like the UART is indeed=
=20
> going idle while the TX FIFO has bytes in it.

That makes me happy :-)

>=20
> Here's a patch that helps.  It seems to work down to an=20
> autosuspend_delay_ms of 1 ms.  Without it, the best I can get is 8 ms.
>=20
> Of course, ideally it should work fine at autosuspend_delay_ms =3D 0, so=
=20
> likely there's some other infelicity that we're currently missing.
>=20
> Neil, care to give this a test and confirm it on your setup?

Yes, that seems to make the output corruption go away.

Even with small autosuspend_delay_ms down to 0 it doesn't corrupt output,
but as the first input byte is corrupted, I cannot really type with those
setting (so I ssh to gain control again).

The patch disables the IDLEMODE_SMART setting that happens on runtime
suspend/resume so that the IDLEMODE_NO setting stays in force.

So it clearly isn't "stopping the clocks" that is the problem - as I first
imagined - but rather the SIDLE handshake isn't doing what we think it shou=
ld
do.

Thanks,
NeilBrown


--Sig_/gExCDCQEHPg4LT4ONZ.7L8p
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBTyyhYznsnt1WYoG5AQKYFRAApSFw9BU0y8DIbWarcjMgduloLZpMqqZI
ECZ1YliEoPMmyQyRVhxukB4eRwEUI7aqwRlpfUCX2Jla56W/UUpTS4jX454wJLr4
OvEftlPrhFcA7BdUHtsonXS2EmBVeEzxu8oPCbLrR8WtNyoN+NIuZcFpZPZIHIO6
BSsUS3WRHBws/w1MFqnovEG4dOnxEHyr+ThqrRZgtiTBGMFDuI3p6CsDYCC0wPnA
WqsNW4r2BTOl2x1+5Q8mK+8ox2Z8UE0kbcNHTUG7pBt8R9CXAnmaPTydSBVZqvpZ
yxmrtkbRVVKW+tUuptZv8yOtnoexVb9+IcwXIOBhuPNklbcBJg8gtf58jz6gYG6i
ra2a1FjDrt51pnuOqigXxWgHL343Q4UjpqSnitmXA0PWhXOS5oRzrkO5Y1pXQHU/
BM55Fxt0HRDYdfxUyy6xu5SgChH0T6EO6Gdl3MFD8D+hUw/lzyCQOT5wYz4jkc4n
msTi9/k5Kx/kh3rdyhFsbEbpJvHcoVEY3oXliB/e6PThwnHXPd5mYBa1w6Y5QFqh
H5aUMkfy37qMHSwGp1d959CBDpvn8mTZUIvEb5xKzQR8mXiN2tR0oqiHEp0lTBV2
pjtB+w20iJnDpgsaYYxnZTGamKCFwpX9doYTVnBURw64YRQzxLgE46hJuC9aCDSD
iN3DWEmSwxg=
=Jekq
-----END PGP SIGNATURE-----

--Sig_/gExCDCQEHPg4LT4ONZ.7L8p--
