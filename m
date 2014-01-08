From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/5] arm: omap3: twl: use the new lookup method with usb
 phy
Date: Wed, 8 Jan 2014 09:53:15 -0800
Message-ID: <20140108175314.GC31686@atomide.com>
References: <1386601737-8735-1-git-send-email-heikki.krogerus@linux.intel.com>
 <1386601737-8735-5-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1386601737-8735-5-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Heikki Krogerus <heikki.krogerus@linux.intel.com> [131209 07:10]:
> Provide a complete association for the phy and it's user
> (musb) with the new phy_lookup_table.

This seems safe to queue via the USB list:

Acked-by: Tony Lindgren <tony@atomide.com>
 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  arch/arm/mach-omap2/twl-common.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
> index b0d54da..972430b 100644
> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -91,18 +91,13 @@ void __init omap_pmic_late_init(void)
>  }
>  
>  #if defined(CONFIG_ARCH_OMAP3)
> -struct phy_consumer consumers[] = {
> -	PHY_CONSUMER("musb-hdrc.0", "usb"),
> -};
> -
> -struct phy_init_data init_data = {
> -	.consumers = consumers,
> -	.num_consumers = ARRAY_SIZE(consumers),
> +static struct phy_lookup_table twl4030_usb_lookup = {
> +	.dev_id = "musb-hdrc.0",
> +	.table = PHY_LOOKUP("phy-twl4030_usb.0", NULL),
>  };
>  
>  static struct twl4030_usb_data omap3_usb_pdata = {
>  	.usb_mode	= T2_USB_MODE_ULPI,
> -	.init_data	= &init_data,
>  };
>  
>  static int omap3_batt_table[] = {
> @@ -225,8 +220,10 @@ void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
>  	}
>  
>  	/* Common platform data configurations */
> -	if (pdata_flags & TWL_COMMON_PDATA_USB && !pmic_data->usb)
> +	if (pdata_flags & TWL_COMMON_PDATA_USB && !pmic_data->usb) {
> +		phy_add_lookup_table(&twl4030_usb_lookup);
>  		pmic_data->usb = &omap3_usb_pdata;
> +	}
>  
>  	if (pdata_flags & TWL_COMMON_PDATA_BCI && !pmic_data->bci)
>  		pmic_data->bci = &omap3_bci_pdata;
> -- 
> 1.8.5.1
> 
