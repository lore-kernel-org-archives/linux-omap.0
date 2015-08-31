From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] gpio: omap: Fix gpiochip_add() handling for deferred
 probe
Date: Mon, 31 Aug 2015 17:37:22 +0300
Message-ID: <55E466A2.9080900@ti.com>
References: <1440787489-15992-1-git-send-email-tony@atomide.com>
 <55E4186E.7090605@ti.com> <20150831141134.GA4215@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <20150831141134.GA4215@atomide.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier@dowhile0.org>, Kevin Hilman <khilman@deeprootsystems.com>, Santosh Shilimkar <ssantosh@kernel.org>
List-Id: linux-omap@vger.kernel.org

On 08/31/2015 05:11 PM, Tony Lindgren wrote:
> * Grygorii Strashko <grygorii.strashko@ti.com> [150831 02:07]:
>> Hi Tony,
>>
>> On 08/28/2015 09:44 PM, Tony Lindgren wrote:
>>> Currently we gpio-omap breaks if gpiochip_add() returns -EPROBE_DEFER:
>>>
>>> [    0.570000] gpiochip_add: GPIOs 0..31 (gpio) failed to register
>>> [    0.570000] omap_gpio 48310000.gpio: Could not register gpio chip -517
>>> ...
>>> [    3.670000] omap_gpio 48310000.gpio: Unbalanced pm_runtime_enable!
>>
>> I have no objection to the patch itself.
>>
>> But I curious, How have you got this error output? Was it simulated?
> 
> I ran into it when trying to get rid of all the custom initcalls
> for various drivers. And especially if adding dts mappings for
> gpio-ranges to try to find some solution for the 1.158 issue that
> keeps me from having a mainline GPIO PM regresion test with
> pinging wl12xx during off idle :)
> 

Ah. So, -EPROBE_DEFER was returned by of_gpiochip_add_pin_range(),
I was not able to find a place where gpiochip_add() can return -EPROBE_DEFER ;)

Thanks for clarification.


-- 
regards,
-grygorii
