From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 4/4] ARM: OMAP1: Move SoC specific headers from plat to mach
	for omap1
Date: Fri, 31 Aug 2012 17:26:30 -0700
Message-ID: <20120901002630.23715.39417.stgit@muffinssi.local>
References: <20120901002534.23715.28654.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120901002534.23715.28654.stgit-t/zwCYRDW5/25TI67NSWRg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

There's no need to have these in plat-omap any longer. Note that these
could eventually be made local to mach-omap1 instead of being in mach.

But to do that, at least various driver access using omap7xxx.h registers
needs to be fixed first.

Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/mach-omap1/board-htcherald.c       |    4 ++--
 arch/arm/mach-omap1/devices.c               |    2 +-
 arch/arm/mach-omap1/include/mach/hardware.h |    6 +++---
 arch/arm/mach-omap1/include/mach/omap1510.h |    3 +--
 arch/arm/mach-omap1/include/mach/omap16xx.h |    3 +--
 arch/arm/mach-omap1/include/mach/omap7xx.h  |    3 +--
 drivers/spi/spi-omap-uwire.c                |    3 ++-
 7 files changed, 11 insertions(+), 13 deletions(-)
 rename arch/arm/{plat-omap/include/plat/omap1510.h => mach-omap1/include/mach/omap1510.h} (97%)
 rename arch/arm/{plat-omap/include/plat/omap16xx.h => mach-omap1/include/mach/omap16xx.h} (99%)
 rename arch/arm/{plat-omap/include/plat/omap7xx.h => mach-omap1/include/mach/omap7xx.h} (98%)

diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index bdb94fe..4fe4884 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -37,14 +37,14 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
 #include <linux/omapfb.h>
+#include <linux/platform_data/keypad-omap.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <plat/omap7xx.h>
-#include <linux/platform_data/keypad-omap.h>
 #include <plat/mmc.h>
 
+#include <mach/omap7xx.h>
 #include <mach/irqs.h>
 #include <mach/usb.h>
 
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 1feca35..05fdbd9 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -23,8 +23,8 @@
 #include <plat/mux.h>
 #include <plat/dma.h>
 #include <plat/mmc.h>
-#include <plat/omap7xx.h>
 
+#include <mach/omap7xx.h>
 #include <mach/camera.h>
 #include <mach/hardware.h>
 
diff --git a/arch/arm/mach-omap1/include/mach/hardware.h b/arch/arm/mach-omap1/include/mach/hardware.h
index bd3b95e..84248d2 100644
--- a/arch/arm/mach-omap1/include/mach/hardware.h
+++ b/arch/arm/mach-omap1/include/mach/hardware.h
@@ -311,8 +311,8 @@ static inline u32 omap_cs3_phys(void)
  * ---------------------------------------------------------------------------
  */
 
-#include <plat/omap7xx.h>
-#include <plat/omap1510.h>
-#include <plat/omap16xx.h>
+#include "omap7xx.h"
+#include "omap1510.h"
+#include "omap16xx.h"
 
 #endif	/* __ASM_ARCH_OMAP_HARDWARE_H */
diff --git a/arch/arm/plat-omap/include/plat/omap1510.h b/arch/arm/mach-omap1/include/mach/omap1510.h
similarity index 97%
rename from arch/arm/plat-omap/include/plat/omap1510.h
rename to arch/arm/mach-omap1/include/mach/omap1510.h
index d240046..8fe05d6 100644
--- a/arch/arm/plat-omap/include/plat/omap1510.h
+++ b/arch/arm/mach-omap1/include/mach/omap1510.h
@@ -1,5 +1,4 @@
-/* arch/arm/plat-omap/include/mach/omap1510.h
- *
+/*
  * Hardware definitions for TI OMAP1510 processor.
  *
  * Cleanup for Linux-2.6 by Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
diff --git a/arch/arm/plat-omap/include/plat/omap16xx.h b/arch/arm/mach-omap1/include/mach/omap16xx.h
similarity index 99%
rename from arch/arm/plat-omap/include/plat/omap16xx.h
rename to arch/arm/mach-omap1/include/mach/omap16xx.h
index e69e1d8..cd1c724 100644
--- a/arch/arm/plat-omap/include/plat/omap16xx.h
+++ b/arch/arm/mach-omap1/include/mach/omap16xx.h
@@ -1,5 +1,4 @@
-/* arch/arm/plat-omap/include/mach/omap16xx.h
- *
+/*
  * Hardware definitions for TI OMAP1610/5912/1710 processors.
  *
  * Cleanup for Linux-2.6 by Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
diff --git a/arch/arm/plat-omap/include/plat/omap7xx.h b/arch/arm/mach-omap1/include/mach/omap7xx.h
similarity index 98%
rename from arch/arm/plat-omap/include/plat/omap7xx.h
rename to arch/arm/mach-omap1/include/mach/omap7xx.h
index 48e4757..63da994 100644
--- a/arch/arm/plat-omap/include/plat/omap7xx.h
+++ b/arch/arm/mach-omap1/include/mach/omap7xx.h
@@ -1,5 +1,4 @@
-/* arch/arm/plat-omap/include/mach/omap7xx.h
- *
+/*
  * Hardware definitions for TI OMAP7XX processor.
  *
  * Cleanup for Linux-2.6 by Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index 9b0d716..a3996a1 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -53,7 +53,8 @@
 #include <asm/mach-types.h>
 
 #include <plat/mux.h>
-#include <plat/omap7xx.h>	/* OMAP7XX_IO_CONF registers */
+
+#include <mach/omap7xx.h>	/* OMAP7XX_IO_CONF registers */
 
 
 /* FIXME address is now a platform device resource,


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
