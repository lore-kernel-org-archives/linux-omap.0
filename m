From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH 1/8] mfd: twl-core: Rename struct twl4030_platform_data to
 twl_platform_data
Date: Wed, 30 Mar 2016 18:20:41 +0300
Message-ID: <56FBEEC9.1020508@ti.com>
References: <1459279341-17389-1-git-send-email-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1459279341-17389-1-git-send-email-contact@paulk.fr>
Sender: linux-pm-owner@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
List-Id: linux-omap@vger.kernel.org

On 03/29/2016 10:22 PM, Paul Kocialkowski wrote:
> Since twl4030_platform_data also holds platform data (e.g. regulators) for other
> TWL chips, it makes sense to rename it to a non-model-specific name.
>
> This will also allow hooking more platform data structure to it in the future.

Do we really need this patch?
In general ldb and r51 board files are going to be dropped soon and
it not expected to support this PMIC devices for non-DT use cases.
As result twl4030_platform_data will be dropped at all or made private.

>
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>   arch/arm/mach-omap2/board-ldp.c              |  2 +-
>   arch/arm/mach-omap2/board-rx51-peripherals.c |  2 +-
>   arch/arm/mach-omap2/twl-common.c             |  8 ++++----
>   arch/arm/mach-omap2/twl-common.h             | 14 +++++++-------
>   drivers/mfd/twl-core.c                       |  4 ++--
>   include/linux/i2c/twl.h                      |  3 ++-
>   6 files changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
> index d9c3ffc..b8c2e21 100644
> --- a/arch/arm/mach-omap2/board-ldp.c
> +++ b/arch/arm/mach-omap2/board-ldp.c
> @@ -321,7 +321,7 @@ static struct regulator_init_data ldp_vpll2 = {
>   	.consumer_supplies	= ldp_vpll2_supplies,
>   };
>
> -static struct twl4030_platform_data ldp_twldata = {
> +static struct twl_platform_data ldp_twldata = {
>   	/* platform_data for children goes here */
>   	.vmmc1		= &ldp_vmmc1,
>   	.vaux1		= &ldp_vaux1,
> diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
> index da174c0..3739bff 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
> @@ -957,7 +957,7 @@ static struct twl4030_audio_data rx51_audio_data __initdata = {
>   	.vibra		= &rx51_vibra_data,
>   };
>
> -static struct twl4030_platform_data rx51_twldata __initdata = {
> +static struct twl_platform_data rx51_twldata __initdata = {
>   	/* platform_data for children goes here */
>   	.gpio			= &rx51_gpio_data,
>   	.keypad			= &rx51_kp_data,
> diff --git a/arch/arm/mach-omap2/twl-common.c b/arch/arm/mach-omap2/twl-common.c
> index 292eca0..4e6532f 100644
> --- a/arch/arm/mach-omap2/twl-common.c
> +++ b/arch/arm/mach-omap2/twl-common.c
> @@ -55,7 +55,7 @@ static int twl_get_voltage(void *data)
>
>   void __init omap_pmic_init(int bus, u32 clkrate,
>   			   const char *pmic_type, int pmic_irq,
> -			   struct twl4030_platform_data *pmic_data)
> +			   struct twl_platform_data *pmic_data)
>   {
>   	omap_mux_init_signal("sys_nirq", OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE);
>   	strlcpy(pmic_i2c_board_info.type, pmic_type,
> @@ -68,7 +68,7 @@ void __init omap_pmic_init(int bus, u32 clkrate,
>
>   #ifdef CONFIG_ARCH_OMAP4
>   void __init omap4_pmic_init(const char *pmic_type,
> -		    struct twl4030_platform_data *pmic_data,
> +		    struct twl_platform_data *pmic_data,
>   		    struct i2c_board_info *devices, int nr_devices)
>   {
>   	/* PMIC part*/
> @@ -205,7 +205,7 @@ static struct twl_regulator_driver_data omap3_vdd2_drvdata = {
>   	.set_voltage = twl_set_voltage,
>   };
>
> -void __init omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
> +void __init omap3_pmic_get_config(struct twl_platform_data *pmic_data,
>   				  u32 pdata_flags, u32 regulators_flags)
>   {
>   	if (!pmic_data->vdd1) {
> @@ -470,7 +470,7 @@ static struct regulator_init_data omap4_v2v1_idata = {
>   	.consumer_supplies	= omap4_v2v1_supply,
>   };
>
> -void __init omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
> +void __init omap4_pmic_get_config(struct twl_platform_data *pmic_data,
>   				  u32 pdata_flags, u32 regulators_flags)
>   {
>   	if (!pmic_data->vdd1) {
> diff --git a/arch/arm/mach-omap2/twl-common.h b/arch/arm/mach-omap2/twl-common.h
> index 24b65d0..e7caa23 100644
> --- a/arch/arm/mach-omap2/twl-common.h
> +++ b/arch/arm/mach-omap2/twl-common.h
> @@ -30,35 +30,35 @@
>   #define TWL_COMMON_REGULATOR_VPLL2	(1 << 5)
>
>
> -struct twl4030_platform_data;
> +struct twl_platform_data;
>   struct twl6040_platform_data;
>   struct omap_tw4030_pdata;
>   struct i2c_board_info;
>
>   void omap_pmic_init(int bus, u32 clkrate, const char *pmic_type, int pmic_irq,
> -		    struct twl4030_platform_data *pmic_data);
> +		    struct twl_platform_data *pmic_data);
>   void omap_pmic_late_init(void);
>
>   static inline void omap2_pmic_init(const char *pmic_type,
> -				   struct twl4030_platform_data *pmic_data)
> +				   struct twl_platform_data *pmic_data)
>   {
>   	omap_pmic_init(2, 2600, pmic_type, 7 + OMAP_INTC_START, pmic_data);
>   }
>
>   static inline void omap3_pmic_init(const char *pmic_type,
> -				   struct twl4030_platform_data *pmic_data)
> +				   struct twl_platform_data *pmic_data)
>   {
>   	omap_pmic_init(1, 2600, pmic_type, 7 + OMAP_INTC_START, pmic_data);
>   }
>
>   void omap4_pmic_init(const char *pmic_type,
> -		    struct twl4030_platform_data *pmic_data,
> +		    struct twl_platform_data *pmic_data,
>   		    struct i2c_board_info *devices, int nr_devices);
>
> -void omap3_pmic_get_config(struct twl4030_platform_data *pmic_data,
> +void omap3_pmic_get_config(struct twl_platform_data *pmic_data,
>   			   u32 pdata_flags, u32 regulators_flags);
>
> -void omap4_pmic_get_config(struct twl4030_platform_data *pmic_data,
> +void omap4_pmic_get_config(struct twl_platform_data *pmic_data,
>   			   u32 pdata_flags, u32 regulators_flags);
>
>   void omap_twl4030_audio_init(char *card_name, struct omap_tw4030_pdata *pdata);
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index 831696e..dae52f7 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -721,7 +721,7 @@ add_regulator(int num, struct regulator_init_data *pdata,
>    */
>
>   static int
> -add_children(struct twl4030_platform_data *pdata, unsigned irq_base,
> +add_children(struct twl_platform_data *pdata, unsigned irq_base,
>   		unsigned long features)
>   {
>   	struct device	*child;
> @@ -1083,7 +1083,7 @@ static struct of_dev_auxdata twl_auxdata_lookup[] = {
>   static int
>   twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
>   {
> -	struct twl4030_platform_data	*pdata = dev_get_platdata(&client->dev);
> +	struct twl_platform_data	*pdata = dev_get_platdata(&client->dev);
>   	struct device_node		*node = client->dev.of_node;
>   	struct platform_device		*pdev;
>   	const struct regmap_config	*twl_regmap_config;
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index 9ad7828..27bea30 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -704,7 +704,8 @@ struct twl4030_audio_data {
>   	unsigned int irq_base;
>   };
>
> -struct twl4030_platform_data {
> +struct twl_platform_data {
> +	/* TWL4030 platform data */
>   	struct twl4030_clock_init_data		*clock;
>   	struct twl4030_bci_platform_data	*bci;
>   	struct twl4030_gpio_platform_data	*gpio;
>


-- 
regards,
-grygorii
