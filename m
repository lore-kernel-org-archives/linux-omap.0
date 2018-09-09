From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v3 3/3] ARM: OMAP1: ams-delta: make board header file local to
 mach-omap1
Date: Mon, 10 Sep 2018 00:56:05 +0200
Message-ID: <20180909225605.16463-4-jmkrzyszt@gmail.com>
References: <20180717231448.14958-1-jmkrzyszt@gmail.com>
 <20180909225605.16463-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180909225605.16463-1-jmkrzyszt@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Richard Weinberger <richard@nod.at>, Linus Walleij <linus.walleij@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Boris Brezillon <boris.brezillon@bootlin.com>, linux-mtd@lists.infradead.org, linux-gpio@vger.kernel.org, Miquel Raynal <miquel.raynal@bootlin.com>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Marek Vasut <marek.vasut@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Now as board header file is no longer included by drivers, move it to
the root directory of mach-omap1.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/ams-delta-fiq-handler.S              | 2 +-
 arch/arm/mach-omap1/ams-delta-fiq.c                      | 3 +--
 arch/arm/mach-omap1/board-ams-delta.c                    | 2 +-
 arch/arm/mach-omap1/{include/mach => }/board-ams-delta.h | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)
 rename arch/arm/mach-omap1/{include/mach => }/board-ams-delta.h (98%)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq-handler.S b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
index ddc27638ba2a..2e2a17364dc9 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq-handler.S
+++ b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
@@ -17,9 +17,9 @@
 #include <linux/platform_data/ams-delta-fiq.h>
 
 #include <asm/assembler.h>
-#include <mach/board-ams-delta.h>
 
 #include "ams-delta-fiq.h"
+#include "board-ams-delta.h"
 #include "iomap.h"
 #include "soc.h"
 
diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index b0dc7ddf5877..14c3d3f5255e 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -22,11 +22,10 @@
 #include <linux/platform_data/ams-delta-fiq.h>
 #include <linux/platform_device.h>
 
-#include <mach/board-ams-delta.h>
-
 #include <asm/fiq.h>
 
 #include "ams-delta-fiq.h"
+#include "board-ams-delta.h"
 
 static struct fiq_handler fh = {
 	.name	= "ams-delta-fiq"
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index dd28d2614d7f..34cb63ff45b3 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -36,7 +36,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/board-ams-delta.h>
 #include <linux/platform_data/keypad-omap.h>
 #include <mach/mux.h>
 
@@ -45,6 +44,7 @@
 #include <mach/usb.h>
 
 #include "ams-delta-fiq.h"
+#include "board-ams-delta.h"
 #include "iomap.h"
 #include "common.h"
 
diff --git a/arch/arm/mach-omap1/include/mach/board-ams-delta.h b/arch/arm/mach-omap1/board-ams-delta.h
similarity index 98%
rename from arch/arm/mach-omap1/include/mach/board-ams-delta.h
rename to arch/arm/mach-omap1/board-ams-delta.h
index ad6f865d1f16..1fbada29431a 100644
--- a/arch/arm/mach-omap1/include/mach/board-ams-delta.h
+++ b/arch/arm/mach-omap1/board-ams-delta.h
@@ -1,5 +1,5 @@
 /*
- * arch/arm/plat-omap/include/mach/board-ams-delta.h
+ * arch/arm/mach-omap1/board-ams-delta.h
  *
  * Copyright (C) 2006 Jonathan McDowell <noodles@earth.li>
  *
-- 
2.16.4
