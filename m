From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] Omap header cleanup for upcoming 2.6.32 merge
	window
Date: Mon, 24 Aug 2009 16:05:13 +0300
Message-ID: <20090824130512.GA5165@atomide.com>
References: <20090806100614.2569.8531.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64930 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419AbZHXNFT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 09:05:19 -0400
Content-Disposition: inline
In-Reply-To: <20090806100614.2569.8531.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [090806 13:09]:
> Hi all,
> 
> Here are few patches for the upcoming merge window to remove unnecessary
> ifdeffery in the header files.
> 
> We should get these merged early to avoid merge conflicts with other
> patchsets.

I've added this series into omap for-next branch.
 
> Regards,
> 
> Tony
> 
> ---
> 
> Tony Lindgren (3):
>       OMAP: Remove ifdefs for io.h
>       OMAP: Rename OMAP_MPUIO_BASE to OMAP1_MPUIO_BASE
>       OMAP: Remove OMAP_IO_ADDRESS, use OMAP1_IO_ADDRESS and OMAP2_IO_ADDRESS instead
> 
> 
>  arch/arm/mach-omap1/devices.c                 |    2 -
>  arch/arm/mach-omap1/io.c                      |    6 +-
>  arch/arm/mach-omap1/pm.h                      |    4 +
>  arch/arm/mach-omap1/serial.c                  |    6 +-
>  arch/arm/mach-omap1/sram.S                    |   12 ++-
>  arch/arm/mach-omap1/time.c                    |    4 +
>  arch/arm/mach-omap2/board-4430sdp.c           |    4 +
>  arch/arm/mach-omap2/cm.h                      |    6 +-
>  arch/arm/mach-omap2/omap-smp.c                |    2 -
>  arch/arm/mach-omap2/pm-debug.c                |    2 -
>  arch/arm/mach-omap2/prm.h                     |    6 +-
>  arch/arm/mach-omap2/sdrc.h                    |    6 +-
>  arch/arm/mach-omap2/serial.c                  |    6 +-
>  arch/arm/mach-omap2/sram242x.S                |    4 +
>  arch/arm/mach-omap2/sram243x.S                |    4 +
>  arch/arm/mach-omap2/timer-gp.c                |    2 -
>  arch/arm/plat-omap/dma.c                      |    8 +-
>  arch/arm/plat-omap/dmtimer.c                  |    5 +
>  arch/arm/plat-omap/gpio.c                     |   88 +++++++++++------------
>  arch/arm/plat-omap/include/mach/control.h     |   12 ++-
>  arch/arm/plat-omap/include/mach/entry-macro.S |    8 +-
>  arch/arm/plat-omap/include/mach/gpio.h        |    2 -
>  arch/arm/plat-omap/include/mach/io.h          |   97 ++++++++++++-------------
>  arch/arm/plat-omap/include/mach/mtd-xip.h     |    2 -
>  arch/arm/plat-omap/include/mach/omap44xx.h    |    8 +-
>  arch/arm/plat-omap/include/mach/sdrc.h        |    6 +-
>  arch/arm/plat-omap/io.c                       |   62 +++++++++++++++-
>  arch/arm/plat-omap/sram.c                     |   20 +++--
>  drivers/input/keyboard/omap-keypad.c          |   22 +++---
>  drivers/mtd/nand/ams-delta.c                  |    8 +-
>  drivers/video/omap/dispc.c                    |    6 +-
>  31 files changed, 245 insertions(+), 185 deletions(-)
> 
> -- 
> Signature
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
