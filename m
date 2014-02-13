From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 3/6] net: cpsw: Add control-module macid driver
Date: Thu, 13 Feb 2014 20:44:31 +0100
Message-ID: <20140213194431.GF17650@pengutronix.de>
References: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
 <1387385242-1161-4-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1387385242-1161-4-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 18, 2013 at 05:47:19PM +0100, Markus Pargmann wrote:
> This driver extracts the hardware macid from the control module of
> am335x processors. It exports a function cpsw_ctrl_macid_read for cps=
w
> to get the macid from within the processor.
>=20
> This driver is not used, unless it is defined in DT and referenced by=
 a
> cpsw slave with a phandle.
>=20
> Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> ---
>  .../devicetree/bindings/net/cpsw-ctrl-macid.txt    |  31 +++++
>  drivers/net/ethernet/ti/Kconfig                    |   8 ++
>  drivers/net/ethernet/ti/Makefile                   |   1 +
>  drivers/net/ethernet/ti/cpsw-ctrl-macid.c          | 138 +++++++++++=
++++++++++
>  4 files changed, 178 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/cpsw-ctrl-m=
acid.txt
>  create mode 100644 drivers/net/ethernet/ti/cpsw-ctrl-macid.c
>=20
> diff --git a/Documentation/devicetree/bindings/net/cpsw-ctrl-macid.tx=
t b/Documentation/devicetree/bindings/net/cpsw-ctrl-macid.txt
> new file mode 100644
> index 0000000..abff2af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/cpsw-ctrl-macid.txt
> @@ -0,0 +1,31 @@
> +TI CPSW ctrl macid Devicetree bindings
> +--------------------------------------
> +
> +Required properties:
> + - compatible		: Should be "ti,am3352-cpsw-ctrl-macid"
> + - reg			: physical base address and size of the cpsw
> +			  registers map
> + - reg-names		: names of the register map given in "reg" node
> + - #ti,cpsw-ctrl-macid	: Should be <1>
#ti,mac-address-ctrl-cells?

> +
> +When used from cpsw, "ti,mac-address-ctrl" should be a phandle to th=
is device
> +node with one argument, 0 or 1 to select the macid 0 or 1.
> +
> +Examples:
> +
> +	cpsw_ctrl_macid: cpsw-ctrl-macid@44e10630 {
> +		compatible =3D "ti,am3352-cpsw-ctrl-macid";
> +		#ti,mac-address-ctrl-cells =3D <1>;
> +		reg =3D <0x44e10630 0x16>;
s/0x16/0x10/

> +		reg-names =3D "ctrl-macid";
> +	};
> +
> +Used in cpsw slave nodes like this:
> +
> +	cpsw_emac0: slave@4a100200 {
> +		ti,mac-address-ctrl =3D <&cpsw_ctrl_macid 0>;
> +	};
> +
> +	cpsw_emac1: slave@4a100300 {
> +		ti,mac-address-ctrl =3D <&cpsw_ctrl_macid 1>;
> +	};
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/t=
i/Kconfig
> index 53150c2..24819ef 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -56,12 +56,20 @@ config TI_CPSW_PHY_SEL
>  	  This driver supports configuring of the phy mode connected to
>  	  the CPSW.
> =20
> +config TI_CPSW_CTRL_MACID
> +	boolean "TI CPSW internal MACID support"
> +	depends on TI_CPSW
> +	---help---
> +	  This driver supports reading the hardcoded MACID from am33xx
> +	  processors control module.
> +
Would it be nicer to put this after the TI_CPSW definition. (Think
$(make config).)

>  config TI_CPSW
>  	tristate "TI CPSW Switch Support"
>  	depends on ARM && (ARCH_DAVINCI || SOC_AM33XX)
>  	select TI_DAVINCI_CPDMA
>  	select TI_DAVINCI_MDIO
>  	select TI_CPSW_PHY_SEL
> +	select TI_CPSW_CTRL_MACID
If TI_CPSW selects TI_CPSW_CTRL_MACID the latter doesn't need to depend
on the former. So this optin is user visible but never
user-(de)selectable. I'd say drop the Kconfig symbol and just add
cpsw-ctrl-macid.o to ti_cpsw-y in the Makefile (or really make it
optional).

>  	---help---
>  	  This driver supports TI's CPSW Ethernet Switch.
> =20
> diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/=
ti/Makefile
> index 9cfaab8..5a31c2b 100644
> --- a/drivers/net/ethernet/ti/Makefile
> +++ b/drivers/net/ethernet/ti/Makefile
> @@ -8,5 +8,6 @@ obj-$(CONFIG_TI_DAVINCI_EMAC) +=3D davinci_emac.o
>  obj-$(CONFIG_TI_DAVINCI_MDIO) +=3D davinci_mdio.o
>  obj-$(CONFIG_TI_DAVINCI_CPDMA) +=3D davinci_cpdma.o
>  obj-$(CONFIG_TI_CPSW_PHY_SEL) +=3D cpsw-phy-sel.o
> +obj-$(CONFIG_TI_CPSW_CTRL_MACID) +=3D cpsw-ctrl-macid.o
>  obj-$(CONFIG_TI_CPSW) +=3D ti_cpsw.o
>  ti_cpsw-y :=3D cpsw_ale.o cpsw.o cpts.o
> diff --git a/drivers/net/ethernet/ti/cpsw-ctrl-macid.c b/drivers/net/=
ethernet/ti/cpsw-ctrl-macid.c
> new file mode 100644
> index 0000000..e18c957
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/cpsw-ctrl-macid.c
> @@ -0,0 +1,138 @@
> +/* CPSW Control Module MACID driver
> + *
> + * Copyright (C) 2013 Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warran=
ty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +
> +#include "cpsw.h"
> +
> +#define AM33XX_CTRL_MAC_LO_REG(id) (0x8 * id)
> +#define AM33XX_CTRL_MAC_HI_REG(id) (0x8 * id + 0x4)
> +
> +struct cpsw_ctrl_macid {
> +	struct device *dev;
> +	u8 __iomem *ctrl_macid;
> +	void (*cpsw_macid_get)(struct cpsw_ctrl_macid *priv, int slave,
> +			u8 *mac_addr);
> +};
> +
> +
> +static void cpsw_ctrl_get_macid(struct cpsw_ctrl_macid *priv, int sl=
ave,
> +		u8 *mac_addr)
> +{
> +	u32 macid_lo;
> +	u32 macid_hi;
> +
> +	macid_lo =3D readl(priv->ctrl_macid + AM33XX_CTRL_MAC_LO_REG(slave)=
);
> +	macid_hi =3D readl(priv->ctrl_macid + AM33XX_CTRL_MAC_HI_REG(slave)=
);
> +
> +	mac_addr[5] =3D (macid_lo >> 8) & 0xff;
> +	mac_addr[4] =3D macid_lo & 0xff;
> +	mac_addr[3] =3D (macid_hi >> 24) & 0xff;
> +	mac_addr[2] =3D (macid_hi >> 16) & 0xff;
> +	mac_addr[1] =3D (macid_hi >> 8) & 0xff;
> +	mac_addr[0] =3D macid_hi & 0xff;
> +}
> +
> +static struct platform_driver cpsw_ctrl_macid_driver;
> +
> +static int match(struct device *dev, void *data)
> +{
> +	struct device_node *node =3D (struct device_node *)data;
> +
> +	return dev->of_node =3D=3D node &&
> +		dev->driver =3D=3D &cpsw_ctrl_macid_driver.driver;
> +}
> +
> +int cpsw_ctrl_macid_read(struct device_node *np, u8 *mac_addr)
> +{
> +	struct device *ctrl_dev;
> +	struct cpsw_ctrl_macid *priv;
> +	struct of_phandle_args args;
> +	int ret;
> +
> +	ret =3D of_parse_phandle_with_args(np, "ti,mac-address-ctrl",
> +			"#ti,mac-address-ctrl-cells", 0, &args);
> +	if (ret)
> +		return ret;
> +
> +	if (args.args_count !=3D 1 || args.args[0] < 0 || args.args[0] > 1)=
 {
> +		pr_err("Failed to parse ti,mac-address-module phandle because of i=
nvalid arguments\n");
> +		return -EINVAL;
> +	}
> +
> +	ctrl_dev =3D bus_find_device(&platform_bus_type, NULL, args.np, mat=
ch);
> +	priv =3D dev_get_drvdata(ctrl_dev);
> +	of_node_put(args.np);
> +	if (priv =3D=3D NULL)
> +		return -EPROBE_DEFER;
> +
> +	priv->cpsw_macid_get(priv, args.args[0], mac_addr);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(cpsw_ctrl_macid_read);
> +
> +static const struct of_device_id cpsw_ctrl_macid_of_ids[] =3D {
> +	{
> +		.compatible	=3D "ti,am3352-cpsw-ctrl-macid",
> +		.data		=3D &cpsw_ctrl_get_macid,
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cpsw_ctrl_macid_of_ids);
> +
> +static int cpsw_ctrl_macid_probe(struct platform_device *pdev)
> +{
> +	struct resource	*res;
> +	const struct of_device_id *of_id;
> +	struct cpsw_ctrl_macid *priv;
> +
> +	of_id =3D of_match_node(cpsw_ctrl_macid_of_ids, pdev->dev.of_node);
> +	if (!of_id)
> +		return -EINVAL;
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		dev_err(&pdev->dev, "unable to alloc memory for cpsw-ctrl-macid\n"=
);
> +		return -ENOMEM;
> +	}
> +
> +	priv->cpsw_macid_get =3D of_id->data;
> +
> +	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "ctrl-ma=
cid");
> +	priv->ctrl_macid =3D devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(priv->ctrl_macid))
> +		return PTR_ERR(priv->ctrl_macid);
> +
> +	dev_set_drvdata(&pdev->dev, priv);
> +
> +	dev_info(&pdev->dev, "TI CPSW ctrl macid loaded\n");
> +	return 0;
> +}
> +
> +static struct platform_driver cpsw_ctrl_macid_driver =3D {
> +	.probe		=3D cpsw_ctrl_macid_probe,
> +	.driver		=3D {
> +		.name	=3D "cpsw-ctrl-macid",
> +		.owner	=3D THIS_MODULE,
> +		.of_match_table =3D of_match_ptr(cpsw_ctrl_macid_of_ids),
> +	},
> +};
> +
> +module_platform_driver(cpsw_ctrl_macid_driver);
> +MODULE_AUTHOR("Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>");
> +MODULE_LICENSE("GPL v2");
> --=20
> 1.8.5.1
>=20
>=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
