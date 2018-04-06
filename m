From: Pavel Machek <pavel@ucw.cz>
Subject: Re: call/normal switch was Re: omap4-droid4: voice call support was
Date: Sat, 7 Apr 2018 00:02:24 +0200
Message-ID: <20180406220223.GA32064@amd>
References: <20180401131852.GA11086@amd>
 <20180401153631.GA5700@atomide.com>
 <20180401173012.GB5700@atomide.com>
 <67086fdd0cdd69142cb89cd00f90e5a580e6607a.camel@redhat.com>
 <20180402155754.GD5700@atomide.com>
 <20180403150444.GE5700@atomide.com>
 <20180403155023.GA14638@atrey.karlin.mff.cuni.cz>
 <20180403194419.GG5700@atomide.com>
 <20180406120423.GA18691@amd>
 <516eb3f7-e300-d59d-6a31-ab7545c656f1@wizzup.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <516eb3f7-e300-d59d-6a31-ab7545c656f1@wizzup.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Merlijn Wajer <merlijn@wizzup.org>
Cc: Tony Lindgren <tony@atomide.com>, Dan Williams <dcbw@redhat.com>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2018-04-06 14:23:46, Merlijn Wajer wrote:
> Hi,
>=20
> On 06/04/18 14:04, Pavel Machek wrote:
> > Hi!
> >=20
> >> OK that explains why the speaker keeps working then :)
> >=20
> > Ok, I pushed new version of unicsy_demo.
> >=20
> > It now sends & receives sms and you can call & receive call. Tone from
> > linphone is used for incoming call. User interface and code is
> > slightly weird, as ofono was -- and still is -- meant as a backend.
>=20
> Great news, can't wait to try it.

Oh btw ... if you need any help just ask. unicsy_demo needs to be
symlinked to /usr/share/unicsy.

If you could make notes of any problems you encounter and any packages
you'll need to install, that would be nice -- it would be good to
create README with installation instructions.

Good luck,
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

iEYEARECAAYFAlrH7m8ACgkQMOfwapXb+vJjswCfbZnDcnE8joUOeLmBhqfwh3+u
rdoAoKjPe4yRv2yWBOQx9J0eCRxi/1my
=/oPQ
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
