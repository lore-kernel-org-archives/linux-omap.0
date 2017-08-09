From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 0/2] iommu/omap: Rework cache functionality with DMA Streaming API
Date: Wed, 09 Aug 2017 14:20:42 +0300
Message-ID: <1541952.tFANgzzemW@avalon>
References: <1501274954-20973-1-git-send-email-j-albarran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501274954-20973-1-git-send-email-j-albarran@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Josue Albarran <j-albarran@ti.com>
Cc: Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Josue,

Thank you for the patches.

On Friday 28 Jul 2017 15:49:12 Josue Albarran wrote:
> Hi Joerg,
> 
> This series adapts the OMAP IOMMU driver to use the DMA API to flush
> the page table/directory table entries from the CPU caches instead of
> the ARM assembly calls. The patches are baselined on 4.13-rc1.
> 
> Following is the patch summary:
>  1. Patch 1 disables the OMAP IOMMU fault interrupts instead of
>     disabling the MMU upon a fault, and resulted in recurring bus
>     errors during remoteproc recovery on OMAP4. The MMU fault itself
>     is triggered due to the missing PL310 L2 cache operations, and
>     this patch fixes the recurring bus errors.
>  2. The second patch makes the adaptation to the DMA API for flushing
>     the caches. This fixes the MMU fault triggering issues in the
>     first place on OMAP4.
> 
> I have tested these patches on DRA7, OMAP5, and OMAP4 platforms using
> both OMAP IOMMU unit tests and some out-of-tree patches for exercising
> the MMUs using the OMAP remoteproc driver.
> 
> Laurent,
> Appreciate it if you can check the OMAP3ISP functionality with these
> patches once.

I apologize for the delay, I had to resurrect my Beagleboard-xM, which 
involved updating and then debugging U-Boot.

Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
