From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 2/3] mfd: tps65010: move header file out of I2C realm
Date: Mon, 22 May 2017 00:02:09 +0200
Message-ID: <20170521220212.1404-3-wsa@the-dreams.de>
References: <20170521220212.1404-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170521220212.1404-1-wsa@the-dreams.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-i2c@vger.kernel.org
Cc: Felipe Balbi <balbi@kernel.org>, linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@armlinux.org.uk>, Krzysztof Kozlowski <krzk@kernel.org>, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kukjin Kim <kgene@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

include/linux/i2c is not for client devices. Move the header file to a
more appropriate location.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 arch/arm/mach-omap1/board-h2-mmc.c      | 2 +-
 arch/arm/mach-omap1/board-h2.c          | 2 +-
 arch/arm/mach-omap1/board-h3-mmc.c      | 2 +-
 arch/arm/mach-omap1/board-h3.c          | 2 +-
 arch/arm/mach-omap1/board-osk.c         | 2 +-
 arch/arm/mach-s3c24xx/mach-osiris-dvs.c | 2 +-
 arch/arm/mach-s3c24xx/mach-osiris.c     | 2 +-
 drivers/mfd/tps65010.c                  | 2 +-
 drivers/usb/host/ohci-omap.c            | 2 +-
 drivers/usb/phy/phy-isp1301-omap.c      | 2 +-
 drivers/video/fbdev/omap/lcd_h3.c       | 2 +-
 include/linux/{i2c => mfd}/tps65010.h   | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)
 rename include/linux/{i2c => mfd}/tps65010.h (99%)

diff --git a/arch/arm/mach-omap1/board-h2-mmc.c b/arch/arm/mach-omap1/board-h2-mmc.c
index 357be2debc9da8..91bda9c802ff38 100644
--- a/arch/arm/mach-omap1/board-h2-mmc.c
+++ b/arch/arm/mach-omap1/board-h2-mmc.c
@@ -14,7 +14,7 @@
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/gpio-omap.h>
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 
 #include "board-h2.h"
 #include "mmc.h"
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 675254ee4b1e93..dece47d76282ac 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -28,7 +28,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/input.h>
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 #include <linux/smc91x.h>
 #include <linux/omapfb.h>
 #include <linux/platform_data/gpio-omap.h>
diff --git a/arch/arm/mach-omap1/board-h3-mmc.c b/arch/arm/mach-omap1/board-h3-mmc.c
index 4f58bfa5e7549e..692c267a9a9052 100644
--- a/arch/arm/mach-omap1/board-h3-mmc.c
+++ b/arch/arm/mach-omap1/board-h3-mmc.c
@@ -14,7 +14,7 @@
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
 
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 
 #include "common.h"
 #include "board-h3.h"
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index e62f9d454f1005..6d32beeb2d8857 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -28,7 +28,7 @@
 #include <linux/mtd/physmap.h>
 #include <linux/input.h>
 #include <linux/spi/spi.h>
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 #include <linux/smc91x.h>
 #include <linux/omapfb.h>
 #include <linux/platform_data/gpio-omap.h>
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 4dfb995048103b..f20361b8ffb6e0 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -38,7 +38,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/omap1_bl.h>
 
diff --git a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
index 262ab07447483a..6cac7da15e2b0d 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris-dvs.c
@@ -17,7 +17,7 @@
 #include <linux/cpufreq.h>
 #include <linux/gpio.h>
 
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 
 #include <plat/cpu-freq.h>
 #include <mach/gpio-samsung.h>
diff --git a/arch/arm/mach-s3c24xx/mach-osiris.c b/arch/arm/mach-s3c24xx/mach-osiris.c
index 70b0eb7d31347f..64b1a0b7b803a1 100644
--- a/arch/arm/mach-s3c24xx/mach-osiris.c
+++ b/arch/arm/mach-s3c24xx/mach-osiris.c
@@ -24,7 +24,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
diff --git a/drivers/mfd/tps65010.c b/drivers/mfd/tps65010.c
index d829a6131f09e5..2ab67386b4ef1e 100644
--- a/drivers/mfd/tps65010.c
+++ b/drivers/mfd/tps65010.c
@@ -32,7 +32,7 @@
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 
 #include <linux/gpio/driver.h>
 
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index a4d814b7f38066..91393ec7d8503c 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -53,7 +53,7 @@
 #define DRIVER_DESC "OHCI OMAP driver"
 
 #ifdef CONFIG_TPS65010
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 #else
 
 #define LOW	0
diff --git a/drivers/usb/phy/phy-isp1301-omap.c b/drivers/usb/phy/phy-isp1301-omap.c
index 042c5a8fd423d8..c6052c814bcc24 100644
--- a/drivers/usb/phy/phy-isp1301-omap.c
+++ b/drivers/usb/phy/phy-isp1301-omap.c
@@ -96,7 +96,7 @@ struct isp1301 {
 
 #if IS_REACHABLE(CONFIG_TPS65010)
 
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 
 #else
 
diff --git a/drivers/video/fbdev/omap/lcd_h3.c b/drivers/video/fbdev/omap/lcd_h3.c
index 9d2da146813ef0..796f4634c4c6f1 100644
--- a/drivers/video/fbdev/omap/lcd_h3.c
+++ b/drivers/video/fbdev/omap/lcd_h3.c
@@ -21,7 +21,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
-#include <linux/i2c/tps65010.h>
+#include <linux/mfd/tps65010.h>
 #include <linux/gpio.h>
 
 #include "omapfb.h"
diff --git a/include/linux/i2c/tps65010.h b/include/linux/mfd/tps65010.h
similarity index 99%
rename from include/linux/i2c/tps65010.h
rename to include/linux/mfd/tps65010.h
index 08aa92278d71cd..a1fb9bc5311de4 100644
--- a/include/linux/i2c/tps65010.h
+++ b/include/linux/mfd/tps65010.h
@@ -1,4 +1,4 @@
-/* linux/i2c/tps65010.h
+/* linux/mfd/tps65010.h
  *
  * Functions to access TPS65010 power management device.
  *
-- 
2.11.0
