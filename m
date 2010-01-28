From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH 2/2] DSPBRIDGE: Remove DRV_ProcUpdatestate function
Date: Thu, 28 Jan 2010 10:50:27 +0200
Message-ID: <1264668627.2098.0.camel@sanganak>
References: <818EF96F5A7CC84789DD014773DB095484859F57@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:53065 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab0A1IvS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jan 2010 03:51:18 -0500
In-Reply-To: <818EF96F5A7CC84789DD014773DB095484859F57@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

On Wed, 2010-01-27 at 19:13 +0100, ext Gomez Castellanos, Ivan wrote:
> From fe755ce32e6bbbcc0e99d5a06440bed6257b1a23 Mon Sep 17 00:00:00 2001
> From: Ivan Gomez <ivan.gomez@ti.com>
> Date: Wed, 20 Jan 2010 17:45:43 -0600
> Subject: [PATCH] DSPBRIDGE: Remove DRV_ProcUpdatestate function
> 
> The DRV_ProcUpdatestate function was only used in two places and
> it only assigned a value.
> 
> Signed-off-by: Ivan Gomez <ivan.gomez@ti.com>
> ---
>  drivers/dsp/bridge/rmgr/drv.c           |    9 ---------
>  drivers/dsp/bridge/rmgr/drv_interface.c |    4 ++--
>  2 files changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/rmgr/drv.c b/drivers/dsp/bridge/rmgr/drv.c
> index fd09a83..b7817aa 100644
> --- a/drivers/dsp/bridge/rmgr/drv.c
> +++ b/drivers/dsp/bridge/rmgr/drv.c
> @@ -83,15 +83,6 @@ static DSP_STATUS DRV_ProcFreeNodeRes(HANDLE hPCtxt);
>  static DSP_STATUS  DRV_ProcFreeSTRMRes(HANDLE hPCtxt);
>  extern enum NODE_STATE NODE_GetState(HANDLE hNode);
>  
> -/* Update the state of process context */
> -DSP_STATUS DRV_ProcUpdatestate(HANDLE hPCtxt, enum GPP_PROC_RES_STATE status)
> -{
> -	struct PROCESS_CONTEXT *pCtxt = (struct PROCESS_CONTEXT *)hPCtxt;
> -	DSP_STATUS status1 = DSP_SOK;
> -	pCtxt->resState = status;
> -	return status1;
> -}
> -
>  /* Allocate and add a node resource element
>  * This function is called from .Node_Allocate.  */
>  DSP_STATUS DRV_InsertNodeResElement(HANDLE hNode, HANDLE hNodeRes,
> diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
> index 6d293bf..af8c6ad 100644
> --- a/drivers/dsp/bridge/rmgr/drv_interface.c
> +++ b/drivers/dsp/bridge/rmgr/drv_interface.c
> @@ -503,7 +503,7 @@ static int bridge_open(struct inode *ip, struct file *filp)
>  	 */
>  	pr_ctxt = MEM_Calloc(sizeof(struct PROCESS_CONTEXT), MEM_PAGED);
>  	if (pr_ctxt)
> -		DRV_ProcUpdatestate(pr_ctxt, PROC_RES_ALLOCATED);
> +		pr_ctxt->resSatate = PROC_RES_ALLOCATED;
>  	else
>  		status = -ENOMEM;
>  
> @@ -619,7 +619,7 @@ DSP_STATUS DRV_RemoveAllResources(HANDLE hPCtxt)
>  	DRV_RemoveAllSTRMResElements(pCtxt);
>  	DRV_RemoveAllNodeResElements(pCtxt);
>  	DRV_RemoveAllDMMResElements(pCtxt);
> -	DRV_ProcUpdatestate(pCtxt, PROC_RES_FREED);
> +	pCtxt->resState = PROC_RES_FREED;
>  	return status;
>  }
>  #endif

Acked-by: Ameya Palande <ameya.palande@nokia.com>

