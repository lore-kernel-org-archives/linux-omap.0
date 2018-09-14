From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v7 1/6] dt-bindings: ti-lmu: Remove LM3697
Date: Fri, 14 Sep 2018 10:18:23 +0200
Message-ID: <20180914081822.GA21830@amd>
References: <20180911170825.17789-1-dmurphy@ti.com>
 <20180911170825.17789-2-dmurphy@ti.com>
 <20180911200530.GA28290@amd>
 <85ab3bf4-21d4-dda9-a7c8-5ed68f15c611@ti.com>
 <20180912214938.GA30654@amd>
 <7950fa32-c8f9-52bb-06b0-0c1cc93b6bc9@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7950fa32-c8f9-52bb-06b0-0c1cc93b6bc9@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: robh+dt@kernel.org, jacek.anaszewski@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, lee.jones@linaro.org, linux-omap@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> How do I politely explain that the original implementation was wrong f=
or certain devices?
> >=20
> > Implementation? Device tree is hardware description.
>=20
> Yes this hardware description is incorrect.  The hardware description is
> describing a MFD but this LED driver (and a couple others) only perform
> 1 function and that is to drive a LED string.

So what? Does not seem incorrect to me. Maybe the description should
not be in MFD directory, but other than that...

> >> Isn't code and documentation supposed to be pushed in stages
> >> together?
> >=20
> > Device tree is _not_ documentation. And yes, it is normally pushed
> > together. But that did not happen here, and bindings are already in.
>=20
> Hmm..  Its not documentation but it is in the Documentation folder.
> And just because the bindings are in does not mean they cannot be
> changed.

You may want to learn more about device tree and/or talk to the device
tree maintainers. This is an old article. https://lwn.net/Articles/561462/

NAK on this patch. I see that this binding has problems, but
introducing different binding for subset of devices is _not_ a fix.

> > What about the multi function devices? They should have same binding.
>=20
> The MFD devices defined are not in contention here only the SFD.

I'd like to see common solutions for SFD and MFD, as the hardware is
similar, and that includes the code. Having code that is easier to
maintain is important, and having many drivers are harder to maintain
than one driver.

Milo's code looks better than yours in that regard. I disagree about
Milo's code being "nightmare" to modify, and care about "easy to
maintain" more than "binary size".

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlubbs4ACgkQMOfwapXb+vJfLwCgvrCeYUwH6P2phaE9NTvBq/k1
GCIAni/x5JZngbu8vHWGo+wRWYQJu+6x
=8OgQ
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
