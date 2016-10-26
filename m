From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] mfd: tps65217: Drop call to irq_set_parent()
Date: Wed, 26 Oct 2016 06:24:48 -0700
Message-ID: <3b280a00-271a-c743-d076-4f55813fe43f@roeck-us.net>
References: <1476479886-10208-1-git-send-email-linux@roeck-us.net>
 <20161026123516.GC11267@dell> <alpine.DEB.2.20.1610261437320.4983@nanos>
 <20161026125854.GA12618@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161026125854.GA12618@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Marcin Niestroj <m.niestroj@grinn-global.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-omap@vger.kernel.org

On 10/26/2016 05:58 AM, Lee Jones wrote:
> On Wed, 26 Oct 2016, Thomas Gleixner wrote:
>
>> On Wed, 26 Oct 2016, Lee Jones wrote:
>>> On Fri, 14 Oct 2016, Guenter Roeck wrote:
>>>
>>>> The call to irq_set_parent() causes the following build error if tps65217
>>>> is built as module.
>>>>
>>>> ERROR: ".irq_set_parent" [drivers/mfd/tps65217.ko] undefined!
>>>>
>>>> The problem was introduced with commit 6556bdacf646f ("mfd: tps65217: Add
>>>> support for IRQs").
>>>>
>>>> The author states: "I have added irq_set_parent() similarly as in
>>>> drivers/base/regmap/regmap-irq.c. But to be honest I am not sure what it
>>>> really does in case of tps65217."
>>>>
>>>> So let's drop it.
>>>>
>>>> Fixes: 6556bdacf646f ("mfd: tps65217: Add support for IRQs")
>>>> Cc: Marcin Niestroj <m.niestroj@grinn-global.com>
>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> ---
>>>>  drivers/mfd/tps65217.c | 1 -
>>>>  1 file changed, 1 deletion(-)
>>>
>>> This has been fixed now.
>>
>> It was not fixed. The export was a work around as everyone was bitching
>> about the build robots failing forever.
>>
>> So if the irq_set_parent() call is not required for functionality of the
>> driver then it should not be there in the first place.
>
> Ah, I thought this was just another one of the many hacks I received
> in response to the auto-builder's complains.  I've just been NACKing
> them out of habit.
>

Well, it was, in a way. However, with the driver author being silent,
and with irq_set_parent() not that well documented, I considered it
a better solution than blindly exporting the function.

Having said that, I do suspect that its use might possibly be warranted
in this case, since the driver uses edge triggered interrupts and calls
handle_nested_irq(). But then many other drivers do the same and don't
call irq_set_parent(), so who knows. The use case for irq_set_parent()
isn't exactly well explained.

FWIW, since everyone seems to be bitching about auto-builders: You may not
care, but problems like this end up hiding other problems, can make
bisecting a pain, and can end up costing a lot of time in the future.
I have worked for companies where the common attitude was "who cares about
any builds but ours". Sounds great, until one needs to enable one more
configuration option and everything falls apart.

If you don't care about a driver being buildable as module, make it boolean.
Please.

Thanks,
Guenter
