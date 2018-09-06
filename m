From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rfc] leds: add TI LMU backlight driver
Date: Thu, 6 Sep 2018 12:16:15 +0200
Message-ID: <20180906101615.GA1467@amd>
References: <20180829212032.GB15786@amd>
 <a0906253-44e3-5a01-73ca-67c7cb124eb0@ti.com>
 <20180830201825.GA1936@amd>
 <ec7c9624-c1c3-df35-3593-704ac1dc9a4d@ti.com>
 <20180831213030.GA23447@amd>
 <d96eab23-dbd9-71a6-551e-2bc99ce4a57c@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d96eab23-dbd9-71a6-551e-2bc99ce4a57c@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Well, I don't think object file size is huge problem. First,
> > "distribution" kernel with support for 6 different chips will be ~71k,
> > while your proposal will result in ~136k. Second, yes, we could put
> > ifdefs into ti-lmu data file to make it smaller.
> >=20
> > Anyway, clean source code and easy maintainance is more important.
>=20
> I am going to reply here and snip the rest of the chain.
>=20
> My proposal is to create a ti-lmu-led-common file that contains all the c=
ommon
> code.  We can have LED drivers use that common code to perform the common=
 tasks.
> This can then be extended to other devices past, present or future that h=
ave the
> same feature set.

Sounds good. But we'll still need to have the structure with register
info, right?

> Then the register maps and LED registration can be contained in each LED =
driver and any additional features
> can be supported in the LED driver.  The common code will retrieve any de=
vice settings from
> the firmware that it is interested in.

=46rom the device tree?

> I can throw some code together and RFC the code.  This way we get the com=
mon core for the
> chips and not the bloat or messy source with a single driver.
>=20
> And yes I can put this together and support it if it is needed.  I just n=
eed to go get the EVMs
> so I can test it.

Well, if possible, I'd like to see how the code would look. Example
for single LED type would be enough... If it is reasonable, I can port
it to Droid 4 or at least provide testing.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluQ/m8ACgkQMOfwapXb+vJ0WwCfQAscvnJED+8nh2tOsOP9GyLr
5FkAn1toz5PQqjtC1SaukJx9lfgK1cYD
=UtOM
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
