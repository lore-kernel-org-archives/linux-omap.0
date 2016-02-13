From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/3] OMAP/pinmux: remove misuse of IRQF_NO_SUSPEND flag
Date: Sat, 13 Feb 2016 15:42:20 +0100
Message-ID: <CACRpkdYzJ9Hy0sH6gK6RzpLE6juS4WfPjbt7nh43vR9YTuGZWA@mail.gmail.com>
References: <1454351299-27440-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1454351299-27440-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Feb 1, 2016 at 7:28 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:

>   pinctrl: single: Use a separate lockdep class
>   pinctrl: single: remove misuse of IRQF_NO_SUSPEND flag
>   ARM: OMAP2+: remove misuse of IRQF_NO_SUSPEND flag
>
>  arch/arm/mach-omap2/mux.c        |  4 ++--
>  arch/arm/mach-omap2/pm34xx.c     |  9 ++++-----
>  arch/arm/mach-omap2/prm_common.c |  1 +
>  drivers/pinctrl/pinctrl-single.c | 15 ++++++++++++---

Are these patches orthogonal so I can merge the pinctrl patch independently
of the OMAP patches if Tony ACKs this?

If not: should it be merged by me or through ARM SoC/Tony?

Anyways waiting for maintainer feedback, but the above is good to know.

Yours,
Linus Walleij
