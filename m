From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/12] Omap3 updates for the merge window after 2.6.29
Date: Mon, 23 Mar 2009 19:51:37 -0700
Message-ID: <20090324025137.GQ29546@atomide.com>
References: <20090310205824.16425.97745.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58208 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752281AbZCXCvc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 22:51:32 -0400
Content-Disposition: inline
In-Reply-To: <20090310205824.16425.97745.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [090310 14:01]:
> Hi all,
> 
> Here are the patches I promised last week, sorry for the delay
> in posting them. I ended up leaving out the mach-omap3/board-*.c
> files as they still need a bit of work.
> 
> I may post one more series after this to add few more omap3
> boards if we have enough time.

I've added this series to my for-next branch. That is except for
the "ARM: OMAP3: Store reboot mode in scratchpad on OMAP34xx" patch
that needs to be updated.
 
> Cheers,
> 
> Tony
> 
> ---
> 
> Adrian Hunter (3):
>       ARM: OMAP3: mmc-twl4030 allow arbitrary slot names
>       ARM: OMAP3: mmc-twl4030 add cover switch
>       ARM: OMAP3: mmc-twl4030 fix name buffer length
> 
> David Brownell (3):
>       ARM: OMAP3: mmc-twl4030 fix for vmmc = 0
>       ARM: OMAP3: mmc-twl4030 init passes device nodes back
>       ARM: OMAP3: mmc-twl4030 voltage cleanup
> 
> Felipe Balbi (1):
>       ARM: OMAP3: MUSB initialization for omap hw
> 
> Grazvydas Ignotas (1):
>       ARM: OMAP3: mmc-twl4030 add MMC3 support
> 
> Jarkko Nikula (1):
>       ARM: OMAP3: Remove unused CONFIG_I2C2_OMAP_BEAGLE
> 
> Juha Yrjola (1):
>       ARM: OMAP3: Store reboot mode in scratchpad on OMAP34xx
> 
> Tony Lindgren (2):
>       ARM: OMAP3: Add base address definitions and resources for OMAP 3 IS
>       ARM: OMAP3: Add more GPIO mux options
> 
> 
>  arch/arm/mach-omap2/Makefile               |    2 
>  arch/arm/mach-omap2/board-2430sdp.c        |    2 
>  arch/arm/mach-omap2/board-ldp.c            |    2 
>  arch/arm/mach-omap2/board-omap3beagle.c    |    5 -
>  arch/arm/mach-omap2/board-omap3pandora.c   |    9 +
>  arch/arm/mach-omap2/board-overo.c          |    3 
>  arch/arm/mach-omap2/devices.c              |  108 ++++++++++++++++
>  arch/arm/mach-omap2/mmc-twl4030.c          |  186 ++++++++++++++++++++--------
>  arch/arm/mach-omap2/mmc-twl4030.h          |    6 +
>  arch/arm/mach-omap2/mux.c                  |   27 ++++
>  arch/arm/mach-omap2/prcm.c                 |   14 ++
>  arch/arm/mach-omap2/usb-musb.c             |  185 ++++++++++++++++++++++++++++
>  arch/arm/plat-omap/devices.c               |    3 
>  arch/arm/plat-omap/include/mach/control.h  |    9 +
>  arch/arm/plat-omap/include/mach/mmc.h      |    2 
>  arch/arm/plat-omap/include/mach/mux.h      |   13 ++
>  arch/arm/plat-omap/include/mach/omap34xx.h |   27 ++++
>  arch/arm/plat-omap/include/mach/usb.h      |    8 +
>  18 files changed, 549 insertions(+), 62 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/usb-musb.c
> 
> -- 
> Signature
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
