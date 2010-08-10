From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] mailbox: change full flag per mailbox queue instead of
	global
Date: Tue, 10 Aug 2010 17:36:42 +0300
Message-ID: <AANLkTim7s8pX3k7oF7AdZobDRegx17n5gfAze1wAduoT@mail.gmail.com>
References: <1276534269-19179-1-git-send-email-x0095840@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48782 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757748Ab0HJOhD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 10:37:03 -0400
Received: by pvg2 with SMTP id 2so1203617pvg.19
        for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 07:37:03 -0700 (PDT)
In-Reply-To: <1276534269-19179-1-git-send-email-x0095840@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Fernando Guzman Lugo <x0095840@ti.com>

Hi Hiroshi,

On Mon, Jun 14, 2010 at 7:51 PM, Fernando Guzman Lugo <x0095840@ti.com>=
 wrote:
> As pointed by Ben Ohand, the variable rq_full flag is a global
> variable, so if there are multiple mailbox users there will be
> conflics. Now there is a full flag per mailbox queue.
>
> Reported-by: Ohad Ben-Cohen <ohad@wizery.com>
> Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>

It looks like this fix didn't get thru - can you please review and ack/=
nack ?

Thanks,
Ohad.

> ---
> =A0arch/arm/plat-omap/include/plat/mailbox.h | =A0 =A01 +
> =A0arch/arm/plat-omap/mailbox.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A07=
 +++----
> =A02 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/plat-omap/include/plat/mailbox.h b/arch/arm/pla=
t-omap/include/plat/mailbox.h
> index 729166b..a6144b8 100644
> --- a/arch/arm/plat-omap/include/plat/mailbox.h
> +++ b/arch/arm/plat-omap/include/plat/mailbox.h
> @@ -47,6 +47,7 @@ struct omap_mbox_queue {
> =A0 =A0 =A0 =A0struct tasklet_struct =A0 tasklet;
> =A0 =A0 =A0 =A0int =A0 =A0 (*callback)(void *);
> =A0 =A0 =A0 =A0struct omap_mbox =A0 =A0 =A0 =A0*mbox;
> + =A0 =A0 =A0 bool =A0 =A0full;
> =A0};
>
> =A0struct omap_mbox {
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbo=
x.c
> index 8d86b0b..a1e274e 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -30,7 +30,6 @@
>
> =A0static struct omap_mbox *mboxes;
> =A0static DEFINE_RWLOCK(mboxes_lock);
> -static bool rq_full;
>
> =A0static int mbox_configured;
> =A0static DEFINE_MUTEX(mbox_configured_lock);
> @@ -140,9 +139,9 @@ static void mbox_rx_work(struct work_struct *work=
)
> =A0 =A0 =A0 =A0while (1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(q->queue_lock, flags=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rq =3D blk_fetch_request(q);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rq_full) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mbox->rxq->full) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_mbox_enable_irq(m=
box, IRQ_RX);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rq_full =3D false;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox->rxq->full =3D fal=
se;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(q->queue_lock, =
flags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!rq)
> @@ -183,7 +182,7 @@ static void __mbox_rx_interrupt(struct omap_mbox =
*mbox)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rq =3D blk_get_request(q, WRITE, GFP_A=
TOMIC);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (unlikely(!rq)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_mbox_disable_irq(=
mbox, IRQ_RX);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 rq_full =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox->rxq->full =3D tru=
e;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto nomem;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> --
> 1.6.3.3
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
