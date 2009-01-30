From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/10] arm: omap mailbox: add omap3 support with some
	fixes
Date: Fri, 30 Jan 2009 10:57:23 -0800
Message-ID: <20090130185721.GG7215@atomide.com>
References: <20090116081919.17571.34378.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:59957 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752390AbZA3S50 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 13:57:26 -0500
Content-Disposition: inline
In-Reply-To: <20090116081919.17571.34378.stgit@oreo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [090116 00:29]:
> The following patches add omap3 support and some cleanups.
> 
> This "omap mailbox" device driver has been used for the interprocessor
> communication between ARM and some co-processors(DSP) inside of omap
> SoC, which is a kind of interrupt driven FIFO.

Adding the mailbox series to the omap for-next branch. Ignoring the
iommu series for now as it still needs some updates.

Tony


> ---
> 
> Hiroshi DOYU (10):
>       omap mailbox: remove unnecessary header file inclusion
>       omap mailbox: convert sequence bit checking to module paramter
>       omap mailbox: move mailbox.h into mailbox.c
>       omap mailbox: add save_/restore_ctx() for PM
>       omap mailbox: fix empty struct device for omap2
>       omap mailbox: fix empty struct device for omap1
>       omap mailbox: fix empty struct device for omap_mbox
>       omap mailbox: print hardware revision at startup
>       omap mailbox: add initial omap3 support
>       omap mailbox: cleanup omap2 register definition with macro
> 
> 
>  arch/arm/mach-omap1/devices.c              |    2 
>  arch/arm/mach-omap1/mailbox.c              |   31 ++--
>  arch/arm/mach-omap2/devices.c              |   38 ++++-
>  arch/arm/mach-omap2/mailbox.c              |  195 +++++++++++++++++-----------
>  arch/arm/plat-omap/Kconfig                 |    8 +
>  arch/arm/plat-omap/include/mach/mailbox.h  |   27 ++++
>  arch/arm/plat-omap/include/mach/omap34xx.h |    1 
>  arch/arm/plat-omap/mailbox.c               |  152 ++++++++++++++++------
>  arch/arm/plat-omap/mailbox.h               |  100 --------------
>  9 files changed, 311 insertions(+), 243 deletions(-)
>  delete mode 100644 arch/arm/plat-omap/mailbox.h
> 
> -- 
>    Hiroshi DOYU
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
