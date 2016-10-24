From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v2 2/2] power: bq27xxx_battery: add poll interval
 property query
Date: Mon, 24 Oct 2016 22:14:43 +0200
Message-ID: <20161024201443.GB5989@amd>
References: <1475092512-30555-1-git-send-email-matt@ranostay.consulting>
 <1475092512-30555-3-git-send-email-matt@ranostay.consulting>
 <CAKzfze9uvMvrF=gWph_HKFk_cH0qzRz6Wa2VJafK+H+wdnP0rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKzfze9uvMvrF=gWph_HKFk_cH0qzRz6Wa2VJafK+H+wdnP0rg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
List-Id: linux-omap@vger.kernel.org


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2016-10-24 12:58:25, Matt Ranostay wrote:
> Pavel + Sebastian this is the patchset that need I some input on :)

Better then previous one.

But my version of bq27xxx_battery.c already contains this:

static const struct kernel_param_ops param_ops_poll_interval =3D {
        .get =3D param_get_uint,
        .set =3D poll_interval_param_set,
};

=2E..so it should be possible to set poll interval already.

									Pavel
								=09
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlgOa7MACgkQMOfwapXb+vIEQwCfaqEzHwCgehh9rPgyS5/3Bcd1
EJkAoI1GGRsaDu5BjeNrb3Qhk6styBCq
=qdnU
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
