From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.17-rc1: regressions on N900, N950
Date: Mon, 21 May 2018 23:39:53 +0200
Message-ID: <20180521213952.GA11596@amd>
References: <20180422074213.GA12428@amd>
 <20180423202940.ig6iud5lrbgnu35a@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2944609439466726556=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180423202940.ig6iud5lrbgnu35a@darkstar.musicnaut.iki.fi>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, abcloriens@gmail.com, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, martijn@brixit.nl, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Thorsten Leemhuis <regressions@leemhuis.info>, clayton@craftyguy.net, sakari.ailus@linux.intel.com, pali.rohar@gmail.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--===============2944609439466726556==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

HI!

> On Sun, Apr 22, 2018 at 09:42:13AM +0200, Pavel Machek wrote:
> > v4.17-rc1 broke display for me on Nokia N900. (I don't know if system
> > boots, but I can see on red flash LED that at least that driver
> > succeeded. So it should not be early boot crash).
> >=20
> > v4.17-rc1 also broke boot on N950.
> >=20
> > Any ideas? Does it work for you?
>=20
> Below config works for me on N900 and N950. (On N950, I need to disable to
> display DTS entry as discussed in other threads.)

Thanks... On N900 it works for me in v4.16, but display stays blank in
v4.17-rc1...

And I'm starting to suspect I have somehow special N900, or maybe
special gcc version... Whether display on N900 works or not seems to
depend on completely unrelated config options :-(. Maybe it is timing
during boot or something.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlsDPKgACgkQMOfwapXb+vKRdgCgw/d5kwoj1Y0AWn9WFqGhnOz/
3I8AmwTI02rWx45oZcEbv1PHdh7HqfB+
=jt29
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--


--===============2944609439466726556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2944609439466726556==--
