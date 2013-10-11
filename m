From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] pinctrl: single: call pcs_soc->rearm() whenever IRQ
 mask is changed
Date: Fri, 11 Oct 2013 10:23:38 -0700
Message-ID: <20131011172337.GU29913@atomide.com>
References: <1381507996-15021-1-git-send-email-rogerq@ti.com>
 <CACRpkdb7iUypffB7O7-RhQhVf5WkjYdVCNLRz=BgySG4FET-xQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20237 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752163Ab3JKRXk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 13:23:40 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdb7iUypffB7O7-RhQhVf5WkjYdVCNLRz=BgySG4FET-xQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Benoit Cousson <bcousson@baylibre.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>

* Linus Walleij <linus.walleij@linaro.org> [131011 09:27]:
> On Fri, Oct 11, 2013 at 6:13 PM, Roger Quadros <rogerq@ti.com> wrote:
> 
> > On OMAPs the IO ring must be rearmed each time the pad wakeup
> > configuration is changed. So call pcs_soc->rearm() from
> > pcs_irq_set().
> >
> > Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> If Tony needs to apply this with the other patches: Acked-by.

Just replied with a slightly modified version of Roger's patch
suggesting you pull in the signed tag I posted for you yesterday
and then you can pick up Roger's fix into the pinctrl tree :)

Tony
