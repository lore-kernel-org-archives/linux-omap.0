From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Motorola Droid 4 progress, power consumption
Date: Fri, 4 May 2018 23:47:23 +0200
Message-ID: <20180504214723.GA8010@amd>
References: <20180501183148.GA26996@amd>
 <20180502144158.GJ98604@atomide.com>
 <20180503090611.GA14451@amd>
 <20180503142240.GQ98604@atomide.com>
 <20180504202044.GC22519@amd>
 <20180504203819.GF98604@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180504203819.GF98604@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > But I guess I can sample charge_counter every minute or so and get
> > what I need?
>=20
> Not sure what the max time range is for the PMIC, but yeah I'd
> assume once a minute is duoable. Maybe compare it to the chart
> you already have?

Yes, I can try some more graph painting.

OTOH... battery life is "good enough" and I can already tell when the
battery is full :-). So this part is not critical.

> > I agree this should not be done in kernel as it requires persistent
> > storage.
> >=20
> > Battery is not user-replacable (and this will recalibrate itself on
> > charge/discharge cycle) so.. I don't think keying is strictly
> > neccessary for D4.
>=20
> Yeah right, that can be added later on if needed if you just
> plan accordingly. It's replaceable with a T5 after you peel off the
> sticker from the corners :)

Aha, I wanted to ask what kind of phone T5 is, and T5 is probably torx
5 screwdriver, right? Well, I don't have second battery, so these
experiments will have to wait.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrs1OsACgkQMOfwapXb+vJeigCgkGoTgS02dCQUhOyqk+sIofMw
MksAoICoU32BVSWagZSy5pPIxBMo10SZ
=btoQ
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
