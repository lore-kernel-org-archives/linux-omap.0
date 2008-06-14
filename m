From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 05/21] ARM: OMAP: DMA: Remove __REG access
Date: Sat, 14 Jun 2008 09:04:39 +0100
Message-ID: <20080614080439.GH32122@flint.arm.linux.org.uk>
References: <1212802253-17797-1-git-send-email-tony@atomide.com> <1212802253-17797-2-git-send-email-tony@atomide.com> <1212802253-17797-3-git-send-email-tony@atomide.com> <1212802253-17797-4-git-send-email-tony@atomide.com> <1212802253-17797-5-git-send-email-tony@atomide.com> <1212802253-17797-6-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:32916 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752392AbYFNIEv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 14 Jun 2008 04:04:51 -0400
Content-Disposition: inline
In-Reply-To: <1212802253-17797-6-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, Jun 06, 2008 at 06:30:37PM -0700, Tony Lindgren wrote:
> Remove __REG access in DMA code, use dma_read/write instead:
> 
> - dynamically set the omap_dma_base based on the omap type
> 
> - omap_read/write becomes dma_read/write
> - dma channel registers are read with dma_ch_read/write
> 
> Cc: David Brownell <david-b@pacbell.net>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 02f00a9..50f83bc 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -126,6 +126,7 @@ static int dma_chan_count;
>  
>  static spinlock_t dma_chan_lock;
>  static struct omap_dma_lch *dma_chan;
> +void __iomem *omap_dma_base;

Shouldn't this be static?
