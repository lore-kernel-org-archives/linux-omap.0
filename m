From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: Panda ES board hang when using GPIO as interrupt
Date: Fri, 29 Jun 2012 10:53:04 -0500
Message-ID: <4FEDCF60.9020800@ti.com>
References: <4FE8CF77.5080400@broadcom.com> <87txxxs9we.fsf@ti.com> <4FEBA854.5010508@broadcom.com> <4FEC7B48.8040402@ti.com> <4FECCB91.7090609@broadcom.com> <4FECD2E5.1060603@ti.com> <4FECE067.7000809@broadcom.com> <4FECE1BD.80906@ti.com> <4FECE45E.6040506@broadcom.com> <4FECEE9A.5070300@ti.com> <4FECFDD8.5060105@broadcom.com> <CAC83ZvJJw-7Xt4Ey4_OT70D6MGHEfwURYVuj5wYTLe5oYiMuRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAC83ZvJJw-7Xt4Ey4_OT70D6MGHEfwURYVuj5wYTLe5oYiMuRw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "DebBarma, Tarun Kanti" <tarun.kanti-l0cyMroinI0@public.gmane.org>
Cc: Franky Lin <frankyl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Kevin Hilman <khilman-l0cyMroinI0@public.gmane.org>, b-cousson-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


On 06/28/2012 11:07 PM, DebBarma, Tarun Kanti wrote:
> On Fri, Jun 29, 2012 at 6:29 AM, Franky Lin <frankyl-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
>> On 06/28/2012 04:54 PM, Jon Hunter wrote:
>>>
>>> I am wondering if this could be the bug ... on start-up I see that we do
>>> a context restore on bank1 during the probe which is before we have done
>>> the first suspend! In other words, we could restore a bad/uninitialised
>>> context for bank1. In the case of bank1, the loss count starts at 1 and
>>> not 0 and so we falsely think we need to perform a restore :-(
>>>
>>> [    0.176269] omap_gpio_runtime_resume: bank @ 0xfc310000
>>> [    0.177276] omap_gpio_runtime_resume: count 0, now 1
>>> [    0.177276] gpiochip_add: registered GPIOs 0 to 31 on device: gpio
>>> [    0.177642] omap_gpio_runtime_suspend: bank @ 0xfc310000
>>>
>>> Can you try ...
>>>
>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>> index c4ed172..9623408 100644
>>> --- a/drivers/gpio/gpio-omap.c
>>> +++ b/drivers/gpio/gpio-omap.c
>>> @@ -1086,6 +1086,9 @@ static int __devinit omap_gpio_probe(struct
>>> platform_device *pdev)
>>>  #ifdef CONFIG_OF_GPIO
>>>         bank->chip.of_node = of_node_get(node);
>>>  #endif
>>> +       if (bank->get_context_loss_count)
>>> +               bank->context_loss_count =
>>> +                               bank->get_context_loss_count(bank->dev);
>>>
>>>         bank->irq_base = irq_alloc_descs(-1, 0, bank->width, 0);
>>>         if (bank->irq_base < 0) {
>>>
>>
>> Looks like you found the culprit. :) It does fix the problem.
> So this looks similar to what NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org> reported in
> another thread.
> The reason was context_loss_count = 1 for GPIO BANK#0 which of course is in the
> WKUP domain. In fact he tried out with the same fix. Anyways, we
> should hear from
> Kevin now whether it is feasible to fix the context_loss_count for the WKUP GPIO
> bank or to put the workaround here in the gpio driver.

Ok, so I have been looking at this some more today. I believe that the
actual bug is that we are not checking to see if "loses_context" is true
before populating "get_context_loss_count" (see omap dmtimer driver).
For bank0 loses_context is false and so we should never be calling
"get_context_loss_count" in the first place.

I will send out a patch to fix this and will copy Kevin and Franky.

Franky, if you can test and confirm it works that would be great.

Kevin, if you can review that would be great too.

Cheers
Jon
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
