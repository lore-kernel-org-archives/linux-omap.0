From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] OMAP3EVM: ehci: Fix EHCI support
Date: Wed, 24 Aug 2011 11:07:32 +0300
Message-ID: <4E54B144.8010702@compulab.co.il>
References: <1314112595-14849-1-git-send-email-bdefaria@adeneo-embedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1314112595-14849-1-git-send-email-bdefaria@adeneo-embedded.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Once again my mailer played me... sending for the second time... sorry

Hi Bryan,

Please, CC linux-arm-kernel@lists.infradead.org for patches like this.
One question below

On 08/23/11 18:16, Bryan DE FARIA wrote:
> Set the VAUX2 regulator supply to 1.8V for the HSUSB host interface.
> Gpio 2 of the TPS65950 has to be set to zero in order to enable the HSUBS2 clock.
> 
> Signed-off-by: Bryan DE FARIA <bdefaria@adeneo-embedded.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
> index c452b3f..ce09e9e 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -377,6 +377,10 @@ static int omap3evm_twl_gpio_setup(struct device *dev,
>  	if (r)
>  		printk(KERN_ERR "failed to get/set lcd_bkl gpio\n");
>  
> +	/* gpio + 2 == HSUSB2 Clock Enable */
> +	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2)
> +		gpio_request_one(gpio + 2, GPIOF_OUT_INIT_LOW, "EN_HSUSB2_CLK");
> +
>  	/* gpio + 7 == DVI Enable */
>  	gpio_request_one(gpio + 7, GPIOF_OUT_INIT_LOW, "EN_DVI");
>  
> @@ -450,6 +454,25 @@ static struct regulator_init_data omap3evm_vio = {
>  	.consumer_supplies	= omap3evm_vio_supply,
>  };
>  
> +/* VAUX2 for EHCI */
> +static struct regulator_consumer_supply omap3evm_vaux2_supplies[] = {
> +	REGULATOR_SUPPLY("hsusb1", "ehci-omap.0"),
> +};
> +
> +static struct regulator_init_data omap3evm_vaux2 = {
> +	.constraints = {
> +		.min_uV      		= 1800000,
> +		.max_uV      		= 1800000,
> +		.apply_uV    		= true,
> +		.valid_modes_mask  	= REGULATOR_MODE_NORMAL
> +					| REGULATOR_MODE_STANDBY,
> +		.valid_ops_mask  	= REGULATOR_CHANGE_MODE
> +					| REGULATOR_CHANGE_STATUS,
> +	},
> +	.num_consumer_supplies  = ARRAY_SIZE(omap3evm_vaux2_supplies),
> +	.consumer_supplies   	= omap3evm_vaux2_supplies,
> +};
> +
>  #ifdef CONFIG_WL12XX_PLATFORM_DATA
>  
>  #define OMAP3EVM_WLAN_PMENA_GPIO	(150)
> @@ -645,6 +668,7 @@ static void __init omap3_evm_init(void)
>  	usb_nop_xceiv_register();
>  
>  	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2) {
> +		omap3evm_twldata.vaux2 = &omap3evm_vaux2;

Wouldn't it be better to put this inside the omap3_evm_i2c_init() function
so all the initialization of that type be close to each other
and done before the omap3_pmic_init() call?

-- 
Regards,
Igor.
