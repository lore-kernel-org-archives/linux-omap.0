From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v3 5/7] net: cpsw: Add am33xx MACID readout
Date: Mon, 18 Aug 2014 08:58:40 +0200
Message-ID: <20140818065840.GA12930@pengutronix.de>
References: <1408202315-20006-1-git-send-email-mpa@pengutronix.de>
 <1408202315-20006-6-git-send-email-mpa@pengutronix.de>
 <20140816164647.GA2858@katana>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34958 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbaHRG64 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Aug 2014 02:58:56 -0400
Content-Disposition: inline
In-Reply-To: <20140816164647.GA2858@katana>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: "David S. Miller" <davem@davemloft.net>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Steven Rostedt <rostedt@goodmis.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Aug 16, 2014 at 11:46:48AM -0500, Wolfram Sang wrote:
>=20
> > diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti=
/Makefile
> > index 9cfaab8152be..5a31c2b322ee 100644
> > --- a/drivers/net/ethernet/ti/Makefile
> > +++ b/drivers/net/ethernet/ti/Makefile
> > @@ -8,5 +8,6 @@ obj-$(CONFIG_TI_DAVINCI_EMAC) +=3D davinci_emac.o
> >  obj-$(CONFIG_TI_DAVINCI_MDIO) +=3D davinci_mdio.o
> >  obj-$(CONFIG_TI_DAVINCI_CPDMA) +=3D davinci_cpdma.o
> >  obj-$(CONFIG_TI_CPSW_PHY_SEL) +=3D cpsw-phy-sel.o
> > +obj-$(CONFIG_TI_CPSW_CTRL_MACID) +=3D cpsw-ctrl-macid.o
> >  obj-$(CONFIG_TI_CPSW) +=3D ti_cpsw.o
> >  ti_cpsw-y :=3D cpsw_ale.o cpsw.o cpts.o
>=20
> Leftover from your last series?

Yes thanks, will remove it for the next version.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJT8aQgAAoJEEpcgKtcEGQQE5kP/2eUExjlf/6CYkX6em+e4VdG
SIjpmXKU8yM9wCaVSNE06v5F02QN+eXp1UxFgXGwe2+mqj5C4sblk4ZW+HtUwZ+f
c7Cq9mJAta8eHSKLv0f9JWM3Zq8KLuDikbnPZ4EdB8+rBGoXNi9C+heQT08Llnrr
bmS1vB/X6c0VXF5BsPbB8wX7ClosZ2wa1L8ZoZTcCkCOn+6i5F0Jo76XNhc04cAf
lTMA1O2lb9TSn9GS2gz0JK/v1UWQGnkwNl+4ZmnwWgiN8w/Bn13AFlRPWd4h6tm3
ujhJMH/xzxvivcxkNHqG48l29GnPhngysG2+27gTmnmAMfEUbNsAjY7TZ0MAK8Mm
09IFmAFRtb/pUQG0bkFidm7es0S+r9RlSp/T+NNDS0ri+QG99jVJddIlqLlnKJqf
5fOtrJdkwKEHK5Bgo4wpVuPRWHHqRvn8W+MdwwvvBgRstW3LGEJOXPd09hEFCx2G
Qb7NrXiTlWrGE0gbSLY9kHgT91+ExRhhIURgJ9bscaczzMEoeCZGMDFGRKeKtxG1
FNilMBmFINleC2bWWpTz9IfmAJ9J7/YODxzN94BEsAIJRZ3KC4Ax/xY8t2SBxKYt
+GgSwWBDrtz/nD5f6ybeM/7c7eUscp/eB4K2Ru+r20S3NSpFJukbf1zvpauRRLes
HbyEbLgyQIHn3jorOgNl
=tdMW
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
