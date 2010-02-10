From: Ameya Palande <ameya.palande@nokia.com>
Subject: Re: [PATCH] DSPBRIDGE: check pointer before calling Proc_Detach
Date: Wed, 10 Feb 2010 15:47:39 +0200
Message-ID: <1265809659.30481.52.camel@sanganak>
References: <1265318253-20308-1-git-send-email-omar.ramirez@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:28399 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435Ab0BJNsm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Feb 2010 08:48:42 -0500
In-Reply-To: <1265318253-20308-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Doyu Hiroshi (Nokia-D/Helsinki)" <hiroshi.doyu@nokia.com>, "Contreras Felipe (Nokia-D/Helsinki)" <felipe.contreras@nokia.com>, Nishanth Menon <nm@ti.com>, Ernest Ramos Falcon <ernesto@ti.com>

Hi,

On Thu, 2010-02-04 at 22:17 +0100, ext Omar Ramirez Luna wrote:
> From: Ernest Ramos Falcon <ernesto@ti.com>
> 
> This patch adds a check before calling Proc_Detach, otherwise
> in case a failure occurs on PROC_Attach and hProcessor is
> invalid when the userspace task closes its handle, unexpected
> behavior might be seen as this pointer is dereferenced in
> PROC_Detach.
> 
> Signed-off-by: Ernest Ramos Falcon <ernesto@ti.com>
> ---
>  drivers/dsp/bridge/rmgr/drv_interface.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/dsp/bridge/rmgr/drv_interface.c b/drivers/dsp/bridge/rmgr/drv_interface.c
> index 32aff66..b0f0d93 100644
> --- a/drivers/dsp/bridge/rmgr/drv_interface.c
> +++ b/drivers/dsp/bridge/rmgr/drv_interface.c
> @@ -539,7 +539,8 @@ static int bridge_release(struct inode *ip, struct file *filp)
>  	pr_ctxt = filp->private_data;
>  	flush_signals(current);
>  	DRV_RemoveAllResources(pr_ctxt);
> -	PROC_Detach(pr_ctxt);
> +	if (pr_ctxt->hProcessor)
> +		PROC_Detach(pr_ctxt);
>  	MEM_Free(pr_ctxt);
>  
>  	filp->private_data = NULL;

I guess PROC_Detach already checks for a valid hProcessor handle!
Why we need this check here again?

Also if you go ahead with this patch, then how are you going to cover a
use case where userspace application calls PROC_Attach() which fails,
but without checking the failure userspace application calls
PROC_Detach()!

Cheers,
Ameya.

