From: Hari Kanigeri <hari.kanigeri@gmail.com>
Subject: Re: [PATCH 6/7] omap:mailbox-add notification support for multiple readers
Date: Fri, 29 Oct 2010 07:05:41 -0500
Message-ID: <AANLkTin_qX+ANZHWg6Qk54bC7MYuA5YNKkqN-kapt2C_@mail.gmail.com>
References: <1287108808-32119-1-git-send-email-h-kanigeri2@ti.com>
	<1287108808-32119-7-git-send-email-h-kanigeri2@ti.com>
	<4CC9E3C5.7000208@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:42759 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab0J2MFm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Oct 2010 08:05:42 -0400
Received: by gxk23 with SMTP id 23so1899495gxk.19
        for <linux-omap@vger.kernel.org>; Fri, 29 Oct 2010 05:05:42 -0700 (PDT)
In-Reply-To: <4CC9E3C5.7000208@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Hari Kanigeri <h-kanigeri2@ti.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, linux omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Guzman Lugo, Fernando" <fernando.lugo@ti.com>

Omar,

>>
>> =A0static void omap_mbox_fini(struct omap_mbox *mbox)
>> =A0{
>> + =A0 =A0 =A0 if (!--mbox->use_count) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tasklet_kill(&mbox->txq->tasklet);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flush_work(&mbox->rxq->work);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox_queue_free(mbox->txq);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mbox_queue_free(mbox->rxq);
>> + =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 if (likely(mbox->ops->shutdown)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!--mbox_configured) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(mbox->irq, mb=
ox);
>
> Above hunks will create an imbalance of free_irq, as request_irq can =
be
> called per registered mailbox and free_irq is only done for the last =
caller
> releasing the mailbox handle.
>
> e.g.: mbox-1, mbox-N will request a shared irq on the same interrupt =
line,
> but only the last caller of omap_mbox_put will free its irq, leaving =
the
> other one there.
>
> This can be fixed if the free is moved to be executed within the foll=
owing
> block:
>
> =A0 =A0 =A0 =A0if (!--mbox->use_count) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0...
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0free_irq(mbox->irq, mbox);
> =A0 =A0 =A0 =A0}
>

Good catch. I will make the changes in next revision.

Thank you,
Best regards,
Hari
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
