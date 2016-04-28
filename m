From: Laxman Dewangan <ldewangan@nvidia.com>
Subject: Re: [PATCH 3/7] mfd: max77686: Use devm_mfd_add_devices and devm_regmap_add_irq_chip
Date: Thu, 28 Apr 2016 15:32:42 +0530
Message-ID: <5721DFC2.4070301@nvidia.com>
References: <1461241558-26983-1-git-send-email-ldewangan@nvidia.com> <1461241558-26983-4-git-send-email-ldewangan@nvidia.com> <571DF7FD.8020209@samsung.com> <20160428090102.GM4892@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160428090102.GM4892@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: milo.kim@ti.com, cw00.choi@samsung.com, sbkim73@samsung.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


On Thursday 28 April 2016 02:31 PM, Lee Jones wrote:
> On Mon, 25 Apr 2016, Krzysztof Kozlowski wrote:
>
>> On 04/21/2016 02:25 PM, Laxman Dewangan wrote:
>>> Use devm_mfd_add_devices() for adding MFD child devices and
>>> devm_regmap_add_irq_chip() for IRQ chip registration.
>>>
>>> This reduces the error code path and .remove callback for removing
>>> MFD child devices and deleting IRQ chip data.
>>>
>>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>>> CC: Chanwoo Choi <cw00.choi@samsung.com>
>>> CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>>> ---
>>>   drivers/mfd/max77686.c | 31 ++++++++-----------------------
>>>   1 file changed, 8 insertions(+), 23 deletions(-)
>> Switching existing code to devm-like interface doesn't bring huge
>> benefits but looks okay and I'm fine with it:
> This is pretty much my view, but it get's Laxman's patch count up. ;)

Yaah. :-)

There is some other motivation of doing this:
* I got the review comment about the resource leak and sequencing in my 
max77620. It was silly mistake done by me  and it causes recycle of 
patch. To avoid this in future, devm_ was better option.
* Spent lots of time on unbinding test during my RTC patch. Although fix 
was not related to the devm_ but gave the impression that something we 
are doing on probe. devm_ looks straight forward.
- Some of code quality tools suggest to avoid goto statement. Only 
possible if we dont have any code in error path i.e. return from any place.
- If we have devm_ apis for few resource and some does not support then 
difficult to use them as this affect the sequence of deallocation. 
Existing devm_ can be used effectively only if we have all resource 
allocation using devm_.
- Reducing code size always better.
