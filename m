From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 00/17] OMAP IOMMU Cleanup & Consolidation
Date: Thu, 23 Oct 2014 14:34:47 +0200
Message-ID: <20141023123447.GA10053@8bytes.org>
References: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:43351 "EHLO theia.8bytes.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754971AbaJWMeu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Oct 2014 08:34:50 -0400
Content-Disposition: inline
In-Reply-To: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org

On Wed, Oct 22, 2014 at 05:22:18PM -0500, Suman Anna wrote:
> Suman Anna (17):
>   iommu/omap: Remove refcount field from omap_iommu object
>   iommu/omap: Remove unused isr_priv field from omap_iommu
>   iommu/omap: Remove duplicate declarations
>   iommu/omap: Remove conditional definition of dev_to_omap_iommu()
>   iommu/omap: Remove ver debugfs entry
>   iommu/omap: Remove omap_iommu_arch_version() and version field
>   iommu/omap: Remove bogus version check in context save/restore
>   iommu/omap: Simplify omap2_iommu_fault_isr()
>   iommu/omap: Consolidate OMAP IOMMU modules
>   iommu/omap: Fix the permissions on nr_tlb_entries
>   iommu/omap: Make pagetable debugfs entry read-only
>   iommu/omap: Integrate omap-iommu-debug into omap-iommu
>   iommu/omap: Remove couple of unused exported functions
>   iommu/omap: Do not export unneeded functions
>   iommu/omap: Reset the domain field upon detaching
>   iommu/omap: Fix bus error on debugfs access of unattached IOMMU
>   iommu/omap: Switch pagetable debugfs entry to use seq_file
> 
>  drivers/iommu/Kconfig            |  12 +-
>  drivers/iommu/Makefile           |   1 -
>  drivers/iommu/omap-iommu-debug.c | 242 ++++++++--------------------
>  drivers/iommu/omap-iommu.c       | 306 ++++++++++++++++++++++-------------
>  drivers/iommu/omap-iommu.h       |  98 ++++++------
>  drivers/iommu/omap-iommu2.c      | 337 ---------------------------------------
>  6 files changed, 312 insertions(+), 684 deletions(-)
>  delete mode 100644 drivers/iommu/omap-iommu2.c

Applied to arm/omap, thanks Suman.

