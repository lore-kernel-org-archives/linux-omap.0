From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] phy: omap-usb2: Manage PHY 3.3V supply regulator
Date: Tue, 1 Jul 2014 15:26:44 +0530
Message-ID: <53B285DC.8070102@ti.com>
References: <1404126038-19974-1-git-send-email-rogerq@ti.com> <1404126038-19974-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1404126038-19974-2-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: nm-l0cyMroinI0@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Roger,

On Monday 30 June 2014 04:30 PM, Roger Quadros wrote:
> On some SoCs e.g. J6 the 3.3V supply to the USB2 PHY can be
> powered down when the PHY is not in use. Add regulator
> management code to control this power line.
> 
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/phy/phy-omap-usb2.c  | 25 +++++++++++++++++++++++++
>  include/linux/phy/omap_usb.h |  1 +
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/phy/phy-omap-usb2.c b/drivers/phy/phy-omap-usb2.c
> index 7007c11..2afc79c 100644
> --- a/drivers/phy/phy-omap-usb2.c
> +++ b/drivers/phy/phy-omap-usb2.c
> @@ -30,6 +30,7 @@
>  #include <linux/phy/omap_control_phy.h>
>  #include <linux/phy/phy.h>
>  #include <linux/of_platform.h>
> +#include <linux/regulator/consumer.h>
>  
>  #define USB2PHY_DISCON_BYP_LATCH (1 << 31)
>  #define USB2PHY_ANA_CONFIG1 0x4c
> @@ -107,6 +108,14 @@ static int omap_usb_power_off(struct phy *x)
>  
>  	omap_control_phy_power(phy->control_dev, 0);
>  
> +	if (phy->pwr) {
> +		int ret;
> +
> +		ret = regulator_disable(phy->pwr);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -114,6 +123,14 @@ static int omap_usb_power_on(struct phy *x)
>  {
>  	struct omap_usb *phy = phy_get_drvdata(x);
>  
> +	if (phy->pwr) {
> +		int ret;
> +
> +		ret = regulator_enable(phy->pwr);
> +		if (ret)
> +			return ret;
> +	}
> +

Shouldn't we do this in phy_power_on/phy_power_off in phy-core?

Cheers
Kishon

>  	omap_control_phy_power(phy->control_dev, 1);
>  
>  	return 0;
> @@ -253,6 +270,14 @@ static int omap_usb2_probe(struct platform_device *pdev)
>  	phy->control_dev = &control_pdev->dev;
>  	omap_control_phy_power(phy->control_dev, 0);
>  
> +	/* phy-supply */
> +	phy->pwr = devm_regulator_get_optional(phy->dev, "phy");
> +	if (IS_ERR(phy->pwr)) {
> +		if (PTR_ERR(phy->pwr) == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
> +		phy->pwr = NULL;
> +	}
> +
>  	otg->set_host		= omap_usb_set_host;
>  	otg->set_peripheral	= omap_usb_set_peripheral;
>  	if (phy_data->flags & OMAP_USB2_HAS_SET_VBUS)
> diff --git a/include/linux/phy/omap_usb.h b/include/linux/phy/omap_usb.h
> index dc2c541..e2c46df 100644
> --- a/include/linux/phy/omap_usb.h
> +++ b/include/linux/phy/omap_usb.h
> @@ -40,6 +40,7 @@ struct omap_usb {
>  	struct clk		*wkupclk;
>  	struct clk		*optclk;
>  	u8			flags;
> +	struct regulator	*pwr;
>  };
>  
>  struct usb_phy_data {
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
