From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v6 5/7] net: cpsw: Add am33xx MACID readout
Date: Tue, 9 Sep 2014 08:05:22 +0200
Message-ID: <20140909060522.GD24081@pengutronix.de>
References: <1410110375-3570-1-git-send-email-mpa@pengutronix.de>
 <1410110375-3570-6-git-send-email-mpa@pengutronix.de>
 <20140908165116.GH3238@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VMt1DrMGOVs3KQwf"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49764 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbaIIGFf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Sep 2014 02:05:35 -0400
Content-Disposition: inline
In-Reply-To: <20140908165116.GH3238@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "David S. Miller" <davem@davemloft.net>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Rostedt <rostedt@goodmis.org>, Mugunthan V N <mugunthanvnm@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de


--VMt1DrMGOVs3KQwf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 08, 2014 at 09:51:17AM -0700, Tony Lindgren wrote:
> * Markus Pargmann <mpa@pengutronix.de> [140907 10:20]:
> > This patch adds a function to get the MACIDs from the am33xx SoC
> > control module registers which hold unique vendor MACIDs. This is only
> > used if of_get_mac_address() fails to get a valid mac address.
> ...
>=20
> > @@ -1928,8 +1960,16 @@ static int cpsw_probe_dt(struct cpsw_platform_da=
ta *data,
> >  			 PHY_ID_FMT, mdio->name, phyid);
> > =20
> >  		mac_addr =3D of_get_mac_address(slave_node);
> > -		if (mac_addr)
> > +		if (mac_addr) {
> >  			memcpy(slave_data->mac_addr, mac_addr, ETH_ALEN);
> > +		} else {
> > +			if (of_machine_is_compatible("ti,am33xx")) {
> > +				ret =3D cpsw_am33xx_cm_get_macid(&pdev->dev, i,
> > +							slave_data->mac_addr);
> > +				if (ret)
> > +					return ret;
> > +			}
> > +		}
> > =20
> >  		slave_data->phy_if =3D of_get_phy_mode(slave_node);
> >  		if (slave_data->phy_if < 0) {
>=20
> Thanks for updating this, this looks more future proof for adding
> the dra7 related patch.
>=20
> For the long run, it probably makes sense to add SoC specific
> compatible values such as "ti,cpsw-am3350" and so on. Then the
> mac address functions can be initialized based on the of_device_id
> entry for .data. The wiring is cleary SoC specific here.

The hardware doesn't differ across the SoCs, so I thought it may be
better to keep one compatible and parse the machine compatible for the
MACID location. But different compatible values are also ok.

>=20
> So for the purpose of this series, I'm fine with this series,
> please feel free to add for this patch:
>=20
> Acked-by: Tony Lindgren <tony@atomide.com>

Thanks.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--VMt1DrMGOVs3KQwf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJUDpiiAAoJEEpcgKtcEGQQz9cQAJAjeqU57PVda0KLTo872VXN
EParWewrWRw4BW6L4EaVG+NEo4Dmi5ZuWxcihp3CEcYc8ZfmTn9hwJnyGoqs8wv3
nBxCFTSlzoG4co7FbwHV24CoxC09IGk0Gd4jGIX9CmT6MyMKqjEEZKqp4X1YAciD
cMflZnWYKEBZ2GWexGiUO4OZE14asPFJOuiYNa5KoyMmQ2gI6N9G2kSC92APQWQQ
fvNNfSh3d3823oaEQ9MUfRI12Onz14LNDcuv+wkg0lLrbhSAkBPhc14Y1ntBlstT
MfW9rCJKYzjQaak1lgCjsqS94c6pRCaXZftHjCLjwLGDaDaiGFjrUQKytf86szH7
E6fubNb2t8T3ls1EHum8TwV1Jwv2u+L9HGIj749otDsVAfjdUjjjBrFgwJahJulK
VTZY5uSm/a0MQuLpA42LxMFpV18sqoWpejGeEvTA6CXp44Ew7Gr7uTn1VmR4F57f
2H4tngeGV9G/pO3NBsZ5IQdbtG+Ypr0a+L7kefU8jlCJ7hsRCMehAVB9LGaTVYnX
4YYUmmBuK3dooIh8k+U8eGB8tBw8Ns61RG7WneBUBWPy2KjOqcm2eDZqRTSEFH64
oruWLU2EM1aLEzoiDL6zXGrhNKJzgXKZpPM0a+q1MVtH+9XtOQ86vP+nPPg+69SV
RzTlc6gjoGG1txk5YJp/
=/qoz
-----END PGP SIGNATURE-----

--VMt1DrMGOVs3KQwf--
