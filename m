From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] pinctrl: single: remove misuse of IRQF_NO_SUSPEND
 flag
Date: Thu, 3 Dec 2015 10:13:38 -0800
Message-ID: <20151203181337.GV23396@atomide.com>
References: <1448644860-29323-1-git-send-email-sudeep.holla@arm.com>
 <1448644860-29323-2-git-send-email-sudeep.holla@arm.com>
 <CACRpkdYy1fPAm5r0GxXxzgZA7RsqJ6ZtPtNzd1bzrfkME_j09g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYy1fPAm5r0GxXxzgZA7RsqJ6ZtPtNzd1bzrfkME_j09g@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [151201 06:07]:
> On Fri, Nov 27, 2015 at 6:21 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
> > From: Sudeep Holla <Sudeep.Holla@arm.com>
> >
> > The IRQF_NO_SUSPEND flag is used to identify the interrupts that should
> > be left enabled so as to allow them to work as expected during the
> > suspend-resume cycle, but doesn't guarantee that it will wake the system
> > from a suspended state, enable_irq_wake is recommended to be used for
> > the wakeup.
> >
> > This patch removes the use of IRQF_NO_SUSPEND flags replacing it with
> > irq_set_irq_wake instead.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: linux-gpio@vger.kernel.org
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> I need Tony's ACK on this as well.

At least on omaps, this controller is always powered and we never want to
suspend it as it handles wake-up events for all the IO pins. And that
usecase sounds exactly like what you're describing above.

I don't quite follow what your suggested alternative for an interrupt
controller is?

At least we need to have the alternative patched in with this chage before
just removing IRQF_NO_SUSPEND.

The enable_irq_wake is naturally used for the consumer drivers of this
interrupt controller and actually mostly done automatically now with the
dev_pm_set_dedicated_wake_irq.

Regards,

Tony
