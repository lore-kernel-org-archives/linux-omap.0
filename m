From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 3/7] omap: mailbox: call request_irq after mbox queues
 are allocated
Date: Mon, 10 Jun 2013 14:14:55 -0500
Message-ID: <51B625AF.3040801@ti.com>
References: <1370656671-41285-1-git-send-email-s-anna@ti.com> <CA+Bv8XYWswZOy91pQgrT_YgXXavwZbHgB=H7_mTkYFRf0kdcbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44556 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754027Ab3FJTU0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Jun 2013 15:20:26 -0400
In-Reply-To: <CA+Bv8XYWswZOy91pQgrT_YgXXavwZbHgB=H7_mTkYFRf0kdcbg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Jassi Brar <jaswinder.singh@linaro.org>, Loic Pallardy <loic.pallardy@st.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fernando Guzman Lugo <lugo.fernando@gmail.com>

Russ,

On 06/08/2013 01:53 PM, Russ Dill wrote:
> On Fri, Jun 7, 2013 at 6:57 PM, Suman Anna <s-anna@ti.com> wrote:
>> The OMAP mailbox startup code is enabling the interrupt even before
>> any of the associated mailbox queues are allocated. Any pending
>> received mailbox message could cause a kernel panic as soon as
>> the interrupt is enabled due to the dereferencing of non-existing
>> mailbox queues within the ISR.
>>
>> Signed-off-by: Fernando Guzman Lugo <lugo.fernando@gmail.com>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>  arch/arm/plat-omap/mailbox.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
>> index 5fb4027..e1bd333 100644
>> --- a/arch/arm/plat-omap/mailbox.c
>> +++ b/arch/arm/plat-omap/mailbox.c
>> @@ -261,13 +261,6 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
>>         }
>>
>>         if (!mbox->use_count++) {
>> -               ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
>> -                                                       mbox->name, mbox);
>> -               if (unlikely(ret)) {
>> -                       pr_err("failed to register mailbox interrupt:%d\n",
>> -                                                                       ret);
>> -                       goto fail_request_irq;
>> -               }
>>                 mq = mbox_queue_alloc(mbox, NULL, mbox_tx_tasklet);
>>                 if (!mq) {
>>                         ret = -ENOMEM;
>> @@ -282,17 +275,24 @@ static int omap_mbox_startup(struct omap_mbox *mbox)
>>                 }
>>                 mbox->rxq = mq;
>>                 mq->mbox = mbox;
>> +               ret = request_irq(mbox->irq, mbox_interrupt, IRQF_SHARED,
>> +                                                       mbox->name, mbox);
>> +               if (unlikely(ret)) {
>> +                       pr_err("failed to register mailbox interrupt:%d\n",
>> +                                                                       ret);
>> +                       goto fail_request_irq;
>> +               }
>>
>>                 omap_mbox_enable_irq(mbox, IRQ_RX);
> 
> I can't help but to notice the IRQ unmasking function here. Is there a
> reason it isn't working?

This patch was based on an internal patch needed before the equivalent
of 1d8a0e9 "ARM: OMAP: enable mailbox irq per instance" is merged. I
will revise the patch description - this is more of a minor cleanup now
rather than a fix, would have been a fix without the above patch. Thanks
for pointing it out.

regards
Suman
