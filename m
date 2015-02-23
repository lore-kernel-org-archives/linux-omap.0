From: Felipe Balbi <balbi@ti.com>
Subject: Re: "advanced" LED controllers
Date: Mon, 23 Feb 2015 16:58:36 -0600
Message-ID: <20150223225836.GB4355@saruman.tx.rr.com>
References: <20150219211424.GN13603@saruman.tx.rr.com>
 <20150223223457.GA4073@amd>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hHWLQfXTYDoKhP50"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150223223457.GA4073@amd>
Sender: linux-leds-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Felipe Balbi <balbi@ti.com>, cooloney@gmail.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--hHWLQfXTYDoKhP50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2015 at 11:34:57PM +0100, Pavel Machek wrote:
> On Thu 2015-02-19 15:14:24, Felipe Balbi wrote:
> > Hi,
> >=20
> > Do we have support for LED controllers which can handle patterns of
> > different kinds ? I mean, currently, if we have an LED controller such
> > as TPIC2810 [1] which can control 8 different leds and each LED
> > corresponds to one bit on register 0x44, we could control leds by just
> > "playing" a wave file on the controller and create easy patterns with
> > that.
> >=20
> > AFAICT, in linux today we would have to register each of the 8 LEDs as a
> > different LED and have driver magic to write the proper bits on register
> > 0x44, that seems a bit overkill, specially when we want to make
> > patterns: instead of writing 0xff we would have to write 0x80, 0x40,
> > 0x20, 0x10, 0x08, 0x04, 0x02, 0x01 separately and have the driver cache
> > the previous results so we don't end up switching off other LEDs.
> >=20
> > IOW, what could be handled with a single write, currently needs 8.
> >=20
> > I wonder if there's any work happening to support these slightly more
> > inteligent LED engines.
> >=20
> > regards
> >=20
> > [1] http://www.ti.com/product/tpic2810
> >=20
> > ps: tpic2810 is probably the simplest example, lp551, lp5523 and others
> > have even more advanced pattern engines which can even handle RGB leds.
>=20
> Well... some more advanced pattern engines can actually run code, up
> to and including prime number computation. So yes, this is complex,
> and how to handle it nicely is a question...
>=20
> I have "notcc" to compile for that.

right, the point is that this is a solution which only works with lp5523
and IMO linux led subsystem should do a little more for such devices.

--=20
balbi

--hHWLQfXTYDoKhP50
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU67CcAAoJEIaOsuA1yqREJYEP/2vW2PORLZZhR4OuFoGjD4JH
A3ZAU1TdUsFRnMHHKSLqjHSpIOFV8Il+bZ6XEcdOBJjnSCQnwouVZAr2n9zwXdE8
y7xE60O0q+ISNPoTNDuG9qn0GC+fYK5KovnTFo2iThK7ot/9/rbtO2OkaQizP3Yr
49krY/XOFtGDcP50EMkTWtuaVYK69TnrDKLOx36Zvz0LzNLaRGMBfGnaVs/9o/qA
wLv01Smgd5a2In27luW1O/2k1zU0vMrf0CyqTosA8L928ZfzlRJsqXv9Iu+IUjfz
QK7qvs2ZS55gzRTKovqdFxveA2le/FadFfIzDKPKfTgjc8FgrdXEytNxc+X2w9vY
y4fo8N2HVfERMxoLt/yUFMngBDxsEGP+oEGjjA6gvLw0t3ytEz21wBJW4YZl5tRG
02rOmVNlO5i81v1Q1M8WJHKyv+K8w2i+9DyGx7HQqULpleUAdi2MY73Sn1keD0sM
d1bCL90qJSbEP3o0tR7hp57lkYB8t610Ucz2yrZikWRzUWV5/dKJV5EzLTBSOv9p
QAGMXQ3ovSulsT+n4qG3Y3XZ4DaEEb4HRLTQA7BxurpAI307+KyucL+HNzQfDBh/
8xhKraKrosP/32IC9k3fSdtUAQ31zgX/JyyYx65JyrQL7QDlk1ST0uMvCJfSvUUK
zMDPPcefYHQ/jLLvfCqx
=qh09
-----END PGP SIGNATURE-----

--hHWLQfXTYDoKhP50--
