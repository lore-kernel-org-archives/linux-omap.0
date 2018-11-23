From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 2/2] phy: mapphone-mdm6600: Improve phy related runtime PM
 calls
Date: Fri, 23 Nov 2018 13:29:24 +0530
Message-ID: <ac3a7cdd-4f03-069f-844a-072e99759c83@ti.com>
References: <20181117133755.9129-1-tony@atomide.com>
 <20181117133755.9129-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181117133755.9129-3-tony@atomide.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

On 17/11/18 7:07 PM, Tony Lindgren wrote:
> I noticed that phy_pm_runtime_get_sync() and phy_pm_runtime_put() are not
> currently doing anything for phy-mapphone-mdm6600, only the sysfs interface
> for works for "auto" and "on".
> 
> This is because of the shared GPIO pins between mdm6600 USB port and n_gsm
> port. We have not enabled runtime PM for the phy driver until after we've
> booted up mdm6600 properly to the USB mode. Otherwise phy_create() would
> have called pm_runtime_enable() and pm_runtime_no_callbacks() automatically
> on init.
> 
> Let's fix this by registering the phy a bit later after we've powered up the
> mdm6600 USB port.
> 
> And as the PM runtime support is only needed for the n_gsm mode and not for
> USB, we can allow the device to idle between phy_mdm6600_power_on() and
> phy_mdm6600_power_off(). Note that for suspend, runtime_pm is already
> disabled for the phy so we need to check for phy_pm_runtime_enabled().
> 
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/phy/motorola/phy-mapphone-mdm6600.c | 71 +++++++++++++++------
>  1 file changed, 51 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/motorola/phy-mapphone-mdm6600.c
> --- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
> +++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
> @@ -16,6 +16,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/of_platform.h>
>  #include <linux/phy/phy.h>
> +#include <linux/pinctrl/consumer.h>
>  
>  #define PHY_MDM6600_PHY_DELAY_MS	4000	/* PHY enable 2.2s to 3.5s */
>  #define PHY_MDM6600_ENABLED_DELAY_MS	8000	/* 8s more total for MDM6600 */
> @@ -124,12 +125,22 @@ static int phy_mdm6600_power_on(struct phy *x)
>  {
>  	struct phy_mdm6600 *ddata = phy_get_drvdata(x);
>  	struct gpio_desc *enable_gpio = ddata->ctrl_gpios[PHY_MDM6600_ENABLE];
> +	int error;
>  
>  	if (!ddata->enabled)
>  		return -ENODEV;
>  
> +	error = pinctrl_pm_select_default_state(ddata->dev);
> +	if (error)
> +		dev_warn(ddata->dev, "%s: error with default_state: %i\n",
> +			 __func__, error);
> +
>  	gpiod_set_value_cansleep(enable_gpio, 1);
>  
> +	/* Allow aggressive PM for USB, it's only needed for n_gsm port */
> +	if (phy_pm_runtime_enabled(ddata->generic_phy))
> +		phy_pm_runtime_put(ddata->generic_phy);

phy_*() API's are generally added to be used by the consumer driver. I guess in
this case we can directly use pm_runtime_enabled(x).

Thanks
Kishon
