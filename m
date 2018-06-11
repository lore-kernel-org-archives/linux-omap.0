From: Pavel Machek <pavel@ucw.cz>
Subject: Re: handling voice calls in ALSA soc (on Droid 4)
Date: Mon, 11 Jun 2018 14:01:58 +0200
Message-ID: <20180611120158.GA21745@amd>
References: <20180611102529.GA1272@amd>
 <20180611111011.GA11580@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180611111011.GA11580@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com
List-Id: linux-omap@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-06-11 12:10:11, Mark Brown wrote:
> On Mon, Jun 11, 2018 at 12:25:30PM +0200, Pavel Machek wrote:
>=20
> > ...and also. What is right interface for this? Mixer component that
> > says if voice call is active or not?
>=20
> Your modem should be represented as a component in the system and have
> an input and an output representing the input and output on the cell
> network.  See speyside for an example of how this can look in software
> though there's a bunch of different ways modems can appear so you might
> not have a fully digital link like that.

Thanks for the pointer.

With setup like that, how does userland tell kernel that the baseband
<-> microphone/speaker connection should be activated?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlseZLYACgkQMOfwapXb+vLTKgCePk3alYN445NsOHmo+vsZuR+N
8ncAn2Srh+HDZ8pQNncr6xWcW6+zAWf9
=pkOF
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
