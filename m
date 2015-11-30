From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/7] ARM: omap1: make headers more local
Date: Tue,  1 Dec 2015 00:00:52 +0100
Message-ID: <1448924458-3279040-2-git-send-email-arnd@arndb.de>
References: <1448924458-3279040-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1448924458-3279040-1-git-send-email-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Wan ZongShun <mcuos.com@gmail.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Arnd Bergmann <arnd@arndb.de>, Greg Ungerer <gerg@uclinux.org>, Gregory Clement <gregory.clement@free-electrons.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Some header files are never included outside of a mach-omap1
directory and do not need to be made visible in include/mach,
so let's just move them all down one level.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap1/board-ams-delta.c              | 2 +-
 arch/arm/mach-omap1/board-fsample.c                | 2 +-
 arch/arm/mach-omap1/board-h2.c                     | 2 +-
 arch/arm/mach-omap1/board-h3.c                     | 2 +-
 arch/arm/mach-omap1/board-innovator.c              | 2 +-
 arch/arm/mach-omap1/board-osk.c                    | 2 +-
 arch/arm/mach-omap1/board-palmte.c                 | 2 +-
 arch/arm/mach-omap1/board-palmtt.c                 | 2 +-
 arch/arm/mach-omap1/board-palmz71.c                | 2 +-
 arch/arm/mach-omap1/board-perseus2.c               | 2 +-
 arch/arm/mach-omap1/board-sx1-mmc.c                | 2 +-
 arch/arm/mach-omap1/board-sx1.c                    | 4 ++--
 arch/arm/mach-omap1/{include/mach => }/board-sx1.h | 0
 arch/arm/mach-omap1/{include/mach => }/camera.h    | 0
 arch/arm/mach-omap1/devices.c                      | 2 +-
 arch/arm/mach-omap1/flash.c                        | 2 +-
 arch/arm/mach-omap1/{include/mach => }/flash.h     | 0
 17 files changed, 15 insertions(+), 15 deletions(-)
 rename arch/arm/mach-omap1/{include/mach => }/board-sx1.h (100%)
 rename arch/arm/mach-omap1/{include/mach => }/camera.h (100%)
 rename arch/arm/mach-omap1/{include/mach => }/flash.h (100%)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index a95499ea8706..9fc70978823b 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -41,7 +41,7 @@
 
 #include <mach/hardware.h>
 #include <mach/ams-delta-fiq.h>
-#include <mach/camera.h>
+#include "camera.h"
 #include <mach/usb.h>
 
 #include "iomap.h"
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 0fb51d22c8b5..fad95b74bb65 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -29,7 +29,7 @@
 
 #include <mach/tc.h>
 #include <mach/mux.h>
-#include <mach/flash.h>
+#include "flash.h"
 #include <linux/platform_data/keypad-omap.h>
 
 #include <mach/hardware.h>
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 8340d684d8b6..cd146ed0538d 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -42,7 +42,7 @@
 #include <linux/omap-dma.h>
 #include <mach/tc.h>
 #include <linux/platform_data/keypad-omap.h>
-#include <mach/flash.h>
+#include "flash.h"
 
 #include <mach/hardware.h>
 #include <mach/usb.h>
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 086ff34e072b..f7c8c63dd532 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -44,7 +44,7 @@
 #include <mach/tc.h>
 #include <linux/platform_data/keypad-omap.h>
 #include <linux/omap-dma.h>
-#include <mach/flash.h>
+#include "flash.h"
 
 #include <mach/hardware.h>
 #include <mach/irqs.h>
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index ed4e045c2ad8..ae90bd02b3bf 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -32,7 +32,7 @@
 #include <asm/mach/map.h>
 
 #include <mach/mux.h>
-#include <mach/flash.h>
+#include "flash.h"
 #include <mach/tc.h>
 #include <linux/platform_data/keypad-omap.h>
 
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 0efd165b8227..209aecb0df68 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -46,7 +46,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/flash.h>
+#include "flash.h"
 #include <mach/mux.h>
 #include <mach/tc.h>
 
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index 1142ae431fe0..e5288cda1a6a 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -34,7 +34,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/flash.h>
+#include "flash.h"
 #include <mach/mux.h>
 #include <mach/tc.h>
 #include <linux/omap-dma.h>
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 54a547a96950..d672495f7441 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -34,7 +34,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/flash.h>
+#include "flash.h"
 #include <mach/mux.h>
 #include <linux/omap-dma.h>
 #include <mach/tc.h>
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 87ec04ae40dd..aaf741b0aff6 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -36,7 +36,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/flash.h>
+#include "flash.h"
 #include <mach/mux.h>
 #include <linux/omap-dma.h>
 #include <mach/tc.h>
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 3d76f05407f0..150b57ba42bf 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -30,7 +30,7 @@
 
 #include <mach/tc.h>
 #include <mach/mux.h>
-#include <mach/flash.h>
+#include "flash.h"
 
 #include <mach/hardware.h>
 
diff --git a/arch/arm/mach-omap1/board-sx1-mmc.c b/arch/arm/mach-omap1/board-sx1-mmc.c
index 4fcf19c78a08..a9373570bbb1 100644
--- a/arch/arm/mach-omap1/board-sx1-mmc.c
+++ b/arch/arm/mach-omap1/board-sx1-mmc.c
@@ -16,7 +16,7 @@
 #include <linux/platform_device.h>
 
 #include <mach/hardware.h>
-#include <mach/board-sx1.h>
+#include "board-sx1.h"
 
 #include "mmc.h"
 
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 939991ea33d5..6c482254b37c 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -34,11 +34,11 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <mach/flash.h>
+#include "flash.h"
 #include <mach/mux.h>
 #include <linux/omap-dma.h>
 #include <mach/tc.h>
-#include <mach/board-sx1.h>
+#include "board-sx1.h"
 
 #include <mach/hardware.h>
 #include <mach/usb.h>
diff --git a/arch/arm/mach-omap1/include/mach/board-sx1.h b/arch/arm/mach-omap1/board-sx1.h
similarity index 100%
rename from arch/arm/mach-omap1/include/mach/board-sx1.h
rename to arch/arm/mach-omap1/board-sx1.h
diff --git a/arch/arm/mach-omap1/include/mach/camera.h b/arch/arm/mach-omap1/camera.h
similarity index 100%
rename from arch/arm/mach-omap1/include/mach/camera.h
rename to arch/arm/mach-omap1/camera.h
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 325e6030095e..263c07a566cb 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -25,7 +25,7 @@
 #include <mach/mux.h>
 
 #include <mach/omap7xx.h>
-#include <mach/camera.h>
+#include "camera.h"
 #include <mach/hardware.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-omap1/flash.c b/arch/arm/mach-omap1/flash.c
index b3fb531af94e..99cda402e1e2 100644
--- a/arch/arm/mach-omap1/flash.c
+++ b/arch/arm/mach-omap1/flash.c
@@ -11,7 +11,7 @@
 #include <linux/mtd/map.h>
 
 #include <mach/tc.h>
-#include <mach/flash.h>
+#include "flash.h"
 
 #include <mach/hardware.h>
 
diff --git a/arch/arm/mach-omap1/include/mach/flash.h b/arch/arm/mach-omap1/flash.h
similarity index 100%
rename from arch/arm/mach-omap1/include/mach/flash.h
rename to arch/arm/mach-omap1/flash.h
-- 
2.1.0.rc2
