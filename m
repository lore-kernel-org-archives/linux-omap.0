From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH v2 00/21] irqchip: gic: killing gic_arch_extn and co, slowly
Date: Mon, 12 Jan 2015 08:14:46 -0600
Message-ID: <CAL_JsqLLGn1mZr7eNuLA1=M7BcwFRdOQ6xQGo+bbc2aScAVrnQ@mail.gmail.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:56511 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbbALOPJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2015 09:15:09 -0500
In-Reply-To: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Kukjin Kim <kgene.kim@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Michal Simek <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jason Cooper <jason@lakedaemon.net>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-omap <linux-omap@vger.kernel.org>

On Wed, Jan 7, 2015 at 11:42 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> The gic_arch_extn hack that a number of platform use has been nagging
> me for too long. It is only there for the benefit of a few platform,
> and yet it impacts all GIC users. Moreover, it gives people the wrong
> idea ("let's use it to put some new custom hack in there"...).
>
> But now that stacked irq domains have landed in -next, the time has
> come for gic_arch_extn to meet the Big Bit Bucket.

[...]

> - This actively *breaks* existing setups. Once you boot a new kernel
>   with an old DT, suspend/resume *will* be broken. Old kernels on a
>   new DT won't even boot! You've been warned. This really outline the
>   necessity of actually describing the HW in device trees...

Just to be clear, you need some agreement from the maintainers of
those platforms before doing this. It doesn't appear there is
disagreement, but I don't see any explicit agreement either.

This seems to model the interrupts as chained, but at least for some
cases aren't these auxiliary controllers in parallel to the GIC? In
other words, do the they require configuration for interrupts to work
for the normal non-wakeup use? I'm not sure that the h/w is being
modeled any more accurately if that is the case. However, we don't
really have a way to describe an interrupt line is connected to 2
interrupt parents in DT, so I'm not sure what else you could do here.

Rob
