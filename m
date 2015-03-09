From: Bin Liu <binmlist-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] phy: Add a driver for dm816x USB PHY
Date: Mon, 9 Mar 2015 16:11:28 -0500
Message-ID: <CADYTM3bEQ1mFTusuFQAMYfgOrhNM4=8a7_5=Nh5kHQKO3r1v6A@mail.gmail.com>
References: <20150309205157.GE5140@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150309205157.GE5140-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,

On Mon, Mar 9, 2015 at 3:51 PM, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> Add a minimal driver for dm816x USB. Otherwise we can just use
> the existing musb_am335x and musb_dsps on dm816x.

dm816x has the almost identical usbss as that in am335x, we should be
able to adopt musb_am335x and musb_dsps for dm816x, and dm814x too?

Regards,
-Bin.

>
> Cc: Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/dm816x-phy.txt
> @@ -0,0 +1,24 @@
> +Device tree binding documentation for am816x USB PHY
> +=========================
> +
> +Required properties:
> +- compatible : should be "ti,dm816x-usb-phy"
> +- reg : offset and length of the PHY register set.
> +- reg-names : name for the phy registers
> +- clocks : phandle to the clock
> +- clock-names : name of the clock
> +- syscon: phandle for the syscon node to access misc registers
> +- #phy-cells : from the generic PHY bindings, must be 1
> +- syscon: phandle for the syscon node to access misc registers
> +
> +Example:
> +
> +usb_phy0: usb-phy@20 {
> +       compatible = "ti,dm8168-usb-phy";
> +       reg = <0x20 0x8>;
> +       reg-names = "phy";
> +       clocks = <&main_fapll 6>;
> +       clock-names = "refclk";
> +       #phy-cells = <0>;
> +       syscon = <&scm_conf>;
> +};
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -35,6 +35,13 @@ config ARMADA375_USBCLUSTER_PHY
>         depends on OF
>         select GENERIC_PHY
>
> +config PHY_DM816X_USB
> +       tristate "TI dm816x USB PHY driver"
> +       depends on ARCH_OMAP2PLUS
> +       select GENERIC_PHY
> +       help
> +         Enable this for dm81xx USB to work."
> +
>  config PHY_EXYNOS_MIPI_VIDEO
>         tristate "S5P/EXYNOS SoC series MIPI CSI-2/DSI PHY driver"
>         depends on HAS_IOMEM
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -5,6 +5,7 @@
>  obj-$(CONFIG_GENERIC_PHY)              += phy-core.o
>  obj-$(CONFIG_PHY_BERLIN_USB)           += phy-berlin-usb.o
>  obj-$(CONFIG_PHY_BERLIN_SATA)          += phy-berlin-sata.o
> +obj-$(CONFIG_PHY_DM816X_USB)           += phy-dm816x-usb.o
>  obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY) += phy-armada375-usb2.o
>  obj-$(CONFIG_BCM_KONA_USB2_PHY)                += phy-bcm-kona-usb2.o
>  obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)      += phy-exynos-dp-video.o
> --- /dev/null
> +++ b/drivers/phy/phy-dm816x-usb.c
> @@ -0,0 +1,295 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/io.h>
> +#include <linux/usb/phy_companion.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/delay.h>
> +#include <linux/phy/phy.h>
> +#include <linux/of_platform.h>
> +
> +#include <linux/mfd/syscon.h>
> +
> +/*
> + * TRM has two sets of USB_CTRL registers.. The correct register bits
> + * are in TRM section 24.9.8.2 USB_CTRL Register.
> + */
> +#define DM816X_USB_CTRL_PHYCLKSRC      BIT(8)  /* 1 = PLL ref clock */
> +#define DM816X_USB_CTRL_PHYSLEEP1      BIT(1)
> +#define DM816X_USB_CTRL_PHYSLEEP0      BIT(0)
> +
> +#define DM816X_USBPHY_CTRL_TXRISETUNE  1
> +#define DM816X_USBPHY_CTRL_TXVREFTUNE  0xc
> +#define DM816X_USBPHY_CTRL_TXPREEMTUNE 0x2
> +
> +struct dm816x_usb_phy {
> +       struct regmap *syscon;
> +       struct device *dev;
> +       unsigned int instance;
> +       struct clk *refclk;
> +       struct usb_phy phy;
> +       unsigned int usb_ctrl;          /* Shared between phy0 and phy1 */
> +       unsigned int usbphy_ctrl;
> +};
> +
> +static int dm816x_usb_phy_set_host(struct usb_otg *otg, struct usb_bus *host)
> +{
> +       otg->host = host;
> +       if (!host)
> +               otg->state = OTG_STATE_UNDEFINED;
> +
> +       return 0;
> +}
> +
> +static int dm816x_usb_phy_set_peripheral(struct usb_otg *otg,
> +                                        struct usb_gadget *gadget)
> +{
> +       otg->gadget = gadget;
> +       if (!gadget)
> +               otg->state = OTG_STATE_UNDEFINED;
> +
> +       return 0;
> +}
> +
> +static int dm816x_usb_phy_power_off(struct phy *x)
> +{
> +       struct dm816x_usb_phy *phy = phy_get_drvdata(x);
> +
> +       pm_runtime_put(phy->dev);
> +
> +       return 0;
> +}
> +
> +static int dm816x_usb_phy_power_on(struct phy *x)
> +{
> +       struct dm816x_usb_phy *phy = phy_get_drvdata(x);
> +
> +       return pm_runtime_get_sync(phy->dev);
> +}
> +
> +static int dm816x_usb_phy_init(struct phy *x)
> +{
> +       struct dm816x_usb_phy *phy = phy_get_drvdata(x);
> +       unsigned int val;
> +       int error;
> +
> +       error = pm_runtime_get_sync(phy->dev);
> +       if (error)
> +               return error;
> +
> +       if (clk_get_rate(phy->refclk) != 24000000)
> +               dev_warn(phy->dev, "nonstandard phy refclk\n");
> +
> +       /* Set PLL ref clock and put phys to sleep */
> +       error = regmap_update_bits(phy->syscon, phy->usb_ctrl,
> +                                  DM816X_USB_CTRL_PHYCLKSRC |
> +                                  DM816X_USB_CTRL_PHYSLEEP1 |
> +                                  DM816X_USB_CTRL_PHYSLEEP0,
> +                                  0);
> +       regmap_read(phy->syscon, phy->usb_ctrl, &val);
> +
> +       /*
> +        * TI kernel sets these values for "symmetrical eye diagram and
> +        * better signal quality" so let's assume somebody checked the
> +        * values with a scope and set them here too.
> +        */
> +       regmap_read(phy->syscon, phy->usbphy_ctrl, &val);
> +       val |= DM816X_USBPHY_CTRL_TXRISETUNE |
> +               DM816X_USBPHY_CTRL_TXVREFTUNE |
> +               DM816X_USBPHY_CTRL_TXPREEMTUNE;
> +       regmap_write(phy->syscon, phy->usbphy_ctrl, val);
> +
> +       pm_runtime_put(phy->dev);
> +
> +       return 0;
> +}
> +
> +static struct phy_ops ops = {
> +       .init           = dm816x_usb_phy_init,
> +       .power_on       = dm816x_usb_phy_power_on,
> +       .power_off      = dm816x_usb_phy_power_off,
> +       .owner          = THIS_MODULE,
> +};
> +
> +static int dm816x_usb_phy_runtime_suspend(struct device *dev)
> +{
> +       struct dm816x_usb_phy *phy = dev_get_drvdata(dev);
> +       unsigned int mask, val;
> +       int error = 0;
> +
> +       mask = BIT(phy->instance);
> +       val = ~BIT(phy->instance);
> +       error = regmap_update_bits(phy->syscon, phy->usb_ctrl,
> +                                  mask, val);
> +       if (error)
> +               dev_err(phy->dev, "phy%i failed to power off\n",
> +                       phy->instance);
> +       clk_disable(phy->refclk);
> +
> +       return 0;
> +}
> +
> +static int dm816x_usb_phy_runtime_resume(struct device *dev)
> +{
> +       struct dm816x_usb_phy *phy = dev_get_drvdata(dev);
> +       unsigned int mask, val;
> +       int error;
> +
> +       error = clk_enable(phy->refclk);
> +       if (error)
> +               return error;
> +
> +       mask = BIT(phy->instance);
> +       val = BIT(phy->instance);
> +       error = regmap_update_bits(phy->syscon, phy->usb_ctrl,
> +                                  mask, val);
> +       if (error) {
> +               dev_err(phy->dev, "phy%i failed to power on\n",
> +                       phy->instance);
> +               clk_disable(phy->refclk);
> +               return error;
> +       }
> +
> +       return 0;
> +}
> +
> +static UNIVERSAL_DEV_PM_OPS(dm816x_usb_phy_pm_ops,
> +                           dm816x_usb_phy_runtime_suspend,
> +                           dm816x_usb_phy_runtime_resume,
> +                           NULL);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id dm816x_usb_phy_id_table[] = {
> +       {
> +               .compatible = "ti,dm8168-usb-phy",
> +       },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, dm816x_usb_phy_id_table);
> +#endif
> +
> +static int dm816x_usb_phy_probe(struct platform_device *pdev)
> +{
> +       struct dm816x_usb_phy *phy;
> +       struct resource *res;
> +       struct phy *generic_phy;
> +       struct phy_provider *phy_provider;
> +       struct usb_otg *otg;
> +       const struct of_device_id *of_id;
> +       const struct usb_phy_data *phy_data;
> +       int error;
> +
> +       of_id = of_match_device(of_match_ptr(dm816x_usb_phy_id_table),
> +                               &pdev->dev);
> +       if (!of_id)
> +               return -EINVAL;
> +
> +       phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
> +       if (!phy)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -ENOENT;
> +
> +       phy->syscon = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +                                                     "syscon");
> +       if (IS_ERR(phy->syscon))
> +               return PTR_ERR(phy->syscon);
> +
> +       /*
> +        * According to sprs614e.pdf, the first usb_ctrl is shared and
> +        * the second instance for usb_ctrl is reserved.. Also the
> +        * register bits are different from earlier TRMs.
> +        */
> +       phy->usb_ctrl = 0x20;
> +       phy->usbphy_ctrl = (res->start & 0xff) + 4;
> +       if (phy->usbphy_ctrl == 0x2c)
> +               phy->instance = 1;
> +
> +       phy_data = of_id->data;
> +
> +       otg = devm_kzalloc(&pdev->dev, sizeof(*otg), GFP_KERNEL);
> +       if (!otg)
> +               return -ENOMEM;
> +
> +       phy->dev = &pdev->dev;
> +       phy->phy.dev = phy->dev;
> +       phy->phy.label = "dm8168_usb_phy";
> +       phy->phy.otg = otg;
> +       phy->phy.type = USB_PHY_TYPE_USB2;
> +       otg->set_host = dm816x_usb_phy_set_host;
> +       otg->set_peripheral = dm816x_usb_phy_set_peripheral;
> +       otg->usb_phy = &phy->phy;
> +
> +       platform_set_drvdata(pdev, phy);
> +
> +       phy->refclk = devm_clk_get(phy->dev, "refclk");
> +       if (IS_ERR(phy->refclk))
> +               return PTR_ERR(phy->refclk);
> +
> +       generic_phy = devm_phy_create(phy->dev, NULL, &ops);
> +       if (IS_ERR(generic_phy))
> +               return PTR_ERR(generic_phy);
> +
> +       phy_set_drvdata(generic_phy, phy);
> +
> +       phy_provider = devm_of_phy_provider_register(phy->dev,
> +                                                    of_phy_simple_xlate);
> +       if (IS_ERR(phy_provider))
> +               return PTR_ERR(phy_provider);
> +
> +       error = clk_prepare(phy->refclk);
> +       if (error)
> +               return error;
> +
> +       pm_runtime_enable(phy->dev);
> +       usb_add_phy_dev(&phy->phy);
> +
> +       return 0;
> +}
> +
> +static int dm816x_usb_phy_remove(struct platform_device *pdev)
> +{
> +       struct dm816x_usb_phy *phy = platform_get_drvdata(pdev);
> +
> +       usb_remove_phy(&phy->phy);
> +       pm_runtime_disable(phy->dev);
> +       clk_unprepare(phy->refclk);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver dm816x_usb_phy_driver = {
> +       .probe          = dm816x_usb_phy_probe,
> +       .remove         = dm816x_usb_phy_remove,
> +       .driver         = {
> +               .name   = "dm816x-usb-phy",
> +               .pm     = &dm816x_usb_phy_pm_ops,
> +               .of_match_table = of_match_ptr(dm816x_usb_phy_id_table),
> +       },
> +};
> +
> +module_platform_driver(dm816x_usb_phy_driver);
> +
> +MODULE_ALIAS("platform: dm816x_usb");
> +MODULE_AUTHOR("Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>");
> +MODULE_DESCRIPTION("dm816x usb phy driver");
> +MODULE_LICENSE("GPL v2");
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
