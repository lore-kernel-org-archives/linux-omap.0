From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: Re: [PATCH v2 2/2] DSPBRIDGE: Remove DRV_ProcUpdatestate function
Date: Tue, 2 Feb 2010 13:19:45 -0600
Message-ID: <4B687AD1.10903@ti.com>
References: <818EF96F5A7CC84789DD014773DB095484859F64@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54150 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756313Ab0BBTTu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 14:19:50 -0500
In-Reply-To: <818EF96F5A7CC84789DD014773DB095484859F64@dlee01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gomez Castellanos, Ivan" <ivan.gomez@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Ameya.Palande@nokia.com" <Ameya.Palande@nokia.com>, "Hiroshi.DOYU@nokia.com" <Hiroshi.DOYU@nokia.com>, "felipe.contreras@nokia.com" <felipe.contreras@nokia.com>, "Menon, Nishanth" <nm@ti.com>

On 1/28/2010 7:18 PM, Gomez Castellanos, Ivan wrote:
> In the previous patch, the function prototype was not removed.
>
>  From 22a3646710806c9390a48556ded889e19178db9e Mon Sep 17 00:00:00 2001
> From: Ivan Gomez<ivan.gomez@ti.com>
> Date: Thu, 28 Jan 2010 18:53:45 -0600
> Subject: [PATCH] DSPBRIDGE: Remove DRV_ProcUpdatestate function
>
> The DRV_ProcUpdatestate function was only used in two places and
> it only assigned a value.
>
> Signed-off-by: Ivan Gomez<ivan.gomez@ti.com>
> ---

[...]

> diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
> index f3a67e2..09365bc 100644
> --- a/drivers/dsp/bridge/rmgr/drv_interface.c
> +++ b/drivers/dsp/bridge/rmgr/drv_interface.c
> @@ -503,7 +503,7 @@ static int bridge_open(struct inode *ip, struct file *filp)
>   	 */
>   	pr_ctxt = MEM_Calloc(sizeof(struct PROCESS_CONTEXT), MEM_PAGED);
>   	if (pr_ctxt)
> -		DRV_ProcUpdatestate(pr_ctxt, PROC_RES_ALLOCATED);
> +		pr_ctxt->resSatate = PROC_RES_ALLOCATED;

should be resState

>   	else
>   		status = -ENOMEM;
>
> @@ -622,7 +622,7 @@ DSP_STATUS DRV_RemoveAllResources(HANDLE hPCtxt)
>   	DRV_RemoveAllSTRMResElements(pCtxt);
>   	DRV_RemoveAllNodeResElements(pCtxt);
>   	DRV_RemoveAllDMMResElements(pCtxt);
> -	DRV_ProcUpdatestate(pCtxt, PROC_RES_FREED);
> +	pCtxt->resState = PROC_RES_FREED;
>   	return status;
>   }
>   #endif

