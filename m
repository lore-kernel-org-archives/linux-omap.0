From: Russ Dill <russ.dill@gmail.com>
Subject: Re: [PATCH 3/7] omap: mailbox: call request_irq after mbox queues are allocated
Date: Sat, 8 Jun 2013 11:53:26 -0700
Message-ID: <CA+Bv8XYWswZOy91pQgrT_YgXXavwZbHgB=H7_mTkYFRf0kdcbg@mail.gmail.com>
References: <1370656671-41285-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:48171 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286Ab3FHSx1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Jun 2013 14:53:27 -0400
Received: by mail-qc0-f177.google.com with SMTP id n1so716861qcx.22
        for <linux-omap@vger.kernel.org>; Sat, 08 Jun 2013 11:53:26 -0700 (PDT)
In-Reply-To: <1370656671-41285-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Jassi Brar <jaswinder.singh@linaro.org>, Loic Pallardy <loic.pallardy@st.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fernando Guzman Lugo <lugo.fernando@gmail.com>

On Fri, Jun 7, 2013 at 6:57 PM, Suman Anna <s-anna@ti.com> wrote:
> The OMAP mailbox startup code is enabling the interrupt even before
> any of the associated mailbox queues are allocated. Any pending
> received mailbox message could cause a kernel panic as soon as
> the interrupt is enabled due to the dereferencing of non-existing
> mailbox queues within the ISR.
>
> Signed-off-by: Fernando Guzman Lugo <lugo.fernando@gmail.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  arch/arm/plat-omap/mailbox.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
> index 5fb4027..e1bd333 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -261,13 +261,6 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
>         }
>
>         if (!mbox->use_count++) {
> -               ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
> -                                                       mbox->name, mbox);
> -               if (unlikely(ret)) {
> -                       pr_err("failed to register mailbox interrupt:%d\n",
> -                                                                       ret);
> -                       goto fail_request_irq;
> -               }
>                 mq = mbox_queue_alloc(mbox, NULL, mbox_tx_tasklet);
>                 if (!mq) {
>                         ret = -ENOMEM;
> @@ -282,17 +275,24 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
>                 }
>                 mbox->rxq = mq;
>                 mq->mbox = mbox;
> +               ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
> +                                                       mbox->name, mbox);
> +               if (unlikely(ret)) {
> +                       pr_err("failed to register mailbox interrupt:%d\n",
> +                                                                       ret);
> +                       goto fail_request_irq;
> +               }
>
>                 omap_mbox_enable_irq(mbox, IRQ_RX);

I can't help but to notice the IRQ unmasking function here. Is there a
reason it isn't working?

>         }
>         mutex_unlock(&mbox_configured_lock);
>         return 0;
>
> +fail_request_irq:
> +       mbox_queue_free(mbox->rxq);
>  fail_alloc_rxq:
>         mbox_queue_free(mbox->txq);
>  fail_alloc_txq:
> -       free_irq(mbox->irq, mbox);
> -fail_request_irq:
>         if (mbox->ops->shutdown)
>                 mbox->ops->shutdown(mbox);
>         mbox->use_count--;
> --
> 1.8.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
