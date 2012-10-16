From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/7] ARM: OMAP1: create read_reset_sources() function (for
 initial use by watchdog)
Date: Mon, 15 Oct 2012 19:32:11 -0600
Message-ID: <20121016013210.21844.77150.stgit@dusk.lan>
References: <20121016012448.21844.92339.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42854 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755452Ab2JPBe2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 21:34:28 -0400
In-Reply-To: <20121016012448.21844.92339.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On OMAP1, the existing OMAP watchdog driver reads a register directly
from a non-watchdog IP block.  It also does not convert the register's
contents into the standard WDIOF_* bits expected from the
GETBOOTSTATUS ioctl().

To move towards fixing these problems, create an function in
arch/arm/mach-omap1 to return the reset source data.  A subsequent
patch will provide this function to the watchdog driver via
platform_data.

In the long term, the best approach would be to move this function
to a new OMAP1 driver that handles access to the OMAP1 Clock
Generation and Reset Management IP block.  Then no platform_data would
be needed.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/common.h |    2 ++
 arch/arm/mach-omap1/reset.c  |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index c2552b2..e83fd70 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -90,4 +90,6 @@ extern int ocpi_enable(void);
 static inline int ocpi_enable(void) { return 0; }
 #endif
 
+extern u32 omap1_read_reset_sources(void);
+
 #endif /* __ARCH_ARM_MACH_OMAP1_COMMON_H */
diff --git a/arch/arm/mach-omap1/reset.c b/arch/arm/mach-omap1/reset.c
index b177091..3e894fb 100644
--- a/arch/arm/mach-omap1/reset.c
+++ b/arch/arm/mach-omap1/reset.c
@@ -8,8 +8,22 @@
 
 #include <mach/hardware.h>
 
+#include "iomap.h"
 #include "common.h"
 
+/* ARM_SYSST bit shifts related to SoC reset sources */
+#define ARM_SYSST_POR_SHIFT				5
+#define ARM_SYSST_EXT_RST_SHIFT				4
+#define ARM_SYSST_ARM_WDRST_SHIFT			2
+#define ARM_SYSST_GLOB_SWRST_SHIFT			1
+
+/* Standardized reset source bits (across all OMAP SoCs) */
+#define OMAP_GLOBAL_COLD_RST_SRC_ID_SHIFT		0
+#define OMAP_GLOBAL_WARM_RST_SRC_ID_SHIFT		1
+#define OMAP_MPU_WD_RST_SRC_ID_SHIFT			3
+#define OMAP_EXTWARM_RST_SRC_ID_SHIFT			5
+
+
 void omap1_restart(char mode, const char *cmd)
 {
 	/*
@@ -23,3 +37,28 @@ void omap1_restart(char mode, const char *cmd)
 
 	omap_writew(1, ARM_RSTCT1);
 }
+
+/**
+ * omap1_read_reset_sources - return the source of the SoC's last reset
+ *
+ * Returns bits that represent the last reset source for the SoC.  The
+ * format is standardized across OMAPs for use by the OMAP watchdog.
+ */
+u32 omap1_read_reset_sources(void)
+{
+	int ret = 0;
+	u16 rs;
+
+	rs = __raw_readw(OMAP1_IO_ADDRESS(ARM_SYSST));
+
+	if (rs & (1 << ARM_SYSST_POR_SHIFT))
+		ret |= 1 << OMAP_GLOBAL_COLD_RST_SRC_ID_SHIFT;
+	if (rs & (1 << ARM_SYSST_EXT_RST_SHIFT))
+		ret |= 1 << OMAP_EXTWARM_RST_SRC_ID_SHIFT;
+	if (rs & (1 << ARM_SYSST_ARM_WDRST_SHIFT))
+		ret |= 1 << OMAP_MPU_WD_RST_SRC_ID_SHIFT;
+	if (rs & (1 << ARM_SYSST_GLOB_SWRST_SHIFT))
+		ret |= 1 << OMAP_GLOBAL_WARM_RST_SRC_ID_SHIFT;
+
+	return ret;
+}


