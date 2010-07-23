From: Hari Kanigeri <hari.kanigeri@gmail.com>
Subject: Re: [PATCH 2/2] omap:mailbox-provide multiple reader support
Date: Thu, 22 Jul 2010 23:05:05 -0500
Message-ID: <AANLkTikB+WE5rErmiAhXNn6g3KQZ+xKvAbsuFvFxe8sG@mail.gmail.com>
References: <1279662096-3121-1-git-send-email-h-kanigeri2@ti.com>
	<1279662096-3121-3-git-send-email-h-kanigeri2@ti.com>
	<702744BC498BAE41B3AA631D95EC463058B3CFD799@NOK-EUMSG-01.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:51468 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701Ab0GWEFH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jul 2010 00:05:07 -0400
Received: by yxg6 with SMTP id 6so986335yxg.19
        for <linux-omap@vger.kernel.org>; Thu, 22 Jul 2010 21:05:06 -0700 (PDT)
In-Reply-To: <702744BC498BAE41B3AA631D95EC463058B3CFD799@NOK-EUMSG-01.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext-phil.2.carmody@nokia.com
Cc: h-kanigeri2@ti.com, linux-omap@vger.kernel.org, tony@atomide.com, hiroshi.doyu@nokia.com, ohad@wizery.com

Phil,

Thanks for looking at the patch.


On Wed, Jul 21, 2010 at 4:45 AM,  <ext-phil.2.carmody@nokia.com> wrote:
> Apologies - top posting and not quoting properly due to having to use=
 MS's braindead OWA.
>
> It appears that most of the "changes" are simply indentation changes =
caused by the inclusion of a new inner block here:

-- I don't know if we can say most of the changes are simply
indentation changes.

> + =A0 =A0 =A0 if (atomic_inc_return(&mbox->use_count) =3D=3D 1) {
> rather than just using a goto to skip past the unneeded parts. (Hmmm,=
 is it not simply an immediate return now?)
> The goto/return is both more idiomatic in linux, and I'm sure a simpl=
er patch.

-- Sure, I will make the change.

>
> Phil
> ________________________________________
> From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.=
org] On Behalf Of ext Hari Kanigeri [h-kanigeri2@ti.com]
> Sent: 21 July 2010 01:41
> To: Linux Omap; Tony Lindgren; Doyu Hiroshi (Nokia-MS/Helsinki)
> Cc: Ohad Ben-Cohen; Hari Kanigeri
> Subject: [PATCH 2/2] omap:mailbox-provide multiple reader support
>
> This patch provides mutiple readers support for a mailbox
> instance.
>
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
> =A0arch/arm/plat-omap/include/plat/mailbox.h | =A0 =A06 ++-
> =A0arch/arm/plat-omap/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 63 +=
+++++++++++++++------------
> =A02 files changed, 40 insertions(+), 29 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/pla=
t-omap/include/plat/mailbox.h
> index 0486d64..c8e47d8 100644
> --- a/arch/arm/plat-omap/include/plat/mailbox.h
> +++ b/arch/arm/plat-omap/include/plat/mailbox.h
> @@ -68,13 +68,15 @@ struct omap_mbox {
> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*priv;
>
> =A0 =A0 =A0 =A0void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(*err_noti=
fy)(void);
> + =A0 =A0 =A0 atomic_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0use_count;
> + =A0 =A0 =A0 struct blocking_notifier_head =A0 notifier;
> =A0};
>
> =A0int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
> =A0void omap_mbox_init_seq(struct omap_mbox *);
>
> -struct omap_mbox *omap_mbox_get(const char *);
> -void omap_mbox_put(struct omap_mbox *);
> +struct omap_mbox *omap_mbox_get(const char *, struct notifier_block =
*nb);
> +void omap_mbox_put(struct omap_mbox *, struct notifier_block *nb);
>
> =A0int omap_mbox_register(struct device *parent, struct omap_mbox *);
> =A0int omap_mbox_unregister(struct omap_mbox *);
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbo=
x.c
> index baac315..f9f2af4 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -149,8 +149,8 @@ static void mbox_rx_work(struct work_struct *work=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (unlikely(len !=3D sizeof(msg)))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("%s: kfifo_out =
anomaly detected\n", __func__);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mq->callback)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq->callback((void *)ms=
g);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 blocking_notifier_call_chain(&mq->mbox-=
>notifier, len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void *)msg);
> =A0 =A0 =A0 =A0}
> =A0}
>
> @@ -252,28 +252,30 @@ static int omap_mbox_startup(struct omap_mbox *=
mbox)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 ret =3D request_irq(mbox->irq, mbox_interrupt, IRQF_SHA=
RED,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox->n=
ame, mbox);
> - =A0 =A0 =A0 if (unlikely(ret)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed to register mai=
lbox interrupt:%d\n", ret);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_request_irq;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (atomic_inc_return(&mbox->use_count) =3D=3D 1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D request_irq(mbox->irq, mbox_int=
errupt, IRQF_SHARED,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mbox->name, mbox);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(ret)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "failed=
 to register mailbox interrupt:"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%d\n", ret);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_request_irq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 mq =3D mbox_queue_alloc(mbox, NULL, mbox_tx_tasklet);
> - =A0 =A0 =A0 if (!mq) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_alloc_txq;
> - =A0 =A0 =A0 }
> - =A0 =A0 =A0 mbox->txq =3D mq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq =3D mbox_queue_alloc(mbox, NULL, mbo=
x_tx_tasklet);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!mq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_alloc_txq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox->txq =3D mq;
>
> - =A0 =A0 =A0 mq =3D mbox_queue_alloc(mbox, mbox_rx_work, NULL);
> - =A0 =A0 =A0 if (!mq) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_alloc_rxq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq =3D mbox_queue_alloc(mbox, mbox_rx_w=
ork, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!mq) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_alloc_rxq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox->rxq =3D mq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mq->mbox =3D mbox;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 mbox->rxq =3D mq;
> -
> =A0 =A0 =A0 =A0return 0;
>
> =A0fail_alloc_rxq:
> @@ -281,6 +283,7 @@ static int omap_mbox_startup(struct omap_mbox *mb=
ox)
> =A0fail_alloc_txq:
> =A0 =A0 =A0 =A0free_irq(mbox->irq, mbox);
> =A0fail_request_irq:
> + =A0 =A0 =A0 atomic_dec(&mbox->use_count);
> =A0 =A0 =A0 =A0if (likely(mbox->ops->shutdown)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (atomic_dec_return(&mbox_refcount) =
=3D=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mbox->ops->shutdown(mb=
ox);
> @@ -291,10 +294,12 @@ static int omap_mbox_startup(struct omap_mbox *=
mbox)
>
> =A0static void omap_mbox_fini(struct omap_mbox *mbox)
> =A0{
> - =A0 =A0 =A0 mbox_queue_free(mbox->txq);
> - =A0 =A0 =A0 mbox_queue_free(mbox->rxq);
>
> - =A0 =A0 =A0 free_irq(mbox->irq, mbox);
> + =A0 =A0 =A0 if (atomic_dec_return(&mbox->use_count) =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox_queue_free(mbox->txq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox_queue_free(mbox->rxq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(mbox->irq, mbox);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (likely(mbox->ops->shutdown)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (atomic_dec_return(&mbox_refcount) =
=3D=3D 0)
> @@ -314,7 +319,7 @@ static struct omap_mbox **find_mboxes(const char =
*name)
> =A0 =A0 =A0 =A0return p;
> =A0}
>
> -struct omap_mbox *omap_mbox_get(const char *name)
> +struct omap_mbox *omap_mbox_get(const char *name, struct notifier_bl=
ock *nb)
> =A0{
> =A0 =A0 =A0 =A0struct omap_mbox *mbox;
> =A0 =A0 =A0 =A0int ret;
> @@ -325,19 +330,21 @@ struct omap_mbox *omap_mbox_get(const char *nam=
e)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock(&mboxes_lock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_PTR(-ENOENT);
> =A0 =A0 =A0 =A0}
> -
> =A0 =A0 =A0 =A0spin_unlock(&mboxes_lock);
>
> =A0 =A0 =A0 =A0ret =3D omap_mbox_startup(mbox);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ERR_PTR(-ENODEV);
> + =A0 =A0 =A0 if (nb)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 blocking_notifier_chain_register(&mbox-=
>notifier, nb);
>
> =A0 =A0 =A0 =A0return mbox;
> =A0}
> =A0EXPORT_SYMBOL(omap_mbox_get);
>
> -void omap_mbox_put(struct omap_mbox *mbox)
> +void omap_mbox_put(struct omap_mbox *mbox, struct notifier_block *nb=
)
> =A0{
> + =A0 =A0 =A0 blocking_notifier_chain_unregister(&mbox->notifier, nb)=
;
> =A0 =A0 =A0 =A0omap_mbox_fini(mbox);
> =A0}
> =A0EXPORT_SYMBOL(omap_mbox_put);
> @@ -361,6 +368,8 @@ int omap_mbox_register(struct device *parent, str=
uct omap_mbox *mbox)
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0*tmp =3D mbox;
> =A0 =A0 =A0 =A0spin_unlock(&mboxes_lock);
> + =A0 =A0 =A0 BLOCKING_INIT_NOTIFIER_HEAD(&mbox->notifier);
> + =A0 =A0 =A0 atomic_set(&mbox->use_count, 0);
>
> =A0 =A0 =A0 =A0return 0;
>
> --
> 1.7.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
