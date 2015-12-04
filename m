From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] pinctrl: single: remove misuse of IRQF_NO_SUSPEND
 flag
Date: Fri, 4 Dec 2015 07:40:31 -0800
Message-ID: <20151204154031.GG23396@atomide.com>
References: <1448644860-29323-1-git-send-email-sudeep.holla@arm.com>
 <1448644860-29323-2-git-send-email-sudeep.holla@arm.com>
 <CACRpkdYy1fPAm5r0GxXxzgZA7RsqJ6ZtPtNzd1bzrfkME_j09g@mail.gmail.com>
 <20151203181337.GV23396@atomide.com>
 <566090FC.1020502@arm.com>
 <20151203214013.GB23396@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151203214013.GB23396@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [151203 13:41]:
> * Sudeep Holla <sudeep.holla@arm.com> [151203 11:00]:
> > 
> > I have added irq_set_irq_wake(pcs_soc->irq, state) in pcs_irq_set_wake
> > which ensures it's marked for wakeup.
> 
> Hmm well see the error I pasted in this thread, maybe that provides
> more clues.

The irq_set_irq_wake(pcs_soc->irq, state) in pcs_irq_set_wake does not
look right to me as pcs_irq_set_wake toggles the irq_wake for each pin
separately, not for the whole controller.

I think all that can be left out with the snipped from Grygorii, and maybe
also the lock_class_key changes.

Regards,

Tony
