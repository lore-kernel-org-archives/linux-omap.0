From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH] genirq: provide dummy set_irq_wake()
Date: Wed, 15 Apr 2015 11:07:38 +0300
Message-ID: <552E1C4A.7060503@ti.com>
References: <1427721345-6402-1-git-send-email-rogerq@ti.com> <552CE847.7060103@ti.com> <552D1DEF.6080303@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53954 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752325AbbDOIH6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Apr 2015 04:07:58 -0400
In-Reply-To: <552D1DEF.6080303@free-electrons.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: tglx@linutronix.de, cw00.choi@samsung.com, balbi@ti.com, tony@atomide.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Gregory,

On 14/04/15 17:02, Gregory CLEMENT wrote:
> Hi Roger,
> 
> On 14/04/2015 12:13, Roger Quadros wrote:
>> Hi Thomas,
>>
>> On 30/03/15 16:15, Roger Quadros wrote:
>>> Without this system suspend is broken on systems that have
>>> drivers calling enable/disable_irq_wake() for interrupts based off
>>> the dummy irq hook.
>>> (e.g. drivers/gpio/gpio-pcf857x.c)
>>>
>>> http://article.gmane.org/gmane.linux.kernel/1879035
>>>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>
>> Any comments on this patch?
> 
> I read the url you pointed and I wonder why, at then end, did
> you choose to add a dummy set_irq_wake() instead of using
> IRQCHIP_SKIP_SET_WAKE ?

You mean like this?

diff --git a/kernel/irq/dummychip.c b/kernel/irq/dummychip.c
index 988dc58..2feb6fe 100644
--- a/kernel/irq/dummychip.c
+++ b/kernel/irq/dummychip.c
@@ -57,5 +57,6 @@ struct irq_chip dummy_irq_chip = {
 	.irq_ack	= noop,
 	.irq_mask	= noop,
 	.irq_unmask	= noop,
+	.flags		= IRQCHIP_SKIP_SET_WAKE,
 };
 EXPORT_SYMBOL_GPL(dummy_irq_chip);

This works as well and is better. I'll post a v2.

cheers,
-roger

>>
>>> ---
>>>  kernel/irq/dummychip.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/kernel/irq/dummychip.c b/kernel/irq/dummychip.c
>>> index 988dc58..2405d7a 100644
>>> --- a/kernel/irq/dummychip.c
>>> +++ b/kernel/irq/dummychip.c
>>> @@ -32,6 +32,11 @@ static unsigned int noop_ret(struct irq_data *data)
>>>  	return 0;
>>>  }
>>>  
>>> +static int noop_int_ret(struct irq_data *data, unsigned int val)
>>> +{
>>> +	return 0;
>>> +}
>>> +
>>>  /*
>>>   * Generic no controller implementation
>>>   */
>>> @@ -57,5 +62,6 @@ struct irq_chip dummy_irq_chip = {
>>>  	.irq_ack	= noop,
>>>  	.irq_mask	= noop,
>>>  	.irq_unmask	= noop,
>>> +	.irq_set_wake	= noop_int_ret,
>>>  };
>>>  EXPORT_SYMBOL_GPL(dummy_irq_chip);
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> 

