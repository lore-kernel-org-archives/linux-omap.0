From: Pavel Machek <pavel@ucw.cz>
Subject: Re: camera on n900, v4.8
Date: Mon, 10 Oct 2016 11:11:55 +0200
Message-ID: <20161010091155.GC7597@amd>
References: <20161005190340.GA25755@amd>
 <20161010084859.GD4467@pali>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3883269347200658368=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161010084859.GD4467@pali>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, aaro.koskinen@iki.fi, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--===============3883269347200658368==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tqI+Z3u+9OQ7kwn0"
Content-Disposition: inline


--tqI+Z3u+9OQ7kwn0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2016-10-10 10:48:59, Pali Roh=E1r wrote:
> On Wednesday 05 October 2016 21:03:41 Pavel Machek wrote:
> > Hi!
> >=20
> > Camera has some non-trivial dependencies on N900; it seems to rely on
> > gpio-switch.c, for example. I'll try to strip the diff further, but in
> > the meantime, here's the version I'm working with.
> >=20
>=20
> With "Camera" do you mean some Maemo userspace application? Because I
> think that nobody else could depends on gpio-switch kernel driver.

With camera, I mean kernel drivers for /dev/video*. I don't know why
they depend on gpio-switch.c, but they do.

I'm using fcam-dev for userspace control of camera. I'd prefer not to
touch anything w/o sources.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--tqI+Z3u+9OQ7kwn0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlf7W1sACgkQMOfwapXb+vIH7ACfcTjtTvtYDKek+k5woSDP/cWK
DsMAoIulT1HeE3cmnH8bdfW/R9Ud2ksO
=tydB
-----END PGP SIGNATURE-----

--tqI+Z3u+9OQ7kwn0--


--===============3883269347200658368==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3883269347200658368==--
