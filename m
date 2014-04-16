From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: [GIT PULL v2 FOR v3.16] OMAP IOMMU fixes
Date: Wed, 16 Apr 2014 16:51:56 +0200
Message-ID: <1527771.aIpQeXENtj@avalon>
References: <2312051.xNuD1CfeZH@avalon> <20140416140107.GA3627@8bytes.org>
	<6806421.DjEURPCCWM@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <6806421.DjEURPCCWM@avalon>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Joerg,

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://linuxtv.org/pinchartl/media.git iommu/omap

for you to fetch changes up to 286f600bc890347f7ec7bd50d33210d53a9095a3:

  iommu/omap: Fix map protection value handling (2014-04-16 16:30:18 +0200)

Compared to the v1 pull request, the patches have been rebased directly on top 
of v3.15-rc1.

----------------------------------------------------------------
Laurent Pinchart (3):
      iommu/omap: Fix 'no page for' debug message in flush_iotlb_page()
      iommu/omap: Remove comment about supporting single page mappings only
      iommu/omap: Fix map protection value handling

Suman Anna (3):
      iommu/omap: Correct init value of iotlb_entry valid field
      iommu/omap: Remove omap_iommu_domain_has_cap() function
      iommu/omap: Move to_iommu definition from omap-iopgtable.h

 drivers/iommu/omap-iommu.c     | 31 ++++++++++++-------------------
 drivers/iommu/omap-iopgtable.h |  3 ---
 2 files changed, 12 insertions(+), 22 deletions(-)

-- 
Regards,

Laurent Pinchart
