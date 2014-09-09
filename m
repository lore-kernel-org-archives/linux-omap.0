From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [PATCH 0/2] OMAP IOMMU cleanups
Date: Tue,  9 Sep 2014 18:45:43 +0300
Message-ID: <1410277545-32157-1-git-send-email-laurent.pinchart@ideasonboard.com>
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
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hello,

Those two patches clean up the OMAP IOMMU driver. Please see individual commit
messages for more information.

Laurent Pinchart (2):
  iommu/omap: Reverse dependency between omap-iommu and omap-iommu2
  iommu/omap: Remove omap_iommu unused owner field

 drivers/iommu/omap-iommu-debug.c |   6 ++-
 drivers/iommu/omap-iommu.c       | 103 ++++++++++++---------------------------
 drivers/iommu/omap-iommu.h       |  11 +++--
 drivers/iommu/omap-iommu2.c      |  18 +------
 4 files changed, 44 insertions(+), 94 deletions(-)

-- 
Regards,

Laurent Pinchart
