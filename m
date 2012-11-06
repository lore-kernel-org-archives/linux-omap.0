From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc3
Date: Tue, 6 Nov 2012 10:05:10 +0200
Message-ID: <20121106080510.GA11178@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1210301143420.12697@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EB51E84@DBDE01.ent.ti.com>
 <508FE8BA.1080404@ti.com>
 <20121030162727.GG11908@atomide.com>
 <20121030172707.GB3993@arwen.pp.htv.fi>
 <20121030175856.GK11908@atomide.com>
 <20121030185102.GC4804@arwen.pp.htv.fi>
 <79CD15C6BA57404B839C016229A409A83EB6361E@DBDE01.ent.ti.com>
 <20121106075726.GA10873@arwen.pp.htv.fi>
 <79CD15C6BA57404B839C016229A409A83EB63A74@DBDE01.ent.ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32792 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754349Ab2KFILT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 03:11:19 -0500
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB63A74@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Mark Jackson <mpfj-list@mimc.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Venkatraman S." <svenkatr@ti.com>, Balaji T K <balajitk@ti.com>

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 06, 2012 at 09:07:47AM +0100, Hiremath, Vaibhav wrote:
> On Tue, Nov 06, 2012 at 13:28:00, Balbi, Felipe wrote:
> > Hi,
> >=20
> > On Tue, Nov 06, 2012 at 07:17:19AM +0100, Hiremath, Vaibhav wrote:
> > > On Wed, Oct 31, 2012 at 00:21:02, Balbi, Felipe wrote:
> > > > Hi,
> > > >=20
> > > > On Tue, Oct 30, 2012 at 10:58:59AM -0700, Tony Lindgren wrote:
> > > > > * Felipe Balbi <balbi@ti.com> [121030 10:34]:
> > > > > > Hi,
> > > > > >=20
> > > > > > On Tue, Oct 30, 2012 at 09:27:28AM -0700, Tony Lindgren wrote:
> > > > > > > * Vaibhav Hiremath <hvaibhav@ti.com> [121030 07:50]:
> > > > > > > > >=20
> > > > > > > > > MMC is dependent on EDMA-DMA conversion patches from Matt=
, which he has=20
> > > > > > > > > already submitted to the list recently. So MMC support wi=
ll come along with
> > > > > > > > > EDMA support. DMA-EDMA patches are targeted for v3.8, let=
s see how it goes.
> > > > > > >=20
> > > > > > > This is a bogus dependency, the MMC driver needs to also work
> > > > > > > without DMA.
> > > > > >=20
> > > > > > heh, too bad driver errors out when it doesn't find DMA channel=
s :-)
> > > > >=20
> > > > > It should just print a warning instead and continue.
> > > > > =20
> > > > > > 1869         host->rx_chan =3D dma_request_channel(mask, omap_d=
ma_filter_fn, &rx_req);
> > > > > > 1870         if (!host->rx_chan) {
> > > > > > 1871                 dev_err(mmc_dev(host->mmc), "unable to obt=
ain RX DMA engine channel %u\n", rx_req);
> > > > > > 1872                 ret =3D -ENXIO;
> > > > > > 1873                 goto err_irq;
> > > > > > 1874         }
> > > > > > 1875=20
> > > > > > 1876         host->tx_chan =3D dma_request_channel(mask, omap_d=
ma_filter_fn, &tx_req);
> > > > > > 1877         if (!host->tx_chan) {
> > > > > > 1878                 dev_err(mmc_dev(host->mmc), "unable to obt=
ain TX DMA engine channel %u\n", tx_req);
> > > > > > 1879                 ret =3D -ENXIO;
> > > > > > 1880                 goto err_irq;
> > > > > > 1881         }
> > > > > >=20
> > > > > > in fact, if DMAENGINE isn't enabled, this won't even compile du=
e to
> > > > > > omap_dma_filter_fn() right ?
> > > > >=20
> > > > > It should, CONFIG_DMADEVICES is optional. If it does not compile,
> > > > > then there's a bug somewhere.
> > > >=20
> > > > you're right, there's a static inline nop for when we don't have om=
ap
> > > > dma engine driver compiled.
> > > >=20
> > > > nevermind.
> > > >=20
> > >=20
> > > Did anybody tried polling mode MMC support on OMAP devices in the
> > > past?
> >=20
> > why are you trying out polling when we have a working interrupt mode ?
> >=20
> The thread started with need of MMC support without EDMA.  So when I
> say polling, I would like to try MMC without DMA support, not to put
> dependency on EDMA-DMA engine migration patches.

I see, so you meant interrupt/PIO mode. That's supposed to be working
and I'm sure Venkat and Balaji test that every now and then.

--=20
balbi

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQmMS2AAoJEIaOsuA1yqRELv4P+gNS6uKkGeraYBXDPyUGPCCu
oJuta+CzLBuL8OchmWRYkN2p58xdnjQ88jlyLsUPhCTyRJeI+kikuzsoIrVLvU7+
W0fs7FXDK6fNUMVjVzu99vkBpzQFJmZsPUjHKmcY744kByAfkNyN8aN9eeps52az
EssWuVqNOdi80Pa/sA1dgNauQaF0qfFpzD1p+OyBSxfffDmVwACn1acuqfn1WGUi
g7Mz1BNznomdse4OfH2O+TEa/R5khvXIJWxCpuCGZhv8NvT83+TfHYaMIfWqcaYm
o3Yo4zj1v6/lMw+ux9J5FXcnJGvhh46p7ULJzcs1Fsc8x9XvErsa6SP+8KD+oxz2
lfTL2vIUSmaEeQC+ZmKD/fQzXrhCW6wnbzr5G1iy2vJaUbaY+je91LLhna9N58DY
uj/wTFcpsORR6CB14NUOPY0OV3DLRy/y06qmXMffesuOjTdI/6dZZjMQx1+76x3z
YEhyPW+3foSvG7uQdXIQMYtDlICLgsZopFT4ROT3VAI0HIMfaBRiZ5Gs/zcs8nDr
53cyb6Aq1Sm/D5pUC6HX8VxWfRl40W2ZtYVtcCQlG2XLQMTAbD433i2itGaAFryG
zw4UHZHbLqh9zdd4iZAGZ7p5V1GE+Z0qyOlAX2Bb2UJ5LeH1diUt0vTI3J59/JH7
ruliyy1Vq7I45M2tUNQH
=Xk5n
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
