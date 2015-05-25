From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [RFC/RFT PATCH v2 7/7] gpio: omap: ensure that runtime pm will
 disable unused gpio banks
Date: Mon, 25 May 2015 18:08:07 +0300
Message-ID: <55633AD7.8060806@linaro.org>
References: <1432305354-5968-1-git-send-email-grygorii.strashko@linaro.org> <1432305354-5968-8-git-send-email-grygorii.strashko@linaro.org> <20150522181016.GC10274@atomide.com> <556335AA.5090701@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <556335AA.5090701@linaro.org>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Javier Martinez Canillas <javier@dowhile0.org>, ssantosh@kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 05/25/2015 05:46 PM, Grygorii.Strashko@linaro.org wrote:
> Hi Tony,
> 
> On 05/22/2015 09:10 PM, Tony Lindgren wrote:
>> * Grygorii Strashko <grygorii.strashko@linaro.org> [150522 07:37]:
>>> Now there are some points related to Runtime PM usage:
>>> 1) bank state doesn't need to be checked in places where
>>> Rintime PM is used, bacause Runtime PM maintains its
>>> own usage counter:
>>>        if (!BANK_USED(bank))
>>>                 pm_runtime_get_sync(bank->dev);
>>> so, it's safe to drop such checks.
>>>
>>> 2) Such implementation is racy, because check !BANK_USED(bank)
>>>     is not protected, like:
>>>   CPU0                CPU1
>>>   gpio_request(bankX.A)
>>>   ...
>>>   gpio_free(bankX.A)        gpio_request(bankX.Y)
>>>
>>>   and bankX can be unpowered in the middle of processing
>>>   gpio_request(bankX.Y)
>>>
>>> 3) There is a call of pm_runtime_get_sync() in omap_gpio_irq_type(),
>>> but no corresponding put. As result, GPIO devices could be
>>> powered on forever if at least one GPIO was used as IRQ.
>>> Hence, allow powering off GPIO banks by adding missed
>>> pm_runtime_put(bank->dev) at the end of omap_gpio_irq_type().
>>>
>>> As, part of this change update omap2_gpio_xxxx_idle() functions
>>> to use pm_runtime_force_suspend()/pm_runtime_force_resume().
>>>
>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
>>> ---
>>> Changes in v2:
>>>   - omap2_gpio_xxxx_idle() functions switched to use
>>>     pm_runtime_force_suspend()/pm_runtime_force_resume() API.
>>>
>>> v1:
>>>      http://marc.info/?l=linux-gpio&m=142567003515626&w=2
>>
>> This one causes an abort during boot on at least omap3.
>>
>> Maybe try to get a beagleboard xm to test with? It has Ethernet
>> over USB though, so that does not work with PM over NFSroot.
>>
>> If you want something to test with PM with mainline over
>> NFSroot, maybe you can get hold of some of the better supported
>> ones out of these boards:
>>
>> $ git grep "ethernet@gpmc" arch/arm/boot/dts/*.dts*
>>
>> For those Ethernet has a GPIO interrupt ;)
> 
> Sure, I'll try get beagleboard.
> 
> But, this log is very interesting :( What I can see
> from it is that GPIO IRQ is triggered in the middle of
> omap_sram_idle() - which shouldn't happen, because this is
> cpuidle path and local IRQs should be disabled.
> 
> Am I missing smth?
> 

Yep. I've missed this :(  
pm_runtime_force_suspend
 |- pm_runtime_disable
    |-__pm_runtime_disable
       |- spin_unlock_irq(&dev->power.lock);

So, Runtime PM forced API can't be used in cpuidle path :(

Sorry.

-- 
regards,
-grygorii
