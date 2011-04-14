From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] OMAP: iommu flush page table entries from L1 and L2
	cache
Date: Thu, 14 Apr 2011 23:30:36 +0100
Message-ID: <20110414223036.GA7335@n2100.arm.linux.org.uk>
References: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:58691 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925Ab1DNWas (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Apr 2011 18:30:48 -0400
Content-Disposition: inline
In-Reply-To: <1302817968-28516-1-git-send-email-fernando.lugo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Fernando Guzman Lugo <fernando.lugo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tony@atomide.com, Ramesh Gupta <grgupta@ti.com>, Hari Kanigeri <h-kanigeri2@ti.com>

On Thu, Apr 14, 2011 at 04:52:48PM -0500, Fernando Guzman Lugo wrote:
> From: Ramesh Gupta <grgupta@ti.com>
> 
> This patch is to flush the iommu page table entries from L1 and L2
> caches using dma_map_single. This also simplifies the implementation
> by removing the functions  flush_iopgd_range/flush_iopte_range.

No.  This usage is just wrong.  If you're going to use the DMA API then
unmap it, otherwise the DMA API debugging will go awol.
