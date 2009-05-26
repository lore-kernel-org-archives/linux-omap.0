From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/6] Updates for omap3 for merge window after 2.6.30
Date: Tue, 26 May 2009 16:31:13 -0700
Message-ID: <20090526233112.GJ11865@atomide.com>
References: <20090522223543.31586.44534.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64698 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754416AbZEZXbU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 May 2009 19:31:20 -0400
Content-Disposition: inline
In-Reply-To: <20090522223543.31586.44534.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [090522 15:37]:
> Hi all,
> 
> Here are mostly omap3 specific updates for the coming merge window
> for review. Still to come few more boards and regulator framework
> changes for omap3 in one more series.

I've merged these into omap for-next branch.
 
> Regards,
> 
> Tony
> 
> ---
> 
> Imre Deak (1):
>       ARM: OMAP3: ZOOM MDK: Add FB support to board file
> 
> Paul Walmsley (2):
>       ARM: OMAP3: SDRC: add timing data for Qimonda HYB18M512160AF-6
>       ARM: OMAP3: SDRC: add timing data for Micron MT46H32M32LF-6
> 
> Tony Lindgren (2):
>       ARM: OMAP3: Initialize more devices for LDP
>       ARM: OMAP2/3: Remove L4_WK_OMAP_BASE, L4_PER_OMAP_BASE, L4_EMU_BASE, L3_OMAP_BASE
> 
> Vikram Pandita (1):
>       ARM: OMAP2/3: Serial: Remove arch_initcall dependency
> 
> 
>  arch/arm/mach-omap2/board-3430sdp.c                |    3 
>  arch/arm/mach-omap2/board-ldp.c                    |  219 ++++++++++++++++++++
>  arch/arm/mach-omap2/board-omap3beagle.c            |    4 
>  arch/arm/mach-omap2/board-omap3pandora.c           |    3 
>  arch/arm/mach-omap2/board-overo.c                  |    3 
>  arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h  |   69 ++++++
>  .../mach-omap2/sdram-qimonda-hyb18m512160af-6.h    |   54 +++++
>  arch/arm/mach-omap2/serial.c                       |   22 +-
>  arch/arm/plat-omap/include/mach/keypad.h           |    4 
>  arch/arm/plat-omap/include/mach/omap34xx.h         |    4 
>  10 files changed, 361 insertions(+), 24 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h
>  create mode 100644 arch/arm/mach-omap2/sdram-qimonda-hyb18m512160af-6.h
> 
> -- 
> Signature
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
