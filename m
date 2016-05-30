From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 20/26] ARM: OMAP2: Use the platform_data header for omapdss
Date: Mon, 30 May 2016 14:42:52 +0300
Message-ID: <20160530114258.30879-21-peter.ujfalusi@ti.com>
References: <20160530114258.30879-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160530114258.30879-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, robdclark@gmail.com, airlied@linux.ie, tony@atomide.com
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, laurent.pinchart@ideasonboard.com, jsarha@ti.com, dri-devel@lists.freedesktop.org
List-Id: linux-omap@vger.kernel.org

Instead of the full omapdss internal header, include only the platform_data
header.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-ldp.c        | 2 +-
 arch/arm/mach-omap2/board-rx51-video.c | 2 +-
 arch/arm/mach-omap2/display.c          | 2 +-
 arch/arm/mach-omap2/dss-common.c       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index f364a1b779f0..390795b334c3 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -39,7 +39,7 @@
 #include "gpmc.h"
 #include "gpmc-smsc911x.h"
 
-#include <video/omapdss.h>
+#include <linux/platform_data/omapdss.h>
 #include <video/omap-panel-data.h>
 
 #include "board-flash.h"
diff --git a/arch/arm/mach-omap2/board-rx51-video.c b/arch/arm/mach-omap2/board-rx51-video.c
index 9866ec06a395..180c6aa633bd 100644
--- a/arch/arm/mach-omap2/board-rx51-video.c
+++ b/arch/arm/mach-omap2/board-rx51-video.c
@@ -15,7 +15,7 @@
 #include <linux/spi/spi.h>
 #include <linux/mm.h>
 #include <asm/mach-types.h>
-#include <video/omapdss.h>
+#include <linux/platform_data/omapdss.h>
 #include <video/omap-panel-data.h>
 
 #include <linux/platform_data/spi-omap2-mcspi.h>
diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 6ab13d18c636..70b3eaf085e4 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -29,7 +29,7 @@
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 
-#include <video/omapdss.h>
+#include <linux/platform_data/omapdss.h>
 #include "omap_hwmod.h"
 #include "omap_device.h"
 #include "omap-pm.h"
diff --git a/arch/arm/mach-omap2/dss-common.c b/arch/arm/mach-omap2/dss-common.c
index ea2be0f5953b..1d583bc0b1a9 100644
--- a/arch/arm/mach-omap2/dss-common.c
+++ b/arch/arm/mach-omap2/dss-common.c
@@ -27,7 +27,7 @@
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 
-#include <video/omapdss.h>
+#include <linux/platform_data/omapdss.h>
 #include <video/omap-panel-data.h>
 
 #include "soc.h"
-- 
2.8.3
