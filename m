From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: mailbox: trivial whitespace fix
Date: Mon, 5 Mar 2012 14:01:10 -0800
Message-ID: <20120305220110.GX12083@atomide.com>
References: <1327424535-19862-1-git-send-email-felipe.contreras@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:33757 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755338Ab2CEWBN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Mar 2012 17:01:13 -0500
Content-Disposition: inline
In-Reply-To: <1327424535-19862-1-git-send-email-felipe.contreras@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@nokia.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jiri Kosina <trivial@kernel.org>

* Felipe Contreras <felipe.contreras@nokia.com> [120124 08:32]:
> Signed-off-by: Felipe Contreras <felipe.contreras@nokia.com>
> ---
>  arch/arm/plat-omap/mailbox.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
> index ad80112..ad32621 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -307,7 +307,7 @@ static void omap_mbox_fini(struct omap_mbox *mbox)
>  	if (!--mbox->use_count) {
>  		free_irq(mbox->irq, mbox);
>  		tasklet_kill(&mbox->txq->tasklet);
> -	flush_work_sync(&mbox->rxq->work);
> +		flush_work_sync(&mbox->rxq->work);
>  		mbox_queue_free(mbox->txq);
>  		mbox_queue_free(mbox->rxq);
>  	}

Thanks applying into fixes-non-critical-part2.

Regards,

Tony
