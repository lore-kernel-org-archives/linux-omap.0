From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v2 0/7] omap: iommu migration, relocation and cleanups
Date: Wed, 24 Aug 2011 20:08:07 +0300
Message-ID: <1314205694-28935-1-git-send-email-ohad@wizery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Joerg Roedel <Joerg.Roedel@amd.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, iommu@lists.linux-foundation.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

1. Migrate OMAP's iommu driver to the generic IOMMU API, and move it
to the dedicated iommu folder.

2. Fix omap3isp appropriately so it doesn't break.

3. Adapt OMAP's iovmm appropriately as well, because omap3isp still relies
on it. The plan is eventually to remove iovmm and replace it with the
upcoming IOMMU-based generic DMA-API. Move iovmm to the iommu folder too;
it belongs there more than it belongs in the OMAP folders.

4. Start cleaning up OMAP's iommu components towards the end goal, where
    1) omap-iommu no longer exports public API (and instead provides its
       entire functionality via the generic IOMMU API).
    2) omap-iovmm is removed.

Tested on OMAP3 (with omap3isp) and OMAP4 (with rpmsg/remoteproc).

v1->v2:
1. Added Laurent's and Hiroshi's Acked-by
2. iommu: use spinlock instead of mutex so attach/deattach can stay atomic (Joerg)
3. iovmm: remove obsolete comment (Hiroshi)
4. iommu: don't rename load_iotlb_entry directly (Hiroshi)
5. Rebase to 3.1-rc3

rfc->v1:
1. Migrate iommu, iovmm and omap3isp in a single patch for bisectibility sake.
2. Apply Laurent Pinchart's comments (thanks Laurent!)
3. Rebase to 3.1-rc2

Ohad Ben-Cohen (7):
  omap: iommu: migrate to the generic IOMMU API
  omap: iommu/iovmm: move to dedicated iommu folder
  omap: iommu: stop exporting local functions
  omap: iommu: PREFETCH_IOTLB cleanup
  omap: iovmm: remove unused functionality
  omap: iommu: remove unused exported API
  omap: iommu: omapify 'struct iommu' and exposed API

 arch/arm/mach-omap2/iommu2.c                       |   31 +-
 arch/arm/plat-omap/Kconfig                         |   12 -
 arch/arm/plat-omap/Makefile                        |    2 -
 arch/arm/plat-omap/include/plat/iommu.h            |   77 ++--
 arch/arm/plat-omap/include/plat/iommu2.h           |    4 +-
 arch/arm/plat-omap/{ => include/plat}/iopgtable.h  |   20 +-
 arch/arm/plat-omap/include/plat/iovmm.h            |   30 +-
 drivers/iommu/Kconfig                              |   18 +
 drivers/iommu/Makefile                             |    3 +
 .../iommu/omap-iommu-debug.c                       |   36 +-
 .../iommu.c => drivers/iommu/omap-iommu.c          |  511 +++++++++++++-------
 .../iovmm.c => drivers/iommu/omap-iovmm.c          |  338 +++----------
 drivers/media/video/Kconfig                        |    2 +-
 drivers/media/video/omap3isp/isp.c                 |   45 ++-
 drivers/media/video/omap3isp/isp.h                 |    5 +-
 drivers/media/video/omap3isp/ispccdc.c             |   25 +-
 drivers/media/video/omap3isp/ispstat.c             |   11 +-
 drivers/media/video/omap3isp/ispvideo.c            |    4 +-
 18 files changed, 612 insertions(+), 562 deletions(-)
 rename arch/arm/plat-omap/{ => include/plat}/iopgtable.h (82%)
 rename arch/arm/plat-omap/iommu-debug.c => drivers/iommu/omap-iommu-debug.c (91%)
 rename arch/arm/plat-omap/iommu.c => drivers/iommu/omap-iommu.c (61%)
 rename arch/arm/plat-omap/iovmm.c => drivers/iommu/omap-iovmm.c (63%)

-- 
1.7.4.1
