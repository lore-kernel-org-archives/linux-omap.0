From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/11] ARM: OMAP: Fix relative includes for shared i2c.h file
Date: Tue, 30 Oct 2012 16:52:53 -0700
Message-ID: <20121030235253.25936.83477.stgit@muffinssi.local>
References: <20121030234852.25936.12482.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:56300 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754464Ab2J3Xwy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 19:52:54 -0400
In-Reply-To: <20121030234852.25936.12482.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

As discussed on linux-arm-kernel, we want to avoid
relative includes for the arch/arm/*omap* shared code:

http://www.spinics.net/lists/linux-omap/msg80520.html

To fix this for the shared i2c.h, let's re-introduce
a minimal plat/i2c.h.

Note that drivers must not use this header as it will
break build for omap2+ CONFIG_MULTIPLATFORM builds.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/common.h          |    2 +-
 arch/arm/mach-omap1/i2c.c             |    2 +-
 arch/arm/mach-omap2/i2c.h             |    2 +-
 arch/arm/plat-omap/i2c.c              |    4 ++--
 arch/arm/plat-omap/include/plat/i2c.h |    0 
 5 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/arm/plat-omap/{i2c.h => include/plat/i2c.h} (100%)

diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index 26e19d3..3d40f6e 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -30,7 +30,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/i2c-omap.h>
 
-#include "../plat-omap/i2c.h"
+#include <plat/i2c.h>
 
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 void omap7xx_map_io(void);
diff --git a/arch/arm/mach-omap1/i2c.c b/arch/arm/mach-omap1/i2c.c
index 54097a2..faca808 100644
--- a/arch/arm/mach-omap1/i2c.c
+++ b/arch/arm/mach-omap1/i2c.c
@@ -23,7 +23,7 @@
 #include <mach/mux.h>
 #include "soc.h"
 
-#include "../plat-omap/i2c.h"
+#include <plat/i2c.h>
 
 #define OMAP_I2C_SIZE		0x3f
 #define OMAP1_I2C_BASE		0xfffb3800
diff --git a/arch/arm/mach-omap2/i2c.h b/arch/arm/mach-omap2/i2c.h
index 81dbb99..42b6f2e 100644
--- a/arch/arm/mach-omap2/i2c.h
+++ b/arch/arm/mach-omap2/i2c.h
@@ -19,7 +19,7 @@
  *
  */
 
-#include "../plat-omap/i2c.h"
+#include <plat/i2c.h>
 
 #ifndef __MACH_OMAP2_I2C_H
 #define __MACH_OMAP2_I2C_H
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index d094273..4645dd4 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -31,9 +31,9 @@
 #include <linux/err.h>
 #include <linux/clk.h>
 
-#include <mach/irqs.h>
+#include <plat/i2c.h>
 
-#include "i2c.h"
+#include <mach/irqs.h>
 
 #define OMAP_I2C_MAX_CONTROLLERS 4
 static struct omap_i2c_bus_platform_data i2c_pdata[OMAP_I2C_MAX_CONTROLLERS];
diff --git a/arch/arm/plat-omap/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
similarity index 100%
rename from arch/arm/plat-omap/i2c.h
rename to arch/arm/plat-omap/include/plat/i2c.h

