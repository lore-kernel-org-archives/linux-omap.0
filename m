From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 00/17] OMAP IOMMU Cleanup & Consolidation
Date: Tue, 30 Sep 2014 16:15:55 -0500
Message-ID: <1412111772-38006-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44910 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140AbaI3VQ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Sep 2014 17:16:27 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

Hi,

The OMAP IOMMU driver is currently designed as three different
pieces - a core OMAP IOMMU driver that implements the generic
IOMMU API ops, a OMAP arch-specific layer that implements the
OMAP specific arch iommu_functions, and an independent debugfs
module. The former two are always built-in, while the last one
is tristate.

The driver supports OMAP2+ SoCs only, and this series performs
a whole lot of cleanup and consolidates all the above pieces
into a single built-in driver. The OMAP arch-specific layer is
eliminated completely (absorbed into the core OMAP driver), and
the debugfs portion is still maintained as a separate file, but
not a separate module anymore. This cleanup and consolidation
eliminates most of the currently exported functions from the
OMAP IOMMU driver.

The series also includes couple of fixes to the OMAP IOMMU
debugfs entries - permissions on one debugfs entry, eliminate
bus errors on debugfs access on disabled IOMMUs; and one
enhancement to list all valid page table entries instead of
listing only a page worth of data.

The patches are baselined on 3.17-rc3 and on top of the OMAP
IOMMU patches staged for 3.18 [1]; a reference branch with all
these patches is available is hosted at [2].

I am posting this series for review with the intention to have
them make it to 3.19, so I can repost once rc1 is out if needed.

[1] http://git.kernel.org/cgit/linux/kernel/git/joro/iommu.git/log/?h=arm/omap
[2] https://github.com/sumananna/omap-kernel/commits/iommu/submit/3.17-rc3-cleanup-consolidation

regards
Suman


Suman Anna (17):
  iommu/omap: Remove refcount field from omap_iommu object
  iommu/omap: Remove unused isr_priv field from omap_iommu
  iommu/omap: Remove duplicate declarations
  iommu/omap: Remove conditional definition of dev_to_omap_iommu()
  iommu/omap: Remove ver debugfs entry
  iommu/omap: Remove omap_iommu_arch_version() and version field
  iommu/omap: Remove bogus version check in context save/restore
  iommu/omap: Simplify omap2_iommu_fault_isr()
  iommu/omap: Consolidate OMAP IOMMU modules
  iommu/omap: Fix the permissions on nr_tlb_entries
  iommu/omap: Make pagetable debugfs entry read-only
  iommu/omap: Integrate omap-iommu-debug into omap-iommu
  iommu/omap: Remove couple of unused exported functions
  iommu/omap: Do not export unneeded functions
  iommu/omap: Reset the domain field upon detaching
  iommu/omap: Fix bus error on debugfs access of unattached IOMMU
  iommu/omap: Switch pagetable debugfs entry to use seq_file

 drivers/iommu/Kconfig            |   9 --
 drivers/iommu/Makefile           |   4 +-
 drivers/iommu/omap-iommu-debug.c | 244 ++++++++--------------------
 drivers/iommu/omap-iommu.c       | 304 ++++++++++++++++++++++-------------
 drivers/iommu/omap-iommu.h       |  90 +++++------
 drivers/iommu/omap-iommu2.c      | 337 ---------------------------------------
 6 files changed, 298 insertions(+), 690 deletions(-)
 delete mode 100644 drivers/iommu/omap-iommu2.c

-- 
2.1.0

