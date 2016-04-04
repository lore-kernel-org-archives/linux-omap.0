From: Suman Anna <s-anna-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 0/4] Some OMAP IOMMU Cleanups
Date: Mon, 4 Apr 2016 17:46:17 -0500
Message-ID: <1459809981-37984-1-git-send-email-s-anna@ti.com>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Joerg,

Following are some minor cleanups to the OMAP IOMMU driver intended
for the next merge window.

Patch 1 fixes a crash when the IOMMU device is attempted to be unbound
from the driver using sysfs when no clients were attached to the MMU.
This is not a critical failure during normal usage flow. Feel free to
pick it up either for the -rc cycle or for the next merge window.

Remaining patches are trivial cleanups addressing some of the current
checkpatch warnings/checks.

regards
Suman

Suman Anna (4):
  iommu/omap: Remove iopgtable_clear_entry_all() from driver remove
  iommu/omap: Replace BUG() in iopgtable_store_entry_core()
  iommu/omap: Use WARN_ON for page table alignment check
  iommu/omap: Align code with open parenthesis

 drivers/iommu/omap-iommu-debug.c |  2 +-
 drivers/iommu/omap-iommu.c       | 10 +++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.7.4
