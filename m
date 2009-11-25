From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 6/9] DSPBRIDGE: Remove DPC, create, destroy and schedule
 wrappers
Date: Wed, 25 Nov 2009 16:34:25 -0600
Message-ID: <4B0DB0F1.7010506@ti.com>
References: <1259023830-7557-1-git-send-email-omar.ramirez@ti.com> <1259023830-7557-2-git-send-email-omar.ramirez@ti.com> <1259023830-7557-3-git-send-email-omar.ramirez@ti.com> <1259023830-7557-4-git-send-email-omar.ramirez@ti.com> <1259023830-7557-5-git-send-email-omar.ramirez@ti.com> <1259023830-7557-6-git-send-email-omar.ramirez@ti.com> <1259023830-7557-7-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46184 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934888AbZKYWeY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Nov 2009 17:34:24 -0500
In-Reply-To: <1259023830-7557-7-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Artem Bityutskiy <dedekind1@gmail.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

Ramirez Luna, Omar had written, on 11/23/2009 06:50 PM, the following:
> Remove DPC wrappers and replace with direct Linux calls.
> 
> These changes apply to IO DPC and MMUfault DPC
> 
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
>  arch/arm/plat-omap/include/dspbridge/dpc.h |   90 +++--------------
>  drivers/dsp/bridge/services/dpc.c          |  144 +---------------------------
>  drivers/dsp/bridge/wmd/io_sm.c             |   73 +++++++++++++-
>  drivers/dsp/bridge/wmd/mmu_fault.c         |   24 ++++-
>  drivers/dsp/bridge/wmd/ue_deh.c            |   31 ++++++-
>  5 files changed, 132 insertions(+), 230 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/dspbridge/dpc.h b/arch/arm/plat-omap/include/dspbridge/dpc.h
> index 870a1b2..0c60342 100644
> --- a/arch/arm/plat-omap/include/dspbridge/dpc.h
> +++ b/arch/arm/plat-omap/include/dspbridge/dpc.h
> @@ -19,8 +19,6 @@
>  #ifndef DPC_
>  #define DPC_
> 
> -       struct DPC_OBJECT;
> -
>  /*
>   *  ======== DPC_PROC ========
>   *  Purpose:
> @@ -40,64 +38,22 @@
>   */
>         typedef void(*DPC_PROC) (void *pRefData);
> 
> -/*
> - *  ======== DPC_Cancel ========
> - *  Purpose:
> - *      Cancel a DPC previously scheduled by DPC_Schedule.
> - *  Parameters:
> - *      hDPC:           A DPC object handle created in DPC_Create().
> - *  Returns:
> - *      DSP_SOK:        Scheduled DPC, if any, is cancelled.
> - *      DSP_SFALSE:     No DPC is currently scheduled for execution.
> - *      DSP_EHANDLE:    Invalid hDPC.
> - *  Requires:
> - *  Ensures:
> - *      If the DPC has already executed, is executing, or was not yet
> - *      scheduled, this function will have no effect.
> - */
> -       extern DSP_STATUS DPC_Cancel(IN struct DPC_OBJECT *hDPC);
> +/* The DPC object, passed to our priority event callback routine: */
You may want to follow linux coding style. and not loose info from the 
comments.

Documentation/kernel-doc-nano-HOWTO.txt
[...]
Example kernel-doc function comment:

/**
  * foobar() - short function description of foobar
  * @arg1:       Describe the first argument to foobar.
  * @arg2:       Describe the second argument to foobar.
  *              One can provide multiple line descriptions
  *              for arguments.
  *
  * A longer description, with more discussion of the function foobar()
  * that might be useful to those using or modifying it.  Begins with
  * empty comment line, and may include additional embedded empty
  * comment lines.
  *
  * The longer description can have multiple paragraphs.
  */
[...]
Example kernel-doc data structure comment.

**
* struct blah - the basic blah structure
* @mem1:       describe the first member of struct blah
* @mem2:       describe the second member of struct blah,
*              perhaps with more lines and words.
*
* Longer description of this structure.
*/


> +struct DPC_OBJECT {
> +       u32 dwSignature;        /* Used for object validation.   */
> +       void *pRefData;         /* Argument for client's DPC.    */
> +       DPC_PROC pfnDPC;        /* Client's DPC.                 */
> +       u32 numRequested;       /* Number of requested DPC's.      */
> +       u32 numScheduled;       /* Number of executed DPC's.      */
> +       struct tasklet_struct dpc_tasklet;
[...]


> diff --git a/drivers/dsp/bridge/wmd/io_sm.c b/drivers/dsp/bridge/wmd/io_sm.c
> index 96a5aa6..60dbc62 100644
> --- a/drivers/dsp/bridge/wmd/io_sm.c
> +++ b/drivers/dsp/bridge/wmd/io_sm.c
> @@ -251,7 +251,26 @@ DSP_STATUS WMD_IO_Create(OUT struct IO_MGR **phIOMgr,
> 
>         if (devType == DSP_UNIT) {
>                 /* Create a DPC object: */
> -               status = DPC_Create(&pIOMgr->hDPC, IO_DPC, (void *)pIOMgr);
> +               MEM_AllocObject(pIOMgr->hDPC, struct DPC_OBJECT,
> +                               IO_MGRSIGNATURE);
> +               if (pIOMgr->hDPC) {
> +                       tasklet_init(&pIOMgr->hDPC->dpc_tasklet,
> +                               DPC_DeferredProcedure, (u32)pIOMgr->hDPC);
> +                       /* Fill out our DPC Object: */
> +                       pIOMgr->hDPC->pRefData = (void *)pIOMgr;
> +                       pIOMgr->hDPC->pfnDPC = IO_DPC;
> +                       pIOMgr->hDPC->numRequested = 0;
> +                       pIOMgr->hDPC->numScheduled = 0;
> +#ifdef DEBUG
> +                       pIOMgr->hDPC->numRequestedMax = 0;
> +                       pIOMgr->hDPC->cEntryCount = 0;
> +#endif

Do you want to do a memset with 0 instead and fill up the deltas?

> +                       spin_lock_init(&pIOMgr->hDPC->dpc_lock);
> +               } else {
> +                       DBG_Trace(GT_6CLASS, "IO DPC Create: DSP_EMEMORY\n");
> +                       status = DSP_EMEMORY;
> +               }
> +
>                 if (DSP_SUCCEEDED(status))
>                         status = DEV_GetDevNode(hDevObject, &hDevNode);
> 
> @@ -312,8 +331,13 @@ DSP_STATUS WMD_IO_Destroy(struct IO_MGR *hIOMgr)
>                 destroy_workqueue(bridge_workqueue);
>                 /* Linux function to uninstall ISR */
>                 free_irq(INT_MAIL_MPU_IRQ, (void *)hIOMgr);
> -               if (hIOMgr->hDPC)
> -                       (void)DPC_Destroy(hIOMgr->hDPC);
> +
> +               /* Free DPC object */
> +               tasklet_kill(&hIOMgr->hDPC->dpc_tasklet);
> +               MEM_FreeObject(hIOMgr->hDPC);
> +               hIOMgr->hDPC = NULL;
> +               DBG_Trace(GT_2CLASS, "DPC_Destroy: SUCCESS\n");
> +
>  #ifndef DSP_TRACEBUF_DISABLED
>                 if (hIOMgr->pMsg)
>                         MEM_Free(hIOMgr->pMsg);
> @@ -1009,6 +1033,8 @@ irqreturn_t IO_ISR(int irq, IN void *pRefData)
>  {
>         struct IO_MGR *hIOMgr = (struct IO_MGR *)pRefData;
>         bool fSchedDPC;
> +       unsigned long flags;
> +
>         if (irq != INT_MAIL_MPU_IRQ ||
>            !MEM_IsValidHandle(hIOMgr, IO_MGRSIGNATURE))
>                 return IRQ_NONE;
> @@ -1030,8 +1056,26 @@ irqreturn_t IO_ISR(int irq, IN void *pRefData)
>                         DBG_Trace(DBG_LEVEL6, "*** DSP RESET ***\n");
>                         hIOMgr->wIntrVal = 0;
>                 } else if (fSchedDPC) {
> -                       /* PROC-COPY defer i/o  */
> -                       DPC_Schedule(hIOMgr->hDPC);
> +                       /*
> +                        * PROC-COPY defer i/o.
> +                        * Increment count of DPC's pending.
> +                        */
> +                       spin_lock_irqsave(&hIOMgr->hDPC->dpc_lock, flags);
> +                       hIOMgr->hDPC->numRequested++;
> +                       spin_unlock_irqrestore(&hIOMgr->hDPC->dpc_lock, flags);
> +
> +                       /* Schedule DPC */
> +                       tasklet_schedule(&hIOMgr->hDPC->dpc_tasklet);
> +#ifdef DEBUG
> +                       if (hIOMgr->hDPC->numRequested >
> +                          hIOMgr->hDPC->numScheduled +
> +                          hIOMgr->hDPC->numRequestedMax) {
> +                               hIOMgr->hDPC->numRequestedMax =
> +                                       hIOMgr->hDPC->numRequested -
> +                                       hIOMgr->hDPC->numScheduled;
a) is this safe?
b) {} for a one liner ? mebbe the level of indentation is too much?

> +                       }
> +#endif
[...]

> --- a/drivers/dsp/bridge/wmd/ue_deh.c
> +++ b/drivers/dsp/bridge/wmd/ue_deh.c
> @@ -91,8 +91,27 @@ DSP_STATUS WMD_DEH_Create(OUT struct DEH_MGR **phDehMgr,
>                         status = NTFY_Create(&pDehMgr->hNtfy);
> 
>                 /* Create a DPC object. */
> -               status = DPC_Create(&pDehMgr->hMmuFaultDpc, MMU_FaultDpc,
> -                                  (void *)pDehMgr);
> +               MEM_AllocObject(pDehMgr->hMmuFaultDpc, struct DPC_OBJECT,
> +                               SIGNATURE);
> +               if (pDehMgr->hMmuFaultDpc) {
> +                       tasklet_init(&pDehMgr->hMmuFaultDpc->dpc_tasklet,
> +                               DPC_DeferredProcedure,
> +                               (u32)pDehMgr->hMmuFaultDpc);
> +                       /* Fill out DPC Object */
> +                       pDehMgr->hMmuFaultDpc->pRefData = (void *)pDehMgr;
> +                       pDehMgr->hMmuFaultDpc->pfnDPC = MMU_FaultDpc;
> +                       pDehMgr->hMmuFaultDpc->numRequested = 0;
> +                       pDehMgr->hMmuFaultDpc->numScheduled = 0;
> +#ifdef DEBUG
> +                       pDehMgr->hMmuFaultDpc->numRequestedMax = 0;
> +                       pDehMgr->hMmuFaultDpc->cEntryCount = 0;
> +#endif
> +                       spin_lock_init(&pDehMgr->hMmuFaultDpc->dpc_lock);
> +               } else {
> +                       DBG_Trace(GT_6CLASS, "DEH DPC Create: DSP_EMEMORY\n");
> +                       status = DSP_EMEMORY;
I think you give up at this point right? why continue the code? wont it 
be easier if your code did:
if (!pDehMgr->hMmuFaultDpc) {
	DBG_Trace(GT_6CLASS, "DEH DPC Create: DSP_EMEMORY\n");
	return DSP_EMEMORY;
}
  do rest of code..

> +               }
> +
>                 if (DSP_SUCCEEDED(status))
>                         status = DEV_GetDevNode(hDevObject, &hDevNode);
> 
> @@ -144,7 +163,13 @@ DSP_STATUS WMD_DEH_Destroy(struct DEH_MGR *hDehMgr)
>                         (void)NTFY_Delete(pDehMgr->hNtfy);
>                 /* Disable DSP MMU fault */
>                 free_irq(INT_DSP_MMU_IRQ, pDehMgr);
> -               (void)DPC_Destroy(pDehMgr->hMmuFaultDpc);
> +
> +               /* Free DPC object */
> +               tasklet_kill(&pDehMgr->hMmuFaultDpc->dpc_tasklet);
> +               MEM_FreeObject(pDehMgr->hMmuFaultDpc);
> +               pDehMgr->hMmuFaultDpc = NULL;
> +               DBG_Trace(GT_2CLASS, "DPC_Destroy: SUCCESS\n");
> +
>                 /* Deallocate the DEH manager object */
>                 MEM_FreeObject(pDehMgr);
>         }
> --

-- 
Regards,
Nishanth Menon
