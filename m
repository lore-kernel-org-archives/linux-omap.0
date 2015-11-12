From: santosh shilimkar <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH] gpio: omap: fix debounce time calculation
Date: Thu, 12 Nov 2015 12:02:19 -0800
Message-ID: <5644F04B.6080406@oracle.com>
References: <1447350640-20347-1-git-send-email-balbi@ti.com>
 <5644D4F5.8070006@ti.com> <87egfvqecr.fsf@saruman.tx.rr.com>
 <5644E85C.8010807@ti.com> <877flnqagp.fsf@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <877flnqagp.fsf@saruman.tx.rr.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 11/12/2015 11:33 AM, Felipe Balbi wrote:
>
> Hi,
>
> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>> On 11/12/2015 08:09 PM, Felipe Balbi wrote:
>>>
>>> Hi,
>>>
>>> Grygorii Strashko <grygorii.strashko@ti.com> writes:
>>>> On 11/12/2015 07:50 PM, Felipe Balbi wrote:
>>>>> According to TRM, debounce is measured in periods of
>>>>> the functional clock of the GPIO IP. This means that
>>>>
>>>>
>>>> What TRM? link pls.
>>>>
>>>> http://www.ti.com/lit/ug/spruhl7d/spruhl7d.pdf
>>>>
>>>> 28.4.1.24 GPIO_DEBOUNCINGTIME Register (offset = 154h) [reset = 0h]
>>>>
>>>> The GPIO_DEBOUNCINGTIME register controls debouncing time (the value is
>>>> global for all ports). The debouncing cell is running with the
>>>> debouncing clock (32 kHz), this register represents the number of the
>>>> clock cycle(s) (31 s long) to be used.
>>>>
>>>> Debouncing Value in 31 microsecond steps.
>>>> Debouncing Value = (DEBOUNCETIME + 1) * 31 microseconds.
>>>
>>> DRA7xx:
>>>
>>> "
>>> 8-bit values specifying the debouncing time. It is n-
>>> periods of the muxed clock, which can come from either
>>> a true 32k oscillator/pad of from the system clock. It
>>> depends on which boot mode is selected. For more
>>> information see Chapter 32, Initialization.
>>> "
>>>
>>
>> See
>> http://www.ti.com/lit/ug/spruhz6d/spruhz6d.pdf
>> 27.4.3 General-Purpose Interface Clock Configuration
>> 27.4.3.1 Clocking
>>
>> This completely unclear. Sry, I think this patch can't be used as is,
>> first of all because of backward compatibility issues.
>
> yeah, might be. No issues, I'll just go dig older TRMs and trying to
> figure this one out. Meanwhile, let's let's keep it as is.
>
Just to be clear, being a common GPIO driver, it can't break
backward compatibility. So NAK for current patch.
If needed, please setup different debounce functions based
on GPIO IP numbers if it makes is efficient/accurate.

Regards,
Santosh

