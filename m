From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Enable backlight when trigger is activated
Date: Mon, 22 Jul 2019 23:04:07 +0200
Message-ID: <20190722210407.GA25617@amd>
References: <20190718190849.GA11409@amd>
 <22d7eca4ad8aa2e73933c4f83c92221ce6e0945a.camel@collabora.com>
 <20190722075032.GA27524@amd>
 <6fc6af89-1455-7665-47e7-0568ecd87c9c@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0121990956=="
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <6fc6af89-1455-7665-47e7-0568ecd87c9c@gmail.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: linux-fbdev@vger.kernel.org, mpartap@gmx.net, b.zolnierkie@samsung.com, tony@atomide.com, merlijn@wizzup.org, kernel list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org, sre@kernel.org, nekit1000@gmail.com, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, Ezequiel Garcia <ezequiel@collabora.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--===============0121990956==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >> This looks fishy.
> >>
> >> Maybe you should use a default-state =3D "keep" instead? (and you'll h=
ave
> >> to support it in the LED driver).
> >>
> >> That'll give you proper "don't touch the LED if it was turned on" beha=
vior,
> >> which is what you seem to want.
> >=20
> > Actually no, that's not what I want. LED should go on if the display
> > is active, as soon as trigger is activated.
> >=20
> > Unfortunately, I have see no good way to tell if the display is
> > active (and display is usually active when trigger is activated).
>=20
> default-state DT property can be also set to "on"
> (see Documentation/devicetree/bindings/leds/common.txt).

Ok, thanks for the hint, that could work. (I thought we were using
default trigger to set the LED "on").

Now...this gives me option of 0% or 100% brightness, while best would
be 10% brightness.... but I guess we can live with that ;-).

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl02JMcACgkQMOfwapXb+vI4ugCeInwKolmtAnBHOQNVsMS09AdN
Kr8AnAq4ihyjYP61ghzcLq9l2lbwoALF
=guhn
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--

--===============0121990956==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlz
dHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVs

--===============0121990956==--
