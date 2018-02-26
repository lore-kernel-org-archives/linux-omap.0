From: Pavel Machek <pavel@ucw.cz>
Subject: Re: regression v4.16 on Nokia N900: sound does not work
Date: Mon, 26 Feb 2018 14:13:18 +0100
Message-ID: <20180226131318.GA14045@amd>
References: <20180224214617.GA22619@amd>
 <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5713113411843977649=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: peter.ujfalusi@ti.com, alsa-devel@alsa-project.org, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, tony@atomide.com, aaro.koskinen@iki.fi, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, martijn@brixit.nl, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, broonie@kernel.org, abcloriens@gmail.com, sakari.ailus@linux.intel.com, pali.rohar@gmail.com, clayton@craftyguy.net, linux-omap@vger.kernel.org, afd@ti.com, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--===============5713113411843977649==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> JFYI: This issues is tracked in the regression reports for Linux 4.16
> (http://bit.ly/lnxregrep416 ) with this id:
>=20
> Linux-Regression-ID: lr#4b650f

Ok, so it seems that issue is bigger: whole sound subsystem does not
work. /proc/asound/cards is empty.

7e6127c1240ed569cdda2a67c8f03836f9f28c05 seems to be bad already.

I tried to revert sound/soc changes, and sound is broken, too. Nasty
:-(.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlqUB+4ACgkQMOfwapXb+vIhdwCgkR+ZVhkvkCoNjdoCziV2w6FC
YYQAn2VYm6zqizP3Kg1a/eIUwWPmlYBX
=nnpw
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--

--===============5713113411843977649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5713113411843977649==--
