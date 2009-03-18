From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: RE: [PATCH B 1/3] tidspbridge: don't flood the mailbox on MemUnMap
Date: Wed, 18 Mar 2009 08:06:55 -0500
Message-ID: <8F7AF80515AF0D4D93307E594F3CB40E23320B48@dlee03.ent.ti.com>
References: <1237339605-20697-1-git-send-email-felipe.contreras@gmail.com>
 <1237339605-20697-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35612 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbZCRNHK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2009 09:07:10 -0400
In-Reply-To: <1237339605-20697-2-git-send-email-felipe.contreras@gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Hiroshi DOYU <hiroshi.doyu@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, Felipe Contreras <felipe.contreras@nokia.com>

Felipe,

> Check the hardware state of the DSP before sending the command to wake
> it up thus avoiding to flood the mailbox unnecessarily.
>
-- So this check was missing in Unmap part. Good catch.


> -	u32 temp = 0;
> -	struct CFG_HOSTRES resources;
>  	u32 *pPhysAddrPageTbl = NULL;
>  	struct vm_area_struct *vma;
>  	struct mm_struct *mm = current->mm;
> +	u32 temp = 0;
>

-- Is temp variable needed ?

Thank you,
Best regards,
Hari

> -----Original Message-----
> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Tuesday, March 17, 2009 8:27 PM
> To: linux-omap@vger.kernel.org
> Cc: Kanigeri, Hari; Hiroshi DOYU; Ameya Palande; Guzman Lugo, Fernando;
> Felipe Contreras
> Subject: [PATCH B 1/3] tidspbridge: don't flood the mailbox on MemUnMap
> 
> From: Felipe Contreras <felipe.contreras@nokia.com>
> 
> Impact: improves performance and reliability
> 
> Check the hardware state of the DSP before sending the command to wake
> it up thus avoiding to flood the mailbox unnecessarily.
> 
> By doing that the mailbox is free most of the time which dramatically
> decreases CPU usage since the check for empty slots is done in a busy
> loop.
> 
> Also, a free mailbox means less timeouts, so now most messages are
> posted which improves reliability.
> 
> MemMap is doing the flush properly, so this patch also refactors the
> code into a common flush_all function.
> 
> The problem can be triggered by doing many memmap/unmaps, just like TI's
> OpenMAX IL implementation.
> 
> Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
> ---
>  drivers/dsp/bridge/wmd/tiomap3430.c |   42 +++++++++++++++++++-----------
> ----
>  1 files changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/wmd/tiomap3430.c
> b/drivers/dsp/bridge/wmd/tiomap3430.c
> index c0f4ffc..b538ef7 100644
> --- a/drivers/dsp/bridge/wmd/tiomap3430.c
> +++ b/drivers/dsp/bridge/wmd/tiomap3430.c
> @@ -235,6 +235,25 @@ static struct WMD_DRV_INTERFACE drvInterfaceFxns = {
>  	WMD_MSG_SetQueueId,
>  };
> 
> +static inline void flush_all(struct WMD_DEV_CONTEXT *pDevContext)
> +{
> +	struct CFG_HOSTRES resources;
> +	u32 temp = 0;
> +
> +	CFG_GetHostResources((struct CFG_DEVNODE
> *)DRV_GetFirstDevExtension(), &resources);
> +	HW_PWRST_IVA2RegGet(resources.dwPrmBase, &temp);
> +
> +	if ((temp & HW_PWR_STATE_ON) == HW_PWR_STATE_OFF) {
> +		/* IVA domain is not in ON state*/
> +		DBG_Trace(DBG_LEVEL7, "temp value is 0x%x\n", temp);
> +		CLK_Enable(SERVICESCLK_iva2_ck);
> +		WakeDSP(pDevContext, NULL);
> +		HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
> +		CLK_Disable(SERVICESCLK_iva2_ck);
> +	} else
> +		HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
> +}
> +
>  /*
>   *  ======== WMD_DRV_Entry ========
>   *  purpose:
> @@ -1283,17 +1302,14 @@ static DSP_STATUS WMD_BRD_MemMap(struct
> WMD_DEV_CONTEXT *hDevContext,
>  	struct WMD_DEV_CONTEXT *pDevContext = hDevContext;
>  	struct HW_MMUMapAttrs_t hwAttrs;
>  	u32 numOfActualTabEntries = 0;
> -	u32 temp = 0;
> -	struct CFG_HOSTRES resources;
>  	u32 *pPhysAddrPageTbl = NULL;
>  	struct vm_area_struct *vma;
>  	struct mm_struct *mm = current->mm;
> +	u32 temp = 0;
> 
>  	DBG_Trace(DBG_ENTER, "> WMD_BRD_MemMap hDevContext %x, pa %x, va %x,
> "
>  		 "size %x, ulMapAttr %x\n", hDevContext, ulMpuAddr,
> ulVirtAddr,
>  		 ulNumBytes, ulMapAttr);
> -	status = CFG_GetHostResources(
> -		 (struct CFG_DEVNODE *)DRV_GetFirstDevExtension(),
> &resources);
>  	if (ulNumBytes == 0)
>  		return DSP_EINVALIDARG;
> 
> @@ -1421,16 +1437,7 @@ func_cont:
>  	 * This is called from here instead from PteUpdate to avoid
> unnecessary
>  	 * repetition while mapping non-contiguous physical regions of a
> virtual
>  	 * region */
> -	HW_PWRST_IVA2RegGet(resources.dwPrmBase, &temp);
> -	if ((temp & HW_PWR_STATE_ON) == HW_PWR_STATE_OFF) {
> -		/* IVA domain is not in ON state*/
> -		DBG_Trace(DBG_LEVEL7, "temp value is 0x%x\n", temp);
> -		CLK_Enable(SERVICESCLK_iva2_ck);
> -		WakeDSP(pDevContext, NULL);
> -		HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
> -		CLK_Disable(SERVICESCLK_iva2_ck);
> -	} else
> -		HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
> +	flush_all(pDevContext);
>  	DBG_Trace(DBG_ENTER, "< WMD_BRD_MemMap status %x\n", status);
>  	return status;
>  }
> @@ -1571,8 +1578,7 @@ static DSP_STATUS WMD_BRD_MemUnMap(struct
> WMD_DEV_CONTEXT *hDevContext,
>  	 /* It is better to flush the TLB here, so that any stale old
> entries
>  	 * get flushed */
>  EXIT_LOOP:
> -	CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
> -	HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
> +	flush_all(pDevContext);
>  	DBG_Trace(DBG_LEVEL1, "WMD_BRD_MemUnMap vaCurr %x, pteAddrL1 %x "
>  		  "pteAddrL2 %x\n", vaCurr, pteAddrL1, pteAddrL2);
>  	DBG_Trace(DBG_ENTER, "< WMD_BRD_MemUnMap status %x remBytes %x, "
> @@ -2055,9 +2061,7 @@ func_cont:
>  	 * This is called from here instead from PteUpdate to avoid
> unnecessary
>  	 * repetition while mapping non-contiguous physical regions of a
> virtual
>  	 * region */
> -	/* Waking up DSP before calling TLB Flush */
> -	CHNLSM_InterruptDSP2(pDevContext, MBX_PM_DSPWAKEUP);
> -	HW_MMU_TLBFlushAll(pDevContext->dwDSPMmuBase);
> +	flush_all(pDevContext);
>  	DBG_Trace(DBG_LEVEL7, "< WMD_BRD_MemMap  at end status %x\n",
> status);
>  	return status;
>  }
> --
> 1.6.2.1.287.g9a8be
> 

