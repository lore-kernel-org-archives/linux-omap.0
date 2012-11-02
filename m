From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/6] ARM: OMAP2+: Move iopgtable header to drivers/iommu/
Date: Fri, 02 Nov 2012 12:24:00 -0700
Message-ID: <20121102192400.4253.83596.stgit@muffinssi.local>
References: <20121102192221.4253.34303.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20121102192221.4253.34303.stgit@muffinssi.local>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Joerg Roedel <joro@8bytes.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Omar Ramirez Luna <omar.luna@linaro.org>, linux-omap@vger.kernel.org, Ido Yariv <ido@wizery.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Ido Yariv <ido@wizery.com>

The iopgtable header file is only used by the iommu & iovmm drivers, so
move it to drivers/iommu/, as part of the single zImage effort.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Omar Ramirez Luna <omar.luna@linaro.org>
Signed-off-by: Ido Yariv <ido@wizery.com>
[tony@atomide.com: updated to be earlier in the series]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/iommu/omap-iommu-debug.c            |    2 +-
 drivers/iommu/omap-iommu.c                  |    2 +-
 drivers/iommu/omap-iopgtable.h              |    0 
 drivers/iommu/omap-iovmm.c                  |    2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename arch/arm/plat-omap/include/plat/iopgtable.h => drivers/iommu/omap-iopgtable.h (100%)

diff --git a/drivers/iommu/omap-iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
index f55fc5d..0cac372 100644
--- a/drivers/iommu/omap-iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -22,7 +22,7 @@
 #include <plat/iommu.h>
 #include <plat/iovmm.h>
 
-#include <plat/iopgtable.h>
+#include "omap-iopgtable.h"
 
 #define MAXCOLUMN 100 /* for short messages */
 
diff --git a/drivers/iommu/omap-iommu.c b/drivers/iommu/omap-iommu.c
index d0b1234..f2bbfb0 100644
--- a/drivers/iommu/omap-iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -26,7 +26,7 @@
 
 #include <plat/iommu.h>
 
-#include <plat/iopgtable.h>
+#include "omap-iopgtable.h"
 
 #define for_each_iotlb_cr(obj, n, __i, cr)				\
 	for (__i = 0;							\
diff --git a/arch/arm/plat-omap/include/plat/iopgtable.h b/drivers/iommu/omap-iopgtable.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/iopgtable.h
rename to drivers/iommu/omap-iopgtable.h
diff --git a/drivers/iommu/omap-iovmm.c b/drivers/iommu/omap-iovmm.c
index 2e10c3e..b332392 100644
--- a/drivers/iommu/omap-iovmm.c
+++ b/drivers/iommu/omap-iovmm.c
@@ -24,7 +24,7 @@
 #include <plat/iommu.h>
 #include <plat/iovmm.h>
 
-#include <plat/iopgtable.h>
+#include "omap-iopgtable.h"
 
 static struct kmem_cache *iovm_area_cachep;
