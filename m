From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: regression caused by commit
 8357b48549e17b3e4e402c7f977b65708922e60f
Date: Thu, 27 Jun 2013 17:52:13 +1000
Message-ID: <20130627175213.9abb1e6109abe9a7e0aabb0b@canb.auug.org.au>
References: <20130627061419.GE15455@arwen.pp.htv.fi>
	<20130627163655.239cea102ba0eb968a434593@canb.auug.org.au>
	<20130627070424.GM15455@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Thu__27_Jun_2013_17_52_13_+1000_lHW.OblYF2LSlaEq"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130627070424.GM15455@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: "Yann E. MORIN" <yann.morin.1998@free.fr>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

--Signature=_Thu__27_Jun_2013_17_52_13_+1000_lHW.OblYF2LSlaEq
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi balbi,

On Thu, 27 Jun 2013 10:04:24 +0300 Felipe Balbi <balbi@ti.com> wrote:
>
> On Thu, Jun 27, 2013 at 04:36:55PM +1000, Stephen Rothwell wrote:
> >=20
> > That commit has been reverted in today's kbuild tree and thus in today's
> > linux-next.
>=20
> thanks, I should fetch again :-)

Let me finish first :-)  (an hour or so ...)

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Thu__27_Jun_2013_17_52_13_+1000_lHW.OblYF2LSlaEq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBCAAGBQJRy+8tAAoJEECxmPOUX5FExp0QAIzvzChF/dBvuq1O11Sgfiiv
hbMGtiSz23uwRkbsrZx7JzztPDIkec0NkWA9CEB3BLrGpmTVIVswUqN3Lfj6NkQS
cbnxu7xFk1SYLWAnuOzUjVCdPKBLf/S2Xp3jEZ84dAhX9dea4ZuYYpGwYj8zzBj2
cp3mXICTUAnwI5deM12u77jPc1DMoP1XeNqaLpUoI/MJfQBgwXkJlKrA+nJXtOoH
er2vsweMZ5pdLvU2TVTm1OxaWMp+UsSuPRCHVwYxRm0guXWisGRuha9Wjxb0GtSV
FlR7lt1aq930f+LMefv96GS/gNAzYARcHpFdhvvcMOpd/em5L/1Qa6M+vQhOC1di
sJWpkDiRHVyR+Cyw58HW83QNH9HHk0XVz3ig1E2ZF7Ag75/E9enx1wRdgraMN+2Q
Vbvoih+4nFFyE+D4QxN7L+sf/m2ICp3kQp8Q46z6rpr9P8zH5FYeFf6GOnnojctS
8TfKHn5wlJsYSpD6CsM90A1gFKq3MHsW1bCDqIN4yvwkl1DKJ1fY2sqqo0C09s4v
yAzQ9H8vGS0hBaIdN+hxKDGKGqrIZSF15irlJWXMluIsacjll5FMmhsHNv9u/2lR
k/KVyo13DiBq/72KUkyM94hHNKf2o0oRys1gfP0UvQ2sXtNOUqW7JJDQrCMG6LGO
1o7dzwiHMPgC5440r71n
=gWhp
-----END PGP SIGNATURE-----

--Signature=_Thu__27_Jun_2013_17_52_13_+1000_lHW.OblYF2LSlaEq--
