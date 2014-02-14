From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 4/6] net: cpsw: Use cpsw-ctrl-macid driver
Date: Fri, 14 Feb 2014 10:23:44 +0100
Message-ID: <20140214092344.GM31787@pengutronix.de>
References: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
 <1387385242-1161-5-git-send-email-mpa@pengutronix.de>
 <20140213193702.GE17650@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35396 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752097AbaBNJXt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Feb 2014 04:23:49 -0500
Content-Disposition: inline
In-Reply-To: <20140213193702.GE17650@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

Hi Uwe,

On Thu, Feb 13, 2014 at 08:37:02PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello Markus,
>=20
> On Wed, Dec 18, 2013 at 05:47:20PM +0100, Markus Pargmann wrote:
> > Use ctrl-macid driver to obtain the macids stored in the processor.=
 This
> > is only done when defined in DT.
> >=20
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/net/cpsw.txt |  5 +++++
> >  drivers/net/ethernet/ti/cpsw.c                 | 18 ++++++++++++++=
----
> >  drivers/net/ethernet/ti/cpsw.h                 |  2 ++
> >  3 files changed, 21 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/cpsw.txt b/Docum=
entation/devicetree/bindings/net/cpsw.txt
> > index c39f077..b95c38b 100644
> > --- a/Documentation/devicetree/bindings/net/cpsw.txt
> > +++ b/Documentation/devicetree/bindings/net/cpsw.txt
> > @@ -34,6 +34,11 @@ Required properties:
> >  Optional properties:
> >  - dual_emac_res_vlan	: Specifies VID to be used to segregate the p=
orts
> >  - mac-address		: Specifies slave MAC address
> > +- ti,mac-address-ctrl	: When cpsw-ctrl-macid support is compiledin=
, this can
> > +			  be set to a phandle with one argument, see
> > +			  cpsw-ctrl-macid.txt. If this method fails, cpsw falls
> > +			  back to mac-address or random mac-address.
> > +
> > =20
> >  Note: "ti,hwmods" field is used to fetch the base address and irq
> >  resources from TI, omap hwmod data base during device registration=
=2E
> > diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/=
ti/cpsw.c
> > index 5120d9c..382d793 100644
> > --- a/drivers/net/ethernet/ti/cpsw.c
> > +++ b/drivers/net/ethernet/ti/cpsw.c
> > @@ -1804,9 +1804,16 @@ static int cpsw_probe_dt(struct cpsw_platfor=
m_data *data,
> >  		snprintf(slave_data->phy_id, sizeof(slave_data->phy_id),
> >  			 PHY_ID_FMT, mdio->name, phyid);
> > =20
> > -		mac_addr =3D of_get_mac_address(slave_node);
> > -		if (mac_addr)
> > -			memcpy(slave_data->mac_addr, mac_addr, ETH_ALEN);
> > +		ret =3D cpsw_ctrl_macid_read(slave_node, slave_data->mac_addr);
> > +		if (ret) {
> > +			if (ret =3D=3D -EPROBE_DEFER)
> > +				return ret;
> > +
> > +			mac_addr =3D of_get_mac_address(slave_node);
> > +			if (mac_addr)
> > +				memcpy(slave_data->mac_addr, mac_addr,
> > +						ETH_ALEN);
> > +		}
> I'd do it the other way round: Use the contents from an explicit
> "mac-address" or "local-mac-address" property (i.e. of_get_mac_addres=
s)
> and if that doesn't return anything use the mac-address-ctrl as
> fallback.

Yes you are right. In this case this wouldn't even influence any boots
with u-boot which already set the correct mac-address property.

I will fix this.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
