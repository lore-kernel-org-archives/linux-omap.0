From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: [PATCH v2 2/7] omap: iommu/iovmm: move to dedicated iommu folder
Date: Wed, 24 Aug 2011 20:08:09 +0300
Message-ID: <1314205694-28935-3-git-send-email-ohad@wizery.com>
References: <1314205694-28935-1-git-send-email-ohad@wizery.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57346 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752553Ab1HXRJF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Aug 2011 13:09:05 -0400
Received: by wwf5 with SMTP id 5so1445909wwf.1
        for <linux-omap@vger.kernel.org>; Wed, 24 Aug 2011 10:09:04 -0700 (PDT)
In-Reply-To: <1314205694-28935-1-git-send-email-ohad@wizery.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Joerg Roedel <Joerg.Roedel@amd.com>, Arnd Bergmann <arnd@arndb.de>, iommu@lists.linux-foundation.org, Ohad Ben-Cohen <ohad@wizery.com>

Move OMAP's iommu drivers to the dedicated iommu drivers folder.

While OMAP's iovmm (virtual memory manager) driver does not strictly
belong to the iommu drivers folder, move it there as well, because
it's by no means OMAP-specific (in concept. technically it is still
coupled with OMAP's iommu).

Eventually, iovmm will be completely replaced with the generic,
iommu-based, dma-mapping API.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/Kconfig                         |   14 --------------
 arch/arm/plat-omap/Makefile                        |    2 --
 arch/arm/plat-omap/{ => include/plat}/iopgtable.h  |    0
 drivers/iommu/Kconfig                              |   18 ++++++++++++++++++
 drivers/iommu/Makefile                             |    3 +++
 .../iommu/omap-iommu-debug.c                       |    2 +-
 .../iommu.c => drivers/iommu/omap-iommu.c          |    2 +-
 .../iovmm.c => drivers/iommu/omap-iovmm.c          |    2 +-
 drivers/media/video/Kconfig                        |    2 +-
 9 files changed, 25 insertions(+), 20 deletions(-)
 rename arch/arm/plat-omap/{ => include/plat}/iopgtable.h (100%)
 rename arch/arm/plat-omap/iommu-debug.c => drivers/iommu/omap-iommu-debug.c (99%)
 rename arch/arm/plat-omap/iommu.c => drivers/iommu/omap-iommu.c (99%)
 rename arch/arm/plat-omap/iovmm.c => drivers/iommu/omap-iovmm.c (99%)

diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index e1e954d..fa62037 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -132,20 +132,6 @@ config OMAP_MBOX_KFIFO_SIZE
 	  This can also be changed at runtime (via the mbox_kfifo_size
 	  module parameter).
 
-#can't be tristate; iommu api doesn't support un-registration
-config OMAP_IOMMU
-	bool
-	select IOMMU_API
-
-config OMAP_IOMMU_DEBUG
-       tristate "Export OMAP IOMMU internals in DebugFS"
-       depends on OMAP_IOMMU && DEBUG_FS
-       help
-         Select this to see extensive information about
-         the internal state of OMAP IOMMU in debugfs.
-
-         Say N unless you know you need this.
-
 config OMAP_IOMMU_IVA2
 	bool
 
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index f0233e6..9852622 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -18,8 +18,6 @@ obj-$(CONFIG_ARCH_OMAP3) += omap_device.o
 obj-$(CONFIG_ARCH_OMAP4) += omap_device.o
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
-obj-$(CONFIG_OMAP_IOMMU) += iommu.o iovmm.o
-obj-$(CONFIG_OMAP_IOMMU_DEBUG) += iommu-debug.o
 
 obj-$(CONFIG_CPU_FREQ) += cpu-omap.o
 obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
diff --git a/arch/arm/plat-omap/iopgtable.h b/arch/arm/plat-omap/include/plat/iopgtable.h
similarity index 100%
rename from arch/arm/plat-omap/iopgtable.h
rename to arch/arm/plat-omap/include/plat/iopgtable.h
diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index b57b3fa..432463b 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -107,4 +107,22 @@ config INTR_REMAP
 	  To use x2apic mode in the CPU's which support x2APIC enhancements or
 	  to support platforms with CPU's having > 8 bit APIC ID, say Y.
 
+# OMAP IOMMU support
+config OMAP_IOMMU
+	bool "OMAP IOMMU Support"
+	select IOMMU_API
+
+config OMAP_IOVMM
+	tristate
+	select OMAP_IOMMU
+
+config OMAP_IOMMU_DEBUG
+       tristate "Export OMAP IOMMU/IOVMM internals in DebugFS"
+       depends on OMAP_IOVMM && DEBUG_FS
+       help
+         Select this to see extensive information about
+         the internal state of OMAP IOMMU/IOVMM in debugfs.
+
+         Say N unless you know you need this.
+
 endif # IOMMU_SUPPORT
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 4d4d77d..f798cdd 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -3,3 +3,6 @@ obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o msm_iommu_dev.o
 obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o
 obj-$(CONFIG_DMAR) += dmar.o iova.o intel-iommu.o
 obj-$(CONFIG_INTR_REMAP) += dmar.o intr_remapping.o
+obj-$(CONFIG_OMAP_IOMMU) += omap-iommu.o
+obj-$(CONFIG_OMAP_IOVMM) += omap-iovmm.o
+obj-$(CONFIG_OMAP_IOMMU_DEBUG) += omap-iommu-debug.o
diff --git a/arch/arm/plat-omap/iommu-debug.c b/drivers/iommu/omap-iommu-debug.c
similarity index 99%
rename from arch/arm/plat-omap/iommu-debug.c
rename to drivers/iommu/omap-iommu-debug.c
index f07cf2f..0f8c8dd 100644
--- a/arch/arm/plat-omap/iommu-debug.c
+++ b/drivers/iommu/omap-iommu-debug.c
@@ -21,7 +21,7 @@
 #include <plat/iommu.h>
 #include <plat/iovmm.h>
 
-#include "iopgtable.h"
+#include <plat/iopgtable.h>
 
 #define MAXCOLUMN 100 /* for short messages */
 
diff --git a/arch/arm/plat-omap/iommu.c b/drivers/iommu/omap-iommu.c
similarity index 99%
rename from arch/arm/plat-omap/iommu.c
rename to drivers/iommu/omap-iommu.c
index 51aa008..bf8de64 100644
--- a/arch/arm/plat-omap/iommu.c
+++ b/drivers/iommu/omap-iommu.c
@@ -26,7 +26,7 @@
 
 #include <plat/iommu.h>
 
-#include "iopgtable.h"
+#include <plat/iopgtable.h>
 
 #define for_each_iotlb_cr(obj, n, __i, cr)				\
 	for (__i = 0;							\
diff --git a/arch/arm/plat-omap/iovmm.c b/drivers/iommu/omap-iovmm.c
similarity index 99%
rename from arch/arm/plat-omap/iovmm.c
rename to drivers/iommu/omap-iovmm.c
index aa2c478..809ca12 100644
--- a/arch/arm/plat-omap/iovmm.c
+++ b/drivers/iommu/omap-iovmm.c
@@ -23,7 +23,7 @@
 #include <plat/iommu.h>
 #include <plat/iovmm.h>
 
-#include "iopgtable.h"
+#include <plat/iopgtable.h>
 
 /*
  * A device driver needs to create address mappings between:
diff --git a/drivers/media/video/Kconfig b/drivers/media/video/Kconfig
index f574dc0..6a25fad 100644
--- a/drivers/media/video/Kconfig
+++ b/drivers/media/video/Kconfig
@@ -763,7 +763,7 @@ source "drivers/media/video/m5mols/Kconfig"
 
 config VIDEO_OMAP3
 	tristate "OMAP 3 Camera support (EXPERIMENTAL)"
-	select OMAP_IOMMU
+	select OMAP_IOVMM
 	depends on VIDEO_V4L2 && I2C && VIDEO_V4L2_SUBDEV_API && ARCH_OMAP3 && EXPERIMENTAL
 	---help---
 	  Driver for an OMAP 3 camera controller.
-- 
1.7.4.1

