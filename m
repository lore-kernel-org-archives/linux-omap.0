From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH v4 4/5] OMAP: mailbox: send message in process context
Date: Wed, 24 Nov 2010 10:56:54 +0530
Message-ID: <AANLkTimbXXmPu5KQtpxG6jTxaj18ad+Q5dHSPArEtXgr@mail.gmail.com>
References: <1290547617-16640-1-git-send-email-h-kanigeri2@ti.com> <1290547617-16640-5-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:41766 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750922Ab0KXF1f convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Nov 2010 00:27:35 -0500
Received: by mail-iw0-f169.google.com with SMTP id 35so446364iwn.14
        for <linux-omap@vger.kernel.org>; Tue, 23 Nov 2010 21:27:35 -0800 (PST)
In-Reply-To: <1290547617-16640-5-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <h-kanigeri2@ti.com>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Benoit Cousson <b-cousson@ti.com>, Felipe Balbi <balbi@ti.com>

On Wed, Nov 24, 2010 at 02:56, Hari Kanigeri <h-kanigeri2@ti.com> wrote=
:
> Schedule the Tasklet to send only when mailbox fifo is full and there=
 are
> pending messages in kifo, else send the message directly in the Proce=
ss

Typo -> kifo

> context. This would avoid needless scheduling of Tasklet for every me=
ssage
> transfer
>
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
> =A0arch/arm/plat-omap/mailbox.c | =A0 =A09 +++++++--
> =A01 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbo=
x.c
> index 13698ab..f4177df 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -92,20 +92,25 @@ int omap_mbox_msg_send(struct omap_mbox *mbox, mb=
ox_msg_t msg)
> =A0 =A0 =A0 =A0struct omap_mbox_queue *mq =3D mbox->txq;
> =A0 =A0 =A0 =A0int ret =3D 0, len;
>
> - =A0 =A0 =A0 spin_lock(&mq->lock);
> + =A0 =A0 =A0 spin_lock_bh(&mq->lock);
>
> =A0 =A0 =A0 =A0if (kfifo_avail(&mq->fifo) < sizeof(msg)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENOMEM;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (kfifo_is_empty(&mq->fifo) && !__mbox_poll_for_space=
(mbox)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox_fifo_write(mbox, msg);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0len =3D kfifo_in(&mq->fifo, (unsigned char *)&msg, siz=
eof(msg));
> =A0 =A0 =A0 =A0WARN_ON(len !=3D sizeof(msg));
>
> =A0 =A0 =A0 =A0tasklet_schedule(&mbox->txq->tasklet);
>
> =A0out:
> - =A0 =A0 =A0 spin_unlock(&mq->lock);
> + =A0 =A0 =A0 spin_unlock_bh(&mq->lock);
> =A0 =A0 =A0 =A0return ret;
> =A0}
> =A0EXPORT_SYMBOL(omap_mbox_msg_send);
> --
> 1.7.0
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
