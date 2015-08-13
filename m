From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [4.2-rc1][PATCH] gpio: omap: add missed spin_unlock_irqrestore in omap_gpio_irq_type
Date: Thu, 13 Aug 2015 14:44:13 +0200
Message-ID: <CACRpkda==nTLV+iYfYoVfmb1dfV1uLW_EvV3kgtJe9k0ZNzZ4g@mail.gmail.com>
References: <1435157657-17843-1-git-send-email-grygorii.strashko@ti.com>
	<CACRpkdZeBYrff4ZwVyzSKk9Gcy_57WK-3FcfwbzbD8DY06Adng@mail.gmail.com>
	<20150807033642.GI4215@atomide.com>
	<55C45F94.50000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55C45F94.50000@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Alexandre Courbot <gnurou@gmail.com>, Sekhar Nori <nsekhar@ti.com>, Javier Martinez Canillas <javier@dowhile0.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Grygorii Strashko <grygorii.strashko@linaro.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 7, 2015 at 9:34 AM, Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
> Hi Tony,
> On 08/07/2015 06:36 AM, Tony Lindgren wrote:
>>
>> * Linus Walleij <linus.walleij@linaro.org> [150716 01:38]:
>>>
>>> On Wed, Jun 24, 2015 at 4:54 PM, Grygorii Strashko
>>> <grygorii.strashko@ti.com> wrote:
>>>
>>>> From: Grygorii Strashko <grygorii.strashko@linaro.org>
>>>>
>>>> Add missed spin_unlock_irqrestore in omap_gpio_irq_type when
>>>> omap_set_gpio_triggering() is failed.
>>>>
>>>> It fixes static checker warning:
>>>>
>>>>          drivers/gpio/gpio-omap.c:523 omap_gpio_irq_type()
>>>>          warn: inconsistent returns 'spin_lock:&bank->lock'.
>>>>
>>>> This fixes commit:
>>>> 1562e4618ded ('gpio: omap: fix error handling in omap_gpio_irq_type')
>>>>
>>>> Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
>>>> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
>>>
>>>
>>> Patch applied for fixes.
>>
>>
>> Linus, looks like we now have a new build warning in Linux next
>> with the fixes and raw_spinlock_t change, so a merge or a commit
>> is needed. If you prefer a patch, here's one below.
>
>
> Yes. It seems merge/rebase issue between fixes & next:
> - this patch went through fixes and RAW spinlock conversation
> patch through -next, and without merge conflicts.
>
> and patch has been posted already by Axel Lin:
> http://www.spinics.net/lists/linux-omap/msg121031.html

I merged v4.2-rc4 into my devel branch and applied Axel's
patch to fix this mess. Check that it looks OK now...

Yours,
Linus Walleij
