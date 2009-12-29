From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PULL REQUEST] arm omap patches for next -rc
Date: Tue, 29 Dec 2009 15:42:43 -0800
Message-ID: <20091229234242.GN3512@atomide.com>
References: <1262127509.28789.90.camel@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49159 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbZL2Xmq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Dec 2009 18:42:46 -0500
Content-Disposition: inline
In-Reply-To: <1262127509.28789.90.camel@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: linux-omap@vger.kernel.org

* Felipe Balbi <me@felipebalbi.com> [091229 14:56]:
> The following changes since commit
> abb74381235a05f15a3b07e9e3831034942c67fb:
>   Tony Lindgren (1):
>         Linux-omap rebuilt: Updated to 2.6.33-rc2, clock fixes merged

Looks good, except all the trees should be based against Linus' -rc2,
not against linux-omap or other non-mainline branches.

Regards,

Tony
 
> are available in the git repository at:
> 
>   git://gitorious.org/usb/usb.git for-tony
> 
> Felipe Balbi (12):
>       arm: omap: musb: ioremap only what's ours
>       arm: omap: musb: fix board power budget by passing it to
> usb_musb_init
>       arm: omap: musb: fix board mode by passing it to usb_musb_init
>       arm: omap1: mailbox: kill compile warning
>       arm: omap: gpmc: kill compile warning
>       arm: omap: kill compile warning in irq.c
>       arm: omap: remove unused variables
>       arm: omap: io: kill compile warning
>       arm: omap: kill compile warning on board-4430-sdp.c
>       arm: omap: gpio: kill compile warning in gpio.c
>       arm: omap: mailbox: kill compile warning in mailbox.c
>       arm: omap: perseus: kill compile warning on board-perseus2.c
> 
>  arch/arm/mach-omap1/devices.c                |    2 +-
>  arch/arm/mach-omap1/mailbox.c                |    9 +++++++--
>  arch/arm/mach-omap2/board-2430sdp.c          |    3 ++-
>  arch/arm/mach-omap2/board-3430sdp.c          |    3 ++-
>  arch/arm/mach-omap2/board-4430sdp.c          |    4 ----
>  arch/arm/mach-omap2/board-cm-t35.c           |    3 ++-
>  arch/arm/mach-omap2/board-igep0020.c         |    3 ++-
>  arch/arm/mach-omap2/board-ldp.c              |    3 ++-
>  arch/arm/mach-omap2/board-omap3beagle.c      |    3 ++-
>  arch/arm/mach-omap2/board-omap3evm.c         |    3 ++-
>  arch/arm/mach-omap2/board-omap3pandora.c     |    3 ++-
>  arch/arm/mach-omap2/board-omap3touchbook.c   |    3 ++-
>  arch/arm/mach-omap2/board-overo.c            |    3 ++-
>  arch/arm/mach-omap2/board-rx51.c             |    3 ++-
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    3 ++-
>  arch/arm/mach-omap2/gpmc.c                   |    6 ++++--
>  arch/arm/mach-omap2/io.c                     |    2 ++
>  arch/arm/mach-omap2/irq.c                    |    2 ++
>  arch/arm/mach-omap2/mailbox.c                |    2 +-
>  arch/arm/mach-omap2/omap_hwmod_2430.h        |    2 --
>  arch/arm/mach-omap2/usb-musb.c               |   23
> +++++++----------------
>  arch/arm/plat-omap/gpio.c                    |    3 +++
>  arch/arm/plat-omap/include/plat/fpga.h       |    4 ++--
>  arch/arm/plat-omap/include/plat/usb.h        |    3 ++-
>  24 files changed, 55 insertions(+), 43 deletions(-)
> 
> -- 
> balbi
> 
