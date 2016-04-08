From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] rtc: omap: Support ext_wakeup configuration
Date: Fri, 8 Apr 2016 08:14:09 -0700
Message-ID: <20160408151408.GS16484@atomide.com>
References: <1459785403-1725-1-git-send-email-m.niestroj@grinn-global.com>
 <20160404224046.GA17042@atomide.com>
 <57078A89.3080809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57078A89.3080809-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, "Menon, Nishanth" <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [160408 03:41]:
> Hi Tony,
> 
> On 04/05/2016 01:40 AM, Tony Lindgren wrote:
> > Hi,
> > 
> > * Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org> [160404 08:57]:
> >> Support configuration of ext_wakeup sources. This patch makes it
> >> possible to enable ext_wakeup and set it's polarity, depending on board
> >> configuration. AM335x's dedicated PMIC (tps65217) uses ext_wakeup to
> >> notify about power-button presses. Handling power-button presses enables
> >> to recover from RTC-only power states correctly.
> > 
> > I suggest you just set this pin up as a minimal gpiochip. That way
> > we can use the standard binding :) And if we get lucky, this pin can
> > also trigger during runtime.
> > 
> 
> Following my comments on v2 of this patch I propose to rollback to
> this version of the patch.
> 
> It seems doesn't fit in gpiochip, it's more likely irqchip, but since
> rtc can't generate IRQ there are nor reasons for these genetic
> experiments and RTC's specific bindings looks more suitable, at least for me.

Hmm well gpiochips typically are irqchip too. IMO the generic binding
here sounds like "gpio-wakeup" as it's an input with polarity and with
an optional interrupt.

Plain irqchip would work too in this case if there are no other GPIO
specific features. Some other RTCs may have more GPIO like features.

In any case, setting the ext_wakeup up as an irqchip means that the
RTC controller can be used as a dedicated wakeirq with Linux :)

Are you guys sure there's no wake pin events during runtime? AFAIK
the RTCs just typically produce an interrupt when programmed to
do so, they don't know the state of the SoC.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
