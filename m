From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH RE-SEND-3] ARM: MM: Add ARM_L1_CACHE_SHIFT_6 for handle
	inside each ARCH Kconfig
Date: Fri, 29 Jan 2010 10:29:55 +0000
Message-ID: <20100129102955.GA8919@n2100.arm.linux.org.uk>
References: <1264747415-6711-1-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:59053 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab0A2KaN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Jan 2010 05:30:13 -0500
Content-Disposition: inline
In-Reply-To: <1264747415-6711-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ben-linux@fluff.org

On Fri, Jan 29, 2010 at 03:43:35PM +0900, Kukjin Kim wrote:
> Add ARM_L1_CACHE_SHIFT_6 to arch/arm/Kconfig to allow CPUs with
> L1 cache lines which are 64bytes to indicate this without having to
> alter the arch/arm/mm/Kconfig entry each time.
> 
> Update the mm Kconfig so that ARM_L1_CACHE_SHIFT default value
> uses this and change OMAP3 and S5PC1XX to select ARM_L1_CACHE_SHIFT_6.

This looks fine, thanks.

Who's going to handle this patch?
