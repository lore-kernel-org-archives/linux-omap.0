From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 0/4] OMAP: DMA: mstandby mode and runtime pm support
Date: Tue, 19 Apr 2011 04:05:17 -0700
Message-ID: <20110419110517.GG477@atomide.com>
References: <1301322422-29886-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:21893 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754616Ab1DSLFV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Apr 2011 07:05:21 -0400
Content-Disposition: inline
In-Reply-To: <1301322422-29886-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@ti.com, paul@pwsan.com

* G, Manjunath Kondaiah <manjugk@ti.com> [110328 07:29]:
> 
> G, Manjunath Kondaiah (4):
>   OMAP2+: PM: omap device: API's for handling mstandby mode
>   OMAP2+: DMA: prevent races while setting M idle mode to nostandby
>   OMAP: PM: DMA: Enable runtime pm
>   OMAP: DMA: Fix: context restore during off mode
> 
>  arch/arm/mach-omap1/dma.c                     |    1 +
>  arch/arm/mach-omap2/dma.c                     |   16 ++
>  arch/arm/mach-omap2/omap_hwmod.c              |   42 ++++++
>  arch/arm/plat-omap/dma.c                      |  196 +++++++++++++++++++++----
>  arch/arm/plat-omap/include/plat/dma.h         |    1 +
>  arch/arm/plat-omap/include/plat/omap_device.h |    2 +
>  arch/arm/plat-omap/include/plat/omap_hwmod.h  |    4 +-
>  arch/arm/plat-omap/omap_device.c              |   62 ++++++++
>  8 files changed, 291 insertions(+), 33 deletions(-)

With the DMA code too we need to do the cleanup to move it
to drivers/dma before adding new features.

Tony
 
