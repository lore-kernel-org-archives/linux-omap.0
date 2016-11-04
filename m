From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 2/2] power: bq27xxx_battery: add poll interval
 property query
Date: Fri, 4 Nov 2016 21:29:24 +0100
Message-ID: <20161104202924.GA6841@amd>
References: <CAKzfze9uvMvrF=gWph_HKFk_cH0qzRz6Wa2VJafK+H+wdnP0rg@mail.gmail.com>
 <20161024201443.GB5989@amd>
 <CAKzfze_rv29gwuBGctwTONyw8Oy6fwE+xcN0HMh-ZPB47HKzuQ@mail.gmail.com>
 <CAJ_EiSRzmQHLP2PTfzsLF4uWgYgCiRGsSk=MHbtOC5rgXnnFpw@mail.gmail.com>
 <20161031213846.GA21014@amd>
 <CAKzfze8Bom1XYRfiix_qYFckMggUD0eJm3Fz=GhNi6H_PBFyXA@mail.gmail.com>
 <20161102082206.GE21488@amd>
 <CAKzfze8d_MZJzR1a6rbwVXCWhb30C5GqFamUt2Viw1CzvyaQxw@mail.gmail.com>
 <20161104070955.GA3679@amd>
 <20161104145855.GH21430@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161104145855.GH21430@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Matt Ranostay <mranostay@gmail.com>, Matt Ranostay <matt@ranostay.consulting>, pali.rohar@gmail.com, Sebastian Reichel <sre@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux OMAP List <linux-omap@vger.kernel.org>, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, Patrik Bachan <patrikbachan@gmail.com>, serge@hallyn.com, =?utf-8?B?TWlja3Vsw6HFoQ==?= Qwertz <abcloriens@gmail.com>
List-Id: linux-omap@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2016-11-04 07:58:55, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [161104 00:10]:
> > On Thu 2016-11-03 22:00:56, Matt Ranostay wrote:
> > Do you actually have hardware with more than one bq27xxx?
>=20
> I can at least see the twl4030 battery/charger features
> being used together with some bq device to monitor the
> battery state. Not sure if that counts as multiple
> instances here though :)

I have that, too, but that was not what i was asking.

Matt wanted support for different polling intervals on different
bq27xxx chips. I'd like to know know if he actually has more than one
bq27xxx in his device...

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgc76QACgkQMOfwapXb+vLCyQCgk9ixQXPmR8Xk+QSVpVpRe1QP
xkgAoIHKMbgXuopqJwvc6YlNJlavYAUa
=Ta4+
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
