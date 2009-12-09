From: Tony Lindgren <tony@atomide.com>
Subject: Re: [rfc/rft/patch 0/9] omap warning cleanup
Date: Tue, 8 Dec 2009 16:52:45 -0800
Message-ID: <20091209005244.GI24013@atomide.com>
References: <1259672635-12306-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51341 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967051AbZLIAwm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Dec 2009 19:52:42 -0500
Content-Disposition: inline
In-Reply-To: <1259672635-12306-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Kalle Valo <kalle.valo@iki.fi>, Jean Pihet <jpihet@mvista.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, David Brownell <dbrownell@users.sourceforge.net>

* Felipe Balbi <felipe.balbi@nokia.com> [091201 05:03]:
> The following series removes a few compile warnings from
> omap builds. It was compile tested with all omap defconfigs
> for the ones who have the boards, a boot test would be
> nice, although there aren't any functional changes.

Thanks for doing this. I'll start looking through these
in a few days after we've got all the new code merged as
we can do these as fixes.

Regards,

Tony
 
> Felipe Balbi (9):
>   arm: omap: kill compile warning in irq.c
>   arm: omap: remove unused variables
>   arm: omap: zoom: use vmmc1 regulator supply
>   arm: omap: io: kill compile warning
>   arm: omap: kill compile warning on board-4430-sdp.c
>   arm: omap: gpio: kill compile warning in gpio.c
>   arm: omap: innovator: kill compile warning on board-innovator.c
>   arm: omap: perseus: kill compile warning on board-perseus2.c
>   arm: omap: mailbox: kill compile warning in mailbox.c
> 
>  arch/arm/mach-omap2/board-4430sdp.c          |    4 ----
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    1 +
>  arch/arm/mach-omap2/io.c                     |    2 ++
>  arch/arm/mach-omap2/irq.c                    |    2 ++
>  arch/arm/mach-omap2/mailbox.c                |    2 +-
>  arch/arm/mach-omap2/omap_hwmod_2430.h        |    2 --
>  arch/arm/plat-omap/gpio.c                    |    3 +++
>  arch/arm/plat-omap/include/plat/fpga.h       |    4 ++--
>  8 files changed, 11 insertions(+), 9 deletions(-)
> 
