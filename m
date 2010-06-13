From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 4/4] omap: mailbox: convert block api to kfifo
Date: Sun, 13 Jun 2010 18:52:16 -0500
Message-ID: <AANLkTinixlUAjtwFZmGIkio4H0Gzy1Moww2ssoLBKQWr@mail.gmail.com>
References: <AANLkTik8tLfUzLxcd9tfC_VIgLcRGXbZPLM06nMsMHKz@mail.gmail.com>
	<496565EC904933469F292DDA3F1663E602CBA2C97A@dlee06.ent.ti.com>
	<AANLkTik1OCrni_1Ao0d1qUenn7IAxUaTcQvXU3osjha9@mail.gmail.com>
	<20100609.080728.260086205.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53151 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754873Ab0FMXwh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Jun 2010 19:52:37 -0400
Received: by wyb40 with SMTP id 40so3267171wyb.19
        for <linux-omap@vger.kernel.org>; Sun, 13 Jun 2010 16:52:36 -0700 (PDT)
In-Reply-To: <20100609.080728.260086205.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: deepak.chitriki@ti.com, omar.ramirez@ti.com, h-kanigeri2@ti.com, linux-omap@vger.kernel.org

On Wed, Jun 9, 2010 at 12:07 AM, Hiroshi DOYU <Hiroshi.DOYU@nokia.com> =
wrote:
> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbo=
x.c
> index 87e0cde..1b79b32 100644
> --- a/arch/arm/plat-omap/mailbox.c
> +++ b/arch/arm/plat-omap/mailbox.c
> @@ -188,7 +188,7 @@ static void __mbox_rx_interrupt(struct omap_mbox =
*mbox)
> =A0 =A0 =A0 =A0/* no more messages in the fifo. clear IRQ source. */
> =A0 =A0 =A0 =A0ack_mbox_irq(mbox, IRQ_RX);
> =A0nomem:
> - =A0 =A0 =A0 queue_work(mboxd, &mbox->rxq->work);
> + =A0 =A0 =A0 mbox->callback(mbox);
> =A0}

I like this !

It will allow us to easily plug in new IPC mechanisms in the future.

(btw, if we do this, and also introduce omap_mbox_msg_send_sync, do we
still need a mailbox queuing mechanism at all ? :)

Having said that, this is not going to solve the lockdep warning
reported by Deepak - that was caused because of dspbridge's sending
context (and not because of the receiving context). To eliminate that
issue, I prefer fixing dspbridge to use work queues rather than using
spin_lock_bh in omap_mbox_msg_send. Disabling system bottom halves
just to send a mbox msg sounds unjustified (unless bridge really needs
to use tasklets instead of work queues, which I slightly doubt). What
do you think ?

Speaking of mailbox I'd like to address some issues that are code relat=
ed:

* Let's add mailbox API to set the callback pointer (it feels wrong to
let users directly manipulate the mbox structure).

* We can also safely move the callback field to the main mbox
structure, since it has no usage in the TX mq; it's pretty global to
the whole mbox.

* Let's make sure no one accidentally registers two receivers on the
same time (which would result in one overwriting the other's callback
field).

* mbox_configured is a global variable and that breaks support of
multiple concurrent mailbox instances. Let's move this logic into the
instance of mbox.

* If we make sure there are no two user of the same mailbox instance
(see 3rd *), we can eliminate mbox_configured and its locking (not
that doesn't mean there can't be two concurrent sending contexts, it
just means they are somewhat related, they have a common receiver,
which was registered using only a single call to get).

Something like this, pls tell me what you think:


=46rom 353d36d7fd6ec76c81689893338dfd4d33c8c89a Mon Sep 17 00:00:00 200=
1
=46rom: Ohad Ben-Cohen <ohad@wizery.com>
Date: Sun, 13 Jun 2010 18:32:22 -0500
Subject: [PATCH] mailbox: enforce sane usage

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
I can also be contacted via <  ohadb  at  ti  dot  com  >

 arch/arm/plat-omap/include/plat/mailbox.h |    5 ++-
 arch/arm/plat-omap/mailbox.c              |   38 +++++++++++++++------=
-------
 2 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mailbox.h
b/arch/arm/plat-omap/include/plat/mailbox.h
index 729166b..0a5bf19 100644
--- a/arch/arm/plat-omap/include/plat/mailbox.h
+++ b/arch/arm/plat-omap/include/plat/mailbox.h
@@ -45,7 +45,6 @@ struct omap_mbox_queue {
 	struct request_queue	*queue;
 	struct work_struct	work;
 	struct tasklet_struct	tasklet;
-	int	(*callback)(void *);
 	struct omap_mbox	*mbox;
 };

@@ -65,12 +64,14 @@ struct omap_mbox {
 	void			*priv;

 	void			(*err_notify)(void);
+	int			(*callback)(void *);
+	atomic_t		count;
 };

 int omap_mbox_msg_send(struct omap_mbox *, mbox_msg_t msg);
 void omap_mbox_init_seq(struct omap_mbox *);

-struct omap_mbox *omap_mbox_get(const char *);
+struct omap_mbox *omap_mbox_get(const char *, int (*)(void *));
 void omap_mbox_put(struct omap_mbox *);

 int omap_mbox_register(struct device *parent, struct omap_mbox *);
diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.=
c
index 08a2df7..5f29ea4 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -33,8 +33,6 @@ static struct workqueue_struct *mboxd;
 static struct omap_mbox *mboxes;
 static DEFINE_RWLOCK(mboxes_lock);

-static int mbox_configured;
-
 /* Mailbox FIFO handle functions */
 static inline mbox_msg_t mbox_fifo_read(struct omap_mbox *mbox)
 {
@@ -146,7 +144,7 @@ static void mbox_rx_work(struct work_struct *work)

 		msg =3D (mbox_msg_t)rq->special;
 		blk_end_request_all(rq, 0);
-		mbox->rxq->callback((void *)msg);
+		mbox->callback((void *)msg);
 	}
 }

@@ -249,16 +247,10 @@ static int omap_mbox_startup(struct omap_mbox *mb=
ox)
 	struct omap_mbox_queue *mq;

 	if (likely(mbox->ops->startup)) {
-		write_lock(&mboxes_lock);
-		if (!mbox_configured)
-			ret =3D mbox->ops->startup(mbox);
-
+		ret =3D mbox->ops->startup(mbox);
 		if (unlikely(ret)) {
-			write_unlock(&mboxes_lock);
 			return ret;
 		}
-		mbox_configured++;
-		write_unlock(&mboxes_lock);
 	}

 	ret =3D request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
@@ -304,13 +296,10 @@ static void omap_mbox_fini(struct omap_mbox *mbox=
)
 	free_irq(mbox->irq, mbox);

 	if (unlikely(mbox->ops->shutdown)) {
-		write_lock(&mboxes_lock);
-		if (mbox_configured > 0)
-			mbox_configured--;
-		if (!mbox_configured)
-			mbox->ops->shutdown(mbox);
-		write_unlock(&mboxes_lock);
+		mbox->ops->shutdown(mbox);
 	}
+
+	atomic_dec(&mbox->count);
 }

 static struct omap_mbox **find_mboxes(const char *name)
@@ -325,7 +314,7 @@ static struct omap_mbox **find_mboxes(const char *n=
ame)
 	return p;
 }

-struct omap_mbox *omap_mbox_get(const char *name)
+struct omap_mbox *omap_mbox_get(const char *name, int (*callback)(void=
 *))
 {
 	struct omap_mbox *mbox;
 	int ret;
@@ -339,9 +328,19 @@ struct omap_mbox *omap_mbox_get(const char *name)

 	read_unlock(&mboxes_lock);

+	if (atomic_inc_return(&mbox->count) > 1) {
+		pr_err("%s: mbox %s already in use\n", __func__, mbox->name);
+		atomic_dec(&mbox->count);
+		return ERR_PTR(-EBUSY);
+	}
+
 	ret =3D omap_mbox_startup(mbox);
-	if (ret)
+	if (ret) {
+		atomic_dec(&mbox->count);
 		return ERR_PTR(-ENODEV);
+	}
+
+	mbox->callback =3D callback;

 	return mbox;
 }
@@ -370,6 +369,9 @@ int omap_mbox_register(struct device *parent,
struct omap_mbox *mbox)
 		write_unlock(&mboxes_lock);
 		goto err_find;
 	}
+
+	atomic_set(&mbox->count, 0);
+
 	*tmp =3D mbox;
 	write_unlock



Thanks,
Ohad.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
