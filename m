From: Pavel Machek <pavel@ucw.cz>
Subject: Re: simultaneous voice/data works (was Re: call/normal
 switch was Re: omap4-droid4: voice call support was)
Date: Mon, 9 Apr 2018 22:21:26 +0200
Message-ID: <20180409202126.GA4548@amd>
References: <20180402155754.GD5700@atomide.com>
 <20180403150444.GE5700@atomide.com>
 <20180403155023.GA14638@atrey.karlin.mff.cuni.cz>
 <20180403194419.GG5700@atomide.com> <20180406120423.GA18691@amd>
 <516eb3f7-e300-d59d-6a31-ab7545c656f1@wizzup.org>
 <20180407081000.GB7818@amd> <20180407122233.GA11302@amd>
 <cbfc3cfa8acbc02dde848ec4e1d71b5089ff1d10.camel@redhat.com>
 <20180409140847.GP5700@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7170379174306665839=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180409140847.GP5700@atomide.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@collabora.com, Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org, Merlijn Wajer <merlijn@wizzup.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-omap@vger.kernel.org


--===============7170379174306665839==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-04-09 07:08:47, Tony Lindgren wrote:
> * Dan Williams <dcbw@redhat.com> [180408 02:46]:
> > On Sat, 2018-04-07 at 14:22 +0200, Pavel Machek wrote:
> > > I tried --location-enable-gps-unmanaged , but that did not work for
> > > me.
> >=20
> > That requires a TTY that would spit out the GPS data; in this mode MM
> > only sends the start/stop commands, and what comes out the GPS TTY is
> > undefined (at least by MM).
> >=20
> > So unless you know that one of the 6600's TTYs does GPS and in what
> > format it does GPS, then no.
>=20
> There should be a NMEA port within the unknown port range ttyUSB[123].
>=20
> Is there some easy way to enable --location-enable-gps-unmanaged for
> testing so I can check if GPS gets enabled for one of the ports?

In the meantime, I got GPS to work :-).

I modified qmicli to pipe NMEA data to stdout, which should be enough.

But yes, directly exposing NMEA data on ttyGSM? would be even nicer.

Thanks,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrLy0YACgkQMOfwapXb+vK6XACfQVUZLXMuojngmXdt6ojz5gb1
v6IAn1H5PkXB/AyO1oWYpDT6jbnJnwuR
=hwpN
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

--===============7170379174306665839==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7170379174306665839==--
