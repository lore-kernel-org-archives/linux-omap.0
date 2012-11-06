From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc3
Date: Tue, 6 Nov 2012 09:58:00 +0200
Message-ID: <20121106075726.GA10873@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com>
 <508FB226.20604@mimc.co.uk>
 <alpine.DEB.2.00.1210301143420.12697@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EB51E84@DBDE01.ent.ti.com>
 <508FE8BA.1080404@ti.com>
 <20121030162727.GG11908@atomide.com>
 <20121030172707.GB3993@arwen.pp.htv.fi>
 <20121030175856.GK11908@atomide.com>
 <20121030185102.GC4804@arwen.pp.htv.fi>
 <79CD15C6BA57404B839C016229A409A83EB6361E@DBDE01.ent.ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="V0207lvV8h4k8FAm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34651 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753667Ab2KFIEL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Nov 2012 03:04:11 -0500
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB6361E@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Mark Jackson <mpfj-list@mimc.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 06, 2012 at 07:17:19AM +0100, Hiremath, Vaibhav wrote:
> On Wed, Oct 31, 2012 at 00:21:02, Balbi, Felipe wrote:
> > Hi,
> >=20
> > On Tue, Oct 30, 2012 at 10:58:59AM -0700, Tony Lindgren wrote:
> > > * Felipe Balbi <balbi@ti.com> [121030 10:34]:
> > > > Hi,
> > > >=20
> > > > On Tue, Oct 30, 2012 at 09:27:28AM -0700, Tony Lindgren wrote:
> > > > > * Vaibhav Hiremath <hvaibhav@ti.com> [121030 07:50]:
> > > > > > >=20
> > > > > > > MMC is dependent on EDMA-DMA conversion patches from Matt, wh=
ich he has=20
> > > > > > > already submitted to the list recently. So MMC support will c=
ome along with
> > > > > > > EDMA support. DMA-EDMA patches are targeted for v3.8, lets se=
e how it goes.
> > > > >=20
> > > > > This is a bogus dependency, the MMC driver needs to also work
> > > > > without DMA.
> > > >=20
> > > > heh, too bad driver errors out when it doesn't find DMA channels :-)
> > >=20
> > > It should just print a warning instead and continue.
> > > =20
> > > > 1869         host->rx_chan =3D dma_request_channel(mask, omap_dma_f=
ilter_fn, &rx_req);
> > > > 1870         if (!host->rx_chan) {
> > > > 1871                 dev_err(mmc_dev(host->mmc), "unable to obtain =
RX DMA engine channel %u\n", rx_req);
> > > > 1872                 ret =3D -ENXIO;
> > > > 1873                 goto err_irq;
> > > > 1874         }
> > > > 1875=20
> > > > 1876         host->tx_chan =3D dma_request_channel(mask, omap_dma_f=
ilter_fn, &tx_req);
> > > > 1877         if (!host->tx_chan) {
> > > > 1878                 dev_err(mmc_dev(host->mmc), "unable to obtain =
TX DMA engine channel %u\n", tx_req);
> > > > 1879                 ret =3D -ENXIO;
> > > > 1880                 goto err_irq;
> > > > 1881         }
> > > >=20
> > > > in fact, if DMAENGINE isn't enabled, this won't even compile due to
> > > > omap_dma_filter_fn() right ?
> > >=20
> > > It should, CONFIG_DMADEVICES is optional. If it does not compile,
> > > then there's a bug somewhere.
> >=20
> > you're right, there's a static inline nop for when we don't have omap
> > dma engine driver compiled.
> >=20
> > nevermind.
> >=20
>=20
> Did anybody tried polling mode MMC support on OMAP devices in the
> past?

why are you trying out polling when we have a working interrupt mode ?

--=20
balbi

--V0207lvV8h4k8FAm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmMMIAAoJEIaOsuA1yqREIvwP/0rL5nppxZ7Fp0bxt3w2KmtX
zN4mkN+DAY5ep0u1hQJ3Z+yH6fpDfieOoaizDats3VnG6uF4UqnAoAgG9U1xDzVb
SFD8MH7adyuVstIYm40WObyTAzDzYM+8PUOYKEZnoqQVS6hZeNFUbMEGLwQRBeAt
pZ5Mq0CS4R7E8CICEFYrjDvglsVf4wdOReKK4WhQqWa8zL0YmTK7RXzmfwYmc7VE
a92AhFuQX0spr7r6zYZbuDbnyqxdLj+p3IU5rLo1BOM/VI80bA2WMpvk0UoYlKkr
PRYr5Q0tcqNpoaPWyW34eLI2+sVIX8VDs+22o+NudIZPyD8SusigmefAfSttrmw/
I8Tw1ztaMRMLynGJ0VQLMyTsh2Gp9FkwLvTzaXbMR0oxButk04cqRyaZbIDTh7gC
1UFazMjHrUtpOEfjmhyZog7GSQxkQmEHh3slw+QUrC+zhqE/jWj6/euoZ8QoWapw
7cSV2364WM8KaSzLC+h+KeP4uX/84WVABnd7aNEL6KubBJxQ8Vl/A544MKHKMdja
Ki4TQh/jE+78X28tqp/TlP8Y+sSrhlsWr1JAB/46jxvfoLs/F3TfpEr02csW4gMR
7aH6XZJPuZg0V7GjpTDmFVqKMTUN1Y0aSxCu7FF4am7GPJQjbo40BYR7FtKqTUbe
4Gu6ArDs9DLDCq4cWRy7
=uiS2
-----END PGP SIGNATURE-----

--V0207lvV8h4k8FAm--
