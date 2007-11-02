From: "Girish" <girishsg@ti.com>
Subject: [PATCH 5/5]Twl4030- Keypad support on OMAP 3430
Date: Fri, 2 Nov 2007 20:55:02 +0530
Message-ID: <00f901c81d64$89fa0c60$6a8918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This patch supports Keypad on 3430

Signed-off-by: Girish S G <girishsg@ti.com>
---
 arch/arm/configs/omap_3430sdp_defconfig |    1 
 arch/arm/mach-omap2/board-3430sdp.c     |   53 ++++++++++++++++++++++++++++++++
 drivers/input/keyboard/Kconfig          |    2 -
 3 files changed, 55 insertions(+), 1 deletion(-)

Index: linux-omap-git/arch/arm/configs/omap_3430sdp_defconfig
===================================================================
--- linux-omap-git.orig/arch/arm/configs/omap_3430sdp_defconfig	2007-10-25 21:10:13.000000000 +0530
+++ linux-omap-git/arch/arm/configs/omap_3430sdp_defconfig	2007-10-25 21:11:41.000000000 +0530
@@ -545,6 +545,7 @@
 # CONFIG_KEYBOARD_XTKBD is not set
 # CONFIG_KEYBOARD_NEWTON is not set
 # CONFIG_KEYBOARD_STOWAWAY is not set
+CONFIG_KEYBOARD_TWL4030=y
 # CONFIG_KEYBOARD_GPIO is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
Index: linux-omap-git/arch/arm/mach-omap2/board-3430sdp.c
===================================================================
--- linux-omap-git.orig/arch/arm/mach-omap2/board-3430sdp.c	2007-10-25 21:10:13.000000000 +0530
+++ linux-omap-git/arch/arm/mach-omap2/board-3430sdp.c	2007-10-25 21:17:26.000000000 +0530
@@ -18,6 +18,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/delay.h>
+#include <linux/input.h>
 #include <linux/workqueue.h>
 #include <linux/err.h>
 #include <linux/clk.h>
@@ -36,6 +37,7 @@
 #include <asm/arch/mux.h>
 #include <asm/arch/board.h>
 #include <asm/arch/common.h>
+#include <asm/arch/keypad.h>
 #include <asm/arch/dma.h>
 #include <asm/arch/gpmc.h>
 
@@ -122,6 +124,56 @@
 	.resource	= sdp3430_smc91x_resources,
 };
 
+static int sdp3430_keymap[] = {
+	KEY(0, 0, KEY_LEFT),
+	KEY(0, 1, KEY_RIGHT),
+	KEY(0, 2, KEY_A),
+	KEY(0, 3, KEY_B),
+	KEY(0, 4, KEY_C),
+	KEY(1, 0, KEY_DOWN),
+	KEY(1, 1, KEY_UP),
+	KEY(1, 2, KEY_E),
+	KEY(1, 3, KEY_F),
+	KEY(1, 4, KEY_G),
+	KEY(2, 0, KEY_ENTER),
+	KEY(2, 1, KEY_I),
+	KEY(2, 2, KEY_J),
+	KEY(2, 3, KEY_K),
+	KEY(2, 4, KEY_3),
+	KEY(3, 0, KEY_M),
+	KEY(3, 1, KEY_N),
+	KEY(3, 2, KEY_O),
+	KEY(3, 3, KEY_P),
+	KEY(3, 4, KEY_Q),
+	KEY(4, 0, KEY_R),
+	KEY(4, 1, KEY_4),
+	KEY(4, 2, KEY_T),
+	KEY(4, 3, KEY_U),
+	KEY(4, 4, KEY_D),
+	KEY(5, 0, KEY_V),
+	KEY(5, 1, KEY_W),
+	KEY(5, 2, KEY_L),
+	KEY(5, 3, KEY_S),
+	KEY(5, 4, KEY_H),
+	0
+};
+
+static struct omap_kp_platform_data sdp3430_kp_data = {
+	.rows		= 5,
+	.cols		= 6,
+	.keymap 	= sdp3430_keymap,
+	.keymapsize 	= ARRAY_SIZE(sdp3430_keymap),
+	.rep		= 1,
+};
+
+static struct platform_device sdp3430_kp_device = {
+	.name		= "omap_twl4030keypad",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &sdp3430_kp_data,
+	},
+};
+
 /**
  * @brief ads7846_dev_init : Requests & sets GPIO line for pen-irq
  *
@@ -205,6 +257,7 @@
 static struct platform_device *sdp3430_devices[] __initdata = {
 	&sdp3430_smc91x_device,
 	&sdp3430_flash_device,
+	&sdp3430_kp_device,
 };
 
 static inline void __init sdp3430_init_smc91x(void)
Index: linux-omap-git/drivers/input/keyboard/Kconfig
===================================================================
--- linux-omap-git.orig/drivers/input/keyboard/Kconfig	2007-10-25 21:10:13.000000000 +0530
+++ linux-omap-git/drivers/input/keyboard/Kconfig	2007-10-25 21:11:41.000000000 +0530
@@ -219,7 +219,7 @@
 
 config KEYBOARD_TWL4030
 	tristate "TI TWL4030 keypad support"
-	depends on TWL4030_CORE && MACH_OMAP_2430SDP
+	depends on TWL4030_CORE && (MACH_OMAP_2430SDP || MACH_OMAP_3430SDP)
 	help
 	  Say Y here if you want to use the OMAP TWL4030 keypad.
