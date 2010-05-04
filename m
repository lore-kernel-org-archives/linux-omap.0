From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 3/4] omap: mailbox: fix reverse likeliness
Date: Tue, 4 May 2010 14:47:09 +0300
Message-ID: <s2nda15981b1005040447v335b0d34k1aa812404f478cd4@mail.gmail.com>
References: <1272815071-2827-1-git-send-email-ohad@wizery.com>
	<1272815071-2827-4-git-send-email-ohad@wizery.com> <20100503180224.GV29604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:50430 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab0EDLre convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 May 2010 07:47:34 -0400
Received: by gwj19 with SMTP id 19so1597842gwj.19
        for <linux-omap@vger.kernel.org>; Tue, 04 May 2010 04:47:33 -0700 (PDT)
In-Reply-To: <20100503180224.GV29604@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Mon, May 3, 2010 at 9:02 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Ohad Ben-Cohen <ohad@wizery.com> [100502 08:40]:
>> Fix reverse likeliness
>>
>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> ---
>> If you want, you can also reach me at < ohadb at ti dot com >.
>>
>> =A0arch/arm/plat-omap/mailbox.c | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailb=
ox.c
>> index 5140efc..5309213 100644
>> --- a/arch/arm/plat-omap/mailbox.c
>> +++ b/arch/arm/plat-omap/mailbox.c
>> @@ -290,7 +290,7 @@ static int omap_mbox_startup(struct omap_mbox *m=
box)
>> =A0 fail_alloc_txq:
>> =A0 =A0 =A0 free_irq(mbox->irq, mbox);
>> =A0 fail_request_irq:
>> - =A0 =A0 if (unlikely(mbox->ops->shutdown))
>> + =A0 =A0 if (likely(mbox->ops->shutdown))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox->ops->shutdown(mbox);
>>
>> =A0 =A0 =A0 return ret;
>> @@ -303,7 +303,7 @@ static void omap_mbox_fini(struct omap_mbox *mbo=
x)
>>
>> =A0 =A0 =A0 free_irq(mbox->irq, mbox);
>>
>> - =A0 =A0 if (unlikely(mbox->ops->shutdown)) {
>> + =A0 =A0 if (likely(mbox->ops->shutdown)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&mboxes_lock);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mbox_configured > 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox_configured--;
>
> Does this code path need to be optimized? :)
>
> How about just get rid of the (un)likely here?

I like this :)

If we're at it, there are additional cold-path (un)likely macros I
want to target:

=46rom a921f13dadc02106a2cabb15e3813411d3fcb3a8 Mon Sep 17 00:00:00 200=
1
=46rom: Ohad Ben-Cohen <ohad@wizery.com>
Date: Sat, 17 Apr 2010 01:57:43 +0300
Subject: [PATCH 3/4] omap: mailbox: remove (un)likely macros from cold =
paths

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 arch/arm/plat-omap/mailbox.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.=
c
index 5140efc..7c60550 100644
--- a/arch/arm/plat-omap/mailbox.c
+++ b/arch/arm/plat-omap/mailbox.c
@@ -248,12 +248,12 @@ static int omap_mbox_startup(struct omap_mbox *mb=
ox)
        int ret =3D 0;
        struct omap_mbox_queue *mq;

-       if (likely(mbox->ops->startup)) {
+       if (mbox->ops->startup) {
                spin_lock(&mboxes_lock);
                if (!mbox_configured)
                        ret =3D mbox->ops->startup(mbox);

-               if (unlikely(ret)) {
+               if (ret) {
                        spin_unlock(&mboxes_lock);
                        return ret;
                }
@@ -263,7 +263,7 @@ static int omap_mbox_startup(struct omap_mbox *mbox=
)

        ret =3D request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
                                mbox->name, mbox);
-       if (unlikely(ret)) {
+       if (ret) {
                printk(KERN_ERR
                        "failed to register mailbox interrupt:%d\n", re=
t);
                goto fail_request_irq;
@@ -290,7 +290,7 @@ static int omap_mbox_startup(struct omap_mbox *mbox=
)
  fail_alloc_txq:
        free_irq(mbox->irq, mbox);
  fail_request_irq:
-       if (unlikely(mbox->ops->shutdown))
+       if (mbox->ops->shutdown)
                mbox->ops->shutdown(mbox);

        return ret;
@@ -303,7 +303,7 @@ static void omap_mbox_fini(struct omap_mbox *mbox)

        free_irq(mbox->irq, mbox);

-       if (unlikely(mbox->ops->shutdown)) {
+       if (mbox->ops->shutdown) {
                spin_lock(&mboxes_lock);
                if (mbox_configured > 0)
                        mbox_configured--;
--=20
1.6.3.3

I'll wait a day or two for more comments, and send a v3 series.

Thanks,
Ohad.

>
> Regards,
>
> Tony
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
