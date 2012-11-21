From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/5] ARM: OMAP: Move plat/omap-serial.h to
 include/linux/platform_data/serial-omap.h
Date: Wed, 21 Nov 2012 09:42:30 -0800
Message-ID: <20121121174230.25576.64507.stgit@muffinssi.local>
References: <20121121174201.25576.61961.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20121121174201.25576.61961.stgit@muffinssi.local>
Sender: linux-serial-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

We need to move this file to allow ARM multiplatform configurations
to build for omap2+. This can now be done as this file now only
contains platform_data.

cc: Russell King <linux@arm.linux.org.uk>
cc: Alan Cox <alan@linux.intel.com>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
cc: Govindraj.R <govindraj.raja@ti.com>
cc: Kevin Hilman <khilman@ti.com>
cc: Felipe Balbi <balbi@ti.com>
cc: linux-serial@vger.kernel.org
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/serial.c                  |    4 +---
 drivers/tty/serial/omap-serial.c              |    3 +--
 include/linux/platform_data/serial-omap.h     |    0 
 3 files changed, 2 insertions(+), 5 deletions(-)
 rename arch/arm/plat-omap/include/plat/omap-serial.h => include/linux/platform_data/serial-omap.h (100%)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index aa30a3c..25c799b 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -26,9 +26,7 @@
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 #include <linux/console.h>
-
-#include <plat/omap-serial.h>
-#include <plat-omap/dma-omap.h>
+#include <linux/platform_data/serial-omap.h>
 
 #include "common.h"
 #include "omap_hwmod.h"
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 17babde..0240aa8 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -41,8 +41,7 @@
 #include <linux/of.h>
 #include <linux/gpio.h>
 #include <linux/pinctrl/consumer.h>
-
-#include <plat/omap-serial.h>
+#include <linux/platform_data/serial-omap.h>
 
 #define OMAP_MAX_HSUART_PORTS	6
 
diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/include/linux/platform_data/serial-omap.h
similarity index 100%
rename from arch/arm/plat-omap/include/plat/omap-serial.h
rename to include/linux/platform_data/serial-omap.h

