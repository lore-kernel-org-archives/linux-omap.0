From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH 6/6] ARM: OMAP1: ams-delta: make board header file local to mach-omap1
Date: Fri, 18 May 2018 23:09:54 +0200
Message-ID: <20180518210954.29044-6-jmkrzyszt@gmail.com>
References: <20180518210954.29044-1-jmkrzyszt@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180518210954.29044-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Boris Brezillon <boris.brezillon@bootlin.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Mark Brown <broonie@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Richard Weinberger <richard@nod.at>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-mtd@lists.infradead.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>
List-Id: linux-omap@vger.kernel.org

Now as the AMS Delta board header file is no longer included by
drivers, move it to the root directory of mach-omap1.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
 arch/arm/mach-omap1/ams-delta-fiq-handler.S              | 2 +-
 arch/arm/mach-omap1/ams-delta-fiq.c                      | 3 +--
 arch/arm/mach-omap1/board-ams-delta.c                    | 2 +-
 arch/arm/mach-omap1/{include/mach => }/board-ams-delta.h | 0
 4 files changed, 3 insertions(+), 4 deletions(-)
 rename arch/arm/mach-omap1/{include/mach => }/board-ams-delta.h (100%)

diff --git a/arch/arm/mach-omap1/ams-delta-fiq-handler.S b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
index bf608441b357..9005c00db948 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq-handler.S
+++ b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
@@ -16,9 +16,9 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 
-#include <mach/board-ams-delta.h>
 #include <mach/ams-delta-fiq.h>
 
+#include "board-ams-delta.h"
 #include "iomap.h"
 #include "soc.h"
 
diff --git a/arch/arm/mach-omap1/ams-delta-fiq.c b/arch/arm/mach-omap1/ams-delta-fiq.c
index d7ca9e2b40d2..30aedcc3f2b3 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq.c
+++ b/arch/arm/mach-omap1/ams-delta-fiq.c
@@ -19,11 +19,10 @@
 #include <linux/module.h>
 #include <linux/io.h>
 
-#include <mach/board-ams-delta.h>
-
 #include <asm/fiq.h>
 
 #include <mach/ams-delta-fiq.h>
+#include "board-ams-delta.h"
 
 static struct fiq_handler fh = {
 	.name	= "ams-delta-fiq"
diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 80f54cb54276..17d69eb64df3 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -36,7 +36,6 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/board-ams-delta.h>
 #include <linux/platform_data/keypad-omap.h>
 #include <mach/mux.h>
 
@@ -45,6 +44,7 @@
 #include "camera.h"
 #include <mach/usb.h>
 
+#include "board-ams-delta.h"
 #include "iomap.h"
 #include "common.h"
 
diff --git a/arch/arm/mach-omap1/include/mach/board-ams-delta.h b/arch/arm/mach-omap1/board-ams-delta.h
similarity index 100%
rename from arch/arm/mach-omap1/include/mach/board-ams-delta.h
rename to arch/arm/mach-omap1/board-ams-delta.h
-- 
2.16.1
