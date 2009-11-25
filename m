From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 5/9] DSPBRIDGE: trivial cleanup and indentation for io_sm
Date: Wed, 25 Nov 2009 15:53:14 -0600
Message-ID: <4B0DA74A.802@ti.com>
References: <1259023830-7557-1-git-send-email-omar.ramirez@ti.com> <1259023830-7557-2-git-send-email-omar.ramirez@ti.com> <1259023830-7557-3-git-send-email-omar.ramirez@ti.com> <1259023830-7557-4-git-send-email-omar.ramirez@ti.com> <1259023830-7557-5-git-send-email-omar.ramirez@ti.com> <1259023830-7557-6-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59651 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935096AbZKYVxM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 25 Nov 2009 16:53:12 -0500
In-Reply-To: <1259023830-7557-6-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Artem Bityutskiy <dedekind1@gmail.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

Ramirez Luna, Omar had written, on 11/23/2009 06:50 PM, the following:
> Remove duplicate set of braces from if statement and reduce
> indentation.
> 
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
>  drivers/dsp/bridge/wmd/io_sm.c |   96 +++++++++++++++++-----------------------
>  1 files changed, 40 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
> index af31831..96a5aa6 100644
> --- a/drivers/dsp/bridge/wmd/io_sm.c
> +++ b/drivers/dsp/bridge/wmd/io_sm.c
[...]
> @@ -1028,29 +1016,28 @@ irqreturn_t IO_ISR(int irq, IN void *pRefData)
>  
>  	/* Call WMD's CHNLSM_ISR() to see if interrupt is ours, and process. */
>  	if (IO_CALLISR(hIOMgr->hWmdContext, &fSchedDPC, &hIOMgr->wIntrVal)) {
> -		{
> -			DBG_Trace(DBG_LEVEL3, "IO_ISR %x\n", hIOMgr->wIntrVal);
> -			if (hIOMgr->wIntrVal & MBX_PM_CLASS) {
> -				hIOMgr->dQuePowerMbxVal[hIOMgr->iQuePowerHead] =
> -					hIOMgr->wIntrVal;
> -				hIOMgr->iQuePowerHead++;
> -				if (hIOMgr->iQuePowerHead >= MAX_PM_REQS)
> -					hIOMgr->iQuePowerHead = 0;
> -
> -				queue_work(bridge_workqueue, &hIOMgr->io_workq);
> -			}
> -			if (hIOMgr->wIntrVal == MBX_DEH_RESET) {
> -				DBG_Trace(DBG_LEVEL6, "*** DSP RESET ***\n");
> -				hIOMgr->wIntrVal = 0;
> -			} else if (fSchedDPC) {
> -				/* PROC-COPY defer i/o  */
> -				DPC_Schedule(hIOMgr->hDPC);
> -			}
> +		DBG_Trace(DBG_LEVEL3, "IO_ISR %x\n", hIOMgr->wIntrVal);
> +		if (hIOMgr->wIntrVal & MBX_PM_CLASS) {
> +			hIOMgr->dQuePowerMbxVal[hIOMgr->iQuePowerHead] =
> +				hIOMgr->wIntrVal;
> +			hIOMgr->iQuePowerHead++;
> +			if (hIOMgr->iQuePowerHead >= MAX_PM_REQS)
> +				hIOMgr->iQuePowerHead = 0;
> +
> +			queue_work(bridge_workqueue, &hIOMgr->io_workq);
> +		}
> +		if (hIOMgr->wIntrVal == MBX_DEH_RESET) {
> +			DBG_Trace(DBG_LEVEL6, "*** DSP RESET ***\n");
> +			hIOMgr->wIntrVal = 0;
> +		} else if (fSchedDPC) {
> +			/* PROC-COPY defer i/o  */
> +			DPC_Schedule(hIOMgr->hDPC);
>  		}
> -       } else
> +	} else
>  		/* Ensure that, if WMD didn't claim it, the IRQ is shared. */
>  		DBC_Ensure(hIOMgr->fSharedIRQ);

Style comment } else { needed.



-- 
Regards,
Nishanth Menon
