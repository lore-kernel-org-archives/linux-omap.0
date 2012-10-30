From: Felipe Balbi <balbi@ti.com>
Subject: Re: OMAP baseline test results for v3.7-rc3
Date: Tue, 30 Oct 2012 19:27:07 +0200
Message-ID: <20121030172707.GB3993@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1210300229590.12697@utopia.booyaka.com>
 <508FB226.20604@mimc.co.uk>
 <alpine.DEB.2.00.1210301143420.12697@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EB51E84@DBDE01.ent.ti.com>
 <508FE8BA.1080404@ti.com>
 <20121030162727.GG11908@atomide.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:33454 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964929Ab2J3RdF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 30 Oct 2012 13:33:05 -0400
Content-Disposition: inline
In-Reply-To: <20121030162727.GG11908@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>, Paul Walmsley <paul@pwsan.com>, Mark Jackson <mpfj-list@mimc.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 30, 2012 at 09:27:28AM -0700, Tony Lindgren wrote:
> * Vaibhav Hiremath <hvaibhav@ti.com> [121030 07:50]:
> > >=20
> > > MMC is dependent on EDMA-DMA conversion patches from Matt, which he h=
as=20
> > > already submitted to the list recently. So MMC support will come alon=
g with
> > > EDMA support. DMA-EDMA patches are targeted for v3.8, lets see how it=
 goes.
>=20
> This is a bogus dependency, the MMC driver needs to also work
> without DMA.

heh, too bad driver errors out when it doesn't find DMA channels :-)

1869         host->rx_chan =3D dma_request_channel(mask, omap_dma_filter_fn=
, &rx_req);
1870         if (!host->rx_chan) {
1871                 dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA e=
ngine channel %u\n", rx_req);
1872                 ret =3D -ENXIO;
1873                 goto err_irq;
1874         }
1875=20
1876         host->tx_chan =3D dma_request_channel(mask, omap_dma_filter_fn=
, &tx_req);
1877         if (!host->tx_chan) {
1878                 dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA e=
ngine channel %u\n", tx_req);
1879                 ret =3D -ENXIO;
1880                 goto err_irq;
1881         }

in fact, if DMAENGINE isn't enabled, this won't even compile due to
omap_dma_filter_fn() right ?

--=20
balbi

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkA3rAAoJEIaOsuA1yqREWJIP/R3LonEAt42bzJYWo+61Gp+o
g9ElULqeSVbjAZ5joTuib9h6sZ5a4M9iOUxk7xZlPbmwpN8jwRl88OrH+tZMrdm1
Xhn0DtMP/YGdALeCSqrdnwi4EqCPqJlEjVCzUGx6ppRFqPtMlBbUDluZyYn1rrbI
jje5f3MS+U2StXPxsGHK3e45blmaLbNMory3qfvk6GgXvMC7O8p314hDfJGuFVlU
yM0qbLgBvNX78QHulwrsC57CLGE7cVzPz/mO/zIV37Qo8e3tKEe2nq3t1vK8LC14
ouGhIcVj+gIAGENtrmdMminwRCHQIyQI7XPiVMgO2rGOr9hXw19K4glj9RlKH81Z
IC/RQlIdY0DxcUOGracl/Zw6lWwzx8OqzGtZGJS2OyfVGQjPTSaOJs0HybBfpNZS
8QnGSid2VUvx1OmRriqcQ9BIyNJ3HHO3YiVjjkIkJ7xZcJrGig+7+jHNA3mAV33a
Q1S9evLiMsnMKtkTasms9hKDu/ZLZpt1HVmX9WASloPXh7mB3suwcXjkIpeSt0/R
vsgdOR6W1jivNDoG1LXSn7EiAqJZCu9guqSVj70SqnZdGlNazWlS1LY96ille7NN
reStwcLMkktsHchYA+Li7xVQLWdXkbelpuNp0HBgCIcB4IIn0x8dOS9AbCPSXt0m
dD0+R6G69uMn7OnzBS69
=SqTq
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
