From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 2/2] omap:mailbox-provide multiple reader support
Date: Wed, 28 Jul 2010 01:02:29 +0300
Message-ID: <AANLkTi=tHyRBgO79e=LEPOS85z=87TEt1QOvXR+keZHG@mail.gmail.com>
References: <1279662096-3121-1-git-send-email-h-kanigeri2@ti.com>
	<1279662096-3121-3-git-send-email-h-kanigeri2@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51084 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab0G0WCv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Jul 2010 18:02:51 -0400
Received: by wwj40 with SMTP id 40so1784031wwj.1
        for <linux-omap@vger.kernel.org>; Tue, 27 Jul 2010 15:02:50 -0700 (PDT)
In-Reply-To: <1279662096-3121-3-git-send-email-h-kanigeri2@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hari Kanigeri <h-kanigeri2@ti.com>
Cc: Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>

Hi Hari,

On Wed, Jul 21, 2010 at 12:41 AM, Hari Kanigeri <h-kanigeri2@ti.com> wr=
ote:
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

In this context, I'd like to change notifier to support adding a
cookie which will be passed back to the handler function (unmodified,
in a similar manner to request_irq's void *dev param).

This cookie param will be passed to the mailbox callback whenever a
mailbox event is triggered, and will allow drivers to have multiple
instances: instead of maintaining their state in a global variable
(like bridge is doing today), it will be given back every time a
mailbox event is delivered. For syslink it will also help using the
same mbox callback for different devices (e.g. sysm3, appm3).

The changes should be minor, and shouldn't affect existing notifier
users, here's the diff (untested):

diff --git a/include/linux/notifier.h b/include/linux/notifier.h
index 540703b..e740aea 100644
--- a/include/linux/notifier.h
+++ b/include/linux/notifier.h
@@ -51,6 +51,7 @@ struct notifier_block {
        int (*notifier_call)(struct notifier_block *, unsigned long, vo=
id *);
        struct notifier_block *next;
        int priority;
+       void *dev_id;
 };

 struct atomic_notifier_head {
diff --git a/kernel/notifier.c b/kernel/notifier.c
index 2488ba7..050fd9b 100644
--- a/kernel/notifier.c
+++ b/kernel/notifier.c
@@ -64,6 +64,7 @@ static int notifier_chain_unregister(struct notifier_=
block **n
  *     @nl:            Pointer to head of the blocking notifier chain
  *     @val:           Value passed unmodified to notifier function
  *     @v:             Pointer passed unmodified to notifier function
+ *                     If pointer is NULL, the notifier block's
cookie is passed
  *     @nr_to_call:    Number of notifier functions to be called. Don'=
t care
  *                     value of this parameter is -1.
  *     @nr_calls:      Records the number of notifications sent. Don't=
 care
@@ -90,6 +91,7 @@ static int __kprobes notifier_call_chain(struct notif=
ier_block
                        continue;
                }
 #endif
+               v =3D v ? v : nb->dev_id;
                ret =3D nb->notifier_call(nb, val, v);

                if (nr_calls)


And the only change in your mbox patch should be:

@@ -149,8 +149,8 @@ static void mbox_rx_work(struct work_struct *work)
               if (unlikely(len !=3D sizeof(msg)))
                       pr_err("%s: kfifo_out anomaly detected\n", __fun=
c__);

-               blocking_notifier_call_chain(&mq->mbox->notifier, len,
-                                                       (void *)msg);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 blocking_notifier_call_chain(&mq->mbox->n=
otifier, msg, NULL);
       }
 }

The result should be us getting both the mailbox msg and the original
cookie, which will, in our case, be the context of the relevant
dspbridge or syslink driver.

What do you think ?

Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
