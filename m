From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 3/4] omap: mailbox: fix reverse likeliness
Date: Mon, 3 May 2010 11:02:24 -0700
Message-ID: <20100503180224.GV29604@atomide.com>
References: <1272815071-2827-1-git-send-email-ohad@wizery.com>
 <1272815071-2827-4-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:59701 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754166Ab0ECSCZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 14:02:25 -0400
Content-Disposition: inline
In-Reply-To: <1272815071-2827-4-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

* Ohad Ben-Cohen <ohad@wizery.com> [100502 08:40]:
> Fix reverse likeliness
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
> ---
> If you want, you can also reach me at < ohadb at ti dot com >.
> 
>  arch/arm/plat-omap/mailbox.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
> index 5140efc..5309213 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -290,7 +290,7 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
>   fail_alloc_txq:
>  	free_irq(mbox->irq, mbox);
>   fail_request_irq:
> -	if (unlikely(mbox->ops->shutdown))
> +	if (likely(mbox->ops->shutdown))
>  		mbox->ops->shutdown(mbox);
>  
>  	return ret;
> @@ -303,7 +303,7 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
>  
>  	free_irq(mbox->irq, mbox);
>  
> -	if (unlikely(mbox->ops->shutdown)) {
> +	if (likely(mbox->ops->shutdown)) {
>  		spin_lock(&mboxes_lock);
>  		if (mbox_configured > 0)
>  			mbox_configured--;

Does this code path need to be optimized? :)

How about just get rid of the (un)likely here?

Regards,

Tony
