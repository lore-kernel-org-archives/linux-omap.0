From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/5] arm: omap: debug-leds: few changes
Date: Fri, 7 Sep 2012 15:32:59 -0700
Message-ID: <20120907223259.GT1303@atomide.com>
References: <1343120042-16695-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:26276 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758331Ab2IGWdB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Sep 2012 18:33:01 -0400
Content-Disposition: inline
In-Reply-To: <1343120042-16695-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [120724 02:02]:
> Hi Tony,
> 
> here are a few changes for the debug-leds driver. This series tries to get the
> driver closer to be moved away from arch/arm/plat-omap/ and under drivers/leds.
> There's only the dependency with <plat/fpga.h> now.
> 
> I tried moving the needed definitions into the C file, but there's another file
> which uses the same structure (arch/arm/mach-omap1/leds-h2p2-debug.c) so I left
> it for another series. Ideally, omap1 would be using the same debug-leds driver
> for that purpose and we could drop the dependency on <plat/fpga.h>.
> 
> BTW, patches were compile tested only due to the lack of an H4 board.
> 
> Felipe Balbi (5):
>   arm: omap: debug-leds: drop machine_is_* checks
>   arm: omap: debug-leds: move initialization to debug-leds
>   arm: omap: debug-leds: add section annotation to probe
>   arm: omap: debug-leds: add a remove method
>   arm: omap: debug-leds: switch to resource_size()
> 
>  arch/arm/plat-omap/debug-leds.c | 37 +++++++++++++++++++++++--------------
>  1 file changed, 23 insertions(+), 14 deletions(-)

Sorry for forgetting this series.. Found it after shrinking my inbox
to a more readable size :)

There are some good changes in linux-next that remove most of the
debug-leds code. Maybe take a quick look what can be rebased on
those to make it into a reald driver?

Regards,

Tony
