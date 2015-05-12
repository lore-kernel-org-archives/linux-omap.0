From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] gpio: omap: Fix PM runtime issue and remove most
 BANK_USED macros
Date: Tue, 12 May 2015 07:13:49 -0700
Message-ID: <20150512141348.GG15563@atomide.com>
References: <1429632533-23285-1-git-send-email-tony@atomide.com>
 <CACRpkdZ1nJ=-NPHrZdCQ6_TCrF7009R9Y7zVyXN1z9RWcv3a6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZ1nJ=-NPHrZdCQ6_TCrF7009R9Y7zVyXN1z9RWcv3a6A@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>, Grygorii Strashko <grygorii.strashko@linaro.org>, Javier Martinez Canillas <jmartinez@softcrates.net>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

* Linus Walleij <linus.walleij@linaro.org> [150512 02:01]:
> On Tue, Apr 21, 2015 at 6:08 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > Looks like omap_gpio_irq_type can return early at several places
> > leaving a GPIO bank enabled without doing pm_runtime_put if wrong
> > GPIO arguments are passed.
> >
> > Instead of adding more complicated BANK_USED macros, let's fix the
> > issue properly. We can pass is_irq flag to omap_enable_gpio_module
> > and omap_disble_gpio_module. And with that we can remove all the
> > similar code elsewhere to get rid of most BANK_USED macros.
> >
> > Note that the reason for the BANK_USED macro is that we need to manage
> > PM runtime on per GPIO bank basis. In the long run we want to move to
> > using PM runtime counts for each GPIO line to determine if a GPIO
> > bank is used. Once we have a solution for omap_enable_gpio_module
> > and omap_disable_gpio_module, we can remove the remaining BANK_USED
> > macros.
> >
> > Cc: Felipe Balbi <balbi@ti.com>
> > Cc: Grygorii Strashko <grygorii.strashko@linaro.org>
> > Cc: Javier Martinez Canillas <jmartinez@softcrates.net>
> > Cc: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> There is so much discussion around this patch that I can't make
> up my mind whether I should apply this or some subsequent inline
> version of it.
> 
> Holding this off for now...

Yeah let's see what Grygorii comes up, sounds like he may have
a minimal fix coming up. Then we can do the rest as clean-up
later on.

Regards,

Tony
