From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v5 11/14] ARM: OMAP2+: gpmc: handle connected peripherals
Date: Wed, 13 Jun 2012 10:31:08 -0500
Message-ID: <4FD8B23C.4020900@ti.com>
References: <cover.1339419492.git.afzal@ti.com> <5b3939381db2b7ac29d9df1e817af2ce80016007.1339419492.git.afzal@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35319 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255Ab2FMPbJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jun 2012 11:31:09 -0400
In-Reply-To: <5b3939381db2b7ac29d9df1e817af2ce80016007.1339419492.git.afzal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Afzal Mohammed <afzal@ti.com>
Cc: tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Afzal,

On 06/11/2012 09:27 AM, Afzal Mohammed wrote:
> Platform will provide driver with configuration details for
> each CS like configuration, timing, interrupts. Setup GPMC
> based on it. Platform data also provides platform data &
> resources used for connected peripheral (eg. gpio irq).
> GPMC driver tunnels those information to respective driver.
> 
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> ---
>  arch/arm/mach-omap2/gpmc.c |  146 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 146 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 9073a8a..281bd23 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -155,6 +155,8 @@ struct gpmc_peripheral {
>  	struct platform_device	*pdev;
>  };
>  
> +static struct gpmc_peripheral gpmc_peripheral[GPMC_CS_NUM];
> +static unsigned gpmc_num_peripheral;
>  static unsigned gpmc_waitpin_map;
>  
>  static struct gpmc_client_irq gpmc_client_irq[GPMC_NR_IRQ];
> @@ -1235,6 +1237,39 @@ static int gpmc_setup_cs_waitpin(struct gpmc_peripheral *g_per, unsigned cs,
>  	return 0;
>  }
>  
> +static int gpmc_setup_cs_config_timing(struct gpmc_peripheral *g_per,
> +						struct gpmc_cs_data *cs)
> +{
> +	int ret;
> +
> +	/* some boards rely on bootloader for configuration */
> +	if (cs->have_config) {
> +		gpmc_setup_cs_config(cs->cs, cs->config);
> +		ret = gpmc_setup_cs_waitpin(g_per, cs->cs, cs->config);
> +		if (IS_ERR_VALUE(ret)) {
> +			dev_err(gpmc_dev, "error: waitpin on CS %d\n", cs->cs);
> +			return ret;
> +		}
> +	} else
> +		gpmc_print_cs_config(cs->cs);
> +
> +	/* some boards rely on bootloader for timing */
> +	if (cs->time_ctrl.type == has_period) {
> +		ret = gpmc_cs_set_timings(cs->cs, &cs->time_ctrl.timings);
> +		if (IS_ERR_VALUE(ret)) {
> +			dev_err(gpmc_dev, "error: timing on CS: %d\n", cs->cs);
> +			return ret;
> +		}
> +		gpmc_cs_misc_timings(cs->cs, &cs->time_ctrl.bool_timings);
> +	} else if (cs->time_ctrl.type == has_clock) {
> +		gpmc_cs_set_register_timings(cs->cs, &cs->time_ctrl.timings);
> +		gpmc_cs_misc_timings(cs->cs, &cs->time_ctrl.bool_timings);
> +	} else
> +		gpmc_print_cs_timings(cs->cs);
> +
> +	return 0;
> +}
> +
>  static inline unsigned gpmc_bit_to_irq(unsigned bitmask)
>  {
>  	return bitmask;
> @@ -1307,10 +1342,100 @@ static int gpmc_setup_waitpin(struct gpmc_peripheral *g_per)
>  	return 0;
>  }
>  
> +static __devinit int gpmc_setup_cs(struct gpmc_peripheral *g_per,
> +				struct gpmc_cs_data *cs, struct resource *res)
> +{
> +	int num, ret;
> +
> +	num = gpmc_setup_cs_mem(cs, res);
> +	if (IS_ERR_VALUE(num))
> +		return num;
> +
> +	ret = gpmc_setup_cs_config_timing(g_per, cs);
> +	if (IS_ERR_VALUE(ret))
> +		return ret;
> +
> +	num += gpmc_setup_cs_irq(cs, res + num);


What happens if the above function returns an error?

Jon
