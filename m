From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/4] pinctrl: single: Prepare for supporting SoC
 specific features
Date: Mon, 29 Jul 2013 01:57:34 -0700
Message-ID: <20130729085731.GW7656@atomide.com>
References: <20130607203936.16513.57494.stgit@localhost>
 <20130607205037.16513.84242.stgit@localhost>
 <CAN1soZzLYpiakcgPR7mBOC7_mLFW=mZwOG98Dq6JpO+JHUW=cw@mail.gmail.com>
 <20130608152732.GR3331@atomide.com>
 <CACRpkdapXZO003xhRCVg5sfQCfJUPMzunui5u6npmht-2hP7Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:30089 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab3G2I5i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Jul 2013 04:57:38 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdapXZO003xhRCVg5sfQCfJUPMzunui5u6npmht-2hP7Tg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Roger Quadros <rogerq@ti.com>

* Linus Walleij <linus.walleij@linaro.org> [130722 14:22]:
> On Sat, Jun 8, 2013 at 5:27 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > Subject: [PATCH] pinctrl: single: Prepare for supporting SoC specific features
> >
> > Let's replace is_pinconf with flags and add struct pcs_soc so we
> > can support also other features like pin wake-up events. Let's
> > export the probe so the SoC specific modules can pass their
> > SoC specific data to pinctrl-single if needed.
> 
> I don't quite understand this motivation. Can this be more verbose and
> include a bit about the mechanics?
> 
> - Why is this necessary? For example, pinctrl-single already supports
>  generic pinconf, and we can surely add a PIN_CONFIG_WAKEUP
>  to include/linux/pinctrl/pinconf-generic.h.

OK I'll take a look. I like the irqchip idea, let's see what all is
missing after that.
 
> - Also: how does this cooperate with irq_set_wake()? If a pin is
>  set to GPIO it is often backed by a GPIO driver (which is calling
>  pinctrl_request_gpio() etc), maybe we should just add a
>  pinctrl_set_wake() then that the irqchip portions of the GPIO drivers
>  can call down to so the pinctrl driver sets this bit if need be?

Yes currently we're missing the mapping between GPIO registers and
pinctrl registers. But your idea of using irqchip + pinctrl_set_wake()
might sort that issue.

Regards,

Tony
