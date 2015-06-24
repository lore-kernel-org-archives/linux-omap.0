From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 06/17] phy: omap-usb2: use *syscon* framework to power
 on/off the PHY
Date: Wed, 24 Jun 2015 14:33:56 +0300
Message-ID: <20150624143356.6971c7b8d6b03f378086e032@ti.com>
References: <1435060743-5511-1-git-send-email-kishon@ti.com>
	<1435060743-5511-7-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1435060743-5511-7-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, 23 Jun 2015 17:28:51 +0530
Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org> wrote:

> Deprecate using phy-omap-control driver to power on/off the PHY,
> and use *syscon* framework to do the same. This handles
> powering on/off the PHY for the USB2 PHYs used in various TI SoCs.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/phy/ti-phy.txt |    6 +-
>  drivers/phy/phy-omap-usb2.c                      |  101 ++++++++++++++++++----
>  include/linux/phy/omap_usb.h                     |   18 ++++
>  3 files changed, 107 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti-phy.txt b/Documentation/devicetree/bindings/phy/ti-phy.txt
> index b9101b9..5bfe461 100644
> --- a/Documentation/devicetree/bindings/phy/ti-phy.txt
> +++ b/Documentation/devicetree/bindings/phy/ti-phy.txt
> @@ -42,10 +42,14 @@ Required properties:
>     * "wkupclk" - wakeup clock.
>     * "refclk" - reference clock (optional).
>  
> -Optional properties:
> +Deprecated properties:
>   - ctrl-module : phandle of the control module used by PHY driver to power on
>     the PHY.
>  
> +Recommended properies:
> +- syscon-phy-power : phandle/offset pair. Phandle to the system control
> +  module and the register offset to power on/off the PHY.
> +
>  This is usually a subnode of ocp2scp to which it is connected.
>  
>  usb2phy@4a0ad080 {
> diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
> index 2f7220f..180b066 100644
> --- a/drivers/phy/phy-omap-usb2.c
> +++ b/drivers/phy/phy-omap-usb2.c
> @@ -29,6 +29,8 @@
>  #include <linux/delay.h>
>  #include <linux/phy/omap_control_phy.h>
>  #include <linux/phy/phy.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/regmap.h>
>  #include <linux/of_platform.h>
>  
>  #define USB2PHY_DISCON_BYP_LATCH (1 << 31)
> @@ -97,22 +99,65 @@ static int omap_usb_set_peripheral(struct usb_otg *otg,
>  	return 0;
>  }
>  
> -static int omap_usb_power_off(struct phy *x)
> +static int omap_usb_phy_power(struct omap_usb *phy, int on)
>  {
> -	struct omap_usb *phy = phy_get_drvdata(x);
> +	u32 val = 0;
> +	u32 mask;
> +	int ret;
>  
> -	omap_control_phy_power(phy->control_dev, 0);
> +	if (phy->syscon_phy_power) {
> +		switch (phy->type) {
> +		case TYPE_USB2:
> +			mask = OMAP_DEV_PHY_PD;
> +			if (!on)
> +				val = OMAP_DEV_PHY_PD;
> +			break;
> +		case TYPE_DRA7USB2:
> +			mask = OMAP_USB2_PHY_PD;
> +			if (!on)
> +				val = OMAP_USB2_PHY_PD;
> +			break;
> +		case TYPE_AM437USB2:
> +			mask = AM437X_USB2_PHY_PD |
> +				AM437X_USB2_OTG_PD |
> +				AM437X_USB2_OTGVDET_EN |
> +				AM437X_USB2_OTGSESSEND_EN;
> +			if (on) {
> +				val = AM437X_USB2_OTGVDET_EN |
> +					AM437X_USB2_OTGSESSEND_EN;
> +			} else {
> +				val = AM437X_USB2_PHY_PD | AM437X_USB2_OTG_PD;
> +			}
> +			break;
> +		default:
> +			dev_err(phy->dev, "%s: type %d not recognized\n",
> +				__func__, phy->type);
> +			return -EINVAL;
> +		}
> +
> +		ret = regmap_update_bits(phy->syscon_phy_power, phy->power_reg,
> +					 mask, val);
> +		if (ret < 0)
> +			return ret;
> +	} else {
> +		omap_control_phy_power(phy->control_dev, on);
> +	}
>  
>  	return 0;
>  }
>  
> -static int omap_usb_power_on(struct phy *x)
> +static int omap_usb_power_off(struct phy *x)
>  {
>  	struct omap_usb *phy = phy_get_drvdata(x);
>  
> -	omap_control_phy_power(phy->control_dev, 1);
> +	return omap_usb_phy_power(phy, false);
> +}
>  
> -	return 0;
> +static int omap_usb_power_on(struct phy *x)
> +{
> +	struct omap_usb *phy = phy_get_drvdata(x);
> +
> +	return omap_usb_phy_power(phy, true);
>  }
>  
>  static int omap_usb_init(struct phy *x)
> @@ -147,26 +192,31 @@ static struct phy_ops ops = {
>  static const struct usb_phy_data omap_usb2_data = {
>  	.label = "omap_usb2",
>  	.flags = OMAP_USB2_HAS_START_SRP | OMAP_USB2_HAS_SET_VBUS,
> +	.type = TYPE_USB2,
>  };
>  
>  static const struct usb_phy_data omap5_usb2_data = {
>  	.label = "omap5_usb2",
>  	.flags = 0,
> +	.type = TYPE_USB2,
>  };
>  
>  static const struct usb_phy_data dra7x_usb2_data = {
>  	.label = "dra7x_usb2",
>  	.flags = OMAP_USB2_CALIBRATE_FALSE_DISCONNECT,
> +	.type = TYPE_USB2,
>  };
>  
>  static const struct usb_phy_data dra7x_usb2_phy2_data = {
>  	.label = "dra7x_usb2_phy2",
>  	.flags = OMAP_USB2_CALIBRATE_FALSE_DISCONNECT,
> +	.type = TYPE_DRA7USB2,
>  };
>  
>  static const struct usb_phy_data am437x_usb2_data = {
>  	.label = "am437x_usb2",
>  	.flags =  0,
> +	.type = TYPE_AM437USB2,
>  };
>  
>  static const struct of_device_id omap_usb2_id_table[] = {
> @@ -223,6 +273,7 @@ static int omap_usb2_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	phy->dev		= &pdev->dev;
> +	phy->type		= phy_data->type;
>  
>  	phy->phy.dev		= phy->dev;
>  	phy->phy.label		= phy_data->label;
> @@ -237,20 +288,36 @@ static int omap_usb2_probe(struct platform_device *pdev)
>  		phy->flags |= OMAP_USB2_CALIBRATE_FALSE_DISCONNECT;
>  	}
>  
> -	control_node = of_parse_phandle(node, "ctrl-module", 0);
> -	if (!control_node) {
> -		dev_err(&pdev->dev, "Failed to get control device phandle\n");
> -		return -EINVAL;
> -	}
> +	phy->syscon_phy_power = syscon_regmap_lookup_by_phandle(node,
> +							"syscon-phy-power");
> +	if (IS_ERR(phy->syscon_phy_power)) {
> +		dev_info(&pdev->dev,
> +			 "can't get syscon-phy-power, using control device\n");
> +		phy->syscon_phy_power = NULL;
> +
> +		control_node = of_parse_phandle(node, "ctrl-module", 0);
> +		if (!control_node) {
> +			dev_err(&pdev->dev,
> +				"Failed to get control device phandle\n");
> +			return -EINVAL;
> +		}
>  
> -	control_pdev = of_find_device_by_node(control_node);
> -	if (!control_pdev) {
> -		dev_err(&pdev->dev, "Failed to get control device\n");
> -		return -EINVAL;
> +		control_pdev = of_find_device_by_node(control_node);
> +		if (!control_pdev) {
> +			dev_err(&pdev->dev, "Failed to get control device\n");
> +			return -EINVAL;
> +		}
> +		phy->control_dev = &control_pdev->dev;
> +	} else {
> +		if (of_property_read_u32_index(node,
> +					       "syscon-phy-power", 1,
> +					       &phy->power_reg)) {
> +			dev_err(&pdev->dev,
> +				"couldn't get power reg. offset\n");
> +			return -EINVAL;
> +		}
>  	}
>  
> -	phy->control_dev = &control_pdev->dev;
> -
>  	otg->set_host		= omap_usb_set_host;
>  	otg->set_peripheral	= omap_usb_set_peripheral;
>  	if (phy_data->flags & OMAP_USB2_HAS_SET_VBUS)
> diff --git a/include/linux/phy/omap_usb.h b/include/linux/phy/omap_usb.h
> index dc2c541..de933ab 100644
> --- a/include/linux/phy/omap_usb.h
> +++ b/include/linux/phy/omap_usb.h
> @@ -30,6 +30,12 @@ struct usb_dpll_params {
>  	u32	mf;
>  };
>  
> +enum omap_usb_phy_type {
> +	TYPE_USB2,    /* USB2_PHY, power down in CONTROL_DEV_CONF */
> +	TYPE_DRA7USB2, /* USB2 PHY, power and power_aux e.g. DRA7 */
> +	TYPE_AM437USB2, /* USB2 PHY, power e.g. AM437x */
> +};
> +
>  struct omap_usb {
>  	struct usb_phy		phy;
>  	struct phy_companion	*comparator;
> @@ -40,11 +46,15 @@ struct omap_usb {
>  	struct clk		*wkupclk;
>  	struct clk		*optclk;
>  	u8			flags;
> +	enum omap_usb_phy_type	type;
> +	struct regmap		*syscon_phy_power; /* ctrl. reg. acces */
> +	unsigned int		power_reg; /* power reg. index within syscon */
>  };
>  
>  struct usb_phy_data {
>  	const char *label;
>  	u8 flags;
> +	enum omap_usb_phy_type type;
>  };
>  
>  /* Driver Flags */
> @@ -52,6 +62,14 @@ struct usb_phy_data {
>  #define OMAP_USB2_HAS_SET_VBUS (1 << 1)
>  #define OMAP_USB2_CALIBRATE_FALSE_DISCONNECT (1 << 2)
>  
> +#define OMAP_DEV_PHY_PD		BIT(0)
> +#define OMAP_USB2_PHY_PD	BIT(28)
> +
> +#define AM437X_USB2_PHY_PD		BIT(0)

This PD bit can be set in usb_phy_data and used by
a single block of code for all 3 phys.

> +#define AM437X_USB2_OTG_PD		BIT(1)
> +#define AM437X_USB2_OTGVDET_EN		BIT(19)
> +#define AM437X_USB2_OTGSESSEND_EN	BIT(20)
> +
>  #define	phy_to_omapusb(x)	container_of((x), struct omap_usb, phy)
>  
>  #if defined(CONFIG_OMAP_USB2) || defined(CONFIG_OMAP_USB2_MODULE)
> -- 
> 1.7.9.5
> 

cheers,
-roger
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
