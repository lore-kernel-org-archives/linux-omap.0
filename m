From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2] phy: Add a driver for dm816x USB PHY
Date: Wed, 18 Mar 2015 20:37:31 +0530
Message-ID: <550994B3.5080301@ti.com>
References: <1426637554-27178-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426637554-27178-1-git-send-email-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Bin Liu <binmlist@gmail.com>, Brian Hutchinson <b.hutchman@gmail.com>, Felipe Balbi <balbi@ti.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Paul Bolle <pebolle@tiscali.nl>, Rusty Russell <rusty@rustcorp.com.au>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On Wednesday 18 March 2015 05:42 AM, Tony Lindgren wrote:
> Add a minimal driver for dm816x USB. This makes USB work on dm816x
> without any other changes needed as it can use the existing musb_dsps
> glue layer for the USB controller.
>
> Note that this phy is different from dm814x and am335x.
>
> Cc: Bin Liu <binmlist@gmail.com>
> Cc: Brian Hutchinson <b.hutchman@gmail.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
> Cc: Paul Bolle <pebolle@tiscali.nl>
> Cc: Rusty Russell <rusty@rustcorp.com.au>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>   .../devicetree/bindings/phy/dm816x-phy.txt         |  24 ++
>   drivers/phy/Kconfig                                |   7 +
>   drivers/phy/Makefile                               |   1 +
>   drivers/phy/phy-dm816x-usb.c                       | 304 +++++++++++++++++++++
>   4 files changed, 336 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/phy/dm816x-phy.txt
>   create mode 100644 drivers/phy/phy-dm816x-usb.c
>
> diff --git a/Documentation/devicetree/bindings/phy/dm816x-phy.txt b/Documentation/devicetree/bindings/phy/dm816x-phy.txt
> new file mode 100644
> index 0000000..2fe3d11
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

							^^^^
						    should be '0'
> +- syscon: phandle for the syscon node to access misc registers
> +
> +Example:
> +
> +usb_phy0: usb-phy@20 {
> +	compatible = "ti,dm8168-usb-phy";
> +	reg = <0x20 0x8>;
> +	reg-names = "phy";
> +	clocks = <&main_fapll 6>;
> +	clock-names = "refclk";
> +	#phy-cells = <0>;
> +	syscon = <&scm_conf>;
> +};
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index 2962de2..c858c2b 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -35,6 +35,13 @@ config ARMADA375_USBCLUSTER_PHY
>   	depends on OF
>   	select GENERIC_PHY
>
> +config PHY_DM816X_USB
> +	tristate "TI dm816x USB PHY driver"
> +	depends on ARCH_OMAP2PLUS
> +	select GENERIC_PHY
> +	help
> +	  Enable this for dm81xx USB to work."
> +
>   config PHY_EXYNOS_MIPI_VIDEO
>   	tristate "S5P/EXYNOS SoC series MIPI CSI-2/DSI PHY driver"
>   	depends on HAS_IOMEM
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index f080e1b..dab6665 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -5,6 +5,7 @@
>   obj-$(CONFIG_GENERIC_PHY)		+= phy-core.o
>   obj-$(CONFIG_PHY_BERLIN_USB)		+= phy-berlin-usb.o
>   obj-$(CONFIG_PHY_BERLIN_SATA)		+= phy-berlin-sata.o
> +obj-$(CONFIG_PHY_DM816X_USB)		+= phy-dm816x-usb.o
>   obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+= phy-armada375-usb2.o
>   obj-$(CONFIG_BCM_KONA_USB2_PHY)		+= phy-bcm-kona-usb2.o
>   obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)	+= phy-exynos-dp-video.o
> diff --git a/drivers/phy/phy-dm816x-usb.c b/drivers/phy/phy-dm816x-usb.c
> new file mode 100644
> index 0000000..2fc276d
> --- /dev/null
> +++ b/drivers/phy/phy-dm816x-usb.c
> @@ -0,0 +1,304 @@
> +/*
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation version 2.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
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
> + * are in TRM section 24.9.8.2 USB_CTRL Register. The TRM documents the
> + * phy as being SR70LX Synopsys USB 2.0 OTG nanoPHY. It also seems at
> + * least dm816x rev c ignores writes to USB_CTRL register, but the TI
> + * kernel is writing to those so it's possible that later revisions
> + * have worknig USB_CTRL register.
> + *
> + * Also note that At least USB_CTRL register seems to be dm816x specific
> + * according to the TRM. It's possible that USBPHY_CTRL is more generic,
> + * but that would have to be checked against the SR70LX documentation
> + * which does not seem to be publicly available.
> + *
> + * Finally, the phy on dm814x and am335x is different from dm816x.
> + */
> +#define DM816X_USB_CTRL_PHYCLKSRC	BIT(8)	/* 1 = PLL ref clock */
> +#define DM816X_USB_CTRL_PHYSLEEP1	BIT(1)	/* Enable the first phy */
> +#define DM816X_USB_CTRL_PHYSLEEP0	BIT(0)	/* Enable the second phy */
> +
> +#define DM816X_USBPHY_CTRL_TXRISETUNE	1
> +#define DM816X_USBPHY_CTRL_TXVREFTUNE	0xc
> +#define DM816X_USBPHY_CTRL_TXPREEMTUNE	0x2
> +
> +struct dm816x_usb_phy {
> +	struct regmap *syscon;
> +	struct device *dev;
> +	unsigned int instance;
> +	struct clk *refclk;
> +	struct usb_phy phy;
> +	unsigned int usb_ctrl;		/* Shared between phy0 and phy1 */
> +	unsigned int usbphy_ctrl;
> +};
> +
> +static int dm816x_usb_phy_set_host(struct usb_otg *otg, struct usb_bus *host)
> +{
> +	otg->host = host;
> +	if (!host)
> +		otg->state = OTG_STATE_UNDEFINED;
> +
> +	return 0;
> +}
> +
> +static int dm816x_usb_phy_set_peripheral(struct usb_otg *otg,
> +					 struct usb_gadget *gadget)
> +{
> +	otg->gadget = gadget;
> +	if (!gadget)
> +		otg->state = OTG_STATE_UNDEFINED;
> +
> +	return 0;
> +}
> +
> +/*
> + * We have phy-core.c handle pm_runtime calls for us. We implement
> + * these functions for phy-core.c to keep track of power_count.
> + * Note that we may want to remove these eventually and rely only
> + * on the usecounting done by PM runtime.

irrespective of whether the phy drivers implement power_off/power_on callbacks
or not, the phy core maintains it's usecount. So the following two functions
shouldn't be needed at all.
> + */
> +static int dm816x_usb_phy_power_off(struct phy *x)
> +{
> +	return 0;
> +}
> +
> +static int dm816x_usb_phy_power_on(struct phy *x)
> +{
> +	return 0;
> +}
> +
> +static int dm816x_usb_phy_init(struct phy *x)
> +{
> +	struct dm816x_usb_phy *phy = phy_get_drvdata(x);
> +	unsigned int val;
> +	int error;
> +
> +	if (clk_get_rate(phy->refclk) != 24000000)
> +		dev_warn(phy->dev, "nonstandard phy refclk\n");
> +
> +	/* Set PLL ref clock and put phys to sleep */
> +	error = regmap_update_bits(phy->syscon, phy->usb_ctrl,
> +				   DM816X_USB_CTRL_PHYCLKSRC |
> +				   DM816X_USB_CTRL_PHYSLEEP1 |
> +				   DM816X_USB_CTRL_PHYSLEEP0,
> +				   0);
> +	regmap_read(phy->syscon, phy->usb_ctrl, &val);
> +
> +	/*
> +	 * TI kernel sets these values for "symmetrical eye diagram and
> +	 * better signal quality" so let's assume somebody checked the
> +	 * values with a scope and set them here too.
> +	 */
> +	regmap_read(phy->syscon, phy->usbphy_ctrl, &val);
> +	val |= DM816X_USBPHY_CTRL_TXRISETUNE |
> +		DM816X_USBPHY_CTRL_TXVREFTUNE |
> +		DM816X_USBPHY_CTRL_TXPREEMTUNE;
> +	regmap_write(phy->syscon, phy->usbphy_ctrl, val);
> +
> +	return 0;
> +}
> +
> +static struct phy_ops ops = {
> +	.init		= dm816x_usb_phy_init,
> +	.power_on	= dm816x_usb_phy_power_on,
> +	.power_off	= dm816x_usb_phy_power_off,
> +	.owner		= THIS_MODULE,
> +};
> +
> +static int dm816x_usb_phy_runtime_suspend(struct device *dev)
> +{
> +	struct dm816x_usb_phy *phy = dev_get_drvdata(dev);
> +	unsigned int mask, val;
> +	int error = 0;
> +
> +	mask = BIT(phy->instance);
> +	val = ~BIT(phy->instance);
> +	error = regmap_update_bits(phy->syscon, phy->usb_ctrl,
> +				   mask, val);

Shouldn't this be protected since both the PHYs can access the same register?

Thanks
Kishon
