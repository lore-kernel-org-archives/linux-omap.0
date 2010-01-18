From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH 2/3] DSPBRIDGE: change to cpufreq_register_notifier for
 OPP changes
Date: Mon, 18 Jan 2010 12:20:19 +0200
Message-ID: <1263810019.1968.7.camel@sanganak>
References: <1263607307-21693-1-git-send-email-omar.ramirez@ti.com>
	 <1263607307-21693-2-git-send-email-omar.ramirez@ti.com>
	 <1263607307-21693-3-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:18605 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093Ab0ARKU7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jan 2010 05:20:59 -0500
In-Reply-To: <1263607307-21693-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Fernando Guzman Lugo <x0095840@ti.com>

On Sat, 2010-01-16 at 03:01 +0100, ext Omar Ramirez Luna wrote:
> From: Fernando Guzman Lugo <x0095840@ti.com>
> 
> This patch changes clk_notifier_unregister with
> cpufreq_unregister_notifier, which is used for OPP change
> notifications
> 
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> ---
>  drivers/dsp/bridge/Kconfig              |    2 +-
>  drivers/dsp/bridge/rmgr/drv_interface.c |   25 +++++++++++++++----------
>  2 files changed, 16 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/Kconfig b/drivers/dsp/bridge/Kconfig
> index e494f02..ea639e3 100644
> --- a/drivers/dsp/bridge/Kconfig
> +++ b/drivers/dsp/bridge/Kconfig
> @@ -13,7 +13,7 @@ menuconfig MPU_BRIDGE
>  
>  config BRIDGE_DVFS
>  	bool "Enable Bridge Dynamic Voltage and Frequency Scaling (DVFS)"
> -	depends on MPU_BRIDGE && OMAP_PM_SRF
> +	depends on MPU_BRIDGE && OMAP_PM_SRF && CPU_FREQ
>  	default n
>  	help
>  	  DVFS allows DSP Bridge to initiate the operating point change to
> diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
> index 8fce70c..19682b5 100644
> --- a/drivers/dsp/bridge/rmgr/drv_interface.c
> +++ b/drivers/dsp/bridge/rmgr/drv_interface.c
> @@ -236,15 +236,18 @@ u32 vdd1_dsp_freq[6][4] = {
>  };
>  
>  #ifdef CONFIG_BRIDGE_DVFS
> -static int dspbridge_post_scale(struct notifier_block *op, unsigned long level,
> -				void *ptr)
> +static int dspbridge_scale_notification(struct notifier_block *op,
> +		unsigned long val, void *ptr)
>  {
> -	PWR_PM_PostScale(PRCM_VDD1, level);
> +	struct dspbridge_platform_data *pdata =
> +					omap_dspbridge_dev->dev.platform_data;
> +	if (CPUFREQ_POSTCHANGE == val && pdata->dsp_get_opp)
> +		PWR_PM_PostScale(PRCM_VDD1, pdata->dsp_get_opp());
>  	return 0;
>  }
>  
>  static struct notifier_block iva_clk_notifier = {
> -	.notifier_call = dspbridge_post_scale,
> +	.notifier_call = dspbridge_scale_notification,
>  	NULL,
>  };
>  #endif
> @@ -380,12 +383,13 @@ static int __devinit omap34xx_bridge_probe(struct platform_device *pdev)
>  			GT_0trace(driverTrace, GT_7CLASS,
>  			"clk_get PASS to get iva2_ck \n");
>  		}
> -		if (!clk_notifier_register(clk_handle, &iva_clk_notifier)) {
> +		if (!cpufreq_register_notifier(&iva_clk_notifier,
> +						CPUFREQ_TRANSITION_NOTIFIER)) {
>  			GT_0trace(driverTrace, GT_7CLASS,
> -			"clk_notifier_register PASS for iva2_ck \n");
> +				"cpufreq_register_notifier PASS for iva2_ck\n");
>  		} else {
>  			GT_0trace(driverTrace, GT_7CLASS,
> -			"clk_notifier_register FAIL for iva2_ck \n");
> +				"cpufreq_register_notifier FAIL for iva2_ck\n");
>  		}
>  #endif
>  		driverContext = DSP_Init(&initStatus);
> @@ -429,12 +433,13 @@ static int __devexit omap34xx_bridge_remove(struct platform_device *pdev)
>  		goto func_cont;
>  
>  #ifdef CONFIG_BRIDGE_DVFS
> -	if (!clk_notifier_unregister(clk_handle, &iva_clk_notifier)) {
> +	if (!cpufreq_unregister_notifier(&iva_clk_notifier,
> +						CPUFREQ_TRANSITION_NOTIFIER)) {
>  		GT_0trace(driverTrace, GT_7CLASS,
> -		"clk_notifier_unregister PASS for iva2_ck \n");
> +			"cpufreq_unregister_notifier PASS for iva2_ck\n");
>  	} else {
>  		GT_0trace(driverTrace, GT_7CLASS,
> -		"clk_notifier_unregister FAILED for iva2_ck \n");
> +			"cpufreq_unregister_notifier FAILED for iva2_ck\n");
>  	}
>  #endif /* #ifdef CONFIG_BRIDGE_DVFS */
>  

Acked-by: Ameya Palande <ameya.palande@nokia.com>

