From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 3/3] ARM: OMAP: dma: Fix the kfree ordering
Date: Thu, 13 Jun 2013 14:16:47 +0100
Message-ID: <20130613131647.GS21614@n2100.arm.linux.org.uk>
References: <1371128960-24822-1-git-send-email-rnayak@ti.com> <1371128960-24822-4-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42631 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134Ab3FMNQ6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jun 2013 09:16:58 -0400
Content-Disposition: inline
In-Reply-To: <1371128960-24822-4-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Jun 13, 2013 at 06:39:20PM +0530, Rajendra Nayak wrote:
> diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
> index 8a71f75..8e16503 100644
> --- a/arch/arm/plat-omap/dma.c
> +++ b/arch/arm/plat-omap/dma.c
> @@ -2111,8 +2111,8 @@ exit_dma_irq_fail:
>  	}
>  
>  exit_dma_lch_fail:
> -	kfree(p);
>  	kfree(d);
> +	kfree(p);

Err.

        p = pdev->dev.platform_data;
        d                       = p->dma_attr;

Why is it kfree'ing platform data in the first place?  This means that
a failed bind can't be reattempted later.  It also means that an unbind
plus rebind in userspace will free the platform data leaving stale
pointers behind.

This is totally nonsense.  Don't kfree() data in your driver which you
haven't allocated yourself!
