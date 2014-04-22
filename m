From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 11/11] pinctrl: single: Clear pin interrupts enabled by
 bootloader
Date: Tue, 22 Apr 2014 09:10:33 -0700
Message-ID: <20140422161033.GC19317@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
 <1397173639-29587-12-git-send-email-tony@atomide.com>
 <CACRpkdYu2Obo8kuA2D9a33K_KCF-LPza=+reEpFnq8JFK6jOCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:31760 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756814AbaDVQKj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Apr 2014 12:10:39 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdYu2Obo8kuA2D9a33K_KCF-LPza=+reEpFnq8JFK6jOCg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux-OMAP <linux-omap@vger.kernel.org>, Haojian Zhuang <haojian.zhuang@linaro.org>

* Linus Walleij <linus.walleij@linaro.org> [140422 04:55]:
> On Fri, Apr 11, 2014 at 1:47 AM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > Since we set up device wake-up interrupts as pinctrl-single
> > interrupts, we now must use the standard request_irq and
> > related functions to manage them.
> >
> > If the pin interrupts are enabled for some pins at boot,
> > the wake-up events can show up as constantly pending
> > at least on omaps and will hang the system unless the related
> > device driver clears the event at the device.
> >
> > To fix this, let's clear the interrupt flags during init,
> > and print out a warning so the board maintainers can update
> > their drivers to do proper request_irq for the driver specific
> > wake-up events.
> >
> > Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> Looks clean.
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Shall I apply this patch or will you funnel it through ARM SoC
> due to deps?

No deps except boards hanging without it.. Please feel free to
take this one, prererrably as a fix for the -rc series if no
objections.

Regards,

Tony
