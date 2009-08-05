From: "Ramos Falcon, Ernesto" <ernesto@ti.com>
Subject: RE: [PATCH 2/3] DSPBRIDGE: Move resource cleanup to bridge_release
Date: Wed, 5 Aug 2009 14:20:26 -0500
Message-ID: <B852767254C5C94EBB1040EE0EFA06006821961B@dlee01.ent.ti.com>
References: <1249478717-4446-1-git-send-email-ameya.palande@nokia.com>
 <1249478717-4446-2-git-send-email-ameya.palande@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50253 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751803AbZHETUg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Aug 2009 15:20:36 -0400
In-Reply-To: <1249478717-4446-2-git-send-email-ameya.palande@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ameya Palande <ameya.palande@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "hiroshi.doyu@nokia.com" <hiroshi.doyu@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Ramirez Luna, Omar" <omar.ramirez@ti.com>, "roman.tereshonkov@nokia.com" <roman.tereshonkov@nokia.com>, "Moogi, Suyog" <suyog@ti.com>

Hi,

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Ameya Palande
> Sent: Wednesday, August 05, 2009 8:25 AM
> To: linux-omap@vger.kernel.org
> Cc: hiroshi.doyu@nokia.com; Guzman Lugo, Fernando; Ramirez Luna, Omar;
> roman.tereshonkov@nokia.com; Moogi, Suyog
> Subject: [PATCH 2/3] DSPBRIDGE: Move resource cleanup to bridge_release
> 
> Instead of doing lazy resource cleanup in bridge_open, this patch will
> move
> it to bridge_release. This way the resources allocated will be cleaned up
> when that instance of the open is closed and will not wait till the next
> instance of open happens.
> 
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
> Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
> ---
>  drivers/dsp/bridge/rmgr/drv_interface.c |  132 ++++++++++++--------------
> -----
>  1 files changed, 52 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c
> b/drivers/dsp/bridge/rmgr/drv_interface.c
> index 8cbdeee..2fcd6f9 100644
> --- a/drivers/dsp/bridge/rmgr/drv_interface.c
> +++ b/drivers/dsp/bridge/rmgr/drv_interface.c
> @@ -562,102 +562,74 @@ static void __exit bridge_exit(void)
>  	platform_driver_unregister(&bridge_driver);
>  }
> 
> -/* This function is called when an application opens handle to the
> - * bridge driver. */
> -
> +/*
> + * This function is called when an application opens handle to the
> + * bridge driver.
> + */
>  static int bridge_open(struct inode *ip, struct file *filp)
>  {
>  	int status = 0;
> -#ifndef RES_CLEANUP_DISABLE
> -       u32     hProcess;
> -	DSP_STATUS dsp_status = DSP_SOK;
> -	HANDLE	     hDrvObject = NULL;
> -	struct PROCESS_CONTEXT    *pPctxt = NULL;
> -	struct PROCESS_CONTEXT	*next_node = NULL;
> -	struct PROCESS_CONTEXT    *pCtxtclosed = NULL;
> -	struct PROCESS_CONTEXT    *pCtxttraverse = NULL;
> -	struct task_struct *tsk = NULL;
> -	GT_0trace(driverTrace, GT_ENTER, "-> driver_open\n");
> -	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
> +	DSP_STATUS dsp_status;
> +	HANDLE hDrvObject;
> +	struct PROCESS_CONTEXT *pr_ctxt = NULL;
> 
> -	/* Checking weather task structure for all process existing
> -	 * in the process context list If not removing those processes*/
> -	if (DSP_FAILED(dsp_status))
> -		goto func_cont;
> +	GT_0trace(driverTrace, GT_ENTER, "-> bridge_open\n");
> 
> -	DRV_GetProcCtxtList(&pCtxtclosed, (struct DRV_OBJECT *)hDrvObject);
> -	while (pCtxtclosed != NULL) {
> -		tsk = find_task_by_vpid(pCtxtclosed->pid);
> -		next_node = pCtxtclosed->next;
> -
> -		if ((tsk == NULL) || (tsk->exit_state == EXIT_ZOMBIE)) {
> -
> -			GT_1trace(driverTrace, GT_5CLASS,
> -				 "***Task structure not existing for "
> -				 "process***%d\n", pCtxtclosed->pid);
> -			DRV_RemoveAllResources(pCtxtclosed);
> -			if (pCtxtclosed->hProcessor != NULL) {
> -				DRV_GetProcCtxtList(&pCtxttraverse,
> -					    (struct DRV_OBJECT *)hDrvObject);
> -				if (pCtxttraverse->next == NULL) {
> -					PROC_Detach(pCtxtclosed->hProcessor);
> -				} else {
> -					if ((pCtxtclosed->pid ==
> -					  pCtxttraverse->pid) &&
> -					  (pCtxttraverse->next != NULL)) {
> -						pCtxttraverse =
> -							pCtxttraverse->next;
> -					}
> -					while ((pCtxttraverse != NULL) &&
> -					     (pCtxtclosed->hProcessor
> -					     != pCtxttraverse->hProcessor)) {
> -						pCtxttraverse =
> -							pCtxttraverse->next;
> -						if ((pCtxttraverse != NULL) &&
> -						  (pCtxtclosed->pid ==
> -						  pCtxttraverse->pid)) {
> -							pCtxttraverse =
> -							   pCtxttraverse->next;
> -						}
> -					}
> -					if (pCtxttraverse == NULL) {
> -						PROC_Detach
> -						     (pCtxtclosed->hProcessor);
> -					}
> -				}
> -			}
> -			DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
> -					     pCtxtclosed,
> -					     (void *)pCtxtclosed->pid);
> +	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
> +	if (DSP_SUCCEEDED(dsp_status)) {
> +		/*
> +		 * Allocate a new process context and insert it into global
> +		 * process context list.
> +		 */
> +		DRV_InsertProcContext(hDrvObject, &pr_ctxt);
> +		if (pr_ctxt) {
> +			DRV_ProcUpdatestate(pr_ctxt, PROC_RES_ALLOCATED);
> +			DRV_ProcSetPID(pr_ctxt, current->pid);
> +		} else {
> +			status = -ENOMEM;
>  		}
> -		pCtxtclosed = next_node;
> +	} else {
> +		status = -EIO;
>  	}
> -func_cont:
> -	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
> -	if (DSP_SUCCEEDED(dsp_status))
> -		dsp_status = DRV_InsertProcContext(
> -				(struct DRV_OBJECT *)hDrvObject, &pPctxt);
> 
> -	if (pPctxt != NULL) {
> -			/* Return PID instead of process handle */
> -			hProcess = current->pid;
> +	filp->private_data = pr_ctxt;
> 
> -		DRV_ProcUpdatestate(pPctxt, PROC_RES_ALLOCATED);
> -			DRV_ProcSetPID(pPctxt, hProcess);
> -	}
> -#endif
> -
> -	GT_0trace(driverTrace, GT_ENTER, " <- driver_open\n");
> +	GT_0trace(driverTrace, GT_ENTER, "<- bridge_open\n");
>  	return status;
>  }
> 
> -/* This function is called when an application closes handle to the
> bridge
> - * driver. */
> +/*
> + * This function is called when an application closes handle to the
> bridge
> + * driver.
> + */
>  static int bridge_release(struct inode *ip, struct file *filp)
>  {
> +	int status = 0;
> +	DSP_STATUS dsp_status;
> +	HANDLE hDrvObject;
> +	struct PROCESS_CONTEXT *pr_ctxt;
> +
>  	GT_0trace(driverTrace, GT_ENTER, "-> bridge_release\n");
> +
> +	if (!filp->private_data) {
> +		status = -EIO;
> +	} else {
> +		pr_ctxt = filp->private_data;
> +		dsp_status = CFG_GetObject((u32 *)&hDrvObject,
> REG_DRV_OBJECT);
> +		if (DSP_SUCCEEDED(dsp_status)) {
> +			flush_signals(current);
> +			DRV_RemoveAllResources(pr_ctxt);
> +			PROC_Detach(pr_ctxt->hProcessor);
> +			DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
> +					pr_ctxt, (void *)pr_ctxt->pid);
> +		} else {
> +			status = -EIO;
> +		}
> +		filp->private_data = NULL;
> +	}
> +
>  	GT_0trace(driverTrace, GT_ENTER, "<- bridge_release\n");
> -	return 0;
> +	return status;
>  }
> 
>  /* This function provides IO interface to the bridge driver. */
> --
> 1.6.2.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

We have detected a use case where if an application creates a child process using fork call, and then the child and father processes call DSPProcessor_Attach() and create a new process context with new tgid; when the processes are terminated, only the last process calls bridge_release cleaning only the resources in the father process, leaving the child resources unreleased.

One solution we have seen is to perform goes through the entire process context list, clean up all the resources for all terminated processes or in "zombie" state, as below,

DRV_GetProcCtxtList(&pCtxtclosed, (struct DRV_OBJECT *)hDrvObject);
while (pCtxtclosed != NULL) {
	printk("pCtxtclosed->pid = %d\n",pCtxtclosed->pid);
	tsk = find_task_by_pid(pCtxtclosed->pid);

	if ((tsk == NULL) || (tsk->exit_state == EXIT_ZOMBIE)) {
	
		GT_1trace(driverTrace, GT_5CLASS,
			"***Task structure not existing for "
			 "process***%d\n", pCtxtclosed->pid);
		DRV_RemoveAllResources(pCtxtclosed);
		if (pCtxtclosed->hProcessor != NULL) {
					PROC_Detach
						 (pCtxtclosed->hProcessor);
		}
		pTmp = pCtxtclosed->next;
		DRV_RemoveProcContext((struct DRV_OBJECT *)hDrvObject,
					 pCtxtclosed,
					 (void *)pCtxtclosed->pid);
	} else {
		pTmp = pCtxtclosed->next;
	}
	pCtxtclosed = pTmp;
}

Please let me know your comments.

/Ernesto
