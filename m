From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc3
Date: Tue, 30 Oct 2012 20:51:02 +0200
Message-ID: <20121030185102.GC4804@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com>
 <508FB226.20604@mimc.co.uk>
 <alpine.DEB.2.00.1210301143420.12697@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EB51E84@DBDE01.ent.ti.com>
 <508FE8BA.1080404@ti.com>
 <20121030162727.GG11908@atomide.com>
 <20121030172707.GB3993@arwen.pp.htv.fi>
 <20121030175856.GK11908@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37752 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752651Ab2J3S5A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 14:57:00 -0400
Content-Disposition: inline
In-Reply-To: <20121030175856.GK11908@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, Vaibhav Hiremath <hvaibhav@ti.com>, Paul Walmsley <paul@pwsan.com>, Mark Jackson <mpfj-list@mimc.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 30, 2012 at 10:58:59AM -0700, Tony Lindgren wrote:
> * Felipe Balbi <balbi@ti.com> [121030 10:34]:
> > Hi,
> >=20
> > On Tue, Oct 30, 2012 at 09:27:28AM -0700, Tony Lindgren wrote:
> > > * Vaibhav Hiremath <hvaibhav@ti.com> [121030 07:50]:
> > > > >=20
> > > > > MMC is dependent on EDMA-DMA conversion patches from Matt, which =
he has=20
> > > > > already submitted to the list recently. So MMC support will come =
along with
> > > > > EDMA support. DMA-EDMA patches are targeted for v3.8, lets see ho=
w it goes.
> > >=20
> > > This is a bogus dependency, the MMC driver needs to also work
> > > without DMA.
> >=20
> > heh, too bad driver errors out when it doesn't find DMA channels :-)
>=20
> It should just print a warning instead and continue.
> =20
> > 1869         host->rx_chan =3D dma_request_channel(mask, omap_dma_filte=
r_fn, &rx_req);
> > 1870         if (!host->rx_chan) {
> > 1871                 dev_err(mmc_dev(host->mmc), "unable to obtain RX D=
MA engine channel %u\n", rx_req);
> > 1872                 ret =3D -ENXIO;
> > 1873                 goto err_irq;
> > 1874         }
> > 1875=20
> > 1876         host->tx_chan =3D dma_request_channel(mask, omap_dma_filte=
r_fn, &tx_req);
> > 1877         if (!host->tx_chan) {
> > 1878                 dev_err(mmc_dev(host->mmc), "unable to obtain TX D=
MA engine channel %u\n", tx_req);
> > 1879                 ret =3D -ENXIO;
> > 1880                 goto err_irq;
> > 1881         }
> >=20
> > in fact, if DMAENGINE isn't enabled, this won't even compile due to
> > omap_dma_filter_fn() right ?
>=20
> It should, CONFIG_DMADEVICES is optional. If it does not compile,
> then there's a bug somewhere.

you're right, there's a static inline nop for when we don't have omap
dma engine driver compiled.

nevermind.

--=20
balbi

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkCGWAAoJEIaOsuA1yqREZ0wP/1VqFKLSn7NEKBiA5wF8Ellf
+RmJdufxLGoLJNzt828Yah3zG4sKqc1LHDfSq496QkG5ZNRfYj1AhU1tnPzztH6x
eN+8kH3t/m5u6Xbt+tAAloJw3CMN+UT3ozhuAr13niJ4jplJPuXM8LgrckG5dwfc
lcNoRzb6vacaX2kQYI+FhpyIUUtz7ZSmW/iZCf40PpLxRqTxFnQS1WaHISEdRCwv
WSZiiAUDtbe8uHGWyV29QKDandYi1yVe5B5z91dVOZgKmJq+se92+EBD++E2DVVV
DhRnjZACItzaJ3ho/NMgAnt3Ha6BRAClnRwSPOjZxmqJTfcT/jjIi309ppyOOHDM
teryGsUe/MpQjBuHKRJJcX1Qm0zX3vby8EKHiHb1YuqOF+D6eMzPq4jzU/z2gso5
g0zfJ4w7l6LFPqBLiKwsH7jikmsF05jBEWsF+/fFku5tQzUn9ClszPUBiJ2GEuaY
tGbQ96JP4Dt00DSeEuG/EGdPwTLP183PfGHUhms/jM5ZcS0hcwKBtP3886FVnRRr
r2uU84oCNpI1WkGMR0CMQcgME3VeXttGo0MnYO5DH3ab+Miy6pEwMKFCf4DcaI0m
1l/umY/t3f8be75vxo8w45XcNXG3hOvWLqEt24Z/laF7HSsTAipEnRQtYex5KJs1
+EiExSuNCyWxAVsQ24xe
=F8xi
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
