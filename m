From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RE-SEND-3] ARM: MM: Add ARM_L1_CACHE_SHIFT_6 for handle
 inside each ARCH Kconfig
Date: Fri, 29 Jan 2010 12:48:45 -0800
Message-ID: <20100129204845.GM23505@atomide.com>
References: <1264747415-6711-1-git-send-email-kgene.kim@samsung.com>
 <20100129102955.GA8919@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:62450 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802Ab0A2Usf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jan 2010 15:48:35 -0500
Content-Disposition: inline
In-Reply-To: <20100129102955.GA8919@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ben-linux@fluff.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [100129 02:27]:
> On Fri, Jan 29, 2010 at 03:43:35PM +0900, Kukjin Kim wrote:
> > Add ARM_L1_CACHE_SHIFT_6 to arch/arm/Kconfig to allow CPUs with
> > L1 cache lines which are 64bytes to indicate this without having to
> > alter the arch/arm/mm/Kconfig entry each time.
> > 
> > Update the mm Kconfig so that ARM_L1_CACHE_SHIFT default value
> > uses this and change OMAP3 and S5PC1XX to select ARM_L1_CACHE_SHIFT_6.
> 
> This looks fine, thanks.
> 
> Who's going to handle this patch?

I recommend RMK handle this.

Acked-by: Tony Lindgren <tony@atomide.com>
