From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 00/11] Some OMAP IOMMU cleanup patches
Date: Mon, 20 Jul 2015 17:33:22 -0500
Message-ID: <1437431613-55656-1-git-send-email-s-anna@ti.com>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi Joerg,

The following series includes minor cleanup patches and checkpatch
fixes to the OMAP IOMMU driver. The first 5 patches do some cleanup
and some debugfs code rearrangement, while the last 6 patches deal
with the stricter checkpatch warnings/checks.

The series is baselined on 4.2-rc3 and should apply fine on any 4.2-rc.

regards
Suman

Suman Anna (11):
  Documentation: dt: Add #iommu-cells info to OMAP iommu bindings
  iommu/omap: Remove all module references
  iommu/omap: Move debugfs functions to omap-iommu-debug.c
  iommu/omap: Protect omap-iopgtable.h against double inclusion
  iommu/omap: Remove unused union fields
  iommu/omap: Remove trailing semi-colon from a macro
  iommu/omap: Remove unnecessary error traces on alloc failures
  iommu/omap: Use BIT(x) macros in omap-iopgtable.h
  iommu/omap: Use BIT(x) macros in omap-iommu.h
  iommu/omap: Align code with open parenthesis
  iommu/omap: Split multiple assignments into separate lines

 .../devicetree/bindings/iommu/ti,omap-iommu.txt    |   6 +
 drivers/iommu/omap-iommu-debug.c                   | 113 +++++++++++-
 drivers/iommu/omap-iommu.c                         | 204 +++------------------
 drivers/iommu/omap-iommu.h                         |  79 ++++----
 drivers/iommu/omap-iopgtable.h                     |  27 ++-
 5 files changed, 197 insertions(+), 232 deletions(-)

-- 
2.4.4
