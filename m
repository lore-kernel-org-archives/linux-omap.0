From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v4 5/7] net: cpsw: Add am33xx MACID readout
Date: Sun, 24 Aug 2014 17:44:06 +0200
Message-ID: <20140824154406.GF23823@pengutronix.de>
References: <1408600314-19824-1-git-send-email-mpa@pengutronix.de>
 <1408600314-19824-6-git-send-email-mpa@pengutronix.de>
 <53F5BA31.6030703@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hTiIB9CRvBOLTyqY"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53516 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752766AbaHXPoh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 24 Aug 2014 11:44:37 -0400
Content-Disposition: inline
In-Reply-To: <53F5BA31.6030703@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Rostedt <rostedt@goodmis.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de


--hTiIB9CRvBOLTyqY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2014 at 02:51:53PM +0530, Mugunthan V N wrote:
> On Thursday 21 August 2014 11:21 AM, Markus Pargmann wrote:
> > This patch adds a function to get the MACIDs from the am33xx SoC
> > control module registers which hold unique vendor MACIDs. This is only
> > used if of_get_mac_address() fails to get a valid mac address.
> >
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > Reviewed-by: Wolfram Sang <wsa@the-dreams.de>
> > Tested-by: Steven Rostedt <rostedt@goodmis.org>
> > ---
> >  Documentation/devicetree/bindings/net/cpsw.txt |  4 +++
> >  drivers/net/ethernet/ti/Kconfig                |  2 ++
> >  drivers/net/ethernet/ti/cpsw.c                 | 46 ++++++++++++++++++=
++++++--
> >  3 files changed, 50 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/cpsw.txt b/Documenta=
tion/devicetree/bindings/net/cpsw.txt
> > index 107caf174a0e..33fe8462edf4 100644
> > --- a/Documentation/devicetree/bindings/net/cpsw.txt
> > +++ b/Documentation/devicetree/bindings/net/cpsw.txt
> > @@ -24,6 +24,8 @@ Optional properties:
> >  - ti,hwmods		: Must be "cpgmac0"
> >  - no_bd_ram		: Must be 0 or 1
> >  - dual_emac		: Specifies Switch to act as Dual EMAC
> > +- syscon		: Phandle to the system control device node, which is
> > +			  the control module device of the am33x
> > =20
> >  Slave Properties:
> >  Required properties:
> > @@ -57,6 +59,7 @@ Examples:
> >  		active_slave =3D <0>;
> >  		cpts_clock_mult =3D <0x80000000>;
> >  		cpts_clock_shift =3D <29>;
> > +		syscon =3D <&cm>;
> >  		cpsw_emac0: slave@0 {
> >  			phy_id =3D <&davinci_mdio>, <0>;
> >  			phy-mode =3D "rgmii-txid";
> > @@ -85,6 +88,7 @@ Examples:
> >  		active_slave =3D <0>;
> >  		cpts_clock_mult =3D <0x80000000>;
> >  		cpts_clock_shift =3D <29>;
> > +		syscon =3D <&cm>;
> >  		cpsw_emac0: slave@0 {
> >  			phy_id =3D <&davinci_mdio>, <0>;
> >  			phy-mode =3D "rgmii-txid";
> > diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/=
Kconfig
> > index 1769700a6070..5d8cb7956113 100644
> > --- a/drivers/net/ethernet/ti/Kconfig
> > +++ b/drivers/net/ethernet/ti/Kconfig
> > @@ -62,6 +62,8 @@ config TI_CPSW
> >  	select TI_DAVINCI_CPDMA
> >  	select TI_DAVINCI_MDIO
> >  	select TI_CPSW_PHY_SEL
> > +	select MFD_SYSCON
> > +	select REGMAP
> >  	---help---
> >  	  This driver supports TI's CPSW Ethernet Switch.
> > =20
> > diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/c=
psw.c
> > index 0bc2c2a2c236..aaf8a42f9633 100644
> > --- a/drivers/net/ethernet/ti/cpsw.c
> > +++ b/drivers/net/ethernet/ti/cpsw.c
> > @@ -33,6 +33,8 @@
> >  #include <linux/of_net.h>
> >  #include <linux/of_device.h>
> >  #include <linux/if_vlan.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/regmap.h>
> > =20
> >  #include <linux/pinctrl/consumer.h>
> > =20
> > @@ -1816,6 +1818,39 @@ static void cpsw_slave_init(struct cpsw_slave *s=
lave, struct cpsw_priv *priv,
> >  	slave->port_vlan =3D data->dual_emac_res_vlan;
> >  }
> > =20
> > +#define AM33XX_CTRL_MAC_LO_REG(id) (0x630 + 0x8 * id)
> > +#define AM33XX_CTRL_MAC_HI_REG(id) (0x630 + 0x8 * id + 0x4)
> > +
> > +static int cpsw_am33xx_cm_get_macid(struct device *dev, int slave,
> > +		u8 *mac_addr)
> > +{
> > +	u32 macid_lo;
> > +	u32 macid_hi;
> > +	struct regmap *syscon;
> > +
> > +	if (!of_machine_is_compatible("ti,am33xx"))
> > +		return 0;
> > +
> > +	syscon =3D syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
> > +	if (IS_ERR(syscon)) {
> > +		if (PTR_ERR(syscon) =3D=3D -ENODEV)
> > +			return 0;
> > +		return PTR_ERR(syscon);
> > +	}
> > +
> > +	regmap_read(syscon, AM33XX_CTRL_MAC_LO_REG(slave), &macid_lo);
> > +	regmap_read(syscon, AM33XX_CTRL_MAC_HI_REG(slave), &macid_hi);
> > +
> > +	mac_addr[5] =3D (macid_lo >> 8) & 0xff;
> > +	mac_addr[4] =3D macid_lo & 0xff;
> > +	mac_addr[3] =3D (macid_hi >> 24) & 0xff;
> > +	mac_addr[2] =3D (macid_hi >> 16) & 0xff;
> > +	mac_addr[1] =3D (macid_hi >> 8) & 0xff;
> > +	mac_addr[0] =3D macid_hi & 0xff;
> > +
> > +	return 0;
> > +}
> > +
> >  static int cpsw_probe_dt(struct cpsw_platform_data *data,
> >  			 struct platform_device *pdev)
> >  {
> > @@ -1928,8 +1963,15 @@ static int cpsw_probe_dt(struct cpsw_platform_da=
ta *data,
> >  			 PHY_ID_FMT, mdio->name, phyid);
> > =20
> >  		mac_addr =3D of_get_mac_address(slave_node);
> > -		if (mac_addr)
> > -			memcpy(slave_data->mac_addr, mac_addr, ETH_ALEN);
> > +		if (mac_addr) {
> > +			memcpy(slave_data->mac_addr, mac_addr,
> > +					ETH_ALEN);
>=20
> Alignment should match open parenthesis

Thanks, fixed as the rest of the driver is also aligned to the opening
paranthesis.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--hTiIB9CRvBOLTyqY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJT+ghGAAoJEEpcgKtcEGQQSn4QALb+YeWwzJGGzzPEHwTWkJoD
D5SHZTxae1ySyGrWVQPbTdVu59SDxjZvZUsKYmbsRRotuBwIN/4Gt5hl88QFUa0D
YBMRD7qleVNVbBTfTebroaHomF0j9vP1UPV+qIQNMNFiok3dk0JC0DqPAkiQLl1z
MAuZgJAnf29ZeS2u6NsDUp4rgUtcfY46fh8BU6fobqosWZbQ/mYc9VlYc59/Prwa
u+MDV0V76Apsvhv/0Bkb4P3YPnCJ+qDul8ttOTHJGXRPFeMdTBjlRkERXTmwNtkB
bxaQJzh55nZ+VRkFTOUpXapS+255iN22Kj1o9VyEh/ykGSisO2TIBzQnJ0f6xsuB
R0QZ0/YwIrbC0X0oD1asVWVtAMPxCFrk0hIJAwvW5MLdy6y6EIElSgrTd6Ky4cNg
rYzIpcUoWCcKABQZOXiUiJH6S4XZ4oX3/VGK5EYt4LOAzG1g3XeZDNYIZLqcdFWD
Rivx0gALpvaUOpwbsGn7DtPS/XpLQ+YAwIvi/h3Le3kjOKY0iCTm8LJeFzSfDogM
RqFrf2xBAc4mcVkvFGLeDePoVW+k3IVxlxhCcbycKcqxI4fmmMCC9j1pGbpuZR84
VbWj0PDWfUDaeIUipWH9T2zKBR5Mx0YpXsx3H3MucJKhoh+MQBQcOFnY+blnHOwu
I7qxvfQerszIlpQNKPSA
=bPra
-----END PGP SIGNATURE-----

--hTiIB9CRvBOLTyqY--
