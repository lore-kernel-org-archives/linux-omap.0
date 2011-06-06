From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 1/2] omap3: iovmm: Work around sg_alloc_table size
	limitation in IOMMU
Date: Mon, 6 Jun 2011 19:00:52 +0100
Message-ID: <20110606180052.GB9456@n2100.arm.linux.org.uk>
References: <20110601131744.GH11352@atomide.com> <201106061823.18767.laurent.pinchart@ideasonboard.com> <20110606164400.GA9456@n2100.arm.linux.org.uk> <201106061854.10450.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60492 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756989Ab1FFSBB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 14:01:01 -0400
Content-Disposition: inline
In-Reply-To: <201106061854.10450.laurent.pinchart@ideasonboard.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Jun 06, 2011 at 06:54:10PM +0200, Laurent Pinchart wrote:
> Of course not, but if the scatterlist is only touched by kernel code, it 
> doesn't need to be contiguous in memory. It could be allocated with vmalloc().

Except vmalloc has a higher latency and a more restrictive API than
other allocators (think about the coherency issues with SMP systems
which may have to do TLB flushing on several cores, etc.)
