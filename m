From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v9 1/8] drivers:input:tsc2007: add new common binding
 names, pre-calibration, flipping and rotation
Date: Sun, 19 Feb 2017 15:17:15 +0100
Message-ID: <20170219141715.GA7159@amd>
References: <9830dd21e6425e3a866fac6ed4cc73ddd58b719f.1482936802.git.hns@goldelico.com>
 <20170128193342.GB38136@dtor-ws>
 <1F6355E1-A5E3-41A6-908F-619A15581BEF@goldelico.com>
 <20170217204041.GE13050@dtor-ws>
 <20170218091526.GC8937@amd>
 <61F3C580-4BF2-4EE6-9DEC-FB8634434EC0@goldelico.com>
 <20170218180811.GB9377@amd>
 <27287BC5-E4E2-4F50-B140-C74D3CADED5B@goldelico.com>
 <20170218225435.GA4693@amd>
 <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CC600A84-A5C8-4A8C-8CF4-B54C57DF73F3@goldelico.com>
Sender: linux-input-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Michael Welling <mwelling@ieee.org>, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Igor Grinberg <grinberg@compulab.co.il>, "Andrew F. Davis" <afd@ti.com>, Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Eric Engestrom <eric@engestrom.ch>, Hans de Goede <hdegoede@redhat.com>Benjamin Tissoires <be>
List-Id: linux-omap@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> About loosing precision: there is already noise (jitter) in
> real-world devices so that you can't achieve subpixel precision
> anyways (unless your panel has a very low resolution). Please see my
> answer to Dmitry some mails ago.

Maybe you can achieve better precision with averaging.

Anyway "input is already noisy" does not mean "so it is okay to
degrade it more". Solve it properly. That means passing calibration
data from kernel to userland.

Thanks,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlipqOoACgkQMOfwapXb+vJI+wCdHzKW12zdkGsR6MudbcX7kYpj
7iwAn1dCxePy7UQKi5bfaRI8t/Uj6bNV
=Hj0A
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
