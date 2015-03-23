From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/4] mmc: core: allow non-blocking form of mmc_claim_host
Date: Mon, 23 Mar 2015 10:58:24 +0100
Message-ID: <CAPDyKFrY=DEH0dZvObgXriMoTz9fBbBhOhU3+ZXATUkj=vrpnA@mail.gmail.com>
References: <20150224024023.22719.32436.stgit@notabene.brown>
	<20150224024223.22719.95786.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:36173 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbbCWJ6Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2015 05:58:25 -0400
Received: by qgez102 with SMTP id z102so51923759qge.3
        for <linux-omap@vger.kernel.org>; Mon, 23 Mar 2015 02:58:24 -0700 (PDT)
In-Reply-To: <20150224024223.22719.95786.stgit@notabene.brown>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Tony Lindgren <tony@atomide.com>, Andreas Fenkart <afenkart@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, GTA04 owners <gta04-owner@goldelico.com>, NeilBrown <neil@brown.name>, linux-omap <linux-omap@vger.kernel.org>

On 24 February 2015 at 03:42, NeilBrown <neilb@suse.de> wrote:
> Change the handling for the 'abort' flag so that if
> it is set, but we can claim the host, then do the claim,
> rather than aborting.
>
> When the abort is async this just means that a race between aborting
> an allowing a claim is resolved slightly differently.  Any
> code must already be able to handle 'abort' being set just as the host
> is claimed.
>
> This allows extra functionality.  If __mmc_claim_host() is called
> with an 'abort' pointer which is initialized to '1', it will effect a
> non-blocking 'claim'.
>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  drivers/mmc/core/core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 23f10f72e5f3..541c8903dc6b 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -912,10 +912,11 @@ int __mmc_claim_host(struct mmc_host *host, atomic_t *abort)
>                 spin_lock_irqsave(&host->lock, flags);
>         }
>         set_current_state(TASK_RUNNING);
> -       if (!stop) {
> +       if (!host->claimed || host->claimer == current) {

This seems risky in that regards that it will change the behaviour for
the sdio_irq_thread(). Did you check that?

I guess we could change the sdio_irq_thread() to read it's
sdio_irq_thread_abort value before trying to claim the host?

>                 host->claimed = 1;
>                 host->claimer = current;
>                 host->claim_cnt += 1;
> +               stop = 0;
>         } else
>                 wake_up(&host->wq);
>         spin_unlock_irqrestore(&host->lock, flags);
>
>

Kind regards
Uffe
