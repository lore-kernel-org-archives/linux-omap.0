From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: Fixes the DSP crash when driver is unloaded.
Date: Wed, 1 Jul 2009 10:25:35 -0500
Message-ID: <496565EC904933469F292DDA3F1663E602A2C9D229@dlee06.ent.ti.com>
References: <1246455159-7420-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56573 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715AbZGAPZm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Jul 2009 11:25:42 -0400
In-Reply-To: <1246455159-7420-1-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>


Hi Ameya,

	I have test the patch and it works and fixes the problem, thanks.

> -----Original Message-----
> From: Ameya Palande [mailto:ameya.palande@nokia.com]
> Sent: Wednesday, July 01, 2009 8:33 AM
> To: linux-omap@vger.kernel.org
> Cc: Kanigeri, Hari; Ramirez Luna, Omar; Guzman Lugo, Fernando
> Subject: [PATCH] DSPBRIDGE: Fixes the DSP crash when driver is unloaded.
> 
> From: Roman Tereshonkov <roman.tereshonkov@nokia.com>
> 
> clk_notifier_unregister should be run before data structures are freed,
> otherwise it will try to access to NULLed data.
> 
> Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  drivers/dsp/bridge/rmgr/drv_interface.c |   29 ++++++++++++++++----------
> ---
>  1 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c
> b/drivers/dsp/bridge/rmgr/drv_interface.c
> index f41e153..12b140c 100644
> --- a/drivers/dsp/bridge/rmgr/drv_interface.c
> +++ b/drivers/dsp/bridge/rmgr/drv_interface.c
> @@ -452,6 +452,17 @@ static int __devexit omap34xx_bridge_remove(struct
> platform_device *pdev)
>  	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
>  	if (DSP_FAILED(dsp_status))
>  		goto func_cont;
> +
> +#ifdef CONFIG_BRIDGE_DVFS
> +	if (!clk_notifier_unregister(clk_handle, &iva_clk_notifier)) {
> +		GT_0trace(driverTrace, GT_7CLASS,
> +		"clk_notifier_unregister PASS for iva2_ck \n");
> +	} else {
> +		GT_0trace(driverTrace, GT_7CLASS,
> +		"clk_notifier_unregister FAILED for iva2_ck \n");
> +	}
> +#endif /* #ifdef CONFIG_BRIDGE_DVFS */
> +
>  	DRV_GetProcCtxtList(&pCtxtclosed, (struct DRV_OBJECT *)hDrvObject);
>  	while (pCtxtclosed != NULL) {
>  		GT_1trace(driverTrace, GT_5CLASS, "***Cleanup of "
> @@ -463,28 +474,20 @@ static int __devexit omap34xx_bridge_remove(struct
> platform_device *pdev)
>  				     pCtxtclosed, (void *)pCtxtclosed->pid);
>  		pCtxtclosed = pTmp;
>  	}
> -func_cont:
> +
>  	if (driverContext) {
>  		/* Put the DSP in reset state */
>  		ret = DSP_Deinit(driverContext);
>  		driverContext = 0;
>  		DBC_Assert(ret == true);
>  	}
> -	SERVICES_Exit();
> -	GT_exit();
> -	/* unregister the clock notifier */
> -#ifdef CONFIG_BRIDGE_DVFS
> -	if (!clk_notifier_unregister(clk_handle, &iva_clk_notifier)) {
> -		GT_0trace(driverTrace, GT_7CLASS,
> -		"clk_notifier_unregister PASS for iva2_ck \n");
> -	} else {
> -		GT_0trace(driverTrace, GT_7CLASS,
> -		"clk_notifier_unregister PASS for iva2_ck \n");
> -	}
> 
>  	clk_put(clk_handle);
>  	clk_handle = NULL;
> -#endif /* #ifdef CONFIG_BRIDGE_DVFS */
> +
> +func_cont:
> +	SERVICES_Exit();
> +	GT_exit();
> 
>  	devno = MKDEV(driver_major, driver_minor);
>  	if (bridge_device) {
> --
> 1.6.2.4
> 

Acked-by Fernando Guzman Lugo <x0095840@ti.com>

