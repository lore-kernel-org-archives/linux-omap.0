From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Droid 4 on 5.5-rc3
Date: Wed, 1 Jan 2020 23:02:37 +0100
Message-ID: <20200101220237.GA13059@amd>
References: <20191228162929.GA29269@duo.ucw.cz>
 <20191228193622.GA13047@duo.ucw.cz>
 <20191230173507.GM35479@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3706446887482005289=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191230173507.GM35479@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: mpartap@gmx.net, merlijn@wizzup.org, martin_rysavy@centrum.cz, kernel list <linux-kernel@vger.kernel.org>, sre@kernel.org, nekit1000@gmail.com, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org


--===============3706446887482005289==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2019-12-30 09:35:07, Tony Lindgren wrote:
> * Pavel Machek <pavel@ucw.cz> [191228 19:37]:
> > Hi!
> >=20
> > > 5.4-based kernel works ok on my droid 4.
> > >=20
> > > 5.5-rc3 based kernel has problems; it reboots when I try to kexec it.
> > >=20
> > > Vanilla 5.5-rc3 reboots, too.
> > >=20
> > > If you have any ideas, let me know.
> >=20
> > I managed to get partial serial dump. This should be 5.5-rc3: And then
> > a bit better serial dump (below). But it is silent for few seconds,
> > and then it restarts...
>=20
> If spi or regulators have problems, nothing will really work..

Hmmm. I'm too lazy to think. 5.4 is okay, 5.5-rc3 is broken... Let me
try 5.5-rc1 and then bisect. Unfortunately getting serial output is
tricky, too, since I need the USB for kexec...

If you know that there's known bug somewhere in 5.5-rc1, tell
me. Bisect can only locate one bug....

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl4NFv0ACgkQMOfwapXb+vIF3wCcDMrs0bs+1JWU3nnm2hPedrZ9
I+0AoK0newXf9VEBn/TY7kJrz1pSg+qu
=8xnV
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--


--===============3706446887482005289==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3706446887482005289==--
