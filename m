From: Pavel Machek <pavel@ucw.cz>
Subject: Re: handling voice calls in ALSA soc (on Droid 4)
Date: Tue, 12 Jun 2018 14:18:03 +0200
Message-ID: <20180612121803.GA9707@amd>
References: <20180611102529.GA1272@amd>
 <20180611111011.GA11580@sirena.org.uk>
 <20180611120158.GA21745@amd>
 <20180611121548.GB11580@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180611121548.GB11580@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org, alsa-devel@alsa-project.org, tiwai@suse.com, perex@perex.cz, lgirdwood@gmail.com
List-Id: linux-omap@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Sebastian, would you have pointer to original Motorola sources you
used for inspiration?

> > With setup like that, how does userland tell kernel that the baseband
> > <-> microphone/speaker connection should be activated?
>=20
> Audio routing should be done as normal, and ideally the driver for the
> modem will be able to figure out if there's an active call or not.  If
> userspace has to enable the input and output manually then you can set
> up SOC_DAPM_PIN_SWITCH()es as normal.

Modem talks AT commands, so the driver is in userspace for now.

I tried SOC_DAPM_PIN_SWITCH(), but it results in alsamixer oopsing, I
guess I'm doing something wrong.

Message from syslogd@devuan at Jun 12 13:51:31 ...
 kernel:[  743.678588] BUG: spinlock bad magic on CPU#1,
 alsamixer/2217

Message from syslogd@devuan at Jun 12 13:51:31 ...
 kernel:[  743.684417]  lock: 0xede423a0, .magic: eee2a6a4, .owner:
 <none>/-1, .owner_cpu: -287136604
=20
I'm trying to understand how it is supposed to work, but
https://www.alsa-project.org/main/index.php/DAPM has TODO's at
critical places. If there's better source of information, let me know.

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

iEYEARECAAYFAlsfufsACgkQMOfwapXb+vKxvwCeMXZn0QSc3zGQ4P91OT3vR5aT
CNcAoMQmdBjFI399f3jwi/POzgWglbm6
=V5kK
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
