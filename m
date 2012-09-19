From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/29] ARM: OMAP1: Move board-ams-delta.h from plat to mach
Date: Wed, 19 Sep 2012 14:05:43 -0700
Message-ID: <20120919210543.28074.10214.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:42355 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751967Ab2ISVFq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:05:46 -0400
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-fbdev@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>, Artem Bityutskiy <Artem.Bityutskiy@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-mtd@lists.infradead.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>

This is only used by omap1.

And to fix things properly, this should not be included
from the drivers at all.

Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Artem Bityutskiy <Artem.Bityutskiy@linux.intel.com>
Cc: linux-mtd@lists.infradead.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lrg@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/ams-delta-fiq-handler.S        |    2 +-
 arch/arm/mach-omap1/ams-delta-fiq.c                |    2 +-
 arch/arm/mach-omap1/board-ams-delta.c              |    2 +-
 arch/arm/mach-omap1/include/mach/board-ams-delta.h |    0 
 drivers/input/serio/ams_delta_serio.c              |    2 +-
 drivers/mtd/nand/ams-delta.c                       |    2 +-
 drivers/video/omap/lcd_ams_delta.c                 |    2 +-
 sound/soc/omap/ams-delta.c                         |    2 +-
 8 files changed, 7 insertions(+), 7 deletions(-)
 rename arch/arm/{plat-omap/include/plat/board-ams-delta.h => mach-omap1/include/mach/board-ams-delta.h} (100%)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq-handler.S b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
index d2b6acc..3d1e1c2 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq-handler.S
+++ b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
@@ -16,7 +16,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 
-#include <plat/board-ams-delta.h>
+#include <mach/board-ams-delta.h>
 
 #include <mach/irqs.h>
 #include <mach/ams-delta-fiq.h>
diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index 68e8e56..f12a12a 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -19,7 +19,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 
-#include <plat/board-ams-delta.h>
+#include <mach/board-ams-delta.h>
 
 #include <asm/fiq.h>
 
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 05af063..b9929cb 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -35,7 +35,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/board-ams-delta.h>
+#include <mach/board-ams-delta.h>
 #include <plat/keypad.h>
 #include <mach/mux.h>
 
diff --git a/arch/arm/plat-omap/include/plat/board-ams-delta.h b/arch/arm/mach-omap1/include/mach/board-ams-delta.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/board-ams-delta.h
rename to arch/arm/mach-omap1/include/mach/board-ams-delta.h
diff --git a/drivers/input/serio/ams_delta_serio.c b/drivers/input/serio/ams_delta_serio.c
index f5fbdf9..45887e3 100644
--- a/drivers/input/serio/ams_delta_serio.c
+++ b/drivers/input/serio/ams_delta_serio.c
@@ -27,7 +27,7 @@
 #include <linux/module.h>
 
 #include <asm/mach-types.h>
-#include <plat/board-ams-delta.h>
+#include <mach/board-ams-delta.h>
 
 #include <mach/ams-delta-fiq.h>
 
diff --git a/drivers/mtd/nand/ams-delta.c b/drivers/mtd/nand/ams-delta.c
index c28eec0..9e7723a 100644
--- a/drivers/mtd/nand/ams-delta.c
+++ b/drivers/mtd/nand/ams-delta.c
@@ -29,7 +29,7 @@
 #include <asm/io.h>
 #include <asm/sizes.h>
 
-#include <plat/board-ams-delta.h>
+#include <mach/board-ams-delta.h>
 
 #include <mach/hardware.h>
 
diff --git a/drivers/video/omap/lcd_ams_delta.c b/drivers/video/omap/lcd_ams_delta.c
index 5cca6b3..ed4cad8 100644
--- a/drivers/video/omap/lcd_ams_delta.c
+++ b/drivers/video/omap/lcd_ams_delta.c
@@ -27,7 +27,7 @@
 #include <linux/lcd.h>
 #include <linux/gpio.h>
 
-#include <plat/board-ams-delta.h>
+#include <mach/board-ams-delta.h>
 
 #include "omapfb.h"
 
diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index 7b18b74..98e25d5 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -32,7 +32,7 @@
 
 #include <asm/mach-types.h>
 
-#include <plat/board-ams-delta.h>
+#include <mach/board-ams-delta.h>
 #include <plat/mcbsp.h>
 
 #include "omap-mcbsp.h"

