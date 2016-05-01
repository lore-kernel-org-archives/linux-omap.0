From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 5/6] HSI: omap_ssi: built omap_ssi and omap_ssi_port into
 one module
Date: Sun, 1 May 2016 21:34:10 +0200
Message-ID: <20160501193409.GA29870@earth>
References: <1461982153-19139-1-git-send-email-sre@kernel.org>
 <1461982153-19139-6-git-send-email-sre@kernel.org>
 <20160501094349.GE14243@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160501094349.GE14243@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
List-Id: linux-omap@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, May 01, 2016 at 11:43:49AM +0200, Pavel Machek wrote:
> > +++ b/drivers/hsi/controllers/Makefile
> > @@ -2,5 +2,5 @@
> >  # Makefile for HSI controllers drivers
> >  #
> > =20
> > -obj-$(CONFIG_OMAP_SSI)		+=3D omap_ssi.o
> > -obj-$(CONFIG_OMAP_SSI_PORT)	+=3D omap_ssi_port.o
> > +omap_ssi-objs		+=3D omap_ssi_core.o omap_ssi_port.o
> > +obj-$(CONFIG_OMAP_SSI)	+=3D omap_ssi.o
>=20
> Can you simply do
>=20
> obj-$(CONFIG_OMAP_SSI)       +=3D  omap_ssi_core.o omap_ssi_port.o

No, that would result in omap_ssi_core.ko and omap_ssi_port.ko if
CONFIG_OMAP_SSI is enabled. Basically it's an optimized variant of
the current behaviour, but it still builds two modules.

-- Sebastian

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXJlovAAoJENju1/PIO/qarVQQAJkz+RlejDGOIcbmz0PZOfKW
3e+0Dd/JtZ/Sxxe0UuMVSA9r7Ln6lrbi+2oaeJ4dfccicOLlz0WhkSHUzg+TjXAz
i88LKPHOOfU9JR7PqBYll6cQbhoaOiqKufTIJYXDtUPzmFznleZQzRixjagqLp9F
uB9HRYHwrOBrVPE+WGuD2QQa96aQOr151Awv6hrIbC79FZk1MpaGQSnd0N1/ELKB
xj1vxegmJ+1MD9jpRcn7hhdeONd8OguSGNp1yKRJ4hioIC7zoblLg581uT+SAHk/
aYrSMVYHA5G1p2QpWeD7TB6chfJkJC1+ztRommT9RV9AU9AHyjGtokfSbxxenrfi
EPxEKfytGDU+6/P7bt5t7SidORCEHRDbORwt61xhq3OqLlkBnskV/an8TXU5Amz4
z0ZyWQz223eYvBrmgEjaH32lBe0Uy9G5dl5nK+Qp1pF/JvnrFbwVbaR2+LDIUX9s
HEMuAUf2GliXdE7eOiCYe+TPmAy1cxkpPL3ZweACiZHNvudmTiaovOUgRD0lznJF
1kMucoxHgeHEt6GU39krRmx2xkKL8lThtblGK+mlO6hFN9tWAwn+sEV72BPp80PO
gT6ifA5ZiQ8nreoQebNHATRExuNCgWOUnTBvMamfcC0A97IMZjzu4OzM66aaYuVj
YR26K3uZaUwxBX9AcUya
=03AO
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
