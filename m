From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH] DSPBRIDGE: CLK_Enable and CLK_Disable Code cleanup
Date: Fri, 17 Apr 2009 08:05:15 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E23958AAB@dlee03.ent.ti.com>
References: <1239797948-30199-1-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48268 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469AbZDQNF1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Apr 2009 09:05:27 -0400
In-Reply-To: <1239797948-30199-1-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Ameya,

Patch looks good to me.

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Ameya Palande
> Sent: Wednesday, April 15, 2009 7:19 AM
> To: linux-omap@vger.kernel.org
> Subject: [PATCH] DSPBRIDGE: CLK_Enable and CLK_Disable Code cleanup
> 
> This patch does following things:
> 1. Instead of GT_2trace() use pr_err(), since failure to enable or disable
> a
>    clock is error which should be notified.
> 2. There is no need to check the return value of CLK_Enable and
> CLK_Disable
>    and print error message, since these functions internally print the
> error.
> 3. Indentation changes and a typo fix.
> 
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> ---
>  drivers/dsp/bridge/services/clk.c       |   42 ++++++++++++++------------
> ----
>  drivers/dsp/bridge/wmd/tiomap3430.c     |   13 +--------
>  drivers/dsp/bridge/wmd/tiomap3430_pwr.c |   22 ++++-----------
>  3 files changed, 28 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/services/clk.c
> b/drivers/dsp/bridge/services/clk.c
> index 440706f..fbbde72 100644
> --- a/drivers/dsp/bridge/services/clk.c
> +++ b/drivers/dsp/bridge/services/clk.c
> @@ -188,7 +188,7 @@ DSP_STATUS CLK_Enable(IN enum SERVICES_ClkId clk_id)
>  	struct clk *pClk;
> 
>  	DBC_Require(clk_id < SERVICESCLK_NOT_DEFINED);
> -       GT_2trace(CLK_debugMask, GT_6CLASS, "CLK_Enable: CLK %s, "
> +	GT_2trace(CLK_debugMask, GT_6CLASS, "CLK_Enable: CLK %s, "
>  		"CLK dev id = %d\n", SERVICES_Clks[clk_id].clk_name,
>  		SERVICES_Clks[clk_id].id);
> 
> @@ -197,18 +197,16 @@ DSP_STATUS CLK_Enable(IN enum SERVICES_ClkId clk_id)
>  		if (clk_enable(pClk) == 0x0) {
>  			/* Success ? */
>  		} else {
> -		       GT_2trace(CLK_debugMask, GT_7CLASS,
> -				 "CLK_Enable: failed to Enable CLK %s, "
> -				 "CLK dev id = %d\n",
> -				 SERVICES_Clks[clk_id].clk_name,
> -				 SERVICES_Clks[clk_id].id);
> +			pr_err("CLK_Enable: failed to Enable CLK %s, "
> +					"CLK dev id = %d\n",
> +					SERVICES_Clks[clk_id].clk_name,
> +					SERVICES_Clks[clk_id].id);
>  			status = DSP_EFAIL;
>  		}
>  	} else {
> -	       GT_2trace(CLK_debugMask, GT_7CLASS,
> -			 "CLK_Enable: failed to get CLK %s, CLK dev id = %d\n",
> -			 SERVICES_Clks[clk_id].clk_name,
> -			 SERVICES_Clks[clk_id].id);
> +		pr_err("CLK_Enable: failed to get CLK %s, CLK dev id = %d\n",
> +					SERVICES_Clks[clk_id].clk_name,
> +					SERVICES_Clks[clk_id].id);
>  		status = DSP_EFAIL;
>  	}
>  	/* The SSI module need to configured not to have the Forced idle for
> @@ -274,15 +272,15 @@ DSP_STATUS CLK_Disable(IN enum SERVICES_ClkId
> clk_id)
> 
>  	clkUseCnt = CLK_Get_UseCnt(clk_id);
>  	if (clkUseCnt == -1) {
> -	       GT_2trace(CLK_debugMask, GT_7CLASS, "CLK_Disable: failed to "
> -			"get CLK Use count for CLK %s, CLK dev id = %d\n",
> -			SERVICES_Clks[clk_id].clk_name,
> -			SERVICES_Clks[clk_id].id);
> +		pr_err("CLK_Disable: failed to get CLK Use count for CLK %s,
> +				CLK dev id = %d\n",
> +				SERVICES_Clks[clk_id].clk_name,
> +				SERVICES_Clks[clk_id].id);
>  	} else if (clkUseCnt == 0) {
> -	       GT_2trace(CLK_debugMask, GT_7CLASS, "CLK_Disable: CLK %s, "
> -			"CLK dev id= %d is already disabled\n",
> -			SERVICES_Clks[clk_id].clk_name,
> -			SERVICES_Clks[clk_id].id);
> +		pr_err("CLK_Disable: CLK %s, CLK dev id= %d is already
> +				disabled\n",
> +				SERVICES_Clks[clk_id].clk_name,
> +				SERVICES_Clks[clk_id].id);
>  		 return status;
>  	}
>  	if (clk_id == SERVICESCLK_ssi_ick)
> @@ -291,10 +289,10 @@ DSP_STATUS CLK_Disable(IN enum SERVICES_ClkId
> clk_id)
>  		if (pClk) {
>  			clk_disable(pClk);
>  		} else {
> -		       GT_2trace(CLK_debugMask, GT_7CLASS, "CLK_Disable: "
> -				"failed to get CLK %s, CLK dev id = %d\n",
> -				SERVICES_Clks[clk_id].clk_name,
> -				SERVICES_Clks[clk_id].id);
> +			pr_err("CLK_Disable: failed to get CLK %s,
> +					CLK dev id = %d\n",
> +					SERVICES_Clks[clk_id].clk_name,
> +					SERVICES_Clks[clk_id].id);
>  			status = DSP_EFAIL;
>  		}
>  	return status;
> diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c
> b/drivers/dsp/bridge/wmd/tiomap3430.c
> index 7fa6f8e..606de3c 100644
> --- a/drivers/dsp/bridge/wmd/tiomap3430.c
> +++ b/drivers/dsp/bridge/wmd/tiomap3430.c
> @@ -2119,7 +2119,6 @@ static DSP_STATUS run_IdleBoot(u32 prm_base, u32
> cm_base,
>  {
>  	u32 temp;
>  	DSP_STATUS status = DSP_SOK;
> -	DSP_STATUS clk_status = DSP_SOK;
>  	enum HW_PwrState_t    pwrState;
> 
>  	/* Read PM_PWSTST_IVA2 */
> @@ -2134,11 +2133,7 @@ static DSP_STATUS run_IdleBoot(u32 prm_base, u32
> cm_base,
>  		/* Wait until the state has moved to ON */
>  		HW_PWR_IVA2StateGet(prm_base, HW_PWR_DOMAIN_DSP, &pwrState);
>  	}
> -	clk_status = CLK_Disable(SERVICESCLK_iva2_ck);
> -	if (DSP_FAILED(clk_status)) {
> -		DBG_Trace(DBG_LEVEL6, "CLK_Disbale failed for clk = 0x%x \n",
> -			  SERVICESCLK_iva2_ck);
> -	}
> +	CLK_Disable(SERVICESCLK_iva2_ck);
>  	udelay(10);
>  	/* Assert IVA2-RST1 and IVA2-RST2  */
>  	*((REG_UWORD32 *)((u32)(prm_base) + 0x50)) = (u32)0x07;
> @@ -2155,11 +2150,7 @@ static DSP_STATUS run_IdleBoot(u32 prm_base, u32
> cm_base,
>                 temp =  (temp & 0xFFFFFC8) | 0x37;
>                 *((REG_UWORD32 *) ((u32) (cm_base) + 0x4))
>                         (u32) temp;
> -	clk_status = CLK_Enable(SERVICESCLK_iva2_ck);
> -	if (DSP_FAILED(clk_status)) {
> -		DBG_Trace(DBG_LEVEL6, "CLK_Enable failed for clk = 0x%x \n",
> -			  SERVICESCLK_iva2_ck);
> -	}
> +	CLK_Enable(SERVICESCLK_iva2_ck);
>  	udelay(20);
>  	GetHWRegs(prm_base, cm_base);
>  	/* Release Reset1 and Reset2 */
> diff --git a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> index 488a512..1ad1565 100644
> --- a/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> +++ b/drivers/dsp/bridge/wmd/tiomap3430_pwr.c
> @@ -285,7 +285,7 @@ DSP_STATUS WakeDSP(struct WMD_DEV_CONTEXT
> *pDevContext, IN void *pArgs)
>  #ifdef CONFIG_PM
>  	struct CFG_HOSTRES resources;
>  	enum HW_PwrState_t pwrState;
> -       u32 temp;
> +	u32 temp;
> 
>  	status = CFG_GetHostResources(
>  		 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
> &resources);
> @@ -306,7 +306,7 @@ DSP_STATUS WakeDSP(struct WMD_DEV_CONTEXT
> *pDevContext, IN void *pArgs)
>  		 pDevContext->uDspPerClks);
>  	status = DSP_PeripheralClocks_Enable(pDevContext, NULL);
> 
> -       /* Enablifg Dppll in lock mode*/
> +	/* Enabling Dppll in lock mode */
>                 temp = (u32) *((REG_UWORD32 *)
>                         ((u32) (resources.dwCmBase) + 0x34));
>                 temp = (temp & 0xFFFFFFFE) | 0x1;
> @@ -546,27 +546,17 @@ DSP_STATUS DSP_PeripheralClocks_Enable(struct
> WMD_DEV_CONTEXT *pDevContext,
>  				      IN void *pArgs)
>  {
>  	u32 clkIdx;
> -	DSP_STATUS status = DSP_SOK;
> +	DSP_STATUS int_clk_status = DSP_EFAIL, fun_clk_status = DSP_EFAIL;
> 
>  	for (clkIdx = 0; clkIdx < MBX_PM_MAX_RESOURCES; clkIdx++) {
>  		if (((pDevContext->uDspPerClks) >> clkIdx) & 0x01) {
>  			/* Enable the interface clock of the peripheral */
> -			status = CLK_Enable(BPWR_Clks[clkIdx].intClk);
> -			if (DSP_FAILED(status)) {
> -				DBG_Trace(DBG_LEVEL7,
> -					 "Failed to Enable the DSP Peripheral"
> -					 "Clk 0x%x \n", BPWR_Clks[clkIdx]);
> -			}
> +			int_clk_status = CLK_Enable(BPWR_Clks[clkIdx].intClk);
>  			/* Enable the functional clock of the periphearl */
> -			status = CLK_Enable(BPWR_Clks[clkIdx].funClk);
> -			if (DSP_FAILED(status)) {
> -				DBG_Trace(DBG_LEVEL7,
> -					 "Failed to Enable the DSP Peripheral"
> -					 "Clk 0x%x \n", BPWR_Clks[clkIdx]);
> -			}
> +			fun_clk_status = CLK_Enable(BPWR_Clks[clkIdx].funClk);
>  		}
>  	}
> -	return status;
> +	return ((int_clk_status | fun_clk_status) != DSP_OK) ? DSP_EFAIL :
> DSP_OK;
>  }
> 
>  void DSPClkWakeupEventCtrl(u32 ClkId, bool enable)
> --
> 1.6.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

