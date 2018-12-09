From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] Input: omap-keypad: Fix keyboard debounce
 configuration
Date: Sun, 9 Dec 2018 12:56:48 +0100
Message-ID: <20181209115648.GA23309@amd>
References: <20181203012933.6647-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181203012933.6647-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Axel Haslam <axelhaslam@ti.com>, Felipe Balbi <felipe.balbi@linux.intel.com>, Illia Smyrnov <illia.smyrnov@ti.com>, Marcel Partap <mpartap@gmx.net>, Merlijn Wajer <merlijn@wizzup.org>, Michael Scott <hashcode0f@gmail.com>, NeKit <nekit1000@gmail.com>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun 2018-12-02 17:29:32, Tony Lindgren wrote:
> I noticed that the Android v3.0.8 kernel on droid4 is using different
> keypad values from the mainline kernel and does not have issues with
> keys occasionally being stuck until pressed again. Turns out there was
> an earlier patch posted to fix this as "Input: omap-keypad: errata i689:
> Correct debounce time", but it was never reposted to fix use macros
> for timing calculations.
>=20
> This updated version is using macros, and also fixes the use of the
> input clock rate to use 32768KiHz instead of 32000KiHz. And we want to
> use the known good Android kernel values of 3 and 6 instead of 2 and 6
> in the earlier patch.
>=20
> Cc: Axel Haslam <axelhaslam@ti.com>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: Illia Smyrnov <illia.smyrnov@ti.com>
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Merlijn Wajer <merlijn@wizzup.org>
> Cc: Michael Scott <hashcode0f@gmail.com>
> Cc: NeKit <nekit1000@gmail.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sre@kernel.org>
> Reported-by: Pavel Machek <pavel@ucw.cz>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

So, if I press key "." quickly on console in
4.18.0-rc4-88970-gf075a2c-dirty it starts repeating. I could reproduce
it 3 times from tree tries. Then I decided to test your patch, and so
I booted 4.20-rc5+ using kexec. Turns out, I can't reproduce that
repeat there... I tried more than 10 times. But that's before your
patch.

So -- bad news for you -- seems like someone -- maybe you -- already
fixed this. (But that does not mean the patch is bad idea).

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlwNAwAACgkQMOfwapXb+vIzOwCgwGpGhjOyTgDxRGX5KMcDvnjp
laIAoK9E4BElVpVT2De8AQRVQz87KZ2u
=Pik5
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
