From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH 06/11] gpio/omap: add clk_prepare and clk_unprepare
Date: Mon, 25 Jun 2012 12:32:29 +0530
Message-ID: <4FE80D05.7010305@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>	<1340372890-10091-7-git-send-email-rnayak@ti.com>	<alpine.DEB.2.00.1206221312400.10198@utopia.booyaka.com>	<4FE7F765.40405@ti.com> <CAC83Zv+2B9=fu+YDab62O-WZdJzP8-qddPOZaVKLrqD0vvzCjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:43546 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753988Ab2FYHCh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 25 Jun 2012 03:02:37 -0400
Received: by pbbrq13 with SMTP id rq13so6340403pbb.8
        for <linux-omap@vger.kernel.org>; Mon, 25 Jun 2012 00:02:36 -0700 (PDT)
In-Reply-To: <CAC83Zv+2B9=fu+YDab62O-WZdJzP8-qddPOZaVKLrqD0vvzCjw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, mturquette@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Grant Likely <grant.likely@secretlab.ca>, Pankaj Jangra <jangra.pankaj9@gmail.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Monday 25 June 2012 11:41 AM, DebBarma, Tarun Kanti wrote:
> On Mon, Jun 25, 2012 at 11:00 AM, Rajendra Nayak<rnayak@ti.com>  wrote:
>> On Saturday 23 June 2012 12:47 AM, Paul Walmsley wrote:
>>>
>>> Hi
>>>
>>> On Fri, 22 Jun 2012, Rajendra Nayak wrote:
>>>
>>>> In preparation of OMAP moving to Common Clk Framework(CCF) add
>>>> clk_prepare()
>>>> for omap gpio debounce clock.
>>>>
>>>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>>>> Cc: Grant Likely<grant.likely@secretlab.ca>
>>>> ---
>>>>   drivers/gpio/gpio-omap.c |    2 ++
>>>>   1 files changed, 2 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
>>>> index c4ed172..6a73b01 100644
>>>> --- a/drivers/gpio/gpio-omap.c
>>>> +++ b/drivers/gpio/gpio-omap.c
>>>> @@ -893,6 +893,8 @@ static int gpio_debounce(struct gpio_chip *chip,
>>>> unsigned offset,
>>>>                 bank->dbck = clk_get(bank->dev, "dbclk");
>>>>                 if (IS_ERR(bank->dbck))
>>>>                         dev_err(bank->dev, "Could not get gpio dbck\n");
>>>> +               else
>>>> +                       clk_prepare(bank->dbck);
>>>>         }
>>>>
>>>>         spin_lock_irqsave(&bank->lock, flags);
>>>
>>>
>>> What code unprepares this clock?
>>>
>>> Put differently, doesn't this driver need at least a platform_driver
>>> .remove function pointer, that would call clk_unprepare() and clk_put()?
>>
>>
>> Maybe because this driver can never be built as a module. It gets
>> complied in with CONFIG_ARCH_OMAP=y.
>>
>> Adding Tarun and Santosh who can comment further.
>>
>>
>>>
>>> Also, it looks to me that the bank->dbck init should be in
>>> omap_gpio_chip_init(), not gpio_debounce()?
>>
>>
>> Tarun, can you comment on why the dbck init is in gpio_debounce
>> and not in omap_gpio_chip_init()?
> BTW, bank->dbck is initialized in gpio_debounce() even before the cleanup
> and fixes series. I am not quite sure if there was specific intent for keeping
> it here. Personally I do not see issues in doing clk_get of bank->dbck in
> omap_gpio_chip_init().

Care to send a patch to move it into omap_gpio_chip_init() then? Also
can you comment on the above point that Paul made, as to why this driver
has a .remove missing? If adding that is a non-issue, would be great if
you can drop in a patch for that too.

>
>>
>>>
>>>
>>> - Paul
>>
>>

