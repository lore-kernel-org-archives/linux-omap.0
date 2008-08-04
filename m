From: Riku Voipio <riku.voipio@iki.fi>
Subject: Re: [PATCH 07/07][GIT 3/4+] Renaming CFG_GetC55Procs
Date: Mon, 4 Aug 2008 18:11:05 +0300
Message-ID: <20080804151105.GA25489@kos.to>
References: <27F9C60D11D683428E133F85D2BB4A530804B519@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from naru.obs2.net ([84.20.150.76]:37591 "EHLO narury.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286AbYHDPLJ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Aug 2008 11:11:09 -0400
Content-Disposition: inline
In-Reply-To: <27F9C60D11D683428E133F85D2BB4A530804B519@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <x00omar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Mon, Aug 04, 2008 at 09:56:31AM -0500, Ramirez Luna, Omar wrote:
> Renaming CFG_GetC55Procs function for a more proper name (CFG_GetDSPProcs) and removed redundant initialization statements.

Why does this function need to exist in the first place? The only place
this is ever going to be used print a trace message on how many
dsp's there are... Just eliminate the CFG_GetC55Procs please.

> ---
> Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/cfg.h
> ===================================================================
> --- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/inc/cfg.h  2008-07-29 23:52:55.000000000 -0500
> +++ omapkernel/drivers/dsp/dspbridge/mpu_driver/inc/cfg.h       2008-07-29 23:56:40.000000000 -0500
> @@ -337,6 +337,6 @@
>   */
>         extern DSP_STATUS CFG_SetObject(IN u32 dwValue, IN u32 dwType);
> 
> -       extern DSP_STATUS CFG_GetC55Procs(OUT u32 *numProcs);
> +       extern DSP_STATUS CFG_GetDSPProcs(OUT u32 *numProcs);
> 
>  #endif                         /* CFG_ */
> Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/rmgr/dspdrv.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/rmgr/dspdrv.c  2008-07-29 23:56:26.000000000 -0500
> +++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/rmgr/dspdrv.c       2008-07-29 23:56:40.000000000 -0500
> @@ -156,7 +156,7 @@
>                 goto func_cont;
>         }               /* End DRV_Create */
>         GT_0trace(curTrace, GT_5CLASS, "DSP_Init:DRV Created \r\n");
> -       status = CFG_GetC55Procs(&numProcs);
> +       status = CFG_GetDSPProcs(&numProcs);
>         GT_1trace(curTrace, GT_5CLASS, "DSP_Init:C55 procs configured = %d\n",
>                   numProcs);
>         if (DSP_SUCCEEDED(status) & numProcs) {
> Index: omapkernel/drivers/dsp/dspbridge/mpu_driver/src/services/cfg.c
> ===================================================================
> --- omapkernel.orig/drivers/dsp/dspbridge/mpu_driver/src/services/cfg.c 2008-07-29 23:52:26.000000000 -0500
> +++ omapkernel/drivers/dsp/dspbridge/mpu_driver/src/services/cfg.c      2008-07-29 23:56:40.000000000 -0500
> @@ -485,16 +485,15 @@
>  }
> 
>  /*
> - * ===========CFG_GetC55Procs ============
> + * ===========CFG_GetDSPProcs ============
>   * Purpose:
>   * Get the number of configured C55 processors
>   */
> 
> -DSP_STATUS CFG_GetC55Procs(OUT u32 *numProcs)
> +DSP_STATUS CFG_GetDSPProcs(OUT u32 *numProcs)
>  {
>         DSP_STATUS status = DSP_SOK;
> 
> -       *numProcs = 0;
>         *numProcs = 1;
>         return status;
>  }
> ---
> 
> Regards,
> 
> omar
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
"rm -rf" only sounds scary if you don't have backups
