From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 4/8] DSPBRIDGE: Remove unused hDrvObject in bridge_[open|release]
Date: Thu, 7 Jan 2010 20:19:30 -0600
Message-ID: <4B469632.8030900@ti.com>
References: <1262912440-30050-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41593 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752648Ab0AHCTd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Jan 2010 21:19:33 -0500
In-Reply-To: <1262912440-30050-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, "Guzman Lugo, Fernando" <x0095840@ti.com>, "Ramos Falcon, Ernesto" <ernesto@ti.com>

Omar Ramirez Luna had written, on 01/07/2010 07:00 PM, the following:
> This patch removes an unused variable in bridge_open
> and bridge_release functions, which reduces indentation.
> 
> Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
> ---
>  drivers/dsp/bridge/rmgr/drv_interface.c |   25 +++++--------------------
>  1 files changed, 5 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
> index 3a4d058..e551840 100644
> --- a/drivers/dsp/bridge/rmgr/drv_interface.c
> +++ b/drivers/dsp/bridge/rmgr/drv_interface.c
> @@ -540,18 +540,10 @@ static void __exit bridge_exit(void)
>  static int bridge_open(struct inode *ip, struct file *filp)
>  {
>  	int status = 0;
> -	DSP_STATUS dsp_status;
> -	HANDLE hDrvObject;
>  	struct PROCESS_CONTEXT *pr_ctxt = NULL;
>  
>  	GT_0trace(driverTrace, GT_ENTER, "-> bridge_open\n");
>  
> -	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
> -	if (DSP_FAILED(dsp_status)) {
is this some sort of verification if the hDrvObject is valid?
if so this is not an unused variable rt?

> -		status = -EIO;
> -		goto err;
> -	}
> -
>  	/*
>  	 * Allocate a new process context and insert it into global
>  	 * process context list.
> @@ -564,7 +556,6 @@ static int bridge_open(struct inode *ip, struct file *filp)
>  
>  	filp->private_data = pr_ctxt;
>  
> -err:
>  	GT_0trace(driverTrace, GT_ENTER, "<- bridge_open\n");
>  	return status;
>  }
> @@ -576,8 +567,6 @@ err:
>  static int bridge_release(struct inode *ip, struct file *filp)
>  {
>  	int status = 0;
> -	DSP_STATUS dsp_status;
> -	HANDLE hDrvObject;
>  	struct PROCESS_CONTEXT *pr_ctxt;
>  
>  	GT_0trace(driverTrace, GT_ENTER, "-> bridge_release\n");
> @@ -588,15 +577,11 @@ static int bridge_release(struct inode *ip, struct file *filp)
>  	}
>  
>  	pr_ctxt = filp->private_data;
> -	dsp_status = CFG_GetObject((u32 *)&hDrvObject, REG_DRV_OBJECT);
> -	if (DSP_SUCCEEDED(dsp_status)) {
is this some sort of verification if the hDrvObject is valid?
if so this is not an unused variable rt?
> -		flush_signals(current);
> -		DRV_RemoveAllResources(pr_ctxt);
> -		PROC_Detach(pr_ctxt);
> -		MEM_Free(pr_ctxt);
> -	} else {
> -		status = -EIO;
> -	}
> +	flush_signals(current);
> +	DRV_RemoveAllResources(pr_ctxt);
> +	PROC_Detach(pr_ctxt);
> +	MEM_Free(pr_ctxt);
> +
>  	filp->private_data = NULL;
>  
>  err:


-- 
Regards,
Nishanth Menon
