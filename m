From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [RFC] Correct registration of multiple gpmc smsc911x
 devices.
Date: Wed, 21 Mar 2012 19:00:28 +0000
Message-ID: <20120321190028.GK3226@opensource.wolfsonmicro.com>
References: <4F6324D5.9010106@uni-dortmund.de>
 <1332352554-6417-1-git-send-email-Russ.Dill@ti.com>
 <20120321181259.GJ3226@opensource.wolfsonmicro.com>
 <A9E31EDE-A279-41FB-9EBE-3370A587ADA7@ti.com>
 <20120321183957.GM9859@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="enGqbSaueFq5omEL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:52186 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760005Ab2CUTAb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Mar 2012 15:00:31 -0400
Content-Disposition: inline
In-Reply-To: <20120321183957.GM9859@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "Porter, Matt" <mporter@ti.com>, "Dill, Russ" <russ.dill@ti.com>, "<linux-omap@vger.kernel.org>" <linux-omap@vger.kernel.org>, "<robert.marklund@stericsson.com>" <robert.marklund@stericsson.com>, "<linus.walleij@linaro.org>" <linus.walleij@linaro.org>


--enGqbSaueFq5omEL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 21, 2012 at 11:39:57AM -0700, Tony Lindgren wrote:
> * Porter, Matt <mporter@ti.com> [120321 11:27]:

> > > Hrm?  Adding regulator supply mappings anywhere other than the
> > > initialisation for a specific board would be extremely unusual and
> > > rather suspicious.

> The issue here is that we don't want to copy paste the dummy fixed
> regulator all over the board-*.c files, and we don't know how the
> real regulator is wired up.

Well, I don't think it's too unreasonable especially now we've got
the fixed helper stuff which slims it right down - it makes it clear
there's a missing thing that might need to get filled in and makes it
easier to use the same regulator for other devices.

> > Just to be clear, here is the thread on the board-specific approach:
> > https://lkml.org/lkml/2012/2/8/415

> We should use the real regulator if passed from board file.

> And if no real regulator is passed, just use the dummy fixed regulator
> in gpmc-smsc911x.c.

Yes, it should definitely be conditional.

> This patch I posted should fix the situation and allow adding the
> real regulators to board-*.c files when they become known:

> http://www.spinics.net/lists/linux-omap/msg66714.html

That should be changed to pass in a boolean flag rather than a pointer
to platform device - the board may not have direct access to the
relevant regulator (eg, if it's part of a MFD) or the regulator may be
on another bus like I2C (for simpler regulator only devices).

--enGqbSaueFq5omEL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPaiVEAAoJEBus8iNuMP3dhwYP/2vS7VttDBXEqu4av60J/6AZ
9FN4d+ucUbOGLIFSYQ8xbr99ekENxo9PoY3Lg3DZRFkJBf4cxr1J5JTJYTRG4QZY
Jir1rBq23NFrRq4XG3vVwyIxIlSXVzmfZ45nKMa57UswxiK8b63Bw70ccghrLQFo
lTalOzretDL/VJMF0U3XymxqTB96Vx28wOCiS5WiFdeR+kRmbHD3/dwOSTiASpfp
HZwd9DRQxKsXZ5AYSj3/LAY8mpDQoC+cWm0K9XSaJ2DcIJ0kuw3mheQGl8LnzJu+
JpxIS3K/RHTh5IkrIvfOAnG0qvM37aYCC2qQFVQhkxr4N0Nt7x3cZFrmo7wpz9GT
FFgb/PmpdjpURkVt0czifqBlcUHxyfr2kILDRAldZgHp55rPuF2CBM96XvHb73RT
ZTDuTf1GchKUaL3EdywcM2/lF/qn8UHrLyeQ5mo+XN7+WUUlt5zGeHs+Y8JX2lNy
rtTGYo1mFaYjjXSIe9QhrWehQAJ2zUW3jfF5nAUd9mNOIQL72eAfbgIoLTSSMH0e
0Z6ZZCoRfpaEZByVrc3xIMUd3LqX32d9ruB0p+eBUJqxsWvbuAJD+he0pq6ezCG9
/V9+NIbjR6ZEhzLKjx9aoHQuViNYmOwgpgaiPQkTeeMzIguvBvwFTw7M8lmhVa19
AM2uKRViOvSi2O4OPWi8
=mXVY
-----END PGP SIGNATURE-----

--enGqbSaueFq5omEL--
