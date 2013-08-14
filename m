From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 2/9] usb: phy: nop: Don't use regulator framework for
 RESET line
Date: Wed, 14 Aug 2013 17:27:15 +0200
Message-ID: <1376494035.3994.24.camel@pizza.hi.pengutronix.de>
References: <1376488693-31659-1-git-send-email-rogerq@ti.com>
	 <1376488693-31659-3-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1376488693-31659-3-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: balbi-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Roger,

Am Mittwoch, den 14.08.2013, 16:58 +0300 schrieb Roger Quadros:
> Modelling the RESET line as a regulator supply wasn't a good idea
> as it kind of abuses the regulator framework and also makes adaptation
> code more complex.
> 
> Instead, manage the RESET gpio line directly in the driver. Update
> the device tree binding information.
> 
> This also makes us easy to migrate to a dedicated GPIO RESET controller
> whenever it becomes available.
> 
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>

using the reset-gpios property
Acked-by: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

> ---
>  .../devicetree/bindings/usb/usb-nop-xceiv.txt      |    7 +--
>  drivers/usb/phy/phy-nop.c                          |   48 ++++++++++++--------
>  2 files changed, 32 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> index d7e2726..5535f3b 100644
> --- a/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-nop-xceiv.txt
> @@ -15,7 +15,7 @@ Optional properties:
>  
>  - vcc-supply: phandle to the regulator that provides RESET to the PHY.
>  
> -- reset-supply: phandle to the regulator that provides power to the PHY.
> +- reset-gpios: Should specify the GPIO for reset.
>
>  Example:
>  
> @@ -25,10 +25,9 @@ Example:
>  		clocks = <&osc 0>;
>  		clock-names = "main_clk";
>  		vcc-supply = <&hsusb1_vcc_regulator>;
> -		reset-supply = <&hsusb1_reset_regulator>;
> +		reset-gpios = <&gpio1 7>;

Yes, although the example should probably include GPIO_ACTIVE_LOW or
GPIO_ACTIVE_HIGH flags.

>  	};
>  
>  hsusb1_phy is a NOP USB PHY device that gets its clock from an oscillator
>  and expects that clock to be configured to 19.2MHz by the NOP PHY driver.
> -hsusb1_vcc_regulator provides power to the PHY and hsusb1_reset_regulator
> -controls RESET.
> +hsusb1_vcc_regulator provides power to the PHY and GPIO 7 controls RESET.
> diff --git a/drivers/usb/phy/phy-nop.c b/drivers/usb/phy/phy-nop.c
> index 55445e5d..af5e1a6 100644
> --- a/drivers/usb/phy/phy-nop.c
> +++ b/drivers/usb/phy/phy-nop.c
> @@ -35,6 +35,9 @@
>  #include <linux/clk.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/gpio.h>
> +#include <linux/delay.h>
>  
>  struct nop_usb_xceiv {
>  	struct usb_phy phy;
> @@ -42,6 +45,7 @@ struct nop_usb_xceiv {
>  	struct clk *clk;
>  	struct regulator *vcc;
>  	struct regulator *reset;
> +	int gpio_reset;
>  };
>  
>  static struct platform_device *pd;
> @@ -70,6 +74,15 @@ static int nop_set_suspend(struct usb_phy *x, int suspend)
>  	return 0;
>  }
>  
> +static void nop_gpio_reset(int gpio, int state)
> +{
> +	if (gpio_is_valid(gpio))
> +		gpio_set_value(gpio, state);
> +
> +	if (state)
> +		usleep_range(10000, 20000);
> +}
> +
>  static int nop_init(struct usb_phy *phy)
>  {
>  	struct nop_usb_xceiv *nop = dev_get_drvdata(phy->dev);
> @@ -82,11 +95,8 @@ static int nop_init(struct usb_phy *phy)
>  	if (!IS_ERR(nop->clk))
>  		clk_enable(nop->clk);
>  
> -	if (!IS_ERR(nop->reset)) {
> -		/* De-assert RESET */
> -		if (regulator_enable(nop->reset))
> -			dev_err(phy->dev, "Failed to de-assert reset\n");
> -	}
> +	/* De-assert RESET */
> +	nop_gpio_reset(nop->gpio_reset, 1);
>  
>  	return 0;
>  }
> @@ -95,11 +105,8 @@ static void nop_shutdown(struct usb_phy *phy)
>  {
>  	struct nop_usb_xceiv *nop = dev_get_drvdata(phy->dev);
>  
> -	if (!IS_ERR(nop->reset)) {
> -		/* Assert RESET */
> -		if (regulator_disable(nop->reset))
> -			dev_err(phy->dev, "Failed to assert reset\n");
> -	}
> +	/* Assert RESET */
> +	nop_gpio_reset(nop->gpio_reset, 0);
>  
>  	if (!IS_ERR(nop->clk))
>  		clk_disable(nop->clk);
> @@ -148,7 +155,6 @@ static int nop_usb_xceiv_probe(struct platform_device *pdev)
>  	int err;
>  	u32 clk_rate = 0;
>  	bool needs_vcc = false;
> -	bool needs_reset = false;
>  
>  	nop = devm_kzalloc(&pdev->dev, sizeof(*nop), GFP_KERNEL);
>  	if (!nop)
> @@ -166,13 +172,15 @@ static int nop_usb_xceiv_probe(struct platform_device *pdev)
>  			clk_rate = 0;
>  
>  		needs_vcc = of_property_read_bool(node, "vcc-supply");
> -		needs_reset = of_property_read_bool(node, "reset-supply");
> +		nop->gpio_reset = of_get_named_gpio(node, "reset-gpios", 0);

I'd suggest to use of_get_named_gpio_flags to also obtain the polarity
from the flags.

> +		if (nop->gpio_reset == -EPROBE_DEFER)
> +			return -EPROBE_DEFER;
>  
>  	} else if (pdata) {
>  		type = pdata->type;
>  		clk_rate = pdata->clk_rate;
>  		needs_vcc = pdata->needs_vcc;
> -		needs_reset = pdata->needs_reset;
> +		nop->gpio_reset = pdata->gpio_reset;
>  	}
>  
>  	nop->clk = devm_clk_get(&pdev->dev, "main_clk");
> @@ -205,12 +213,14 @@ static int nop_usb_xceiv_probe(struct platform_device *pdev)
>  			return -EPROBE_DEFER;
>  	}
>  
> -	nop->reset = devm_regulator_get(&pdev->dev, "reset");
> -	if (IS_ERR(nop->reset)) {
> -		dev_dbg(&pdev->dev, "Error getting reset regulator: %ld\n",
> -					PTR_ERR(nop->reset));
> -		if (needs_reset)
> -			return -EPROBE_DEFER;
> +	if (gpio_is_valid(nop->gpio_reset)) {
> +		err = devm_gpio_request_one(dev, nop->gpio_reset,
> +					    GPIOF_OUT_INIT_HIGH, dev_name(dev));
> +		if (err) {
> +			dev_err(dev, "Error requesting RESET GPIO %d\n",
> +					nop->gpio_reset);
> +			return err;
> +		}
>  	}
>  
>  	nop->dev		= &pdev->dev;

regards
Philipp

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
