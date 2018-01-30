From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH] sound/tlv320dac33: Add device tree support
Date: Tue, 30 Jan 2018 11:35:38 +0100
Message-ID: <20180130103538.GD18104@amd>
References: <20180129230539.GA18280@amd>
 <20180129232031.GA7695@lenoch>
 <20180129233301.GA18104@amd>
 <20180130083446.GA13498@lenoch>
 <20180130085314.GA4585@amd>
 <1141b126-b883-a246-85ad-c5a69acb90bb@gmail.com>
 <20180130093838.GA15195@lenoch>
 <20180130100023.GB18104@amd>
 <20180130101046.GA16474@lenoch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="11Y7aswkeuHtSBEs"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180130101046.GA16474@lenoch>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, bhumirks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, patrikbachan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org, abcloriens-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, clayton-fehKsxFhGzZIf6P1QZMOBw@public.gmane.org, martijn-28JJ9oSIdodmR6Xm/wNWPw@public.gmane.org, sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--11Y7aswkeuHtSBEs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2018-01-30 11:10:46, Ladislav Michl wrote:
> On Tue, Jan 30, 2018 at 11:00:23AM +0100, Pavel Machek wrote:
> > On Tue 2018-01-30 10:38:38, Ladislav Michl wrote:
> > > On Tue, Jan 30, 2018 at 10:11:02AM +0100, Filip Matijevi=C4=87 wrote:
> > > > Hi,
> > > >=20
> >=20
> > > > > Well, notice I'm converting existing driver to device tree. And t=
hat
> > > > > one already has GPIO dependency. It is possible that more work ne=
eds
> > > > > to be done there, but that should not be a reason to delay this. =
Feel
> > > > > free to help.
> > >=20
> > > Adding DT properties that need to be maintained for compatibility rea=
sons
> > > is a bad idea and very good reason to delay merging unfinished stuff.
> > > And meanwhile it turned out it is not power-gpio :)
> >=20
> > I believe reset-gpios and power-gpios are commonly used like
> > this... and that's what the old code does.
>=20
> Why do you care about old code when introducing new DT property?
> Either it is reset, then lets call it reset-gpios or it is power supply
> and then voltage regulator should be used (VAUX4.OUT is such a regulator
> although it is unclear to me how it is controlled (*)).

power gpio =3D !reset gpio. Difference is only in polarity.

> > You are not helping.
>=20
> The only way I can help here is to resend your patch with "reset-gpios"
> used, which I'm pretty sure you can handle yourself.

Well, you can do that, and then you can argue with the next person who
feels one of the properties has to get his preferred color. Hard part
is not changing code :-(.

									Pavel

> (*) Remark "DAC33 enabled (for example, plug in a headset to the 3.5mm
> AV connector and start music playback from the device)" in schematics
> suggests it is controlled somehow.

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--11Y7aswkeuHtSBEs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlpwSnoACgkQMOfwapXb+vJpSACfcoEayAIDb8i+euYVi6ax51do
2ogAoLNW73ZHvDoFKVEHhmR0dufAqXGX
=6iRg
-----END PGP SIGNATURE-----

--11Y7aswkeuHtSBEs--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
