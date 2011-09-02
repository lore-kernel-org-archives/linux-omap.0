From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH/RFC 0/7] iommu: fixes & extensions
Date: Fri,  2 Sep 2011 20:32:29 +0300
Message-ID: <1314984756-4400-1-git-send-email-ohad@wizery.com>
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
To: iommu@lists.linux-foundation.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <Joerg.Roedel@amd.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, linux-kernel@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Brown <davidb@codeaurora.org>, linux-omap@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

5 first patches are relatively small iommu fixes/cleanups.

2 last patches are proposals for core iommu extensions:
- Add fault report mechanism, needed for recovery of remote processors
  trying to access unmapped addresses.
- Add splitting of memory regions to pages in the iommu core itself
  (according to hardware capabilities as advertised by the iommu drivers).
  This is needed to prevent duplication of this logic by
  the iommu users/drivers themselves.

The patches are based on Joerg's arm/omap branch.

Tested with OMAP3 (omap3isp) + OMAP4 (rpmsg/remoteproc).

Laurent Pinchart (1):
  iommu/omap-iovmm: support non page-aligned buffers in iommu_vmap

Ohad Ben-Cohen (6):
  iommu/omap: cleanup: remove a redundant 'return' statement
  iommu/core: use the existing IS_ALIGNED macro
  iommu/omap: ->unmap() should return order of unmapped page
  iommu/msm: ->unmap() should return order of unmapped page
  iommu/core: add fault reporting
  iommu/core: split mapping to page sizes as supported by the hardware

 arch/arm/plat-omap/include/plat/iommu.h |    3 +-
 drivers/iommu/iommu.c                   |  142 +++++++++++++++++++++++++++----
 drivers/iommu/msm_iommu.c               |   15 +++-
 drivers/iommu/omap-iommu.c              |   56 +++---------
 drivers/iommu/omap-iovmm.c              |   50 +++++++-----
 drivers/media/video/omap3isp/isp.c      |    2 +-
 include/linux/iommu.h                   |   67 ++++++++++++++-
 virt/kvm/iommu.c                        |    6 +-
 8 files changed, 251 insertions(+), 90 deletions(-)

-- 
1.7.4.1
