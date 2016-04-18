From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] gpio: omap: fix irq triggering in smart-idle wakeup mode
Date: Mon, 18 Apr 2016 16:36:03 -0700
Message-ID: <20160418233602.GW5995@atomide.com>
References: <1460458351-24187-1-git-send-email-grygorii.strashko@ti.com>
 <CACRpkdbGcO7i5B9e3dicAEaTTfG7u_owe3hS2u6Sd6tCNXNzBg@mail.gmail.com>
 <5710B3B9.4090807@ti.com>
 <571106F3.9070805@oracle.com>
 <20160415185429.GU5995@atomide.com>
 <571503F7.4040304@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <571503F7.4040304@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: santosh shilimkar <santosh.shilimkar@oracle.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Santosh Shilimkar <ssantosh@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko@ti.com> [160418 08:59]:
> On 04/15/2016 09:54 PM, Tony Lindgren wrote:
> > * santosh shilimkar <santosh.shilimkar@oracle.com> [160415 08:22]:
> >> On 4/15/2016 2:26 AM, Grygorii Strashko wrote:
> >>>
> >>> Santosh, Tony, do you want me to perform any additional actions regarding this patch?
> >>>
> >> This patch should be run across family of SOCs to make
> >> sure wakeup works on all of those if not done already
> > 
> > Also, I'm not sure if we can just drop this code in question.
> > 
> > After this patch, what function updates the GPIO wkup_en registers
> > depending on enable_irq_wake()/disable_irq_wake()?
> > 
> 
> The main purpose of this patch is to *not* modify GPIO wkup_en registers
> depending of enable_irq_wake()/disable_irq_wake() :), instead all
> non wake up IRQs should be masked during suspend.

OK that makes sense.

> The GPIO wkup_en registers should be always in sync with GPIO irq_en when
> GPIO IP is in smart-idle wakeup mode. And this is done now from 
> omap_gpio_unmask_irq/omap_gpio_mask_irq(). See also [1].
> 
> In general, it is more or less similar to GIC + wakeupgen:
> - during normal work (including cpuidle) GIC irq_en and Wakeupgen wkup_en
> should be in sync always
> - during suspend - only IRQs, marked as wake up sources, should be left
> unmasked.
> 
> Also, I've found old thread [2] where Santosh proposed to use IRQCHIP_MASK_ON_SUSPEND.
> And it was not possible, at that time, but now IRQCHIP_MASK_ON_SUSPEND can be used :),
> because OMAP GPIO driver was switched to use generic irq handler instead of chained, so
> now OMAP GPIO irqs are properly handled by IRQ PM core.  
> [chained irqs (and chained irq handles) are not disabled during suspend/resume and they are
>  not maintained by IRQ PM core as result they can trigger way too early on resume when
>  OMAP GPIO is not ready/powered.]

OK. For my tests this patch does not change anything. I noticed however
that we still have some additional bug somewhere where GPIO wake up
events work fine for omap3 PM runtime, but are flakey for suspend.

> I've tested it on: am57x-evm, am437x-idk-evm, omap4-panda

OK thanks! Based on my tests and the above:

Acked-by: Tony Lindgren <tony@atomide.com>

Regards,

Tony

> [1] https://lkml.org/lkml/2016/4/12/676
> [2] https://lkml.org/lkml/2012/8/26/1
>     https://groups.google.com/forum/#!msg/linux.kernel/iXJ5Y568B3Q/hZ39bSlcs0kJ
