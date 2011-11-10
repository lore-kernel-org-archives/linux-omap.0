From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: OMAP: Introduce local common.h files
Date: Thu, 10 Nov 2011 12:17:19 -0800
Message-ID: <20111110201719.GW31337@atomide.com>
References: <20111106135250.GC15294@n2100.arm.linux.org.uk>
 <20111108004550.GH31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111108004550.GH31337@atomide.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

As suggested by Russell King - ARM Linux <linux@arm.linux.org.uk>,
there's no need to keep local prototypes in non-local headers.

Add mach-omap1/common.h and mach-omap2/common.h and move the
local prototypes there from plat/common.h and mach/omap4-common.h.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 51bae31..1b37400 100644
---
Here's a patch that fixes the locality issues for MACHINE_START/END
functions at least.
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -35,7 +35,7 @@
 #include <plat/mux.h>
 #include <plat/usb.h>
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <mach/camera.h>
 
 #include <mach/ams-delta-fiq.h>
diff --git a/arch/arm/mach-omap1/board-fsample.c b/arch/arm/mach-omap1/board-fsample.c
index 2317827..b9c4c0f 100644
--- a/arch/arm/mach-omap1/board-fsample.c
+++ b/arch/arm/mach-omap1/board-fsample.c
@@ -32,7 +32,7 @@
 #include <plat/flash.h>
 #include <plat/fpga.h>
 #include <plat/keypad.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/board.h>
 
 /* fsample is pretty close to p2-sample */
diff --git a/arch/arm/mach-omap1/board-generic.c b/arch/arm/mach-omap1/board-generic.c
index dc5b75d..7f41d7a 100644
--- a/arch/arm/mach-omap1/board-generic.c
+++ b/arch/arm/mach-omap1/board-generic.c
@@ -25,7 +25,7 @@
 #include <plat/mux.h>
 #include <plat/usb.h>
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 
 /* assume no Mini-AB port */
 
diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index b334b14..7933b97 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -43,7 +43,7 @@
 #include <plat/irda.h>
 #include <plat/usb.h>
 #include <plat/keypad.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/flash.h>
 
 #include "board-h2.h"
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 74ebe72..04be2f8 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -45,7 +45,7 @@
 #include <plat/usb.h>
 #include <plat/keypad.h>
 #include <plat/dma.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/flash.h>
 
 #include "board-h3.h"
diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 3e91baa..46fcfeb 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -41,7 +41,7 @@
 #include <asm/mach/arch.h>
 
 #include <plat/omap7xx.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/board.h>
 #include <plat/keypad.h>
 #include <plat/usb.h>
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 273153d..f99d11d 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -37,7 +37,7 @@
 #include <plat/tc.h>
 #include <plat/usb.h>
 #include <plat/keypad.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/mmc.h>
 
 /* At OMAP1610 Innovator the Ethernet is directly connected to CS1 */
diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/board-nokia770.c
index 6798b84..c643423 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -30,7 +30,7 @@
 #include <plat/usb.h>
 #include <plat/board.h>
 #include <plat/keypad.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/hwa742.h>
 #include <plat/lcd_mipid.h>
 #include <plat/mmc.h>
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index c385927..a409dfc 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -51,7 +51,7 @@
 #include <plat/usb.h>
 #include <plat/mux.h>
 #include <plat/tc.h>
-#include <plat/common.h>
+#include "common.h"
 
 /* At OMAP5912 OSK the Ethernet is directly connected to CS1 */
 #define OMAP_OSK_ETHR_START		0x04800300
diff --git a/arch/arm/mach-omap1/board-palmte.c b/arch/arm/mach-omap1/board-palmte.c
index f9c44cb..105292d 100644
--- a/arch/arm/mach-omap1/board-palmte.c
+++ b/arch/arm/mach-omap1/board-palmte.c
@@ -41,7 +41,7 @@
 #include <plat/board.h>
 #include <plat/irda.h>
 #include <plat/keypad.h>
-#include <plat/common.h>
+#include "common.h"
 
 #define PALMTE_USBDETECT_GPIO	0
 #define PALMTE_USB_OR_DC_GPIO	1
diff --git a/arch/arm/mach-omap1/board-palmtt.c b/arch/arm/mach-omap1/board-palmtt.c
index 11a9853..387a900 100644
--- a/arch/arm/mach-omap1/board-palmtt.c
+++ b/arch/arm/mach-omap1/board-palmtt.c
@@ -39,7 +39,7 @@
 #include <plat/board.h>
 #include <plat/irda.h>
 #include <plat/keypad.h>
-#include <plat/common.h>
+#include "common.h"
 
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
diff --git a/arch/arm/mach-omap1/board-palmz71.c b/arch/arm/mach-omap1/board-palmz71.c
index 4206157..df6d15e 100644
--- a/arch/arm/mach-omap1/board-palmz71.c
+++ b/arch/arm/mach-omap1/board-palmz71.c
@@ -41,7 +41,7 @@
 #include <plat/board.h>
 #include <plat/irda.h>
 #include <plat/keypad.h>
-#include <plat/common.h>
+#include "common.h"
 
 #include <linux/spi/spi.h>
 #include <linux/spi/ads7846.h>
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index 203ae07..57ecd7e 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -32,7 +32,7 @@
 #include <plat/fpga.h>
 #include <plat/flash.h>
 #include <plat/keypad.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/board.h>
 
 static const unsigned int p2_keymap[] = {
diff --git a/arch/arm/mach-omap1/board-sx1.c b/arch/arm/mach-omap1/board-sx1.c
index 092a4c0..774ae39 100644
--- a/arch/arm/mach-omap1/board-sx1.c
+++ b/arch/arm/mach-omap1/board-sx1.c
@@ -40,7 +40,7 @@
 #include <plat/usb.h>
 #include <plat/tc.h>
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/keypad.h>
 #include <plat/board-sx1.h>
 
diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index 61ed6cd..7721c14 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -34,7 +34,7 @@
 #include <asm/mach/map.h>
 
 #include <plat/board-voiceblue.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/flash.h>
 #include <plat/mux.h>
 #include <plat/tc.h>
diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
new file mode 100644
index 0000000..52c4eda
--- /dev/null
+++ b/arch/arm/mach-omap1/common.h
@@ -0,0 +1,61 @@
+/*
+ *
+ * Header for code common to all OMAP1 machines.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP1_COMMON_H
+#define __ARCH_ARM_MACH_OMAP1_COMMON_H
+
+#include <plat/common.h>
+
+#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
+void omap7xx_map_io(void);
+#else
+static inline void omap7xx_map_io(void)
+{
+}
+#endif
+
+#ifdef CONFIG_ARCH_OMAP15XX
+void omap15xx_map_io(void);
+#else
+static inline void omap15xx_map_io(void)
+{
+}
+#endif
+
+#ifdef CONFIG_ARCH_OMAP16XX
+void omap16xx_map_io(void);
+#else
+static inline void omap16xx_map_io(void)
+{
+}
+#endif
+
+void omap1_init_early(void);
+void omap1_init_irq(void);
+
+extern struct sys_timer omap1_timer;
+extern bool omap_32k_timer_init(void);
+
+#endif /* __ARCH_ARM_MACH_OMAP1_COMMON_H */
diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
index 48ef988..9d47ca7 100644
--- a/arch/arm/mach-omap1/devices.c
+++ b/arch/arm/mach-omap1/devices.c
@@ -22,7 +22,7 @@
 #include <mach/hardware.h>
 #include <asm/mach/map.h>
 
-#include <plat/common.h>
+#include "common.h"
 #include <plat/tc.h>
 #include <plat/board.h>
 #include <plat/mux.h>
diff --git a/arch/arm/mach-omap1/time.c b/arch/arm/mach-omap1/time.c
index a183777..485a21d 100644
--- a/arch/arm/mach-omap1/time.c
+++ b/arch/arm/mach-omap1/time.c
@@ -54,7 +54,7 @@
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
 
-#include <plat/common.h>
+#include "common.h"
 
 #ifdef CONFIG_OMAP_MPU_TIMER
 
diff --git a/arch/arm/mach-omap1/timer32k.c b/arch/arm/mach-omap1/timer32k.c
index 96604a5..9a54ef4 100644
--- a/arch/arm/mach-omap1/timer32k.c
+++ b/arch/arm/mach-omap1/timer32k.c
@@ -52,7 +52,7 @@
 #include <asm/irq.h>
 #include <asm/mach/irq.h>
 #include <asm/mach/time.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/dmtimer.h>
 
 /*
diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index d704f0a..a17a6c4 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -34,7 +34,7 @@
 #include <asm/mach/map.h>
 
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 #include <plat/gpmc-smc91x.h>
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 77142c1..670919c 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -33,7 +33,7 @@
 #include <plat/mcspi.h>
 #include <plat/board.h>
 #include <plat/usb.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/dma.h>
 #include <plat/gpmc.h>
 #include <video/omapdss.h>
diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-omap2/board-3630sdp.c
index f552305..63f4b4f 100644
--- a/arch/arm/mach-omap2/board-3630sdp.c
+++ b/arch/arm/mach-omap2/board-3630sdp.c
@@ -16,7 +16,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <plat/common.h>
+#include "common.h"
 #include <plat/board.h>
 #include <plat/gpmc-smc91x.h>
 #include <plat/usb.h>
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 5156468..cff2e32 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -27,13 +27,12 @@
 #include <linux/leds_pwm.h>
 
 #include <mach/hardware.h>
-#include <mach/omap4-common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/usb.h>
 #include <plat/mmc.h>
 #include <plat/omap4-keypad.h>
diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index 7834536..2570475 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -27,7 +27,7 @@
 #include <asm/mach/map.h>
 
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/usb.h>
 
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index d314f03..56ea011 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -32,7 +32,7 @@
 #include <asm/mach/map.h>
 
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/usb.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index de8134b..9aea158 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -37,7 +37,7 @@
 #include <plat/led.h>
 #include <plat/usb.h>
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/gpmc.h>
 
 #include <video/omapdss.h>
diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index bd1bcac..e1de33e 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -37,7 +37,7 @@
 #include <asm/mach/map.h>
 
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/nand.h>
 #include <plat/gpmc.h>
 #include <plat/usb.h>
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 3f4dc66..952df9b 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -39,7 +39,7 @@
 #include <asm/mach/map.h>
 
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/usb.h>
 #include <plat/nand.h>
 #include <plat/gpmc.h>
diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 90154e4..99e6e7a 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -41,7 +41,7 @@
 #include <asm/mach/flash.h>
 
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/gpmc.h>
 #include <plat/nand.h>
 #include <plat/usb.h>
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index fb55fa3..a89d723 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -20,8 +20,7 @@
 #include <asm/mach/arch.h>
 
 #include <plat/board.h>
-#include <plat/common.h>
-#include <mach/omap4-common.h>
+#include "common.h"
 #include "common-board-devices.h"
 
 /*
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 8b351d9..199a174 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -34,7 +34,7 @@
 
 #include <plat/usb.h>
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/menelaus.h>
 #include <plat/dma.h>
 #include <plat/gpmc.h>
diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index d0a3f78..6434bdc 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -28,7 +28,7 @@
 #include <asm/mach/arch.h>
 
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/gpmc.h>
 #include <plat/usb.h>
 #include <video/omapdss.h>
diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index e179da0..e75102a 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -36,7 +36,7 @@
 
 #include <plat/mcspi.h>
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/gpmc.h>
 #include <mach/board-zoom.h>
 
diff --git a/arch/arm/mach-omap2/board-n8x0.c b/arch/arm/mach-omap2/board-n8x0.c
index e9d5f4a..7368614 100644
--- a/arch/arm/mach-omap2/board-n8x0.c
+++ b/arch/arm/mach-omap2/board-n8x0.c
@@ -26,7 +26,7 @@
 #include <asm/mach-types.h>
 
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/menelaus.h>
 #include <mach/irqs.h>
 #include <plat/mcspi.h>
diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 4a71cb7..1843e14 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -40,7 +40,7 @@
 #include <asm/mach/flash.h>
 
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <video/omapdss.h>
 #include <video/omap-panel-dvi.h>
 #include <plat/gpmc.h>
diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index ec00b2e..1653d18 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -43,7 +43,7 @@
 
 #include <plat/board.h>
 #include <plat/usb.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/mcspi.h>
 #include <video/omapdss.h>
 #include <video/omap-panel-dvi.h>
diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index 7c0f193..1b2a776 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -40,7 +40,7 @@
 
 #include <plat/mux.h>
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/gpmc-smsc911x.h>
 #include <plat/gpmc.h>
 #include <plat/sdrc.h>
diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
index f7811f4..6297e81 100644
--- a/arch/arm/mach-omap2/board-omap3pandora.c
+++ b/arch/arm/mach-omap2/board-omap3pandora.c
@@ -41,7 +41,7 @@
 #include <asm/mach/map.h>
 
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <mach/hardware.h>
 #include <plat/mcspi.h>
 #include <plat/usb.h>
diff --git a/arch/arm/mach-omap2/board-omap3stalker.c b/arch/arm/mach-omap2/board-omap3stalker.c
index ddb7d66..ab22647 100644
--- a/arch/arm/mach-omap2/board-omap3stalker.c
+++ b/arch/arm/mach-omap2/board-omap3stalker.c
@@ -35,7 +35,7 @@
 #include <asm/mach/flash.h>
 
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/gpmc.h>
 #include <plat/nand.h>
 #include <plat/usb.h>
diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
index a2d0d19..2741a34 100644
--- a/arch/arm/mach-omap2/board-omap3touchbook.c
+++ b/arch/arm/mach-omap2/board-omap3touchbook.c
@@ -44,7 +44,7 @@
 #include <asm/mach/flash.h>
 
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/gpmc.h>
 #include <plat/nand.h>
 #include <plat/usb.h>
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index a8c2c42..7722d4d 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -30,14 +30,13 @@
 #include <linux/wl12xx.h>
 
 #include <mach/hardware.h>
-#include <mach/omap4-common.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <video/omapdss.h>
 
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/usb.h>
 #include <plat/mmc.h>
 #include <video/omap-panel-dvi.h>
diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
index 4cf7aea..26c5cbb 100644
--- a/arch/arm/mach-omap2/board-overo.c
+++ b/arch/arm/mach-omap2/board-overo.c
@@ -43,7 +43,7 @@
 #include <asm/mach/map.h>
 
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <video/omapdss.h>
 #include <video/omap-panel-generic-dpi.h>
 #include <video/omap-panel-dvi.h>
diff --git a/arch/arm/mach-omap2/board-rm680.c b/arch/arm/mach-omap2/board-rm680.c
index 616fb39..6ffb640 100644
--- a/arch/arm/mach-omap2/board-rm680.c
+++ b/arch/arm/mach-omap2/board-rm680.c
@@ -25,7 +25,7 @@
 #include <plat/mmc.h>
 #include <plat/usb.h>
 #include <plat/gpmc.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/onenand.h>
 
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index ba1aa07..bd18d69 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -27,7 +27,7 @@
 
 #include <plat/mcspi.h>
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/dma.h>
 #include <plat/gpmc.h>
 #include <plat/onenand.h>
diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
index 4af7c4b..8477313 100644
--- a/arch/arm/mach-omap2/board-rx51.c
+++ b/arch/arm/mach-omap2/board-rx51.c
@@ -25,7 +25,7 @@
 
 #include <plat/mcspi.h>
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/dma.h>
 #include <plat/gpmc.h>
 #include <plat/usb.h>
diff --git a/arch/arm/mach-omap2/board-ti8168evm.c b/arch/arm/mach-omap2/board-ti8168evm.c
index e6ee884..8402b39 100644
--- a/arch/arm/mach-omap2/board-ti8168evm.c
+++ b/arch/arm/mach-omap2/board-ti8168evm.c
@@ -22,7 +22,7 @@
 
 #include <plat/irqs.h>
 #include <plat/board.h>
-#include <plat/common.h>
+#include "common.h"
 
 static struct omap_board_config_kernel ti8168_evm_config[] __initdata = {
 };
diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c b/arch/arm/mach-omap2/board-zoom-peripherals.c
index 6d0aa4f..8d7ce11 100644
--- a/arch/arm/mach-omap2/board-zoom-peripherals.c
+++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
@@ -24,7 +24,7 @@
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
-#include <plat/common.h>
+#include "common.h"
 #include <plat/usb.h>
 
 #include <mach/board-zoom.h>
diff --git a/arch/arm/mach-omap2/board-zoom.c b/arch/arm/mach-omap2/board-zoom.c
index be6684d..bd58f92 100644
--- a/arch/arm/mach-omap2/board-zoom.c
+++ b/arch/arm/mach-omap2/board-zoom.c
@@ -21,7 +21,7 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <plat/common.h>
+#include "common.h"
 #include <plat/board.h>
 #include <plat/usb.h>
 
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.c b/arch/arm/mach-omap2/cm2xxx_3xxx.c
index 38830d8..04d39cd 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.c
@@ -18,7 +18,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include <plat/common.h>
+#include "common.h"
 
 #include "cm.h"
 #include "cm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/cm44xx.c b/arch/arm/mach-omap2/cm44xx.c
index e96f53e..6a83630 100644
--- a/arch/arm/mach-omap2/cm44xx.c
+++ b/arch/arm/mach-omap2/cm44xx.c
@@ -18,7 +18,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include <plat/common.h>
+#include "common.h"
 
 #include "cm.h"
 #include "cm1_44xx.h"
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index eb2a472..6204dea 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -20,7 +20,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include <plat/common.h>
+#include "common.h"
 
 #include "cm.h"
 #include "cm1_44xx.h"
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 110e5b9..684b8a7 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -17,7 +17,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/common.h>
+#include "common.h"
 #include <plat/board.h>
 #include <plat/mux.h>
 
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
new file mode 100644
index 0000000..950b39d
--- /dev/null
+++ b/arch/arm/mach-omap2/common.h
@@ -0,0 +1,185 @@
+/*
+ * Header for code common to all OMAP2+ machines.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
+ * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
+ * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H
+#define __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H
+
+#include <linux/delay.h>
+#include <plat/common.h>
+
+#ifdef CONFIG_SOC_OMAP2420
+extern void omap242x_map_common_io(void);
+#else
+static inline void omap242x_map_common_io(void)
+{
+}
+#endif
+
+#ifdef CONFIG_SOC_OMAP2430
+extern void omap243x_map_common_io(void);
+#else
+static inline void omap243x_map_common_io(void)
+{
+}
+#endif
+
+#ifdef CONFIG_ARCH_OMAP3
+extern void omap34xx_map_common_io(void);
+#else
+static inline void omap34xx_map_common_io(void)
+{
+}
+#endif
+
+#ifdef CONFIG_SOC_OMAPTI816X
+extern void omapti816x_map_common_io(void);
+#else
+static inline void omapti816x_map_common_io(void)
+{
+}
+#endif
+
+#ifdef CONFIG_ARCH_OMAP4
+extern void omap44xx_map_common_io(void);
+#else
+static inline void omap44xx_map_common_io(void)
+{
+}
+#endif
+
+extern void omap2_init_common_infrastructure(void);
+
+extern struct sys_timer omap2_timer;
+extern struct sys_timer omap3_timer;
+extern struct sys_timer omap3_secure_timer;
+extern struct sys_timer omap4_timer;
+
+void omap2420_init_early(void);
+void omap2430_init_early(void);
+void omap3430_init_early(void);
+void omap35xx_init_early(void);
+void omap3630_init_early(void);
+void omap3_init_early(void);	/* Do not use this one */
+void am35xx_init_early(void);
+void ti816x_init_early(void);
+void omap4430_init_early(void);
+
+/*
+ * IO bases for various OMAP processors
+ * Except the tap base, rest all the io bases
+ * listed are physical addresses.
+ */
+struct omap_globals {
+	u32		class;		/* OMAP class to detect */
+	void __iomem	*tap;		/* Control module ID code */
+	void __iomem	*sdrc;           /* SDRAM Controller */
+	void __iomem	*sms;            /* SDRAM Memory Scheduler */
+	void __iomem	*ctrl;           /* System Control Module */
+	void __iomem	*ctrl_pad;	/* PAD Control Module */
+	void __iomem	*prm;            /* Power and Reset Management */
+	void __iomem	*cm;             /* Clock Management */
+	void __iomem	*cm2;
+};
+
+void omap2_set_globals_242x(void);
+void omap2_set_globals_243x(void);
+void omap2_set_globals_3xxx(void);
+void omap2_set_globals_443x(void);
+void omap2_set_globals_ti816x(void);
+
+/* These get called from omap2_set_globals_xxxx(), do not call these */
+void omap2_set_globals_tap(struct omap_globals *);
+void omap2_set_globals_sdrc(struct omap_globals *);
+void omap2_set_globals_control(struct omap_globals *);
+void omap2_set_globals_prcm(struct omap_globals *);
+
+void omap242x_map_io(void);
+void omap243x_map_io(void);
+void omap3_map_io(void);
+void omap4_map_io(void);
+
+/**
+ * omap_test_timeout - busy-loop, testing a condition
+ * @cond: condition to test until it evaluates to true
+ * @timeout: maximum number of microseconds in the timeout
+ * @index: loop index (integer)
+ *
+ * Loop waiting for @cond to become true or until at least @timeout
+ * microseconds have passed.  To use, define some integer @index in the
+ * calling code.  After running, if @index == @timeout, then the loop has
+ * timed out.
+ */
+#define omap_test_timeout(cond, timeout, index)			\
+({								\
+	for (index = 0; index < timeout; index++) {		\
+		if (cond)					\
+			break;					\
+		udelay(1);					\
+	}							\
+})
+
+extern struct device *omap2_get_mpuss_device(void);
+extern struct device *omap2_get_iva_device(void);
+extern struct device *omap2_get_l3_device(void);
+extern struct device *omap4_get_dsp_device(void);
+
+void omap2_init_irq(void);
+void omap3_init_irq(void);
+void ti816x_init_irq(void);
+extern int omap_irq_pending(void);
+void omap_intc_save_context(void);
+void omap_intc_restore_context(void);
+void omap3_intc_suspend(void);
+void omap3_intc_prepare_idle(void);
+void omap3_intc_resume_idle(void);
+
+/*
+ * wfi used in low power code. Directly opcode is used instead
+ * of instruction to avoid mulit-omap build break
+ */
+#ifdef CONFIG_THUMB2_KERNEL
+#define do_wfi() __asm__ __volatile__ ("wfi" : : : "memory")
+#else
+#define do_wfi()			\
+		__asm__ __volatile__ (".word	0xe320f003" : : : "memory")
+#endif
+
+#ifdef CONFIG_CACHE_L2X0
+extern void __iomem *l2cache_base;
+#endif
+
+extern void __iomem *gic_dist_base_addr;
+
+extern void __init gic_init_irq(void);
+extern void omap_smc1(u32 fn, u32 arg);
+
+#ifdef CONFIG_SMP
+/* Needed for secondary core boot */
+extern void omap_secondary_startup(void);
+extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
+extern void omap_auxcoreboot_addr(u32 cpu_addr);
+extern u32 omap_read_auxcoreboot0(void);
+#endif
+
+#endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index e34d27f..114c037 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -15,7 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 
-#include <plat/common.h>
+#include "common.h"
 #include <plat/sdrc.h>
 
 #include "cm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
index ace9994..a12e224 100644
--- a/arch/arm/mach-omap2/i2c.c
+++ b/arch/arm/mach-omap2/i2c.c
@@ -21,7 +21,7 @@
 
 #include <plat/cpu.h>
 #include <plat/i2c.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/omap_hwmod.h>
 
 #include "mux.h"
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 7f47092..27ad722 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -21,7 +21,7 @@
 
 #include <asm/cputype.h>
 
-#include <plat/common.h>
+#include "common.h"
 #include <plat/cpu.h>
 
 #include <mach/id.h>
diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
deleted file mode 100644
index e4bd876..0000000
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * omap4-common.h: OMAP4 specific common header file
- *
- * Copyright (C) 2010 Texas Instruments, Inc.
- *
- * Author:
- *	Santosh Shilimkar <santosh.shilimkar@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef OMAP_ARCH_OMAP4_COMMON_H
-#define OMAP_ARCH_OMAP4_COMMON_H
-
-/*
- * wfi used in low power code. Directly opcode is used instead
- * of instruction to avoid mulit-omap build break
- */
-#ifdef CONFIG_THUMB2_KERNEL
-#define do_wfi() __asm__ __volatile__ ("wfi" : : : "memory")
-#else
-#define do_wfi()			\
-		__asm__ __volatile__ (".word	0xe320f003" : : : "memory")
-#endif
-
-#ifdef CONFIG_CACHE_L2X0
-extern void __iomem *l2cache_base;
-#endif
-
-extern void __iomem *gic_dist_base_addr;
-
-extern void __init gic_init_irq(void);
-extern void omap_smc1(u32 fn, u32 arg);
-
-#ifdef CONFIG_SMP
-/* Needed for secondary core boot */
-extern void omap_secondary_startup(void);
-extern u32 omap_modify_auxcoreboot0(u32 set_mask, u32 clear_mask);
-extern void omap_auxcoreboot_addr(u32 cpu_addr);
-extern u32 omap_read_auxcoreboot0(void);
-#endif
-#endif
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 25d20ce..33f090c 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -35,7 +35,7 @@
 #include "clock3xxx.h"
 #include "clock44xx.h"
 
-#include <plat/common.h>
+#include "common.h"
 #include <plat/omap-pm.h>
 #include "voltage.h"
 #include "powerdomain.h"
@@ -43,7 +43,7 @@
 #include "clockdomain.h"
 #include <plat/omap_hwmod.h>
 #include <plat/multi.h>
-#include <plat/common.h>
+#include "common.h"
 
 /*
  * The machine specific code may provide the extra mapping besides the
diff --git a/arch/arm/mach-omap2/omap-hotplug.c b/arch/arm/mach-omap2/omap-hotplug.c
index 4976b93..e5a1c3f 100644
--- a/arch/arm/mach-omap2/omap-hotplug.c
+++ b/arch/arm/mach-omap2/omap-hotplug.c
@@ -19,7 +19,8 @@
 #include <linux/smp.h>
 
 #include <asm/cacheflush.h>
-#include <mach/omap4-common.h>
+
+#include "common.h"
 
 int platform_cpu_kill(unsigned int cpu)
 {
diff --git a/arch/arm/mach-omap2/omap-smp.c b/arch/arm/mach-omap2/omap-smp.c
index 4412ddb..e99bc6c 100644
--- a/arch/arm/mach-omap2/omap-smp.c
+++ b/arch/arm/mach-omap2/omap-smp.c
@@ -24,7 +24,8 @@
 #include <asm/hardware/gic.h>
 #include <asm/smp_scu.h>
 #include <mach/hardware.h>
-#include <mach/omap4-common.h>
+
+#include "common.h"
 
 /* SCU base address */
 static void __iomem *scu_base;
diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 35ac3e5..f327d74 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -22,7 +22,8 @@
 #include <plat/irqs.h>
 
 #include <mach/hardware.h>
-#include <mach/omap4-common.h>
+
+#include "common.h"
 
 #ifdef CONFIG_CACHE_L2X0
 void __iomem *l2cache_base;
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 6b3088d..00fcd2c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -137,7 +137,7 @@
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 
-#include <plat/common.h>
+#include "common.h"
 #include <plat/cpu.h>
 #include "clockdomain.h"
 #include "powerdomain.h"
diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 1e79bdf..e7bee5c 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -18,7 +18,7 @@
 
 #include <plat/omap-pm.h>
 #include <plat/omap_device.h>
-#include <plat/common.h>
+#include "common.h"
 
 #include "voltage.h"
 #include "powerdomain.h"
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index cf0c216..ef8595c 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -42,6 +42,7 @@
 #include <plat/dma.h>
 #include <plat/board.h>
 
+#include "common.h"
 #include "prm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
 #include "cm2xxx_3xxx.h"
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index efa6649..fa637df 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -42,6 +42,7 @@
 #include <plat/gpmc.h>
 #include <plat/dma.h>
 
+#include "common.h"
 #include "cm2xxx_3xxx.h"
 #include "cm-regbits-34xx.h"
 #include "prm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index 59a870b..8edb015 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -16,8 +16,8 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 
+#include "common.h"
 #include "powerdomain.h"
-#include <mach/omap4-common.h>
 
 struct power_state {
 	struct powerdomain *pwrdm;
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 597e2da..c35e5ce 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -26,7 +26,7 @@
 #include <linux/export.h>
 
 #include <mach/system.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/prcm.h>
 #include <plat/irqs.h>
 
diff --git a/arch/arm/mach-omap2/prcm_mpu44xx.c b/arch/arm/mach-omap2/prcm_mpu44xx.c
index 171fe17..ca669b5 100644
--- a/arch/arm/mach-omap2/prcm_mpu44xx.c
+++ b/arch/arm/mach-omap2/prcm_mpu44xx.c
@@ -15,7 +15,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include <plat/common.h>
+#include "common.h"
 
 #include "prcm_mpu44xx.h"
 #include "cm-regbits-44xx.h"
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index f02d87f..9a08ba3 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -16,7 +16,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include <plat/common.h>
+#include "common.h"
 #include <plat/cpu.h>
 #include <plat/prcm.h>
 
diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index 495a31a..dd885ee 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -17,7 +17,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include <plat/common.h>
+#include "common.h"
 #include <plat/cpu.h>
 #include <plat/prcm.h>
 
diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index 3a7bab1..f6de5bc 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -16,7 +16,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include <plat/common.h>
+#include "common.h"
 
 #include "prm44xx.h"
 #include "prminst44xx.h"
diff --git a/arch/arm/mach-omap2/sdram-nokia.c b/arch/arm/mach-omap2/sdram-nokia.c
index 14caa22..ee3a8ad 100644
--- a/arch/arm/mach-omap2/sdram-nokia.c
+++ b/arch/arm/mach-omap2/sdram-nokia.c
@@ -18,7 +18,7 @@
 #include <linux/io.h>
 
 #include <plat/io.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/clock.h>
 #include <plat/sdrc.h>
 
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index 8f27828..e3d345f 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -23,7 +23,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/common.h>
+#include "common.h"
 #include <plat/clock.h>
 #include <plat/sram.h>
 
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
index ccdb010..791a63c 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -24,7 +24,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
-#include <plat/common.h>
+#include "common.h"
 #include <plat/clock.h>
 #include <plat/sram.h>
 
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 9992dbf..42c3267 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -33,7 +33,7 @@
 #include <plat/omap-serial.h>
 #endif
 
-#include <plat/common.h>
+#include "common.h"
 #include <plat/board.h>
 #include <plat/clock.h>
 #include <plat/dma.h>
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 6a4f683..919d827 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -26,7 +26,7 @@
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 
-#include <plat/common.h>
+#include "common.h"
 
 #include "pm.h"
 #include "smartreflex.h"
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 037b0d7..9edcd52 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -41,7 +41,7 @@
 #include <plat/dmtimer.h>
 #include <asm/localtimer.h>
 #include <asm/sched_clock.h>
-#include <plat/common.h>
+#include "common.h"
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 #include <plat/omap-pm.h>
diff --git a/arch/arm/mach-omap2/vc3xxx_data.c b/arch/arm/mach-omap2/vc3xxx_data.c
index cfe348e..a5ec7f8 100644
--- a/arch/arm/mach-omap2/vc3xxx_data.c
+++ b/arch/arm/mach-omap2/vc3xxx_data.c
@@ -18,7 +18,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 
-#include <plat/common.h>
+#include "common.h"
 
 #include "prm-regbits-34xx.h"
 #include "voltage.h"
diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
index 2740a96..d70b930 100644
--- a/arch/arm/mach-omap2/vc44xx_data.c
+++ b/arch/arm/mach-omap2/vc44xx_data.c
@@ -18,7 +18,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 
-#include <plat/common.h>
+#include "common.h"
 
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 1f8fdf7..8a36342 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -27,7 +27,7 @@
 #include <linux/slab.h>
 #include <linux/clk.h>
 
-#include <plat/common.h>
+#include "common.h"
 
 #include "prm-regbits-34xx.h"
 #include "prm-regbits-44xx.h"
diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
index 071101d..474559d 100644
--- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
@@ -18,7 +18,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 
-#include <plat/common.h>
+#include "common.h"
 #include <plat/cpu.h>
 
 #include "prm-regbits-34xx.h"
diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
index c4584e9..4e11d02 100644
--- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
@@ -21,7 +21,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 
-#include <plat/common.h>
+#include "common.h"
 
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 66bd700..807391d 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -1,7 +1,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 
-#include <plat/common.h>
+#include "common.h"
 
 #include "voltage.h"
 #include "vp.h"
diff --git a/arch/arm/mach-omap2/vp3xxx_data.c b/arch/arm/mach-omap2/vp3xxx_data.c
index 260c554..bd89f80 100644
--- a/arch/arm/mach-omap2/vp3xxx_data.c
+++ b/arch/arm/mach-omap2/vp3xxx_data.c
@@ -19,7 +19,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 
-#include <plat/common.h>
+#include "common.h"
 
 #include "prm-regbits-34xx.h"
 #include "voltage.h"
diff --git a/arch/arm/mach-omap2/vp44xx_data.c b/arch/arm/mach-omap2/vp44xx_data.c
index b4e7704..8c031d1 100644
--- a/arch/arm/mach-omap2/vp44xx_data.c
+++ b/arch/arm/mach-omap2/vp44xx_data.c
@@ -19,7 +19,7 @@
 #include <linux/err.h>
 #include <linux/init.h>
 
-#include <plat/common.h>
+#include "common.h"
 
 #include "prm44xx.h"
 #include "prm-regbits-44xx.h"
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index c50df48..346098f 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -27,94 +27,12 @@
 #ifndef __ARCH_ARM_MACH_OMAP_COMMON_H
 #define __ARCH_ARM_MACH_OMAP_COMMON_H
 
-#include <linux/delay.h>
-
 #include <plat/i2c.h>
 
-struct sys_timer;
-
-extern void omap_map_common_io(void);
-extern struct sys_timer omap1_timer;
-extern struct sys_timer omap2_timer;
-extern struct sys_timer omap3_timer;
-extern struct sys_timer omap3_secure_timer;
-extern struct sys_timer omap4_timer;
-extern bool omap_32k_timer_init(void);
 extern int __init omap_init_clocksource_32k(void);
 extern unsigned long long notrace omap_32k_sched_clock(void);
 
 extern void omap_reserve(void);
-
-void omap2420_init_early(void);
-void omap2430_init_early(void);
-void omap3430_init_early(void);
-void omap35xx_init_early(void);
-void omap3630_init_early(void);
-void omap3_init_early(void);	/* Do not use this one */
-void am35xx_init_early(void);
-void ti816x_init_early(void);
-void omap4430_init_early(void);
-
 void omap_sram_init(void);
 
-/*
- * IO bases for various OMAP processors
- * Except the tap base, rest all the io bases
- * listed are physical addresses.
- */
-struct omap_globals {
-	u32		class;		/* OMAP class to detect */
-	void __iomem	*tap;		/* Control module ID code */
-	void __iomem	*sdrc;           /* SDRAM Controller */
-	void __iomem	*sms;            /* SDRAM Memory Scheduler */
-	void __iomem	*ctrl;           /* System Control Module */
-	void __iomem	*ctrl_pad;	/* PAD Control Module */
-	void __iomem	*prm;            /* Power and Reset Management */
-	void __iomem	*cm;             /* Clock Management */
-	void __iomem	*cm2;
-};
-
-void omap2_set_globals_242x(void);
-void omap2_set_globals_243x(void);
-void omap2_set_globals_3xxx(void);
-void omap2_set_globals_443x(void);
-void omap2_set_globals_ti816x(void);
-
-/* These get called from omap2_set_globals_xxxx(), do not call these */
-void omap2_set_globals_tap(struct omap_globals *);
-void omap2_set_globals_sdrc(struct omap_globals *);
-void omap2_set_globals_control(struct omap_globals *);
-void omap2_set_globals_prcm(struct omap_globals *);
-
-void omap242x_map_io(void);
-void omap243x_map_io(void);
-void omap3_map_io(void);
-void omap4_map_io(void);
-
-
-/**
- * omap_test_timeout - busy-loop, testing a condition
- * @cond: condition to test until it evaluates to true
- * @timeout: maximum number of microseconds in the timeout
- * @index: loop index (integer)
- *
- * Loop waiting for @cond to become true or until at least @timeout
- * microseconds have passed.  To use, define some integer @index in the
- * calling code.  After running, if @index == @timeout, then the loop has
- * timed out.
- */
-#define omap_test_timeout(cond, timeout, index)			\
-({								\
-	for (index = 0; index < timeout; index++) {		\
-		if (cond)					\
-			break;					\
-		udelay(1);					\
-	}							\
-})
-
-extern struct device *omap2_get_mpuss_device(void);
-extern struct device *omap2_get_iva_device(void);
-extern struct device *omap2_get_l3_device(void);
-extern struct device *omap4_get_dsp_device(void);
-
 #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index 7f2969e..62f4477 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -257,74 +257,6 @@ extern void omap_writew(u16 v, u32 pa);
 extern void omap_writel(u32 v, u32 pa);
 
 struct omap_sdrc_params;
-
-#if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
-void omap7xx_map_io(void);
-#else
-static inline void omap_map_io(void)
-{
-}
-#endif
-
-#ifdef CONFIG_ARCH_OMAP15XX
-void omap15xx_map_io(void);
-#else
-static inline void omap15xx_map_io(void)
-{
-}
-#endif
-
-#ifdef CONFIG_ARCH_OMAP16XX
-void omap16xx_map_io(void);
-#else
-static inline void omap16xx_map_io(void)
-{
-}
-#endif
-
-void omap1_init_early(void);
-
-#ifdef CONFIG_SOC_OMAP2420
-extern void omap242x_map_common_io(void);
-#else
-static inline void omap242x_map_common_io(void)
-{
-}
-#endif
-
-#ifdef CONFIG_SOC_OMAP2430
-extern void omap243x_map_common_io(void);
-#else
-static inline void omap243x_map_common_io(void)
-{
-}
-#endif
-
-#ifdef CONFIG_ARCH_OMAP3
-extern void omap34xx_map_common_io(void);
-#else
-static inline void omap34xx_map_common_io(void)
-{
-}
-#endif
-
-#ifdef CONFIG_SOC_OMAPTI816X
-extern void omapti816x_map_common_io(void);
-#else
-static inline void omapti816x_map_common_io(void)
-{
-}
-#endif
-
-#ifdef CONFIG_ARCH_OMAP4
-extern void omap44xx_map_common_io(void);
-#else
-static inline void omap44xx_map_common_io(void)
-{
-}
-#endif
-
-extern void omap2_init_common_infrastructure(void);
 extern void omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 				      struct omap_sdrc_params *sdrc_cs1);
 
diff --git a/arch/arm/plat-omap/include/plat/irqs.h b/arch/arm/plat-omap/include/plat/irqs.h
index 30e1071..d3a9fcd 100644
--- a/arch/arm/plat-omap/include/plat/irqs.h
+++ b/arch/arm/plat-omap/include/plat/irqs.h
@@ -438,16 +438,6 @@
 
 #ifndef __ASSEMBLY__
 extern void __iomem *omap_irq_base;
-void omap1_init_irq(void);
-void omap2_init_irq(void);
-void omap3_init_irq(void);
-void ti816x_init_irq(void);
-extern int omap_irq_pending(void);
-void omap_intc_save_context(void);
-void omap_intc_restore_context(void);
-void omap3_intc_suspend(void);
-void omap3_intc_prepare_idle(void);
-void omap3_intc_resume_idle(void);
 #endif
 
 #include <mach/hardware.h>
