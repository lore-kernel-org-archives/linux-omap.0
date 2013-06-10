From: Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH 2/7] omap: mailbox: check for NULL nb in mailbox_put
Date: Mon, 10 Jun 2013 12:38:26 -0500
Message-ID: <51B60F12.30708@ti.com>
References: <1370656664-41250-1-git-send-email-s-anna@ti.com> <CA+Bv8XZW-Xv7D-TxqTiUF-t-QESMQqWGOq2fLshXVA-N7if_5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45913 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab3FJRoB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jun 2013 13:44:01 -0400
In-Reply-To: <CA+Bv8XZW-Xv7D-TxqTiUF-t-QESMQqWGOq2fLshXVA-N7if_5w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russ Dill <Russ.Dill@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Ohad Ben-Cohen <ohad@wizery.com>, Omar Ramirez Luna <omar.ramirez@copitl.com>, Jassi Brar <jaswinder.singh@linaro.org>, Loic Pallardy <loic.pallardy@st.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Fernando Guzman Lugo <lugo.fernando@gmail.com>

Russ,

On 06/08/2013 01:46 PM, Russ Dill wrote:
> On Fri, Jun 7, 2013 at 6:57 PM, Suman Anna <s-anna@ti.com> wrote:
>> The mailbox_put function must check the notifier block for
>> NULL before trying to unregister it.
> 
> I'm going to nack this one. Why must it check for NULL? None of the
> callers pass a NULL argument and blocking_notifier_chain_unregister
> handles a NULL nb argument just fine.

Thanks for the review. It should have been done differently, which is to
print an error trace if the passed in arguments are NULL. Anyway, I will
drop this since I expect this function to go away once this is adapted
to the new framework.

regards
Suman

> 
>> Signed-off-by: Fernando Guzman Lugo <lugo.fernando@gmail.com>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>  arch/arm/plat-omap/mailbox.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/plat-omap/mailbox.c b/arch/arm/plat-omap/mailbox.c
>> index 42377ef..5fb4027 100644
>> --- a/arch/arm/plat-omap/mailbox.c
>> +++ b/arch/arm/plat-omap/mailbox.c
>> @@ -356,7 +356,8 @@ EXPORT_SYMBOL(omap_mbox_get);
>>
>>  void omap_mbox_put(struct omap_mbox *mbox, struct notifier_block *nb)
>>  {
>> -       blocking_notifier_chain_unregister(&mbox->notifier, nb);
>> +       if (nb)
>> +               blocking_notifier_chain_unregister(&mbox->notifier, nb);
>>         omap_mbox_fini(mbox);
>>  }
>>  EXPORT_SYMBOL(omap_mbox_put);
>> --
>> 1.8.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

