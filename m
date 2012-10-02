From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 0/7] ARM: OMAP: Move plat/dma*.h,omap-secure.h
 headers as part of single zImage work
Date: Mon, 1 Oct 2012 20:21:06 -0700
Message-ID: <20121002032106.GP4840@atomide.com>
References: <1349117226-4980-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:36031 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751018Ab2JBDVM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Oct 2012 23:21:12 -0400
Content-Disposition: inline
In-Reply-To: <1349117226-4980-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com

* Lokesh Vutla <lokeshvutla@ti.com> [121001 11:48]:
> Patch 1:
> 	Dropping the file plat/dma44xx.h as none of the omap44xx
> 	dma channel definitions are used.
> Patch 2:
> 	Moving OMAP1 DMA channel definitions to mach-omap1
> Patch 3:
> 	Moving OMAP2+ DMA channel definitions to mach-omap2
> Patch 4:
> 	Moving plat/dma.h to plat-omap/dma-omap.h
> Patch 5:
> 	Removing omap_reserve() callback from all omap1 board files.
> Patch 6:
> 	Defining omap_reserve() locally to mach-omap2.
> Patch 7:
> 	Move plat/omap-secure.h locally to mach-omap2
> 
> Lokesh Vutla (7):
>   ARM: OMAP: DMA: Removing plat/dma-44xx.h
>   ARM: OMAP1: DMA: Moving OMAP1 DMA channel definitions to mach-omap1
>   ARM: OMAP2+: DMA: Moving OMAP2 DMA channel definitions to mach-omap2
>   ARM: OMAP: DMA: Move plat/dma.h to plat-omap/dma-omap.h
>   ARM: OMAP1: Remove omap_reserve() callback for all omap1 boards
>   ARM: OMAP2+: Move omap_reserve() locally to mach-omap2
>   ARM: OMAP: Move plat/omap-secure.h locally to mach-omap2

Thanks, I'll be applying these probably at -rc1. If anybody
has better ideas for the move of plat/dma.h to plat-omap/dma-omap.h,
please yell out now.

Regards,

Tony
