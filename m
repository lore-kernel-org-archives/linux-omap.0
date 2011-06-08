From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 1/2] omap3: iovmm: Work around sg_alloc_table size limitation in IOMMU
Date: Wed, 8 Jun 2011 12:33:15 +0200
Message-ID: <201106081233.16397.laurent.pinchart@ideasonboard.com>
References: <20110601131744.GH11352@atomide.com> <201106061854.10450.laurent.pinchart@ideasonboard.com> <20110606180052.GB9456@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:46399 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753866Ab1FHKdA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Jun 2011 06:33:00 -0400
In-Reply-To: <20110606180052.GB9456@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Russell,

On Monday 06 June 2011 20:00:52 Russell King - ARM Linux wrote:
> On Mon, Jun 06, 2011 at 06:54:10PM +0200, Laurent Pinchart wrote:
> > Of course not, but if the scatterlist is only touched by kernel code, it
> > doesn't need to be contiguous in memory. It could be allocated with
> > vmalloc().
> 
> Except vmalloc has a higher latency and a more restrictive API than
> other allocators (think about the coherency issues with SMP systems
> which may have to do TLB flushing on several cores, etc.)

Right, thank you for the explanation. It is now clear to me why we want to use 
the page allocator and handle scatter list chaining in the critical paths. We 
could still use vmalloc() in the iovmm driver, but that's probably not worth 
it if we can enable scatter list chaining for the system.

With your patch scatter list chaining can be enabled at the platform level for 
the ARM architecture. What are the platform requirements to enable scatter 
list chaining ?

-- 
Regards,

Laurent Pinchart
