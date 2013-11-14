From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] pinctrl: single: call pcs_soc->rearm() whenever IRQ
 mask is changed
Date: Thu, 14 Nov 2013 10:24:48 -0800
Message-ID: <20131114182447.GJ10317@atomide.com>
References: <1381507996-15021-1-git-send-email-rogerq@ti.com>
 <CACRpkdb7iUypffB7O7-RhQhVf5WkjYdVCNLRz=BgySG4FET-xQ@mail.gmail.com>
 <20131011172337.GU29913@atomide.com>
 <CACRpkdbo_TwX79hnJ5mCo8D4TSDd6OUzaOsFa8MgzjLy-H2U4Q@mail.gmail.com>
 <20131112195611.GT15154@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:37403 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753570Ab3KNSYw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Nov 2013 13:24:52 -0500
Content-Disposition: inline
In-Reply-To: <20131112195611.GT15154@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Benoit Cousson <bcousson@baylibre.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>

* Tony Lindgren <tony@atomide.com> [131112 11:57]:
> * Linus Walleij <linus.walleij@linaro.org> [131112 10:45]:
> > On Fri, Oct 11, 2013 at 7:23 PM, Tony Lindgren <tony@atomide.com> wrote:
> > > * Linus Walleij <linus.walleij@linaro.org> [131011 09:27]:
> > >> On Fri, Oct 11, 2013 at 6:13 PM, Roger Quadros <rogerq@ti.com> wrote:
> > >>
> > >> > On OMAPs the IO ring must be rearmed each time the pad wakeup
> > >> > configuration is changed. So call pcs_soc->rearm() from
> > >> > pcs_irq_set().
> > >> >
> > >> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> > >>
> > >> If Tony needs to apply this with the other patches: Acked-by.
> > >
> > > Just replied with a slightly modified version of Roger's patch
> > > suggesting you pull in the signed tag I posted for you yesterday
> > > and then you can pick up Roger's fix into the pinctrl tree :)
> > 
> > Hm now that I go over these old mails in my inbox I start to
> > worry that I missed something here, I have no memory of pulling
> > a tag for OMAP... is this all in the state
> > it needs to be for OMAP?
> 
> The other pinctrl-single related patches are now merged to mainline:
> 
> 1b9c0fb365cbb1154f4e7997061db972cbf58300 pinctrl: single: Fix build when not built on ARM
> dc7743aa3c49fabbc6dc9edbcf7df74d776ac32e pinctrl: single: Add support for auxdata
> 3e6cee1786a13cb2308609b5f8c020e1754e37cf pinctrl: single: Add support for wake-up interrupts
> 02e483f66deb6bd8df6af450726574614eb53be3 pinctrl: single: Prepare for supporting SoC specific features
> 
> The fix from Roger is still missing. You can go ahead and queue
> it, or if you prefer me to do it I can add it to my fixes.

Actually Linus, I'll queue this with your ack as the interrupts-extended
property is now merged in and I can also enable some minimal wake-up
events for omap3.

Regards,

Tony
