From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap iommu clean-up dependency branch for v3.8 merge window
Date: Wed, 21 Nov 2012 13:51:00 -0800
Message-ID: <20121121215059.GA5279@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-headers-iommu-signed

for you to fetch changes up to 2ab7c84815cffd5fe4946a472fc67fefa8ac3c29:

  ARM: OMAP2+: Move iommu/iovmm headers to platform_data (2012-11-20 10:05:01 -0800)

----------------------------------------------------------------
Move most of remaining omap iommu code to drivers/iommu.
This is needed for the multiplatform kernels as the plat
and mach headers cannot be included.

These changes were agreed to be merged via the arm-soc
tree by Joerg and Ohad as these will cause some merge
conflicts with the other related clean-up branches.

So omap-for-v3.8/cleanup-headers-iommu should be added
as one of the depends branches for arm-soc.

----------------------------------------------------------------
Ido Yariv (3):
      ARM: OMAP: Merge iommu2.h into iommu.h
      ARM: OMAP2+: Move iopgtable header to drivers/iommu/
      ARM: OMAP2+: Make some definitions local

Tony Lindgren (3):
      ARM: OMAP2+: Move plat/iovmm.h to include/linux/omap-iommu.h
      ARM: OMAP2+: Move iommu2 to drivers/iommu/omap-iommu2.c
      ARM: OMAP2+: Move iommu/iovmm headers to platform_data

 arch/arm/mach-omap2/Makefile                       |   2 -
 arch/arm/mach-omap2/devices.c                      |   2 +-
 arch/arm/mach-omap2/omap-iommu.c                   |   2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |   2 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c         |   2 +-
 arch/arm/plat-omap/include/plat/iommu2.h           |  96 ---------------
 arch/arm/plat-omap/include/plat/iovmm.h            |  89 --------------
 drivers/iommu/Makefile                             |   1 +
 drivers/iommu/omap-iommu-debug.c                   |   8 +-
 drivers/iommu/omap-iommu.c                         |  39 +++++-
 .../plat/iommu.h => drivers/iommu/omap-iommu.h     | 133 +++++++++++----------
 .../iommu2.c => drivers/iommu/omap-iommu2.c        |  11 +-
 .../iopgtable.h => drivers/iommu/omap-iopgtable.h  |  22 ----
 drivers/iommu/omap-iovmm.c                         |  50 +++++++-
 drivers/media/platform/omap3isp/isp.c              |   1 +
 drivers/media/platform/omap3isp/isp.h              |   4 +-
 drivers/media/platform/omap3isp/ispccdc.c          |   1 +
 drivers/media/platform/omap3isp/ispstat.c          |   1 +
 drivers/media/platform/omap3isp/ispvideo.c         |   3 +-
 include/linux/omap-iommu.h                         |  52 ++++++++
 include/linux/platform_data/iommu-omap.h           |  49 ++++++++
 21 files changed, 279 insertions(+), 291 deletions(-)
 delete mode 100644 arch/arm/plat-omap/include/plat/iommu2.h
 delete mode 100644 arch/arm/plat-omap/include/plat/iovmm.h
 rename arch/arm/plat-omap/include/plat/iommu.h => drivers/iommu/omap-iommu.h (69%)
 rename arch/arm/mach-omap2/iommu2.c => drivers/iommu/omap-iommu2.c (96%)
 rename arch/arm/plat-omap/include/plat/iopgtable.h => drivers/iommu/omap-iopgtable.h (85%)
 create mode 100644 include/linux/omap-iommu.h
 create mode 100644 include/linux/platform_data/iommu-omap.h
