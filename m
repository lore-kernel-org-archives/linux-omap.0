From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 0/6] omap: iommu: hwmod support and code reorganization
Date: Fri,  5 Nov 2010 19:19:50 -0600
Message-ID: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43054 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752950Ab0KFBae (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 5 Nov 2010 21:30:34 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Russell King <linux@arm.linux.org.uk>, Hari Kanigeri <h-kanigeri2@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, Charulatha V <charu@ti.com>, Ramesh Gupta <grgupta@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Boot tested on omap 3430 and 3630, functionality on iva2 only.

Introduced hwmod data and support for omap3 (iva2 mmu & isp mmu) and
omap4 (ducati mmu & tesla mmu).

Minor cleanup due to this changes.

There is an issue (present without patches too):

Doing a cycle of insmod-rmmod to iommu module and then full
insmod of bridgedriver (with all dependencies) causes the next
read of iommu registers to dump an unhandled fault log; this,
because when rmmod of iommu is called it tries to clean the
iommu tables and flush any old entry prior to removing the driver,
however these reads/writes are attempted while the MMU is under
reset and will timeout on the L3 IVA target agent, which will leave
MMU unusable until the proper restore sequence to clear this L3
error is executed.

Fix would be to move page table allocation to iommu get and its
correspondent free to iommu put, however it will fall entirely
under iommu user responsibility, as it needs to clear the mmu
reset bit, before calling iommu functions that read/write into
mmu registers (which should apply only for first boot or on
baseimage reload); trading this restriction in order to keep
the same generic iommu code for all omap iommu devices.

This issue has been seen on omap3 iva2 mmu, same restriction should
apply for tesla mmu.

For discussion: should iommu handle mmu reset source directly?
This register is grouped into an IVA PRM register which handles
sequencer, iva2 mmu and dsp resets. As mentioned iommu handles
cam, iva2 mmu (OMAP3) and tesla, ducati mmu (OMAP4), only tesla
and iva2 should suffer from this restriction and according changes
should be needed to handle both cases on mach-omap2 code. This
also affects hwmod, since, if defined, it tries to read SYSC
registers at boot time when registering the hwmod and causing the
same issue.

Omar Ramirez Luna (6):
  omap: iommu: remove redundant clock usage
  OMAP3: hwmod data: Add mmu for iva2 and isp
  OMAP4: hwmod data: add mmu hwmod for ducati and tesla
  omap: iommu: intial hwmod support
  omap: iommu: hwmod device enable/disable routines
  omap: iommu: code reorganization and cleanup

 arch/arm/mach-omap2/omap-iommu.c           |  168 +++++++++-------------------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  103 +++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |  105 +++++++++++++++++
 arch/arm/plat-omap/include/plat/iommu.h    |   19 +++-
 arch/arm/plat-omap/include/plat/omap34xx.h |    2 +
 arch/arm/plat-omap/iommu.c                 |   64 ++++-------
 6 files changed, 299 insertions(+), 162 deletions(-)

