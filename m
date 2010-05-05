From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v2 3/4] omap: mailbox: fix reverse likeliness
Date: Wed, 5 May 2010 18:24:52 +0300
Message-ID: <u2mda15981b1005050824q54a1acdfv25dd0092837cf7b@mail.gmail.com>
References: <1272815071-2827-1-git-send-email-ohad@wizery.com>
	<1272815071-2827-4-git-send-email-ohad@wizery.com> <20100503180224.GV29604@atomide.com>
	<s2nda15981b1005040447v335b0d34k1aa812404f478cd4@mail.gmail.com>
	<20100505152135.GV29604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f171.google.com ([209.85.210.171]:48149 "EHLO
	mail-yx0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755224Ab0EEPZQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 11:25:16 -0400
Received: by yxe1 with SMTP id 1so1769256yxe.33
        for <linux-omap@vger.kernel.org>; Wed, 05 May 2010 08:25:15 -0700 (PDT)
In-Reply-To: <20100505152135.GV29604@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Kanigeri Hari <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Wed, May 5, 2010 at 6:21 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Ohad Ben-Cohen <ohad@wizery.com> [100504 04:42]:
>> On Mon, May 3, 2010 at 9:02 PM, Tony Lindgren <tony@atomide.com> wro=
te:
>> > * Ohad Ben-Cohen <ohad@wizery.com> [100502 08:40]:
>> >> Fix reverse likeliness
>> >>
>> >> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> >> ---
>> >> If you want, you can also reach me at < ohadb at ti dot com >.
>> >>
>> >> =A0arch/arm/plat-omap/mailbox.c | =A0 =A04 ++--
>> >> =A01 files changed, 2 insertions(+), 2 deletions(-)
>> >>
>> >> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/ma=
ilbox.c
>> >> index 5140efc..5309213 100644
>> >> --- a/arch/arm/plat-omap/mailbox.c
>> >> +++ b/arch/arm/plat-omap/mailbox.c
>> >> @@ -290,7 +290,7 @@ static int omap_mbox_startup(struct omap_mbox=
 *mbox)
>> >> =A0 fail_alloc_txq:
>> >> =A0 =A0 =A0 free_irq(mbox->irq, mbox);
>> >> =A0 fail_request_irq:
>> >> - =A0 =A0 if (unlikely(mbox->ops->shutdown))
>> >> + =A0 =A0 if (likely(mbox->ops->shutdown))
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox->ops->shutdown(mbox);
>> >>
>> >> =A0 =A0 =A0 return ret;
>> >> @@ -303,7 +303,7 @@ static void omap_mbox_fini(struct omap_mbox *=
mbox)
>> >>
>> >> =A0 =A0 =A0 free_irq(mbox->irq, mbox);
>> >>
>> >> - =A0 =A0 if (unlikely(mbox->ops->shutdown)) {
>> >> + =A0 =A0 if (likely(mbox->ops->shutdown)) {
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&mboxes_lock);
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mbox_configured > 0)
>> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox_configured--;
>> >
>> > Does this code path need to be optimized? :)
>> >
>> > How about just get rid of the (un)likely here?
>>
>> I like this :)
>>
>> If we're at it, there are additional cold-path (un)likely macros I
>> want to target:
>
> Looks good to me.
>
> Hiroshi, care to ack/nak all the mailbox and iommu patches you want
> me to merge? Or if you have them in some git branch against mainline
> -rc6 that would be cool too.

I'll post a v3 with all recent updated in a few minutes. I hope it help=
s.

Thanks,
Ohad.

>
> We need to get the ones we want to merge into linux-arm-kernel for
> review soon, I don't think they been posted there yet.
>
> Regards,
>
> Tony
>
>
>
>> From a921f13dadc02106a2cabb15e3813411d3fcb3a8 Mon Sep 17 00:00:00 20=
01
>> From: Ohad Ben-Cohen <ohad@wizery.com>
>> Date: Sat, 17 Apr 2010 01:57:43 +0300
>> Subject: [PATCH 3/4] omap: mailbox: remove (un)likely macros from co=
ld paths
>>
>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>> ---
>> =A0arch/arm/plat-omap/mailbox.c | =A0 10 +++++-----
>> =A01 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailb=
ox.c
>> index 5140efc..7c60550 100644
>> --- a/arch/arm/plat-omap/mailbox.c
>> +++ b/arch/arm/plat-omap/mailbox.c
>> @@ -248,12 +248,12 @@ static int omap_mbox_startup(struct omap_mbox =
*mbox)
>> =A0 =A0 =A0 =A0 int ret =3D 0;
>> =A0 =A0 =A0 =A0 struct omap_mbox_queue *mq;
>>
>> - =A0 =A0 =A0 if (likely(mbox->ops->startup)) {
>> + =A0 =A0 =A0 if (mbox->ops->startup) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&mboxes_lock);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!mbox_configured)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D mbox->ops->s=
tartup(mbox);
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(ret)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&mboxes_=
lock);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> @@ -263,7 +263,7 @@ static int omap_mbox_startup(struct omap_mbox *m=
box)
>>
>> =A0 =A0 =A0 =A0 ret =3D request_irq(mbox->irq, mbox_interrupt, IRQF_=
SHARED,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox=
->name, mbox);
>> - =A0 =A0 =A0 if (unlikely(ret)) {
>> + =A0 =A0 =A0 if (ret) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed to register =
mailbox interrupt:%d\n", ret);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_request_irq;
>> @@ -290,7 +290,7 @@ static int omap_mbox_startup(struct omap_mbox *m=
box)
>> =A0 fail_alloc_txq:
>> =A0 =A0 =A0 =A0 free_irq(mbox->irq, mbox);
>> =A0 fail_request_irq:
>> - =A0 =A0 =A0 if (unlikely(mbox->ops->shutdown))
>> + =A0 =A0 =A0 if (mbox->ops->shutdown)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox->ops->shutdown(mbox);
>>
>> =A0 =A0 =A0 =A0 return ret;
>> @@ -303,7 +303,7 @@ static void omap_mbox_fini(struct omap_mbox *mbo=
x)
>>
>> =A0 =A0 =A0 =A0 free_irq(mbox->irq, mbox);
>>
>> - =A0 =A0 =A0 if (unlikely(mbox->ops->shutdown)) {
>> + =A0 =A0 =A0 if (mbox->ops->shutdown) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&mboxes_lock);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mbox_configured > 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox_configured--;
>> --
>> 1.6.3.3
>>
>> I'll wait a day or two for more comments, and send a v3 series.
>>
>> Thanks,
>> Ohad.
>>
>> >
>> > Regards,
>> >
>> > Tony
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
