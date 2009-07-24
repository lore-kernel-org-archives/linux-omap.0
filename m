From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH 1/1] DSPBRIDGE: expose DSP_TRACEBUF as kernel config
 option
Date: Fri, 24 Jul 2009 12:28:47 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E3A8CAD56@dlee03.ent.ti.com>
References: <1248431051-26340-1-git-send-email-Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59538 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbZGXR2z convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 13:28:55 -0400
In-Reply-To: <1248431051-26340-1-git-send-email-Hiroshi.DOYU@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "ameya.palande@nokia.com" <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>

Hi Doyu-san,

> 
> "CONFIG_DSP_TRACEBUF" is introduced as a kernel config option to save
> some amount of unused memory and "#ifndef DSP_TRACEBUF_DISABLED" was
> not easy to understand.
>

I think we just use the Bridge DEBUG flag that is used in Bridge instead of introducing a new flag. 

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Hiroshi DOYU [mailto:Hiroshi.DOYU@nokia.com]
> Sent: Friday, July 24, 2009 5:24 AM
> To: linux-omap@vger.kernel.org
> Cc: ameya.palande@nokia.com; Kanigeri, Hari; Guzman Lugo, Fernando;
> Ramirez Luna, Omar; Hiroshi DOYU
> Subject: [PATCH 1/1] DSPBRIDGE: expose DSP_TRACEBUF as kernel config
> option
> 
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> 
> "CONFIG_DSP_TRACEBUF" is introduced as a kernel config option to save
> some amount of unused memory and "#ifndef DSP_TRACEBUF_DISABLED" was
> not easy to understand.
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  drivers/dsp/bridge/Kconfig     |    7 +++++++
>  drivers/dsp/bridge/wmd/io_sm.c |   21 +++++++++------------
>  2 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/Kconfig b/drivers/dsp/bridge/Kconfig
> index 2fed82c..a43b19d 100644
> --- a/drivers/dsp/bridge/Kconfig
> +++ b/drivers/dsp/bridge/Kconfig
> @@ -34,3 +34,10 @@ config BRIDGE_DEBUG
>  	depends on MPU_BRIDGE
>  	help
>  	  Say Y to enable Bridge debugging capabilities
> +
> +config DSP_TRACEBUF
> +	bool "DSP Debug Trace Support"
> +	depends on BRIDGE_DEBUG
> +	help
> +	  Say Y to enable DSP debugging capabilities. baseimage needs
> +	  to be built with debug option.
> diff --git a/drivers/dsp/bridge/wmd/io_sm.c
> b/drivers/dsp/bridge/wmd/io_sm.c
> index d8ae1f1..cd58cce 100644
> --- a/drivers/dsp/bridge/wmd/io_sm.c
> +++ b/drivers/dsp/bridge/wmd/io_sm.c
> @@ -138,7 +138,7 @@ struct IO_MGR {
>  	u32 dQuePowerMbxVal[MAX_PM_REQS];
>  	u32 iQuePowerHead;
>  	u32 iQuePowerTail;
> -#ifndef DSP_TRACEBUF_DISABLED
> +#ifdef CONFIG_DSP_TRACEBUF
>  	u32 ulTraceBufferBegin; 	/* Trace message start address */
>  	u32 ulTraceBufferEnd; 	/* Trace message end address */
>  	u32 ulTraceBufferCurrent; 	/* Trace message current address */
> @@ -169,9 +169,9 @@ static u32 ReadData(struct WMD_DEV_CONTEXT
> *hDevContext, void *pDest,
>  static u32 WriteData(struct WMD_DEV_CONTEXT *hDevContext, void *pDest,
>  			void *pSrc, u32 uSize);
>  static struct workqueue_struct *bridge_workqueue;
> -#ifndef DSP_TRACEBUF_DISABLED
> +
>  void PrintDSPDebugTrace(struct IO_MGR *hIOMgr);
> -#endif
> +
> 
>  /* Bus Addr (cached kernel)*/
>  static DSP_STATUS registerSHMSegs(struct IO_MGR *hIOMgr,
> @@ -255,7 +255,7 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
>  		PREPARE_WORK(&pIOMgr->io_workq, (void *)IO_DispatchPM);
> 
>  	/* Initialize CHNL_MGR object:    */
> -#ifndef DSP_TRACEBUF_DISABLED
> +#ifdef CONFIG_DSP_TRACEBUF
>  	pIOMgr->pMsg = NULL;
>  #endif
>  	pIOMgr->hChnlMgr = hChnlMgr;
> @@ -330,7 +330,7 @@ DSP_STATUS WMD_IO_Destroy(struct IO_MGR *hIOMgr)
>                 /* Linux function to uninstall ISR */
>                 free_irq(INT_MAIL_MPU_IRQ, (void *)hIOMgr);
>                 (void)DPC_Destroy(hIOMgr->hDPC);
> -#ifndef DSP_TRACEBUF_DISABLED
> +#ifdef CONFIG_DSP_TRACEBUF
>  		if (hIOMgr->pMsg)
>  			MEM_Free(hIOMgr->pMsg);
>  #endif
> @@ -448,7 +448,7 @@ func_cont1:
>  		}
>  	}
>  	if (DSP_SUCCEEDED(status)) {
> -#ifndef DSP_TRACEBUF_DISABLED
> +#ifdef CONFIG_DSP_TRACEBUF
>  		status = COD_GetSymValue(hCodMan, DSP_TRACESEC_END,
> &ulShm0End);
>  		DBG_Trace(DBG_LEVEL7, "_BRIDGE_TRACE_END value = %x \n",
>  			 ulShm0End);
> @@ -775,7 +775,7 @@ func_cont:
>  			 "0x%x\n", hMsgMgr->uMaxMsgs);
>  		memset((void *) hIOMgr->pSharedMem, 0, sizeof(struct SHM));
>  	}
> -#ifndef DSP_TRACEBUF_DISABLED
> +#ifdef CONFIG_DSP_TRACEBUF
>  	if (DSP_SUCCEEDED(status)) {
>  		/* Get the start address of trace buffer */
>  		if (DSP_SUCCEEDED(status)) {
> @@ -989,15 +989,12 @@ void IO_DPC(IN OUT void *pRefData)
>  		IO_DispatchMsg(pIOMgr, pMsgMgr);
>  	}
>  #endif
> -#ifndef DSP_TRACEBUF_DISABLED
> +#ifdef CONFIG_DSP_TRACEBUF
>  	if (pIOMgr->wIntrVal & MBX_DBG_CLASS) {
>  		/* notify DSP Trace message */
>  		if (pIOMgr->wIntrVal & MBX_DBG_SYSPRINTF)
>  			PrintDSPDebugTrace(pIOMgr);
>  	}
> -#endif
> -
> -#ifndef DSP_TRACEBUF_DISABLED
>  	PrintDSPDebugTrace(pIOMgr);
>  #endif
>  }
> @@ -1767,7 +1764,7 @@ DSP_STATUS WMD_IO_GetProcLoad(IN struct IO_MGR
> *hIOMgr,
>  	return DSP_SOK;
>  }
> 
> -#ifndef DSP_TRACEBUF_DISABLED
> +#ifdef CONFIG_DSP_TRACEBUF
>  void PrintDSPDebugTrace(struct IO_MGR *hIOMgr)
>  {
>  	u32 ulNewMessageLength = 0, ulGPPCurPointer;
> --
> 1.6.0.4
> 

