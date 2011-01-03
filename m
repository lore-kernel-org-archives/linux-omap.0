From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: [PATCH 01/32] arm/omap: use system_wq in mailbox
Date: Mon, 3 Jan 2011 15:35:45 -0600
Message-ID: <AANLkTimMK2Ec8SQiRyRBR+MdVKhAmMaaf+oa0VK3wWsf@mail.gmail.com>
References: <1294062595-30097-1-git-send-email-tj@kernel.org>
	<1294062595-30097-2-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1294062595-30097-2-git-send-email-tj@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Tejun,

On Mon, Jan 3, 2011 at 7:49 AM, Tejun Heo <tj@kernel.org> wrote:
> With cmwq, there's no reason to use a separate workqueue for mailbox.
> Use the system_wq instead. =A0mbox->rxq->work is sync flushed in
> omap_mbox_fini() to make sure it's not running on any cpu, which make=
s
> sure that no mbox work is running when omap_mbox_exit() is entered.
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-omap@vger.kernel.org
> ---
> Only compile tested. =A0Please feel free to take it into the subsyste=
m
> tree or simply ack - I'll route it through the wq tree.

This was changed to dedicated work queue because of performance issues
when there is heavy mailbox traffic between the cores.

Reference:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg24240.html


>
> Thanks.
>
> =A0arch/arm/plat-omap/mailbox.c | =A0 10 ++--------
> =A01 files changed, 2 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbo=
x.c
> index d2fafb8..5bc4d7b 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -31,7 +31,6 @@
>
> =A0#include <plat/mailbox.h>
>
> -static struct workqueue_struct *mboxd;
> =A0static struct omap_mbox **mboxes;
> =A0static bool rq_full;
>
> @@ -186,7 +185,7 @@ static void __mbox_rx_interrupt(struct omap_mbox =
*mbox)
> =A0 =A0 =A0 =A0/* no more messages in the fifo. clear IRQ source. */
> =A0 =A0 =A0 =A0ack_mbox_irq(mbox, IRQ_RX);
> =A0nomem:
> - =A0 =A0 =A0 queue_work(mboxd, &mbox->rxq->work);
> + =A0 =A0 =A0 schedule_work(&mbox->rxq->work);
> =A0}
>
> =A0static irqreturn_t mbox_interrupt(int irq, void *p)
> @@ -291,7 +290,7 @@ static void omap_mbox_fini(struct omap_mbox *mbox=
)
> =A0{
> =A0 =A0 =A0 =A0free_irq(mbox->irq, mbox);
> =A0 =A0 =A0 =A0tasklet_kill(&mbox->txq->tasklet);
> - =A0 =A0 =A0 flush_work(&mbox->rxq->work);
> + =A0 =A0 =A0 flush_work_sync(&mbox->rxq->work);
> =A0 =A0 =A0 =A0mbox_queue_free(mbox->txq);
> =A0 =A0 =A0 =A0mbox_queue_free(mbox->rxq);
>
> @@ -385,10 +384,6 @@ static int __init omap_mbox_init(void)
> =A0 =A0 =A0 =A0if (err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>
> - =A0 =A0 =A0 mboxd =3D create_workqueue("mboxd");
> - =A0 =A0 =A0 if (!mboxd)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> -
> =A0 =A0 =A0 =A0/* kfifo size sanity check: alignment and minimal size=
 */
> =A0 =A0 =A0 =A0mbox_kfifo_size =3D ALIGN(mbox_kfifo_size, sizeof(mbox=
_msg_t));
> =A0 =A0 =A0 =A0mbox_kfifo_size =3D max_t(unsigned int, mbox_kfifo_siz=
e, sizeof(mbox_msg_t));
> @@ -399,7 +394,6 @@ subsys_initcall(omap_mbox_init);
>
> =A0static void __exit omap_mbox_exit(void)
> =A0{
> - =A0 =A0 =A0 destroy_workqueue(mboxd);
> =A0 =A0 =A0 =A0class_unregister(&omap_mbox_class);
> =A0}
> =A0module_exit(omap_mbox_exit);
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Thank you,
Best regards,
Hari Kanigeri
