From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/7] iommu/omap: Add support for iommu-groups and 'struct
	iommu_device'
Date: Wed, 12 Apr 2017 00:21:25 -0500
Message-ID: <20170412052132.14406-1-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Joerg,

I have taken the liberty of refreshing the series you have posted
based on my testing and review comments. My unit tests are passing
now with the series. I have summarized the changes below and also
outlined the changes in each patch.

Laurent,
I cannot test the OMAP3 ISP, so request you to verify that the
OMAP3ISP driver functionality is maintained. I have created the
last patch separately for now since it's a separate subsystem,
but ideally I think it should go with the patch that adds the
iommu-group support. I am not sure how we want to merge this
patch.

Changes in v3:
 * Added 3 new patches
    - The first patch now results in the OMAP IOMMU devices being
      probed before the callbacks kick in. This allowed me to go
      back and use the patches from v1 where the IOMMU groups are
      added in probe.
    - The second patch drops the non-DT IOMMU device support so
      that the name can be dropped from the platform data as well.
    - Patch 7 fixes the OMAP3ISP driver after the addition of the
      IOMMU group support.
 * Squashed the "iommu/omap: Set dev->archdata.iommu = NULL in
   omap_iommu_remove_device" patch into Patch 4
 * Failure path cleanups in patches 4, 5 and 6

Changes in v2:
 * Dropped patch 2 and moved device-link and
   group-handling to attach/detach_dev call-backs for
   now.

Joerg Roedel (4):
  iommu/omap: Move data structures to omap-iommu.h
  iommu/omap: Store iommu_dev pointer in arch_data
  iommu/omap: Make use of 'struct iommu_device'
  iommu/omap: Add iommu-group support

Suman Anna (3):
  iommu/omap: Register driver before setting IOMMU ops
  iommu/omap: Drop legacy-style device support
  [media] omap3isp: Remove iommu_group related code

 drivers/iommu/omap-iommu.c               | 190 ++++++++++++++++++++-----------
 drivers/iommu/omap-iommu.h               |  34 ++++++
 drivers/media/platform/omap3isp/isp.c    |  17 ---
 drivers/media/platform/omap3isp/isp.h    |   1 -
 include/linux/platform_data/iommu-omap.h |  20 ----
 5 files changed, 156 insertions(+), 106 deletions(-)

-- 
2.12.0
