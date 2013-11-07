From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] serial: omap: Add support for optional wake-up
Date: Thu, 7 Nov 2013 11:45:53 -0800
Message-ID: <20131107194553.GL15154@atomide.com>
References: <20131022134947.GK15154@atomide.com>
 <87siv8rqmj.fsf@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:51184 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751405Ab3KGTp6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Nov 2013 14:45:58 -0500
Content-Disposition: inline
In-Reply-To: <87siv8rqmj.fsf@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, Roger Quadros <rogerq@ti.com>

* Kevin Hilman <khilman@linaro.org> [131107 10:53]:
> 
> A bunch of DT boot failures on OMAP3 platforms with latest mainline were
> bisected down to this patch.  Boot results here:
> http://lists.linaro.org/pipermail/kernel-build-reports/2013-November/000954.html
> 
> This doesn't seem to properly handle the OMAP3 case where we have DT
> nodes, but no reg or interrupts properties since they're still using
> hwmod.
> 
> The problems seems to be because these OMAP3 platforms don't list any
> interrupts in their DTS files for the UARTs, but a quick hack at adding
> interrupts to omap3.dtsi didn't help either so something else is going
> on.
> 
> This patch should probably be reverted until it gets broader testing.

Hmm I'm not seeing this with my tree, and sounds like it should be
already fixed by commit d7c8f2596 (ARM: dts: Add missing reg,
interrupt and dma entries for omap3).

Can you check that you have that commit in your tree?

Regards,

Tony
