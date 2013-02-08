From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH V2 1/2] ARM: dts: OMAP2+: Add SDMA controller bindings
 and nodes
Date: Fri, 8 Feb 2013 09:53:56 +0200
Message-ID: <20130208075356.GC21879@arwen.pp.htv.fi>
References: <1360285506-22354-1-git-send-email-jon-hunter@ti.com>
 <1360285506-22354-2-git-send-email-jon-hunter@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46407 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759981Ab3BHHyS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 8 Feb 2013 02:54:18 -0500
Content-Disposition: inline
In-Reply-To: <1360285506-22354-2-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Vinod Koul <vinod.koul@intel.com>, Russell King <linux@arm.linux.org.uk>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Matt Porter <mporter@ti.com>, Felipe Balbi <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Balaji T K <balajitk@ti.com>

--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 07, 2013 at 07:05:05PM -0600, Jon Hunter wrote:
> Add SDMA controller binding for OMAP2+ devices and populate DMA client
> information for SPI and MMC periperhal on OMAP3+ devices. Please note
> that OMAP24xx devices do not have SPI and MMC bindings available yet and
> so DMA client information is not populated.
>=20
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

already given before, but here you go:

Reviewed-by: Felipe Balbi <balbi@ti.com>

--=20
balbi

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRFK8TAAoJEIaOsuA1yqREcFQP/AhlB3ei53+Y1Ry6VMa45Fan
skmPnvHz3s6haVm+7bBOZEhHyUVDqTnqQwVIJVA7HsExVa0LJovNXLs/7rHBltSj
QhGtEAbC04LYC1dZwBbnTWqvlbT3XDExdrHhf03n6cSfUX3P/3sQ0YxteN8TFKXh
n/uSlNK2mF1b6B31GTbq7RhEqGyEUbc7SsxJBtkIijtY5kmKcm8ESx6cKTnnAFQL
Ox/TkhKRob7BGMA/7+fAiNCUGst++qXQGA65YHpCvwEoIHrp7/n7db7qA8TzkLex
9dXl2/CrcAJ4ER9+7hUDpLpFniZijfOJ4HWoNuHMEa/Hok4XeU5IZW4kktJQwbWR
es2mtLOT5MSgsTvAMqOjAE+tQME3z7GQx4eEwGQDmY3Gse2UA5TiWPR8MsZNlony
L5XikakiDwGcoKrTaTsFmuw+e3wbkhTSWunb1ipg5uh94/icBc64mO7MhCqLEVSF
UzHLGmjak/ry/BIg7r1z79DD9I+trits0CK4ID/aPUWNtaB/gWbgbOHATdqx75Rj
NJkJDNzf4tSVQl84/nNBvdhGDbBuJcb+DeB3FX2VIR3y2gjfAF3H67MGU2wKxBHr
H+NlYCWrbfBFrsvIv85qTzsglw2VFFjzmoEg51/26U8I0/YKrNNVNE0VSv8gVjn9
oduzvsr+MlbAVsYmsFZs
=qS7y
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
