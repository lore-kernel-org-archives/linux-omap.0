From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] OMAP: iommu flush page table entries from L1 and L2
	cache
Date: Fri, 15 Apr 2011 09:12:54 +0100
Message-ID: <20110415081253.GA18952@n2100.arm.linux.org.uk>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com> <20110414223036.GA7335@n2100.arm.linux.org.uk> <BANLkTikfXbtsqaw5ZuP_BbDCtsxXOHZs_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:47161 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857Ab1DOINL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Apr 2011 04:13:11 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikfXbtsqaw5ZuP_BbDCtsxXOHZs_w@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: KyongHo Cho <pullip.cho@samsung.com>
Cc: Fernando Guzman Lugo <fernando.lugo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tony@atomide.com, Ramesh Gupta <grgupta@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>

On Fri, Apr 15, 2011 at 11:24:16AM +0900, KyongHo Cho wrote:
> That means we need to translate logical to physical address and it is
> sometimes not trivial.

What do you mean "sometimes not trivial" ?  The DMA does nothing more
than virt_to_phys(virt) to get the physical address.  It's _that_ simple.

If virt_to_phys(virt) is likely to fail, there's protection in the DMA API
to BUG_ON() in that case.

> Finally, the kernel will contain many similar routines that do same thing.

So when we get coherent DMA, you won't care that the DMA API functions
start doing nothing with caches?
