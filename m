From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/10] Omap3 updates for upcoming 2.6.32 merge window
Date: Mon, 24 Aug 2009 16:05:41 +0300
Message-ID: <20090824130540.GB5165@atomide.com>
References: <20090812120926.17601.85860.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:56332 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461AbZHXNFs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 09:05:48 -0400
Content-Disposition: inline
In-Reply-To: <20090812120926.17601.85860.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [090812 15:10]:
> Hi all,
> 
> Here are mostly omap3 specific updates for the merge window.

I've added this series into omap for-next branch.
 
> Regards,
> 
> Tony
> 
> ---
> 
> Felipe Balbi (1):
>       OMAP3: beagle: add missing twl4030 usb platform_data
> 
> Hiroshi DOYU (2):
>       OMAP: iommu: add initial debugfs support
>       OMAP: iommu: fix wrong argument in flush_cache_vmap()
> 
> Paul Walmsley (1):
>       OMAP3: update OMAP3 Beagle defconfig
> 
> Sergio Aguirre (1):
>       OMAP3: 3430SDP: Fix defconfig
> 
> Timo Kokkonen (1):
>       OMAP3: rx51_defconfig: add twl4030 to rx51 default configuration
> 
> Vikram Pandita (4):
>       OMAP3: Zoom2: Update board defconfig
>       OMAP3: Zoom2: Add TWL4030 support
>       OMAP3: MMC: Add mux for pins
>       OMAP2/3: Pass irqflags to 8250 driver
> 
> 
>  arch/arm/configs/omap3_beagle_defconfig     |   11 +
>  arch/arm/configs/omap_3430sdp_defconfig     |   20 +
>  arch/arm/configs/omap_zoom2_defconfig       |  484 +++++++++++++++++++++++----
>  arch/arm/configs/rx51_defconfig             |    1 
>  arch/arm/mach-omap2/board-omap3beagle.c     |    5 
>  arch/arm/mach-omap2/board-zoom-debugboard.c |    2 
>  arch/arm/mach-omap2/board-zoom2.c           |  204 +++++++++++
>  arch/arm/mach-omap2/devices.c               |   42 ++
>  arch/arm/mach-omap2/mux.c                   |   49 +++
>  arch/arm/mach-omap2/serial.c                |    2 
>  arch/arm/plat-omap/Kconfig                  |    4 
>  arch/arm/plat-omap/Makefile                 |    1 
>  arch/arm/plat-omap/include/mach/mux.h       |   28 ++
>  arch/arm/plat-omap/iommu-debug.c            |  334 +++++++++++++++++++
>  arch/arm/plat-omap/iovmm.c                  |    2 
>  15 files changed, 1088 insertions(+), 101 deletions(-)
>  create mode 100644 arch/arm/plat-omap/iommu-debug.c
> 
> -- 
> Signature
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
