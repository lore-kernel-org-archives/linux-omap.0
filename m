From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 6/6] ARM: OMAP: clock: split plat/clkdev_omap.h into OMAP1/2
 files
Date: Thu, 27 Sep 2012 10:33:35 -0600
Message-ID: <20120927163334.21755.32667.stgit@dusk.lan>
References: <20120927162800.21755.62891.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:46758 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729Ab2I0Qf5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Sep 2012 12:35:57 -0400
In-Reply-To: <20120927162800.21755.62891.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

To facilitate the ARM single image work, split
arch/arm/plat-omap/include/plat/clkdev_omap.h into the
arch/arm/mach-omap1/clock.h and arch/arm/mach-omap2/clock.h files.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap1/clock.c          |    1 -
 arch/arm/mach-omap1/clock.h          |   25 +++++++++++++++++++++++++
 arch/arm/mach-omap1/clock_data.c     |    1 -
 arch/arm/mach-omap1/opp_data.c       |    2 +-
 arch/arm/mach-omap2/clock.h          |   33 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/clock2420_data.c |    2 --
 arch/arm/mach-omap2/clock2430_data.c |    2 --
 arch/arm/mach-omap2/clock33xx_data.c |    1 -
 arch/arm/mach-omap2/clock3xxx_data.c |    2 --
 arch/arm/mach-omap2/clock44xx_data.c |    2 --
 10 files changed, 59 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 847b38a..dd568d8 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -26,7 +26,6 @@
 #include <plat/usb.h>
 #include "clock.h"
 #include <plat/sram.h>
-#include <plat/clkdev_omap.h>
 
 #include <mach/hardware.h>
 
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index 155ddd9..1e4918a 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -16,9 +16,34 @@
 #include <linux/clk.h>
 #include <linux/list.h>
 
+#include <linux/clkdev.h>
+
 struct module;
 struct clk;
 
+struct omap_clk {
+	u16				cpu;
+	struct clk_lookup		lk;
+};
+
+#define CLK(dev, con, ck, cp)		\
+	{				\
+		 .cpu = cp,		\
+		.lk = {			\
+			.dev_id = dev,	\
+			.con_id = con,	\
+			.clk = ck,	\
+		},			\
+	}
+
+/* Platform flags for the clkdev-OMAP integration code */
+#define CK_310		(1 << 0)
+#define CK_7XX		(1 << 1)	/* 7xx, 850 */
+#define CK_1510		(1 << 2)
+#define CK_16XX		(1 << 3)	/* 16xx, 17xx, 5912 */
+#define CK_1710		(1 << 4)	/* 1710 extra for rate selection */
+
+
 /* Temporary, needed during the common clock framework conversion */
 #define __clk_get_name(clk)	(clk->name)
 #define __clk_get_parent(clk)	(clk->parent)
diff --git a/arch/arm/mach-omap1/clock_data.c b/arch/arm/mach-omap1/clock_data.c
index 9c376f5..3c3590e 100644
--- a/arch/arm/mach-omap1/clock_data.c
+++ b/arch/arm/mach-omap1/clock_data.c
@@ -24,7 +24,6 @@
 
 #include "clock.h"
 #include <plat/cpu.h>
-#include <plat/clkdev_omap.h>
 #include <plat/sram.h>	/* for omap_sram_reprogram_clock() */
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-omap1/opp_data.c b/arch/arm/mach-omap1/opp_data.c
index 9cd4ddb..8dcebe6 100644
--- a/arch/arm/mach-omap1/opp_data.c
+++ b/arch/arm/mach-omap1/opp_data.c
@@ -10,7 +10,7 @@
  * published by the Free Software Foundation.
  */
 
-#include <plat/clkdev_omap.h>
+#include "clock.h"
 #include "opp.h"
 
 /*-------------------------------------------------------------------------
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index c3bf8c2..cfba1ff 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -19,6 +19,39 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 
+#include <linux/clkdev.h>
+
+struct omap_clk {
+	u16				cpu;
+	struct clk_lookup		lk;
+};
+
+#define CLK(dev, con, ck, cp)		\
+	{				\
+		 .cpu = cp,		\
+		.lk = {			\
+			.dev_id = dev,	\
+			.con_id = con,	\
+			.clk = ck,	\
+		},			\
+	}
+
+/* Platform flags for the clkdev-OMAP integration code */
+#define CK_242X		(1 << 0)
+#define CK_243X		(1 << 1)	/* 243x, 253x */
+#define CK_3430ES1	(1 << 2)	/* 34xxES1 only */
+#define CK_3430ES2PLUS	(1 << 3)	/* 34xxES2, ES3, non-Sitara 35xx only */
+#define CK_AM35XX	(1 << 4)	/* Sitara AM35xx */
+#define CK_36XX		(1 << 5)	/* 36xx/37xx-specific clocks */
+#define CK_443X		(1 << 6)
+#define CK_TI816X	(1 << 7)
+#define CK_446X		(1 << 8)
+#define CK_AM33XX	(1 << 9)	/* AM33xx specific clocks */
+
+
+#define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
+#define CK_3XXX		(CK_34XX | CK_AM35XX | CK_36XX)
+
 struct module;
 struct clk;
 struct clockdomain;
diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 5be7405f..ff47a6c 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -18,8 +18,6 @@
 #include <linux/clk.h>
 #include <linux/list.h>
 
-#include <plat/clkdev_omap.h>
-
 #include "soc.h"
 #include "iomap.h"
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 17f110d..cab8e9c 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -17,8 +17,6 @@
 #include <linux/clk.h>
 #include <linux/list.h>
 
-#include <plat/clkdev_omap.h>
-
 #include "soc.h"
 #include "iomap.h"
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/clock33xx_data.c b/arch/arm/mach-omap2/clock33xx_data.c
index aefcca2..8bb21ec 100644
--- a/arch/arm/mach-omap2/clock33xx_data.c
+++ b/arch/arm/mach-omap2/clock33xx_data.c
@@ -17,7 +17,6 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/clk.h>
-#include <plat/clkdev_omap.h>
 
 #include "am33xx.h"
 #include "iomap.h"
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index e75d0c8..a02d158 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -21,8 +21,6 @@
 #include <linux/list.h>
 #include <linux/io.h>
 
-#include <plat/clkdev_omap.h>
-
 #include "soc.h"
 #include "iomap.h"
 #include "clock.h"
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index c2450a6..a66eeae 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -28,8 +28,6 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/clkdev_omap.h>
-
 #include "soc.h"
 #include "iomap.h"
 #include "clock.h"


