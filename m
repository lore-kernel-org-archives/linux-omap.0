From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 1/4] omap: mailbox cleanup: convert rwlocks to spinlock
Date: Thu, 29 Apr 2010 16:35:45 +0300
Message-ID: <s2tda15981b1004290635i2acaaf8m193be57d1788523d@mail.gmail.com>
References: <1272390982-14882-1-git-send-email-ohad@wizery.com>
	<1272390982-14882-2-git-send-email-ohad@wizery.com> <8F7AF80515AF0D4D93307E594F3CB40E4B661D06@dlee03.ent.ti.com>
	<t2tda15981b1004290614z9cd3cacma0a18c584dbae643@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:54733 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759273Ab0D3SSz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Apr 2010 14:18:55 -0400
Received: by ywh36 with SMTP id 36so191775ywh.4
        for <linux-omap@vger.kernel.org>; Fri, 30 Apr 2010 11:18:54 -0700 (PDT)
In-Reply-To: <t2tda15981b1004290614z9cd3cacma0a18c584dbae643@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>

On Thu, Apr 29, 2010 at 4:14 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote=
:
> Hi Hari,
>
> On Thu, Apr 29, 2010 at 3:44 PM, Kanigeri, Hari <h-kanigeri2@ti.com> =
wrote:
>> Ohad,
>>
>> Looks like the conversion was missed in few places resulting in comp=
ile warnings.
>
> Thanks for pointing that out - that's really strange, it somehow
> slipped in the rebase.
>
> The interesting part is that because you compile for OMAP4 (SMP),
> you got to see the warnings, while I didn't because I compiled for OM=
AP3
> (in the UP case there's no real locking and both types of locks are
> actually the same).
>
>>
>> Please see the below fix. Let me know if you agree with the change.
>
> Sure. I'll add that missing part back together with the review commen=
ts,
> and submit a v2 patchset.

If anyone needs the complete patch now, the original can be found here:

http://dev.omapzoom.org/?p=3Dtisyslink/kernel-syslink.git;a=3Dcommitdif=
f;h=3D8da0385a57cc470ee0a013b164fd3d2438455e79

Thanks,
Ohad.
>
> Thanks again,
> Ohad.
>
>
>>
>> #########
>> [PATCH] omap: mailbox: rwlocks to spinlock: compilation fix
>>
>> fixed the missed =A0rwlocks in few places resultion in following
>> compiler warning.
>>
>> arch/arm/plat-omap/mailbox.c: In function 'omap_mbox_startup':
>> arch/arm/plat-omap/mailbox.c:246: warning: passing argument 1 of '_r=
aw_write_lock' from incompatible pointer type
>> arch/arm/plat-omap/mailbox.c:251: warning: passing argument 1 of '_r=
aw_write_unlock' from incompatible pointer type
>> arch/arm/plat-omap/mailbox.c:255: warning: passing argument 1 of '_r=
aw_write_unlock' from incompatible pointer type
>> arch/arm/plat-omap/mailbox.c: In function 'omap_mbox_fini':
>> arch/arm/plat-omap/mailbox.c:301: warning: passing argument 1 of '_r=
aw_write_lock' from incompatible pointer type
>> arch/arm/plat-omap/mailbox.c:306: warning: passing argument 1 of '_r=
aw_write_unlock' from incompatible pointer type
>>
>> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
>> ---
>> =A0arch/arm/plat-omap/mailbox.c | =A0 10 +++++-----
>> =A01 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailb=
ox.c
>> index 27a8d98..d6a700d 100644
>> --- a/arch/arm/plat-omap/mailbox.c
>> +++ b/arch/arm/plat-omap/mailbox.c
>> @@ -243,16 +243,16 @@ static int omap_mbox_startup(struct omap_mbox =
*mbox)
>> =A0 =A0 =A0 =A0struct omap_mbox_queue *mq;
>>
>> =A0 =A0 =A0 =A0if (likely(mbox->ops->startup)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_lock(&mboxes_lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&mboxes_lock);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!mbox_configured)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D mbox->ops->st=
artup(mbox);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (unlikely(ret)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_unlock(&mboxes_l=
ock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&mboxes_lo=
ck);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mbox_configured++;
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_unlock(&mboxes_lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&mboxes_lock);
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0ret =3D request_irq(mbox->irq, mbox_interrupt, IRQF_S=
HARED,
>> @@ -298,12 +298,12 @@ static void omap_mbox_fini(struct omap_mbox *m=
box)
>> =A0 =A0 =A0 =A0free_irq(mbox->irq, mbox);
>>
>> =A0 =A0 =A0 =A0if (likely(mbox->ops->shutdown)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_lock(&mboxes_lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&mboxes_lock);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mbox_configured > 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mbox_configured--;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!mbox_configured)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mbox->ops->shutdown(m=
box);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_unlock(&mboxes_lock);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&mboxes_lock);
>> =A0 =A0 =A0 =A0}
>> =A0}
>>
>> --
>>
>> ################
>>
>>> -----Original Message-----
>>> From: Ohad Ben-Cohen [mailto:ohad@wizery.com]
>>> Sent: Tuesday, April 27, 2010 12:56 PM
>>> To: linux-omap@vger.kernel.org
>>> Cc: Kanigeri, Hari; Hiroshi Doyu; Ohad Ben-Cohen
>>> Subject: [PATCH 1/4] omap: mailbox cleanup: convert rwlocks
>>> to spinlock
>>>
>>> rwlocks are slower and have potential starvation issues so
>>> spinlocks are generally preferred
>>>
>>> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
>>> ---
>>> =A0arch/arm/plat-omap/mailbox.c | =A0 20 ++++++++++----------
>>> =A01 files changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/arch/arm/plat-omap/mailbox.c
>>> b/arch/arm/plat-omap/mailbox.c index 08a2df7..d73d51a 100644
>>> --- a/arch/arm/plat-omap/mailbox.c
>>> +++ b/arch/arm/plat-omap/mailbox.c
>>> @@ -31,7 +31,7 @@
>>>
>>> =A0static struct workqueue_struct *mboxd;
>>> =A0static struct omap_mbox *mboxes;
>>> -static DEFINE_RWLOCK(mboxes_lock);
>>> +static DEFINE_SPINLOCK(mboxes_lock);
>>>
>>> =A0static int mbox_configured;
>>>
>>> @@ -330,14 +330,14 @@ struct omap_mbox *omap_mbox_get(const
>>> char *name)
>>> =A0 =A0 =A0 struct omap_mbox *mbox;
>>> =A0 =A0 =A0 int ret;
>>>
>>> - =A0 =A0 read_lock(&mboxes_lock);
>>> + =A0 =A0 spin_lock(&mboxes_lock);
>>> =A0 =A0 =A0 mbox =3D *(find_mboxes(name));
>>> =A0 =A0 =A0 if (mbox =3D=3D NULL) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 read_unlock(&mboxes_lock);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&mboxes_lock);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENOENT);
>>> =A0 =A0 =A0 }
>>>
>>> - =A0 =A0 read_unlock(&mboxes_lock);
>>> + =A0 =A0 spin_unlock(&mboxes_lock);
>>>
>>> =A0 =A0 =A0 ret =3D omap_mbox_startup(mbox);
>>> =A0 =A0 =A0 if (ret)
>>> @@ -363,15 +363,15 @@ int omap_mbox_register(struct device
>>> *parent, struct omap_mbox *mbox)
>>> =A0 =A0 =A0 if (mbox->next)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EBUSY;
>>>
>>> - =A0 =A0 write_lock(&mboxes_lock);
>>> + =A0 =A0 spin_lock(&mboxes_lock);
>>> =A0 =A0 =A0 tmp =3D find_mboxes(mbox->name);
>>> =A0 =A0 =A0 if (*tmp) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 write_unlock(&mboxes_lock);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&mboxes_lock);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_find;
>>> =A0 =A0 =A0 }
>>> =A0 =A0 =A0 *tmp =3D mbox;
>>> - =A0 =A0 write_unlock(&mboxes_lock);
>>> + =A0 =A0 spin_unlock(&mboxes_lock);
>>>
>>> =A0 =A0 =A0 return 0;
>>>
>>> @@ -384,18 +384,18 @@ int omap_mbox_unregister(struct
>>> omap_mbox *mbox) =A0{
>>> =A0 =A0 =A0 struct omap_mbox **tmp;
>>>
>>> - =A0 =A0 write_lock(&mboxes_lock);
>>> + =A0 =A0 spin_lock(&mboxes_lock);
>>> =A0 =A0 =A0 tmp =3D &mboxes;
>>> =A0 =A0 =A0 while (*tmp) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mbox =3D=3D *tmp) {
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *tmp =3D mbox->next;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox->next =3D NULL;
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 write_unlock(&mboxes_lock=
);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&mboxes_lock)=
;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D &(*tmp)->next;
>>> =A0 =A0 =A0 }
>>> - =A0 =A0 write_unlock(&mboxes_lock);
>>> + =A0 =A0 spin_unlock(&mboxes_lock);
>>>
>>> =A0 =A0 =A0 return -EINVAL;
>>> =A0}
>>> --
>>> 1.6.3.3
>>>
>>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
