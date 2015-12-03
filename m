From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] pinctrl: single: remove misuse of IRQF_NO_SUSPEND
 flag
Date: Thu, 3 Dec 2015 13:40:14 -0800
Message-ID: <20151203214013.GB23396@atomide.com>
References: <1448644860-29323-1-git-send-email-sudeep.holla@arm.com>
 <1448644860-29323-2-git-send-email-sudeep.holla@arm.com>
 <CACRpkdYy1fPAm5r0GxXxzgZA7RsqJ6ZtPtNzd1bzrfkME_j09g@mail.gmail.com>
 <20151203181337.GV23396@atomide.com>
 <566090FC.1020502@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <566090FC.1020502@arm.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Sudeep Holla <sudeep.holla@arm.com> [151203 11:00]:
> On 03/12/15 18:13, Tony Lindgren wrote:
> >At least on omaps, this controller is always powered and we never want to
> >suspend it as it handles wake-up events for all the IO pins. And that
> >usecase sounds exactly like what you're describing above.
> >
> 
> Understood, but I assume this is a generic driver that can be used by
> any pinmux.

Right no question about that, but we need to keep things working. I just
pasted the output to this thread what happens coming back up from suspend.

> >I don't quite follow what your suggested alternative for an interrupt
> >controller is?
> 
> Why can't we use enable_irq_wake even for parent/interrupt controller as
> they can be considered as parent wakeup irq. I agree the interrupt
> controller may not be powered down, but still it's part of wakeup and
> the irq core needs to identify that. By just marking IRQF_NO_SUSPEND,
> you are saying that you can handle interrupt in the suspend path but not
> informing that it's a wakeup interrupt.
> 
> With this change, the wakeup handler (including the parent handler) is
> called when it's safe as the irq core maintains the state machine.

Maybe paste a suggested patch and I can try it. I guess you mean call
that from pinctrl-single.c.

> >At least we need to have the alternative patched in with this chage before
> >just removing IRQF_NO_SUSPEND.
> >
> 
> I have added irq_set_irq_wake(pcs_soc->irq, state) in pcs_irq_set_wake
> which ensures it's marked for wakeup.

Hmm well see the error I pasted in this thread, maybe that provides
more clues.

Regards,

Tony
