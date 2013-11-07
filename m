From: Kevin Hilman <khilman@linaro.org>
Subject: Re: [PATCH v2] serial: omap: Add support for optional wake-up
Date: Thu, 07 Nov 2013 10:52:36 -0800
Message-ID: <87siv8rqmj.fsf@linaro.org>
References: <20131022134947.GK15154@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f47.google.com ([209.85.160.47]:53346 "EHLO
	mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311Ab3KGSwk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Nov 2013 13:52:40 -0500
Received: by mail-pb0-f47.google.com with SMTP id rq13so997226pbb.6
        for <linux-omap@vger.kernel.org>; Thu, 07 Nov 2013 10:52:39 -0800 (PST)
In-Reply-To: <20131022134947.GK15154@atomide.com> (Tony Lindgren's message of
	"Tue, 22 Oct 2013 06:49:48 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Roger Quadros <rogerq@ti.com>

Tony Lindgren <tony@atomide.com> writes:

> With the recent pinctrl-single changes, omaps can treat
> wake-up events from deeper idle states as interrupts.
>
> There's a separate "io chain" controller on most omaps
> that stays enabled when the device hits off-idle and the
> regular interrupt controller is powered off.
>
> Let's add support for the optional second interrupt for
> wake-up events. And then serial-omap can manage the
> wake-up interrupt from it's runtime PM calls to avoid
> spurious interrupts during runtime.
>
> Note that the wake interrupt is board specific as it
> uses the UART RX pin, and for omap3, there are six pin
> options for UART3 RX pin.
>
> Also Note that the legacy platform based booting handles
> the wake-ups in the legacy mux driver and does not need to
> pass the wake-up interrupt to the driver.
>
> And finally, to pass the wake-up interrupt in the dts file,
> either interrupt-map or the pending interrupts-extended
> property needs to be passed. It's probably best to use
> interrupts-extended when it's available.
>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Felipe Balbi <balbi@ti.com>
> Reviewed-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> ---
>
> Updated to simplify based on the review comments.
>
> Greg, care to queue this for v3.13 if not too late?
>
> This removes a dependency for omaps for having runtime
> PM working with serial port using device tree, so we
> can start moving to device tree only booting for omap3
> for v3.14.

A bunch of DT boot failures on OMAP3 platforms with latest mainline were
bisected down to this patch.  Boot results here:
http://lists.linaro.org/pipermail/kernel-build-reports/2013-November/000954.html

This doesn't seem to properly handle the OMAP3 case where we have DT
nodes, but no reg or interrupts properties since they're still using
hwmod.

The problems seems to be because these OMAP3 platforms don't list any
interrupts in their DTS files for the UARTs, but a quick hack at adding
interrupts to omap3.dtsi didn't help either so something else is going
on.

This patch should probably be reverted until it gets broader testing.

Kevin
