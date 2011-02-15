From: David Cohen <dacohen@gmail.com>
Subject: [PATCH v2 0/1] OMAP: IOMMU fault callback support
Date: Tue, 15 Feb 2011 16:36:30 +0200
Message-ID: <1297780591-15613-1-git-send-email-dacohen@gmail.com>
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
To: Hiroshi.DOYU@nokia.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

v2:

Previous patch 1/2 on v1 was dropped.

---

v1:

This patch set adds fault callback support to allow IOMMU users to debug or
react when a fault happens.
IOMMU faults might be very difficult to reproduce and then to figure out
the source of the problem. Currently IOMMU driver prints not so useful
debug message and does not notice user about such issue.
With a fault callback, IOMMU user may debug much more useful information
and/or react to go back to a valid state.

Br,

David
---

David Cohen (1):
  OMAP: IOMMU: add support to callback during fault handling

 arch/arm/mach-omap2/iommu2.c            |   21 +++++++++++++--
 arch/arm/plat-omap/include/plat/iommu.h |   15 ++++++++++-
 arch/arm/plat-omap/iommu.c              |   41 ++++++++++++++++++++++++++++---
 3 files changed, 69 insertions(+), 8 deletions(-)

-- 
1.7.2.3
