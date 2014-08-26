From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v5 5/7] net: cpsw: Add am33xx MACID readout
Date: Tue, 26 Aug 2014 07:55:09 +0200
Message-ID: <20140826055509.GB21770@pengutronix.de>
References: <1408947828-22316-1-git-send-email-mpa@pengutronix.de>
 <1408947828-22316-6-git-send-email-mpa@pengutronix.de>
 <20140825160118.GG17254@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44348 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755535AbaHZFz2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Aug 2014 01:55:28 -0400
Content-Disposition: inline
In-Reply-To: <20140825160118.GG17254@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "David S. Miller" <davem@davemloft.net>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Wolfram Sang <wsa@the-dreams.de>, Steven Rostedt <rostedt@goodmis.org>, Mugunthan V N <mugunthanvnm@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Aug 25, 2014 at 09:01:19AM -0700, Tony Lindgren wrote:
> > diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/c=
psw.c
> > index 0bc2c2a2c236..7c94a0fb24bc 100644
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
>=20
> I think this only works for the first instance of the cpsw?

This works for both cpsw slaves on am335x. It does not work for multiple
cpsw drivers. But we don't have them on am335x. For other platforms this
function may be used in case they have the same register layout.

>=20
> Can the other instances of cpsw use this too and just increment
> some value in it?
>=20
> >  static int cpsw_probe_dt(struct cpsw_platform_data *data,
> >  			 struct platform_device *pdev)
> >  {
> > @@ -1928,8 +1963,14 @@ static int cpsw_probe_dt(struct cpsw_platform_da=
ta *data,
> >  			 PHY_ID_FMT, mdio->name, phyid);
> > =20
> >  		mac_addr =3D of_get_mac_address(slave_node);
> > -		if (mac_addr)
> > +		if (mac_addr) {
> >  			memcpy(slave_data->mac_addr, mac_addr, ETH_ALEN);
> > +		} else {
> > +			ret =3D cpsw_am33xx_cm_get_macid(&pdev->dev, i,
> > +						       slave_data->mac_addr);
> > +			if (ret)
> > +				return ret;
> > +		}
> > =20
> >  		slave_data->phy_if =3D of_get_phy_mode(slave_node);
> >  		if (slave_data->phy_if < 0) {
>=20
> The cpsw_am33xx_cm_get_macid() should only get called based on the
> compatible flag to avoid random register access on other SoCs.
>=20
> So how about add the of_machine_is_compatible("ti,am33xx")
> check here instead and skip calling cpsw_am33xx_cm_get_macid()
> otherwise?
>=20
> That allows adding support for other omaps as we already have
> ti,am4372-cpsw and people have pointed out issues with dra7xx
> already.

Okay, I will move the machine check here instead.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJT/CE8AAoJEEpcgKtcEGQQA7wQAKK33DwcAGuWq8GyMy2eNoDG
Y5R2DohaXGNUpylW/Tr7VTQnw4RxixRKVlN71DJdhmgegFw6OenNkmqutG6PZeex
S3DvNsjg3KlOiQGvhHjyDEkHAiOPCKrc0ixD/XFELSLAB3bZ7OMrAhBccCF2+jTc
eW/sfAqYgZeN++ernWuCydwDYH/mTeUsia+A3PDvgRWtpwfqrW0TnKrNrkbhsdCM
zIs8+z+fH0622kZGKRo5AbMqC1jj+W1z8GP0kfCLe7ci46uff8epI5zGWk0nywqD
K+J5HB7jhvIu2YYoA+NO90ReCqcigZZTo4EoEk0jVXVlB1y5La/rmhv3BDVPQBJr
7i+OJRh8lS2VhxUC7Onk0748yxm9ifw5pGdWWQX/Ohxt9s8/4vSjtbMFKtfDS7xO
6JEh8504zdtXuX9fWAa9sTeDbDd7Ric2f6nTYAqoAaQVmvt7saaFqQx3ms+ABwH9
68K/qFcoPjGaAfT7xEJ91EUOdgOVjL/ZJyYQe+e8v7/bexy6f+EqhltwMF7A/uLu
N0gXb7wE2L/lpdylqOguNHS8Z7WgaCSXMwgbTsSL79O2kgRIQfZK0cWTwNtt2lPd
8ge+34hHSJ1aCpASqbj6k2nHYugqPLZayguNevlbRZApOGf8K8plCzXRyN61o9/Z
1RtKh5vwZCs4w/NcH+Uo
=ziG9
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
