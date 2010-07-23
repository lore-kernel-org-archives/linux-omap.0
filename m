From: Hari Kanigeri <hari.kanigeri@gmail.com>
Subject: Re: [PATCH 2/2] omap:mailbox-provide multiple reader support
Date: Thu, 22 Jul 2010 23:11:14 -0500
Message-ID: <AANLkTinw1Gbbj57FH4htQsYnF7Z6-MCMEz+NbjwgsrQv@mail.gmail.com>
References: <1279662096-3121-1-git-send-email-h-kanigeri2@ti.com>
	<1279662096-3121-3-git-send-email-h-kanigeri2@ti.com>
	<496565EC904933469F292DDA3F1663E602CBFB10BD@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38704 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab0GWELO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jul 2010 00:11:14 -0400
Received: by yxg6 with SMTP id 6so987539yxg.19
        for <linux-omap@vger.kernel.org>; Thu, 22 Jul 2010 21:11:14 -0700 (PDT)
In-Reply-To: <496565EC904933469F292DDA3F1663E602CBFB10BD@dlee06.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Guzman Lugo, Fernando" <fernando.lugo@ti.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, Linux Omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ohad Ben-Cohen <ohad@wizery.com>

=46ernando,

Thanks for looking at the patch.

On Tue, Jul 20, 2010 at 4:59 PM, Guzman Lugo, Fernando
<fernando.lugo@ti.com> wrote:
>
>
> Hi Hari,
>
>>
>> @@ -252,28 +252,30 @@ static int omap_mbox_startup(struct omap_mbox =
*mbox)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 ret =3D request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED=
,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox->name=
, mbox);
>> - =A0 =A0 if (unlikely(ret)) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed to register mailbo=
x interrupt:%d\n", ret);
>> - =A0 =A0 =A0 =A0 =A0 =A0 goto fail_request_irq;
>> - =A0 =A0 }
>> + =A0 =A0 if (atomic_inc_return(&mbox->use_count) =3D=3D 1) {
>
> What happen if a thread is preempted by other thread which also uses =
the same mailbox after doing the atomic_inc?
>
> The second thread also will call atomic_inc_return and in this case t=
he value returned will be 2 and it will not initialize the mbox queues =
but it will return success status, in this point the second thread =A0w=
ill think it could get the mailbox handle without any issue. However th=
e first thread still can fail and not initialize correctly the mailbox =
leading second thread to not work properly or crash.
>
> I think all the initialization should be protected and not just the u=
se_count.
>

-- How about changing mboxes_lock from spinlock to mutex and
protecting the initialization code ? I guess then the variables don't
have to be atomic too. please share your thougts.

> Please let me know what you think.
>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
