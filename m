From: Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 00/17] OMAP IOMMU Cleanup & Consolidation
Date: Wed, 22 Oct 2014 17:22:18 -0500
Message-ID: <1414016555-28067-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46473 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933496AbaJVWWw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Oct 2014 18:22:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, Suman Anna <s-anna@ti.com>

Hi,

This is an updated version of the OMAP IOMMU Cleanup & Consolidation
patch series [1], rebased onto 3.18-rc1. The update addresses
comments on patch 12 [2] from the previous series, there are no
changes to any of the other patches.

The series is intended for the 3.19 merge window. A reference branch
with all these patches is available is hosted at [3].

Following is the summary of changes in v2:
- Series rebased to 3.18-rc1.
- Added back the OMAP_IOMMU_DEBUG Kconfig option that was removed
  in v1 in Patch 12. This allows the debugfs portions to be built
  conditionally.
- Added the Acked-by received from Laurent on all patches except
  Patch 12.
- Patches 13 through 17 have no code changes but have to rebased
  because of the updates to Patch 12.

v1:
- See [1] for details

regards
Suman

[1] http://marc.info/?l=linux-omap&m=141211179711402&w=2
[2] https://patchwork.kernel.org/patch/5007261/
[3] https://github.com/sumananna/omap-kernel/commits/iommu/submit/3.18-rc1-cleanup-consolidation-v2

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

 drivers/iommu/Kconfig            |  12 +-
 drivers/iommu/Makefile           |   1 -
 drivers/iommu/omap-iommu-debug.c | 242 ++++++++--------------------
 drivers/iommu/omap-iommu.c       | 306 ++++++++++++++++++++++-------------
 drivers/iommu/omap-iommu.h       |  98 ++++++------
 drivers/iommu/omap-iommu2.c      | 337 ---------------------------------------
 6 files changed, 312 insertions(+), 684 deletions(-)
 delete mode 100644 drivers/iommu/omap-iommu2.c

-- 
2.1.0

