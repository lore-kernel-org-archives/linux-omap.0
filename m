From: Felipe Contreras <felipe.contreras@nokia.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: New reserved memory accounting framework
Date: Mon, 15 Feb 2010 18:03:31 +0200
Message-ID: <20100215160331.GB5458@annwn.felipec.org>
References: <cover.1266246150.git.ameya.palande@nokia.com>
 <984ee6f949a5b2e1df3fa8640bb75960042611cc.1266246150.git.ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:43258 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429Ab0BOQDl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Feb 2010 11:03:41 -0500
Content-Disposition: inline
In-Reply-To: <984ee6f949a5b2e1df3fa8640bb75960042611cc.1266246150.git.ameya.palande@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>
Cc: Omar Ramirez Luna <omar.ramirez@ti.com>, Nishanth Menon <nm@ti.com>, "deepak.chitriki@ti.com" <deepak.chitriki@ti.com>, linux-omap <linux-omap@vger.kernel.org>, "x0095840@ti.com" <x0095840@ti.com>

On Mon, Feb 15, 2010 at 04:35:08PM +0100, Ameya Palande wrote:
> DSP_RSV_OBJECT is introduced to track reserved memory accounting information.
> This will allow us to do proper cleanup for memory reserved using
> PROC_ReserveMemory().
> 
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> ---

[...]

> diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
> index 2ccbc9b..74c22cd 100644
> --- a/drivers/dsp/bridge/rmgr/proc.c
> +++ b/drivers/dsp/bridge/rmgr/proc.c
> @@ -1430,7 +1430,7 @@ func_end:
>   *      Reserve a virtually contiguous region of DSP address space.
>   */
>  DSP_STATUS PROC_ReserveMemory(DSP_HPROCESSOR hProcessor, u32 ulSize,
> -			     void **ppRsvAddr)
> +		void **ppRsvAddr, struct PROCESS_CONTEXT *pr_ctxt)
>  {
>  	struct DMM_OBJECT *hDmmMgr;
>  	DSP_STATUS status = DSP_SOK;
> @@ -1450,8 +1450,21 @@ DSP_STATUS PROC_ReserveMemory(DSP_HPROCESSOR hProcessor, u32 ulSize,
>  	if (DSP_FAILED(status)) {
>  		GT_1trace(PROC_DebugMask, GT_7CLASS, "PROC_ReserveMemory: "
>  			 "Failed to get DMM Mgr handle: 0x%x\n", status);
> -	} else
> +	} else {
>  		status = DMM_ReserveMemory(hDmmMgr, ulSize, (u32 *)ppRsvAddr);
> +		if (status == DSP_SOK) {

More indentattion?

Can't we have instead:

if (status != DSP_SOK)
	goto err:

> +			struct DMM_RSV_OBJECT *rsv_obj =
> +				kmalloc(sizeof(struct DMM_RSV_OBJECT),
> +						GFP_KERNEL);
> +			if (rsv_obj) {
> +				rsv_obj->dsp_reserved_addr = (u32) *ppRsvAddr;
> +				spin_lock(&pr_ctxt->dmm_rsv_list_lock);
> +				list_add(&rsv_obj->link,
> +						&pr_ctxt->dmm_rsv_list);
> +				spin_unlock(&pr_ctxt->dmm_rsv_list_lock);
> +			}
> +		}
> +	}
>  
>  	GT_1trace(PROC_DebugMask, GT_ENTER, "Leaving PROC_ReserveMemory [0x%x]",
>  		 status);
> @@ -1704,7 +1717,8 @@ func_end:
>   *  Purpose:
>   *      Frees a previously reserved region of DSP address space.
>   */
> -DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor, void *pRsvAddr)
> +DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor, void *pRsvAddr,
> +		struct PROCESS_CONTEXT *pr_ctxt, int cleanup)
>  {
>  	struct DMM_OBJECT *hDmmMgr;
>  	DSP_STATUS status = DSP_SOK;
> @@ -1720,12 +1734,32 @@ DSP_STATUS PROC_UnReserveMemory(DSP_HPROCESSOR hProcessor, void *pRsvAddr)
>  		goto func_end;
>  	}
>  	status = DMM_GetHandle(pProcObject, &hDmmMgr);
> -	if (DSP_FAILED(status))
> +	if (DSP_FAILED(status)) {
>  		GT_1trace(PROC_DebugMask, GT_7CLASS,
>  			 "PROC_UnReserveMemory: Failed to get DMM Mgr "
>  			 "handle: 0x%x\n", status);
> -	else
> +	} else {
>  		status = DMM_UnReserveMemory(hDmmMgr, (u32) pRsvAddr);
> +		/*
> +		 * cleanup flag handles the special case when this function
> +		 * is called while doing clenaup from
> +		 * DRV_RemoveAllDMMResElements
> +		 */
> +		if (status == DSP_SOK && cleanup) {

Ditto here, although maybe the label should be 'leave' instead.

> +			struct DMM_RSV_OBJECT *temp, *rsv_obj;
> +			spin_lock(&pr_ctxt->dmm_rsv_list_lock);
> +			list_for_each_entry_safe(rsv_obj, temp,
> +					&pr_ctxt->dmm_rsv_list, link) {
> +				if (rsv_obj->dsp_reserved_addr ==
> +						(u32)pRsvAddr) {
> +					list_del(&rsv_obj->link);
> +					kfree(rsv_obj);
> +					break;
> +				}
> +			}
> +			spin_unlock(&pr_ctxt->dmm_rsv_list_lock);
> +		}
> +	}
>  
>  	GT_1trace(PROC_DebugMask, GT_ENTER,
>  		 "Leaving PROC_UnReserveMemory [0x%x]",
> -- 

Cheers.

-- 
Felipe Contreras
