From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 2/8] mfd: twl-core: Rename some non-model-specific
 structures, without model name
Date: Wed, 30 Mar 2016 18:31:33 +0300
Message-ID: <56FBF155.6020500@ti.com>
References: <1459279341-17389-1-git-send-email-contact@paulk.fr>
 <1459279341-17389-2-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1459279341-17389-2-git-send-email-contact@paulk.fr>
Sender: linux-pm-owner@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

On 03/29/2016 10:22 PM, Paul Kocialkowski wrote:
> Some of the structures exposed in the twl_platform_data structure are common
> to various TWL chips, so it makes sense to rename them to a non-model-specific
> name.

the same comment.

>
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>   arch/arm/mach-omap2/board-rx51-peripherals.c |  4 ++--
>   arch/arm/mach-omap2/twl-common.c             |  6 +++---
>   drivers/mfd/twl4030-audio.c                  |  6 +++---
>   drivers/mfd/twl4030-power.c                  | 22 +++++++++++-----------
>   include/linux/i2c/twl.h                      | 10 ++++++----
>   5 files changed, 25 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
> index 3739bff..8273439 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -942,7 +942,7 @@ static struct twl4030_resconfig twl4030_rconfig[] __initdata = {
>   	{ 0, 0},
>   };
>
> -static struct twl4030_power_data rx51_t2scripts_data __initdata = {
> +static struct twl_power_data rx51_t2scripts_data __initdata = {
>   	.scripts        = twl4030_scripts,
>   	.num = ARRAY_SIZE(twl4030_scripts),
>   	.resource_config = twl4030_rconfig,
> @@ -952,7 +952,7 @@ static struct twl4030_vibra_data rx51_vibra_data __initdata = {
>   	.coexist	= 0,
>   };
>
> -static struct twl4030_audio_data rx51_audio_data __initdata = {
> +static struct twl_audio_data rx51_audio_data __initdata = {
>   	.audio_mclk	= 26000000,
>   	.vibra		= &rx51_vibra_data,
>   };
> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
> index 4e6532f..6b5519e 100644
> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -122,7 +122,7 @@ static struct twl4030_madc_platform_data omap3_madc_pdata = {
>
>   static struct twl4030_codec_data omap3_codec;
>
> -static struct twl4030_audio_data omap3_audio_pdata = {
> +static struct twl_audio_data omap3_audio_pdata = {
>   	.audio_mclk = 26000000,
>   	.codec = &omap3_codec,
>   };
> @@ -537,7 +537,7 @@ void __init omap4_pmic_get_config(struct twl_platform_data *pmic_data,
>   #include <linux/platform_data/omap-twl4030.h>
>
>   /* Commonly used configuration */
> -static struct omap_tw4030_pdata omap_twl4030_audio_data;
> +static struct omap_tw4030_pdata omap_twl_audio_data;
>
>   static struct platform_device audio_device = {
>   	.name		= "omap-twl4030",
> @@ -548,7 +548,7 @@ void omap_twl4030_audio_init(char *card_name,
>   				    struct omap_tw4030_pdata *pdata)
>   {
>   	if (!pdata)
> -		pdata = &omap_twl4030_audio_data;
> +		pdata = &omap_twl_audio_data;
>
>   	pdata->card_name = card_name;
>
> diff --git a/drivers/mfd/twl4030-audio.c b/drivers/mfd/twl4030-audio.c
> index 0a16064..e7354f7 100644
> --- a/drivers/mfd/twl4030-audio.c
> +++ b/drivers/mfd/twl4030-audio.c
> @@ -158,7 +158,7 @@ unsigned int twl4030_audio_get_mclk(void)
>   }
>   EXPORT_SYMBOL_GPL(twl4030_audio_get_mclk);
>
> -static bool twl4030_audio_has_codec(struct twl4030_audio_data *pdata,
> +static bool twl4030_audio_has_codec(struct twl_audio_data *pdata,
>   			      struct device_node *node)
>   {
>   	if (pdata && pdata->codec)
> @@ -170,7 +170,7 @@ static bool twl4030_audio_has_codec(struct twl4030_audio_data *pdata,
>   	return false;
>   }
>
> -static bool twl4030_audio_has_vibra(struct twl4030_audio_data *pdata,
> +static bool twl4030_audio_has_vibra(struct twl_audio_data *pdata,
>   			      struct device_node *node)
>   {
>   	int vibra;
> @@ -187,7 +187,7 @@ static bool twl4030_audio_has_vibra(struct twl4030_audio_data *pdata,
>   static int twl4030_audio_probe(struct platform_device *pdev)
>   {
>   	struct twl4030_audio *audio;
> -	struct twl4030_audio_data *pdata = dev_get_platdata(&pdev->dev);
> +	struct twl_audio_data *pdata = dev_get_platdata(&pdev->dev);
>   	struct device_node *node = pdev->dev.of_node;
>   	struct mfd_cell *cell = NULL;
>   	int ret, childs = 0;
> diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
> index 04b5398..b8ce270 100644
> --- a/drivers/mfd/twl4030-power.c
> +++ b/drivers/mfd/twl4030-power.c
> @@ -265,7 +265,7 @@ out:
>   }
>
>   static int
> -twl4030_config_wakeup12_sequence(const struct twl4030_power_data *pdata,
> +twl4030_config_wakeup12_sequence(const struct twl_power_data *pdata,
>   				 u8 address)
>   {
>   	int err = 0;
> @@ -462,7 +462,7 @@ static int twl4030_configure_resource(struct twl4030_resconfig *rconfig)
>   	return 0;
>   }
>
> -static int load_twl4030_script(const struct twl4030_power_data *pdata,
> +static int load_twl4030_script(const struct twl_power_data *pdata,
>   			       struct twl4030_script *tscript,
>   			       u8 address)
>   {
> @@ -564,7 +564,7 @@ int twl4030_remove_script(u8 flags)
>   }
>
>   static int
> -twl4030_power_configure_scripts(const struct twl4030_power_data *pdata)
> +twl4030_power_configure_scripts(const struct twl_power_data *pdata)
>   {
>   	int err;
>   	int i;
> @@ -598,7 +598,7 @@ static void twl4030_patch_rconfig(struct twl4030_resconfig *common,
>   }
>
>   static int
> -twl4030_power_configure_resources(const struct twl4030_power_data *pdata)
> +twl4030_power_configure_resources(const struct twl_power_data *pdata)
>   {
>   	struct twl4030_resconfig *resconfig = pdata->resource_config;
>   	struct twl4030_resconfig *boardconf = pdata->board_config;
> @@ -677,7 +677,7 @@ void twl4030_power_off(void)
>   		pr_err("TWL4030 Unable to power off\n");
>   }
>
> -static bool twl4030_power_use_poweroff(const struct twl4030_power_data *pdata,
> +static bool twl4030_power_use_poweroff(const struct twl_power_data *pdata,
>   					struct device_node *node)
>   {
>   	if (pdata && pdata->use_poweroff)
> @@ -725,7 +725,7 @@ static struct twl4030_resconfig omap3_rconfig[] = {
>   	{ 0, 0 },
>   };
>
> -static struct twl4030_power_data omap3_reset = {
> +static struct twl_power_data omap3_reset = {
>   	.scripts		= omap3_reset_scripts,
>   	.num			= ARRAY_SIZE(omap3_reset_scripts),
>   	.resource_config	= omap3_rconfig,
> @@ -814,7 +814,7 @@ static struct twl4030_resconfig omap3_idle_rconfig[] = {
>   	{ /* Terminator */ },
>   };
>
> -static struct twl4030_power_data omap3_idle = {
> +static struct twl_power_data omap3_idle = {
>   	.scripts		= omap3_idle_scripts,
>   	.num			= ARRAY_SIZE(omap3_idle_scripts),
>   	.resource_config	= omap3_idle_rconfig,
> @@ -826,21 +826,21 @@ static struct twl4030_resconfig osc_off_rconfig[] = {
>   	{ /* Terminator */ },
>   };
>
> -static struct twl4030_power_data osc_off_idle = {
> +static struct twl_power_data osc_off_idle = {
>   	.scripts		= omap3_idle_scripts,
>   	.num			= ARRAY_SIZE(omap3_idle_scripts),
>   	.resource_config	= omap3_idle_rconfig,
>   	.board_config		= osc_off_rconfig,
>   };
>
> -static struct twl4030_power_data omap3_idle_ac_quirk = {
> +static struct twl_power_data omap3_idle_ac_quirk = {
>   	.scripts		= omap3_idle_scripts,
>   	.num			= ARRAY_SIZE(omap3_idle_scripts),
>   	.resource_config	= omap3_idle_rconfig,
>   	.ac_charger_quirk	= true,
>   };
>
> -static struct twl4030_power_data omap3_idle_ac_quirk_osc_off = {
> +static struct twl_power_data omap3_idle_ac_quirk_osc_off = {
>   	.scripts		= omap3_idle_scripts,
>   	.num			= ARRAY_SIZE(omap3_idle_scripts),
>   	.resource_config	= omap3_idle_rconfig,
> @@ -883,7 +883,7 @@ MODULE_DEVICE_TABLE(of, twl4030_power_of_match);
>
>   static int twl4030_power_probe(struct platform_device *pdev)
>   {
> -	const struct twl4030_power_data *pdata = dev_get_platdata(&pdev->dev);
> +	const struct twl_power_data *pdata = dev_get_platdata(&pdev->dev);
>   	struct device_node *node = pdev->dev.of_node;
>   	const struct of_device_id *match;
>   	int err = 0;
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index 27bea30..4e7ea5f 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -668,7 +668,7 @@ struct twl4030_resconfig {
>   	u8 remap_sleep;	/* sleep state remapping */
>   };
>
> -struct twl4030_power_data {
> +struct twl_power_data {
>   	struct twl4030_script **scripts;
>   	unsigned num;
>   	struct twl4030_resconfig *resource_config;
> @@ -693,7 +693,7 @@ struct twl4030_vibra_data {
>   	unsigned int	coexist;
>   };
>
> -struct twl4030_audio_data {
> +struct twl_audio_data {
>   	unsigned int	audio_mclk;
>   	struct twl4030_codec_data *codec;
>   	struct twl4030_vibra_data *vibra;
> @@ -705,6 +705,10 @@ struct twl4030_audio_data {
>   };
>
>   struct twl_platform_data {
> +	/* Common platform data */
> +	struct twl_audio_data			*audio;
> +	struct twl_power_data			*power;
> +
>   	/* TWL4030 platform data */
>   	struct twl4030_clock_init_data		*clock;
>   	struct twl4030_bci_platform_data	*bci;
> @@ -712,8 +716,6 @@ struct twl_platform_data {
>   	struct twl4030_madc_platform_data	*madc;
>   	struct twl4030_keypad_data		*keypad;
>   	struct twl4030_usb_data			*usb;
> -	struct twl4030_power_data		*power;
> -	struct twl4030_audio_data		*audio;
>
>   	/* Common LDO regulators for TWL4030/TWL6030 */
>   	struct regulator_init_data		*vdac;
>


-- 
regards,
-grygorii
