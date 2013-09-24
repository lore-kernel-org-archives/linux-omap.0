From: Sricharan R <r.sricharan@ti.com>
Subject: Re: [RFC] gpio/omap: auto-setup a GPIO when used as an IRQ
Date: Tue, 24 Sep 2013 14:17:43 +0530
Message-ID: <524151AF.2040408@ti.com>
References: <1379860848-29020-1-git-send-email-javier.martinez@collabora.co.uk> <20130923164519.GF2684@atomide.com> <524073BC.9080907@collabora.co.uk> <20130923170724.GG2684@atomide.com> <524141A6.2090701@ti.com> <5241454E.2050602@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <5241454E.2050602@collabora.co.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Lars Poeschel <larsi@wh2.tu-dresden.de>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ian.campbell@citrix.com>, Kumar Gala <galak@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, Tomasz Figa <tomasz.figa@gmail.com>, Enric Balletbo i Serra <eballetbo@gmail.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Balaji T K <balajitk@ti.com>, Jon Hunter <jgchunter@gmail.com>, linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tuesday 24 September 2013 01:24 PM, Javier Martinez Canillas wrote:
> On 09/24/2013 09:39 AM, Sricharan R wrote:
>> Hi,
>> On Monday 23 September 2013 10:37 PM, Tony Lindgren wrote:
>>> * Javier Martinez Canillas <javier.martinez@collabora.co.uk> [130923 10:09]:
>>>> On 09/23/2013 06:45 PM, Tony Lindgren wrote:
>>>>> Hmm does this still work for legacy platform data based
>>>>> drivers that are doing gpio_request() first?
>>>>>
>>>> Yes it still work when booting using board files. I tested on my OMAP3 board and
>>>> it worked in both DT and legacy booting mode.
>>> OK great.
>>>  
>>>>> And what's the path for clearing things for PM when free_irq()
>>>>> gets called? It seems that this would leave the GPIO bank
>>>>> enabled causing a PM regression?
>>>>>
>>>> Indeed, I did set bank->mod_usage |= 1 << offset so the bank is enabled if the
>>>> device goes to suspended and then resumed but I completely forget about the
>>>> clearing path when the IRQ is freed.
>>>>
>>>> Which makes me think that we should probably maintain two usage variables, one
>>>> for GPIO and another one for IRQ and check both of them on the suspend/resume pm
>>>> functions.
>>> Yes that it seems that they should be treated separately.
>>  To understand, why cant the flag be cleared in gpio_irq_shutdown ?
> Hi Sricharan,
>
> Without this patch today drivers do this:
>
> gpio_request(gpio, "foo IRQ"); // bank->mod_usage |= 1 << offset
> gpio_direction_input(gpio);
>
> and then request a IRQ with:
>
> irq = gpio_to_irq(gpio);
> request_irq(irq, ...);
>
> later on its cleanup path:
>
> free_irq(irq, dev);
> gpio_free(gpio) // bank->mod_usage &= ~(1 << offset);
>
> So if you clear the flag on gpio_irq_shutdown then bank module won't be enabled
> after a suspend making drivers using the GPIO after freeing the IRQ to fail.
>
> So the idea is to have something like this:
>
> a) Drivers that request both the GPIO and IRQ
>
> gpio_request(gpio, "foo IRQ"); // bank->mod_usage |= 1 << offset
> gpio_direction_input(gpio);
>
> irq = gpio_to_irq(gpio);
> request_irq(irq, ...); // bank->irq_usage |= 1 << offset
>
> free_irq(irq, dev); // bank->irq_usage &= ~(1 << offset);
> gpio_free(gpio) // bank->mod_usage &= ~(1 << offset);
>
> b) Drivers that just request the IRQ:
>
> irq = gpio_to_irq(gpio);
> request_irq(irq, ...); // bank->irq_usage |= 1 << offset
> free_irq(irq, dev); // bank->irq_usage &= ~(1 << offset);
>
> So irq_usage or mod_usage is set means that the bank has to be enabled and if
> both are not set means that the bank module can be disabled.
>
 Ok get it. Thanks.

Regards,
 Sricharan
