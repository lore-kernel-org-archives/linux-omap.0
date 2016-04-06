From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] rtc: omap: Support ext_wakeup configuration
Date: Wed, 6 Apr 2016 15:36:13 -0700
Message-ID: <20160406223612.GH16484@atomide.com>
References: <1459960367-29399-1-git-send-email-m.niestroj@grinn-global.com>
 <1459960367-29399-2-git-send-email-m.niestroj@grinn-global.com>
 <20160406191103.GE27411@atomide.com>
 <57056352.1060801@grinn-global.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <57056352.1060801-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org>
Cc: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org> [160406 12:29]:
> Hi,
> 
> On 06.04.2016 21:11, Tony Lindgren wrote:
> >* Marcin Niestroj <m.niestroj-z3quKL4iOrmQ6ZAhV5LmOA@public.gmane.org> [160406 09:34]:
> >>Support configuration of ext_wakeup sources. This patch makes it
> >>possible to enable ext_wakeup (and set it's polarity), depending on
> >>board configuration. AM335x's dedicated PMIC (tps65217) uses ext_wakeup
> >>in SLEEP mode (RTC-only) to notify about power-button presses. Handling
> >>power-button presses enables to recover from RTC-only power states
> >>correctly.
> >>
> >>Implementation uses gpiochip to utilize standard bindings. However,
> >>configuration is possible only using device-tree (no runtime changes).
> >
> >Hey looks good to me, adding linux-omap list to Cc.
> >
> >Can you please check that the "depends on GPIOLIB" does not disable
> >the RTC driver for omap1?
> 
> Looks ok for omap1. ARCH_OMAP1 selects ARCH_REQUIRE_GPIOLIB, which
> selects GPIOLIB.

OK thanks for checking.

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
