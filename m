From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 0/8] nand support on omap3 boards
Date: Mon, 2 Aug 2010 15:52:48 +0300
Message-ID: <20100802125248.GK12293@atomide.com>
References: <1278685671-12036-1-git-send-email-s-ghorai@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61706 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457Ab0HBMwX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 2 Aug 2010 08:52:23 -0400
Content-Disposition: inline
In-Reply-To: <1278685671-12036-1-git-send-email-s-ghorai@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sukumar Ghorai <s-ghorai@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org

* Sukumar Ghorai <s-ghorai@ti.com> [100709 17:21]:
>    The following set of patches applies on top of for-next branch.
>    And these are the patches required to enable nand (nor and onenand for sdp
>    only) for different platform.

Will add this series into omap-for-linus too.

Regards,

Tony

    
>    v4: patch rebase on latest code base; depend on
> 	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg31950.html
>    
>    v3:  http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30735.html
> 	patch rebase on latest nand patch and depend on -
> 	http://www.mail-archive.com/linux-omap@vger.kernel.org/msg30305.html
>    
>    v2: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg26479.html
> 	rework to use full nand in partition table of ZOOM2/3;
> 	ZOOM1(LDP)support added.
> 		
>    v1: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg22205.html
> 
> Sukumar Ghorai (5):
> 	omap3 flash: rename board-sdp-flash.c to be use by other boards
> 	omap3: add support for NAND on zoom2 board
> 	omap3: add support for NAND on zoom3 board
> 	omap-3630-sdp : Add support for Flash
> 	omap3: add support for NAND on LDP board
> 
>  arch/arm/mach-omap2/Makefile                  |    6 +-
>  arch/arm/mach-omap2/board-3430sdp.c           |   16 +++-
>  arch/arm/mach-omap2/board-3630sdp.c           |  120 +++++++++++++++++++++++++
>  arch/arm/mach-omap2/board-ldp.c               |   35 +++++++
>  arch/arm/mach-omap2/board-sdp-flash.c         |   88 ++++++++-----------
>  arch/arm/mach-omap2/board-zoom2.c             |   43 +++++++++
>  arch/arm/mach-omap2/board-zoom3.c             |   43 +++++++++
>  arch/arm/mach-omap2/include/mach/board-sdp.h  |    9 ++-
>  arch/arm/mach-omap2/include/mach/board-zoom.h |    6 ++
>  9 files changed, 311 insertions(+), 55 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
