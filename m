From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Omap board updates for merge window after 2.6.29
Date: Mon, 23 Mar 2009 19:52:05 -0700
Message-ID: <20090324025205.GR29546@atomide.com>
References: <20090313224259.8810.3283.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:58555 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbZCXCwA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 22:52:00 -0400
Content-Disposition: inline
In-Reply-To: <20090313224259.8810.3283.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [090313 15:43]:
> Hi all,
> 
> Here are some board updates and few new boards.

Added this series too to my for-next branch.

Tony
 
> Regards,
> 
> Tony
> 
> ---
> 
> Lauri Leukkunen (1):
>       ARM OMAP3: Initial support for Nokia RX-51
> 
> Steve Sakoman (2):
>       ARM: OMAP3: Add ADS7846 touchscreen support to Overo platform
>       ARM: OMAP3: Add SMSC911X support to Overo platform (V2)
> 
> Syed Mohammed Khasim (1):
>       ARM: OMAP3: Add support for 3430 SDP
> 
> 
>  arch/arm/configs/omap_3430sdp_defconfig      | 2061 ++++++++++++++++++++++++++
>  arch/arm/configs/rx51_defconfig              | 1821 +++++++++++++++++++++++
>  arch/arm/mach-omap2/Kconfig                  |   10 
>  arch/arm/mach-omap2/Makefile                 |    6 
>  arch/arm/mach-omap2/board-3430sdp.c          |  514 ++++++
>  arch/arm/mach-omap2/board-overo.c            |  126 ++
>  arch/arm/mach-omap2/board-rx51-peripherals.c |  419 +++++
>  arch/arm/mach-omap2/board-rx51.c             |   96 +
>  8 files changed, 5052 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/configs/omap_3430sdp_defconfig
>  create mode 100644 arch/arm/configs/rx51_defconfig
>  create mode 100644 arch/arm/mach-omap2/board-3430sdp.c
>  create mode 100644 arch/arm/mach-omap2/board-rx51-peripherals.c
>  create mode 100644 arch/arm/mach-omap2/board-rx51.c
> 
> -- 
> Signature
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
