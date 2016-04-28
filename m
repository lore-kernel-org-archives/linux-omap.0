From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH 3/7] mfd: max77686: Use devm_mfd_add_devices and
 devm_regmap_add_irq_chip
Date: Thu, 28 Apr 2016 12:39:36 +0200
Message-ID: <5721E868.6090003@samsung.com>
References: <1461241558-26983-1-git-send-email-ldewangan@nvidia.com>
 <1461241558-26983-4-git-send-email-ldewangan@nvidia.com>
 <571DF7FD.8020209@samsung.com> <20160428090102.GM4892@dell>
 <5721DFC2.4070301@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <5721DFC2.4070301@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laxman Dewangan <ldewangan@nvidia.com>, Lee Jones <lee.jones@linaro.org>
Cc: milo.kim@ti.com, cw00.choi@samsung.com, sbkim73@samsung.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/28/2016 12:02 PM, Laxman Dewangan wrote:
> 
> On Thursday 28 April 2016 02:31 PM, Lee Jones wrote:
>> On Mon, 25 Apr 2016, Krzysztof Kozlowski wrote:
>>
>>> On 04/21/2016 02:25 PM, Laxman Dewangan wrote:
>>>> Use devm_mfd_add_devices() for adding MFD child devices and
>>>> devm_regmap_add_irq_chip() for IRQ chip registration.
>>>>
>>>> This reduces the error code path and .remove callback for removing
>>>> MFD child devices and deleting IRQ chip data.
>>>>
>>>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>>>> CC: Chanwoo Choi <cw00.choi@samsung.com>
>>>> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>>> ---
>>>>   drivers/mfd/max77686.c | 31 ++++++++-----------------------
>>>>   1 file changed, 8 insertions(+), 23 deletions(-)
>>> Switching existing code to devm-like interface doesn't bring huge
>>> benefits but looks okay and I'm fine with it:
>> This is pretty much my view, but it get's Laxman's patch count up. ;)
> 
> Yaah. :-)



The patch was applied so discussion seems useful only for future work. I
don't agree with some of your motivation.

> There is some other motivation of doing this:
> * I got the review comment about the resource leak and sequencing in my
> max77620. It was silly mistake done by me  and it causes recycle of
> patch. To avoid this in future, devm_ was better option.

This is new code. You made error in new code... this is not an argument
to change something in existing well tested code.

> * Spent lots of time on unbinding test during my RTC patch. Although fix
> was not related to the devm_ but gave the impression that something we
> are doing on probe. devm_ looks straight forward.

Nope, the opposite. Usage of devm-like interface hides the order of
cleaning up. With explicit clean it is easy to spot the reverse work of
probe and to find the differences (like when the code is not in the
exact reverse order).

> - Some of code quality tools suggest to avoid goto statement. Only
> possible if we dont have any code in error path i.e. return from any place.

The 'goto' with one exit point is a part of kernel coding style. Of
course lack of error paths is easier to read... usually.

> - If we have devm_ apis for few resource and some does not support then
> difficult to use them as this affect the sequence of deallocation.
> Existing devm_ can be used effectively only if we have all resource
> allocation using devm_.

Ekhm? I don't understand.

> - Reducing code size always better.

Usually... but (again) introducing such questionable improvements for
existing code which was well tested and is working fine:
1. May introduce bugs. Code is already working, error path maybe was or
was not tested. At least it was reviewed. Your change may break this.

2. Is unnecessary code churn. If there are no clear benefits (and for me
in case of max77686 there are no benefits) you just used mine and
maintainer's time.


This is even different kind of change than improvements for defensive
coding (like adding 'consts'). Here, the code does not necessarily
improve. Error paths and order of cleanup are hidden.

Best regards,
Krzysztof
