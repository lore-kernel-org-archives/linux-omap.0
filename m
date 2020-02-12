From: Pavel Machek <pavel@ucw.cz>
Subject: Re: LED backlight on Droid 4 and others
Date: Wed, 12 Feb 2020 21:16:38 +0100
Message-ID: <20200212201638.GB20085@amd>
References: <20200105183202.GA17784@duo.ucw.cz>
 <20200106084549.GA14821@dell>
 <20200211172900.GH64767@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="QKdGvSO+nmPlgiQ/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from jabberwock.ucw.cz ([46.255.230.98]:46908 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgBLUQk (ORCPT
        <rfc822;linux-omap@vger.kernel.org>); Wed, 12 Feb 2020 15:16:40 -0500
Content-Disposition: inline
In-Reply-To: <20200211172900.GH64767@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Lee Jones <lee.jones@linaro.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz, agx@sigxcpu.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, dri-devel@lists.freedesktop.org, tomi.valkeinen@ti.com, jjhiblot@ti.com, tony@atomide.com


--QKdGvSO+nmPlgiQ/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > It would be good to get LED backlight to work in clean way for 5.6
> > > kernel.
> ...
> > > [If you have an idea what else is needed, it would be welcome; it
> > > works for me in development tree but not in tree I'd like to
> > > upstream.]
> > >=20
> > > Lee, would you be willing to take "backlight: add led-backlight
> > > driver"? Would it help if I got "leds: Add managed API to get a LED
> > > from a device driver" and "leds: Add of_led_get() and led_put()" into
> > > for_next tree of the LED subsystem?
> >=20
> > It looks like you have an open question from Tony on v10.
> >=20
> > Is that patch orthogonal, or are there depend{ants,encies}?
>=20
> Uhh looks like we messed up a bit with integration. Now droid4
> LCD backlight can no longer be enabled at all manually in v5.6-rc1
> without the "add led-backlight driver" patch.. Should we just
> merge it to fix it rather than start scrambling with other
> temporary hacks?

We should just merge the "add led-backlight driver". Everything should
be ready for it. I'm sorry if I broke something working, I was not
aware it worked at all.

Unfortunately, this is backlight code, not LED, so I can't just merge it.

> I don't care if we use "default-brightness", or if we use
> "default-brightness-level". The binding merged says now
> "default-brightness", so let's go with that one. That's what
> other LED drivers are using too.

No opinion on that.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--QKdGvSO+nmPlgiQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl5EXSYACgkQMOfwapXb+vICqQCfdtyPBlJKQO90lCtkFWlVhCoQ
XaAAoILSfdQrM5bUUqiTeghX0xqVkkHp
=vMQC
-----END PGP SIGNATURE-----

--QKdGvSO+nmPlgiQ/--
