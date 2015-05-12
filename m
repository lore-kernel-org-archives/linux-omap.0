From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH 1/1] gpio: omap: Fix PM runtime issue and remove most
 BANK_USED macros
Date: Tue, 12 May 2015 18:31:49 +0300
Message-ID: <55521CE5.8070903@linaro.org>
References: <1429632533-23285-1-git-send-email-tony@atomide.com> <CACRpkdZ1nJ=-NPHrZdCQ6_TCrF7009R9Y7zVyXN1z9RWcv3a6A@mail.gmail.com> <20150512141348.GG15563@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:34426 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078AbbELPbx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2015 11:31:53 -0400
Received: by wgic8 with SMTP id c8so14252485wgi.1
        for <linux-omap@vger.kernel.org>; Tue, 12 May 2015 08:31:52 -0700 (PDT)
In-Reply-To: <20150512141348.GG15563@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>, Javier Martinez Canillas <jmartinez@softcrates.net>, Nishanth Menon <nm@ti.com>

Hi Tony, Linus,

On 05/12/2015 05:13 PM, Tony Lindgren wrote:
> * Linus Walleij <linus.walleij@linaro.org> [150512 02:01]:
>> On Tue, Apr 21, 2015 at 6:08 PM, Tony Lindgren <tony@atomide.com> wrote:
>>
>>> Looks like omap_gpio_irq_type can return early at several places
>>> leaving a GPIO bank enabled without doing pm_runtime_put if wrong
>>> GPIO arguments are passed.
>>>
>>> Instead of adding more complicated BANK_USED macros, let's fix the
>>> issue properly. We can pass is_irq flag to omap_enable_gpio_module
>>> and omap_disble_gpio_module. And with that we can remove all the
>>> similar code elsewhere to get rid of most BANK_USED macros.
>>>
>>> Note that the reason for the BANK_USED macro is that we need to manage
>>> PM runtime on per GPIO bank basis. In the long run we want to move to
>>> using PM runtime counts for each GPIO line to determine if a GPIO
>>> bank is used. Once we have a solution for omap_enable_gpio_module
>>> and omap_disable_gpio_module, we can remove the remaining BANK_USED
>>> macros.
>>>
>>> Cc: Felipe Balbi <balbi@ti.com>
>>> Cc: Grygorii Strashko <grygorii.strashko@linaro.org>
>>> Cc: Javier Martinez Canillas <jmartinez@softcrates.net>
>>> Cc: Nishanth Menon <nm@ti.com>
>>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>>
>> There is so much discussion around this patch that I can't make
>> up my mind whether I should apply this or some subsequent inline
>> version of it.
>>
>> Holding this off for now...
> 
> Yeah let's see what Grygorii comes up, sounds like he may have
> a minimal fix coming up. Then we can do the rest as clean-up
> later on.

Thanks for your patience and sorry for delay - was ooo last week.

I'll try to come up with some patches as soon as possible, and,
yes, In my personal opinion, it could be better if OMAP GPIO driver
will be reworked/cleaned up/fixed in a different way.

-- 
regards,
-grygorii
