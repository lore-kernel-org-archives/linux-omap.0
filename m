From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: fix DMA vs memory ordering
Date: Mon, 16 Apr 2012 10:58:49 -0700
Message-ID: <20120416175849.GI6487@atomide.com>
References: <20120414132435.GS24211@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:13428 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209Ab2DPR6x (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Apr 2012 13:58:53 -0400
Content-Disposition: inline
In-Reply-To: <20120414132435.GS24211@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120414 06:27]:
> Using coherent DMA memory with the OMAP DMA engine results in
> unpredictable behaviour due to memory ordering issues; as things stand,
> there is no guarantee that data written to coherent DMA memory will be
> visible to the DMA hardware.
> 
> This is because the OMAP dma_write() accessor contains no barriers,
> necessary on ARMv6 and above.  The effect of this can be seen in comments
> in the OMAP serial driver, which incorrectly talks about cache flushing
> for the coherent DMA stuff.
> 
> Rather than adding barriers to the accessors, add it in the DMA support
> code just before we enable DMA, and just after we disable DMA.  This
> avoids having barriers for every DMA register access.

Good catch.

I guess what you're saying is we don't want to do mb() for each completed
transfer that calls the driver specific callback function?

Other than that:

Acked-by: Tony Lindgren <tony@atomide.com>
