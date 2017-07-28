From: Josue Albarran <j-albarran@ti.com>
Subject: [PATCH 0/2] iommu/omap: Rework cache functionality with DMA Streaming API
Date: Fri, 28 Jul 2017 15:49:12 -0500
Message-ID: <1501274954-20973-1-git-send-email-j-albarran@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Suman Anna <s-anna@ti.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Joerg,

This series adapts the OMAP IOMMU driver to use the DMA API to flush
the page table/directory table entries from the CPU caches instead of
the ARM assembly calls. The patches are baselined on 4.13-rc1.

Following is the patch summary:
 1. Patch 1 disables the OMAP IOMMU fault interrupts instead of
    disabling the MMU upon a fault, and resulted in recurring bus
    errors during remoteproc recovery on OMAP4. The MMU fault itself
    is triggered due to the missing PL310 L2 cache operations, and
    this patch fixes the recurring bus errors.
 2. The second patch makes the adaptation to the DMA API for flushing
    the caches. This fixes the MMU fault triggering issues in the
    first place on OMAP4.
    
I have tested these patches on DRA7, OMAP5, and OMAP4 platforms using
both OMAP IOMMU unit tests and some out-of-tree patches for exercising
the MMUs using the OMAP remoteproc driver.

Laurent,
Appreciate it if you can check the OMAP3ISP functionality with these
patches once.

Regards
Josue

Fernando Guzman Lugo (1):
  iommu/omap: Fix disabling of MMU upon a fault

Josue Albarran (1):
  iommu/omap: Use DMA-API for performing cache flushes

 drivers/iommu/omap-iommu.c | 125 +++++++++++++++++++++++++++++----------------
 drivers/iommu/omap-iommu.h |   1 +
 2 files changed, 81 insertions(+), 45 deletions(-)

-- 
2.7.4
