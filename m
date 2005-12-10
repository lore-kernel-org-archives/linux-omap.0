From: Komal Shah <komal_shah802003@yahoo.com>
Subject: [PATCH] keypad: platform_data and 24xx support -exp
Date: Sat, 10 Dec 2005 05:02:28 -0800 (PST)
Message-ID: <20051210130228.91620.qmail@web32905.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0-358508944-1134219748=:87302"
Content-Transfer-Encoding: 8bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

--0-358508944-1134219748=:87302
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Tony/Brian,

I have attached patch which includes:

o Modification suggested by Brian Swetland 
o Added platform_data structure
   - keymap is moved to appropriate board files.
   - rows and cols fields are not used in the driver yet.
   - rep bit is added.
o IRQ resource
o Added 24xx+menelaus keypad support - tested.

TODO/FIXME:
o appropriate place for test_keymap.

o Removing NUM_COLS/ROWS #defines and replacing with
platform_data->rows/cols.

o Moving request_gpio/free_gpio to board specific file, by introducing
one function in platform_data ? Is this ok? e.g get/put_gpios. As
driver should work as module too.

o How to handle row_/col_gpio_num array and set_/get_gpio_val functions
? I want to keep them out of this keypad.c. Any suggestions?

---Komal Shah
http://komalshah.blogspot.com/

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
--0-358508944-1134219748=:87302
Content-Type: text/plain; name="kbp-exp.patch"
Content-Description: 3036529173-kbp-exp.patch
Content-Disposition: inline; filename="kbp-exp.patch"

diff --git a/arch/arm/mach-omap1/board-h2.c b/arch/arm/mach-omap1/board-h2.c
index 0fc2e0f..371a704 100644
--- a/arch/arm/mach-omap1/board-h2.c
+++ b/arch/arm/mach-omap1/board-h2.c
@@ -37,10 +37,50 @@
 #include <asm/arch/mux.h>
 #include <asm/arch/tc.h>
 #include <asm/arch/usb.h>
+#include <asm/arch/keypad.h>
 #include <asm/arch/common.h>
 
 extern int omap_gpio_init(void);
 
+static int h2_keymap[] = {
+	KEY(0, 0, KEY_LEFT),
+	KEY(0, 1, KEY_RIGHT),
+	KEY(0, 2, KEY_3),
+	KEY(0, 3, KEY_F10),
+	KEY(0, 4, KEY_F5),
+	KEY(0, 5, KEY_9),
+	KEY(1, 0, KEY_DOWN),
+	KEY(1, 1, KEY_UP),
+	KEY(1, 2, KEY_2),
+	KEY(1, 3, KEY_F9),
+	KEY(1, 4, KEY_F7),
+	KEY(1, 5, KEY_0),
+	KEY(2, 0, KEY_ENTER),
+	KEY(2, 1, KEY_6),
+	KEY(2, 2, KEY_1),
+	KEY(2, 3, KEY_F2),
+	KEY(2, 4, KEY_F6),
+	KEY(2, 5, KEY_HOME),
+	KEY(3, 0, KEY_8),
+	KEY(3, 1, KEY_5),
+	KEY(3, 2, KEY_F12),
+	KEY(3, 3, KEY_F3),
+	KEY(3, 4, KEY_F8),
+	KEY(3, 5, KEY_END),
+	KEY(4, 0, KEY_7),
+	KEY(4, 1, KEY_4),
+	KEY(4, 2, KEY_F11),
+	KEY(4, 3, KEY_F1),
+	KEY(4, 4, KEY_F4),
+	KEY(4, 5, KEY_ESC),
+	KEY(5, 0, KEY_F13),
+	KEY(5, 1, KEY_F14),
+	KEY(5, 2, KEY_F15),
+	KEY(5, 3, KEY_F16),
+	KEY(5, 4, KEY_SLEEP),
+	0
+};
+
 static struct mtd_partition h2_nor_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
@@ -171,10 +211,36 @@ static struct platform_device h2_smc91x_
 	.resource	= h2_smc91x_resources,
 };
 
+static struct resource h2_kp_resources[] = {
+	[0] = {
+		.start	= INT_KEYBOARD,
+		.end	= INT_KEYBOARD,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct omap_kp_platform_data h2_kp_data = {
+	.rows	= 8,
+	.cols	= 8,
+	.keymap = h2_keymap,
+	.rep	= 1,
+};
+
+static struct platform_device h2_kp_device = {
+	.name		= "omap-keypad",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &h2_kp_data,
+	},
+	.num_resources	= ARRAY_SIZE(h2_kp_resources),
+	.resource	= h2_kp_resources,
+};
+
 static struct platform_device *h2_devices[] __initdata = {
 	&h2_nor_device,
 	&h2_nand_device,
 	&h2_smc91x_device,
+	&h2_kp_device,
 };
 
 static void __init h2_init_smc91x(void)
diff --git a/arch/arm/mach-omap1/board-h3.c b/arch/arm/mach-omap1/board-h3.c
index 2953d38..5b83cca 100644
--- a/arch/arm/mach-omap1/board-h3.c
+++ b/arch/arm/mach-omap1/board-h3.c
@@ -24,6 +24,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/input.h>
 
 #include <asm/setup.h>
 #include <asm/page.h>
@@ -38,10 +39,50 @@
 #include <asm/arch/mux.h>
 #include <asm/arch/tc.h>
 #include <asm/arch/usb.h>
+#include <asm/arch/keypad.h>
 #include <asm/arch/common.h>
 
 extern int omap_gpio_init(void);
 
+static int h3_keymap[] = {
+	KEY(0, 0, KEY_LEFT),
+	KEY(0, 1, KEY_RIGHT),
+	KEY(0, 2, KEY_3),
+	KEY(0, 3, KEY_F10),
+	KEY(0, 4, KEY_F5),
+	KEY(0, 5, KEY_9),
+	KEY(1, 0, KEY_DOWN),
+	KEY(1, 1, KEY_UP),
+	KEY(1, 2, KEY_2),
+	KEY(1, 3, KEY_F9),
+	KEY(1, 4, KEY_F7),
+	KEY(1, 5, KEY_0),
+	KEY(2, 0, KEY_ENTER),
+	KEY(2, 1, KEY_6),
+	KEY(2, 2, KEY_1),
+	KEY(2, 3, KEY_F2),
+	KEY(2, 4, KEY_F6),
+	KEY(2, 5, KEY_HOME),
+	KEY(3, 0, KEY_8),
+	KEY(3, 1, KEY_5),
+	KEY(3, 2, KEY_F12),
+	KEY(3, 3, KEY_F3),
+	KEY(3, 4, KEY_F8),
+	KEY(3, 5, KEY_END),
+	KEY(4, 0, KEY_7),
+	KEY(4, 1, KEY_4),
+	KEY(4, 2, KEY_F11),
+	KEY(4, 3, KEY_F1),
+	KEY(4, 4, KEY_F4),
+	KEY(4, 5, KEY_ESC),
+	KEY(5, 0, KEY_F13),
+	KEY(5, 1, KEY_F14),
+	KEY(5, 2, KEY_F15),
+	KEY(5, 3, KEY_F16),
+	KEY(5, 4, KEY_SLEEP),
+	0
+};
+
 static struct mtd_partition nor_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
@@ -193,11 +234,37 @@ static struct platform_device intlat_dev
 	.resource       = intlat_resources,
 };
 
+static struct resource h3_kp_resources[] = {
+	[0] = {
+		.start	= INT_KEYBOARD,
+		.end	= INT_KEYBOARD,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct omap_kp_platform_data h3_kp_data = {
+	.rows	= 8,
+	.cols	= 8,
+	.keymap = h3_keymap,
+	.rep	= 1,
+};
+
+static struct platform_device h3_kp_device = {
+	.name		= "omap-keypad",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &h3_kp_data,
+	},
+	.num_resources	= ARRAY_SIZE(h3_kp_resources),
+	.resource	= h3_kp_resources,
+};
+
 static struct platform_device *devices[] __initdata = {
 	&nor_device,
 	&nand_device,
         &smc91x_device,
 	&intlat_device,
+	&h3_kp_device,
 };
 
 static struct omap_usb_config h3_usb_config __initdata = {
diff --git a/arch/arm/mach-omap1/board-innovator.c b/arch/arm/mach-omap1/board-innovator.c
index 95f1ff3..a7e4585 100644
--- a/arch/arm/mach-omap1/board-innovator.c
+++ b/arch/arm/mach-omap1/board-innovator.c
@@ -22,6 +22,7 @@
 #include <linux/delay.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/input.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
@@ -34,8 +35,22 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/tc.h>
 #include <asm/arch/usb.h>
+#include <asm/arch/keypad.h>
 #include <asm/arch/common.h>
 
+static int innovator_keymap[] = {
+	KEY(0, 0, KEY_F1),
+	KEY(0, 3, KEY_DOWN),
+	KEY(1, 1, KEY_F2),
+	KEY(1, 2, KEY_RIGHT),
+	KEY(2, 0, KEY_F3),
+	KEY(2, 1, KEY_F4),
+	KEY(2, 2, KEY_UP),
+	KEY(3, 2, KEY_ENTER),
+	KEY(3, 3, KEY_LEFT),
+	0
+};
+
 static struct mtd_partition innovator_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
@@ -97,6 +112,30 @@ static struct platform_device innovator_
 	.resource	= &innovator_flash_resource,
 };
 
+static struct resource innovator_kp_resources[] = {
+	[0] = {
+		.start	= INT_KEYBOARD,
+		.end	= INT_KEYBOARD,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct omap_kp_platform_data innovator_kp_data = {
+	.rows	= 8,
+	.cols	= 8,
+	.keymap = innovator_keymap,
+};
+
+static struct platform_device innovator_kp_device = {
+	.name		= "omap-keypad",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &innovator_kp_data,
+	},
+	.num_resources	= ARRAY_SIZE(innovator_kp_resources),
+	.resource	= innovator_kp_resources,
+};
+
 #ifdef CONFIG_ARCH_OMAP15XX
 
 /* Only FPGA needs to be mapped here. All others are done with ioremap */
@@ -132,6 +171,7 @@ static struct platform_device innovator1
 static struct platform_device *innovator1510_devices[] __initdata = {
 	&innovator_flash_device,
 	&innovator1510_smc91x_device,
+	&innovator_kp_device,
 };
 
 #endif /* CONFIG_ARCH_OMAP15XX */
@@ -161,6 +201,7 @@ static struct platform_device innovator1
 static struct platform_device *innovator1610_devices[] __initdata = {
 	&innovator_flash_device,
 	&innovator1610_smc91x_device,
+	&innovator_kp_device,
 };
 
 #endif /* CONFIG_ARCH_OMAP16XX */
diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index e990e1b..013a4dd 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -33,6 +33,7 @@
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
+#include <linux/input.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
@@ -44,8 +45,22 @@
 #include <asm/arch/usb.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/tc.h>
+#include <asm/arch/keypad.h>
 #include <asm/arch/common.h>
 
+static int osk_keymap[] = {
+	KEY(0, 0, KEY_F1),
+	KEY(0, 3, KEY_UP),
+	KEY(1, 1, KEY_LEFTCTRL),
+	KEY(1, 2, KEY_LEFT),
+	KEY(2, 0, KEY_SPACE),
+	KEY(2, 1, KEY_ESC),
+	KEY(2, 2, KEY_DOWN),
+	KEY(3, 2, KEY_ENTER),
+	KEY(3, 3, KEY_RIGHT),
+	0 
+}; 
+
 static struct mtd_partition osk_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
@@ -138,11 +153,36 @@ static struct platform_device osk5912_mc
 	.id		= 1,
 };
 
+static struct resource osk5912_kp_resources[] = {
+	[0] = {
+		.start	= INT_KEYBOARD,
+		.end	= INT_KEYBOARD,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct omap_kp_platform_data osk_kp_data = {
+	.rows	= 8,
+	.cols	= 8,
+	.keymap = osk_keymap,
+};
+
+static struct platform_device osk5912_kp_device = {
+	.name		= "omap-keypad",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &osk_kp_data,
+	},
+	.num_resources	= ARRAY_SIZE(osk5912_kp_resources),
+	.resource	= osk5912_kp_resources,
+};
+
 static struct platform_device *osk5912_devices[] __initdata = {
 	&osk5912_flash_device,
 	&osk5912_smc91x_device,
 	&osk5912_cf_device,
 	&osk5912_mcbsp1_device,
+	&osk5912_kp_device,
 };
 
 static void __init osk_init_smc91x(void)
diff --git a/arch/arm/mach-omap1/board-perseus2.c b/arch/arm/mach-omap1/board-perseus2.c
index dd8069a..98c7cdc 100644
--- a/arch/arm/mach-omap1/board-perseus2.c
+++ b/arch/arm/mach-omap1/board-perseus2.c
@@ -18,6 +18,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
 #include <linux/mtd/partitions.h>
+#include <linux/input.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
@@ -29,9 +30,44 @@
 #include <asm/arch/gpio.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/fpga.h>
+#include <asm/arch/keypad.h>
 #include <asm/arch/common.h>
 #include <asm/arch/board.h>
 
+static int p2_keymap[] = {
+	KEY(0,0,KEY_UP),
+	KEY(0,1,KEY_RIGHT),
+	KEY(0,2,KEY_LEFT),
+	KEY(0,3,KEY_DOWN),
+	KEY(0,4,KEY_CENTER),
+	KEY(0,5,KEY_0_5),
+	KEY(1,0,KEY_SOFT2),
+	KEY(1,1,KEY_SEND),
+	KEY(1,2,KEY_END),
+	KEY(1,3,KEY_VOLUMEDOWN),
+	KEY(1,4,KEY_VOLUMEUP),
+	KEY(1,5,KEY_RECORD),
+	KEY(2,0,KEY_SOFT1),
+	KEY(2,1,KEY_3),
+	KEY(2,2,KEY_6),
+	KEY(2,3,KEY_9),
+	KEY(2,4,KEY_SHARP),
+	KEY(2,5,KEY_2_5),
+	KEY(3,0,KEY_BACK),
+	KEY(3,1,KEY_2),
+	KEY(3,2,KEY_5),
+	KEY(3,3,KEY_8),
+	KEY(3,4,KEY_0),
+	KEY(3,5,KEY_HEADSETHOOK),
+	KEY(4,0,KEY_HOME),
+	KEY(4,1,KEY_1),
+	KEY(4,2,KEY_4),
+	KEY(4,3,KEY_7),
+	KEY(4,4,KEY_STAR),
+	KEY(4,5,KEY_POWER),
+	0
+};
+
 static struct resource smc91x_resources[] = {
 	[0] = {
 		.start	= H2P2_DBG_FPGA_ETHR_START,	/* Physical */
@@ -126,10 +162,35 @@ static struct platform_device smc91x_dev
 	.resource	= smc91x_resources,
 };
 
+static struct resource kp_resources[] = {
+	[0] = {
+		.start	= INT_730_MPUIO_KEYPAD,
+		.end	= INT_730_MPUIO_KEYPAD,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct omap_kp_platform_data kp_data = {
+	.rows	= 8,
+	.cols	= 8,
+	.keymap = p2_keymap,
+};
+
+static struct platform_device kp_device = {
+	.name		= "omap-keypad",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &kp_data,
+	},
+	.num_resources	= ARRAY_SIZE(kp_resources),
+	.resource	= kp_resources,
+};
+
 static struct platform_device *devices[] __initdata = {
 	&nor_device,
 	&nand_device,
 	&smc91x_device,
+	&kp_device,
 };
 
 #define P2_NAND_RB_GPIO_PIN	62
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 6a5e88d..c0f12a4 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -17,6 +17,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/delay.h>
+#include <linux/input.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
@@ -29,11 +30,46 @@
 #include <asm/arch/usb.h>
 #include <asm/arch/board.h>
 #include <asm/arch/common.h>
+#include <asm/arch/keypad.h>
 #include "prcm-regs.h"
 
 #include <asm/io.h>
 #include <asm/delay.h>
 
+static int h4_keymap[] = {
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
+	KEY(4, 4, KEY_ENTER),
+	KEY(5, 0, KEY_V),
+	KEY(5, 1, KEY_W),
+	KEY(5, 2, KEY_L),
+	KEY(5, 3, KEY_S),
+	KEY(5, 4, KEY_ENTER),
+	0
+};
+
 static struct mtd_partition h4_partitions[] = {
 	/* bootloader (U-Boot, etc) in first sector */
 	{
@@ -108,9 +144,25 @@ static struct platform_device h4_smc91x_
 	.resource	= h4_smc91x_resources,
 };
 
+static struct omap_kp_platform_data h4_kp_data = {
+	.rows	= 6,
+	.cols	= 7,
+	.keymap = h4_keymap,
+	.rep	= 1,
+};
+
+static struct platform_device h4_kp_device = {
+	.name		= "omap-keypad",
+	.id		= -1,
+	.dev		= {
+		.platform_data = &h4_kp_data,
+	},
+};
+
 static struct platform_device *h4_devices[] __initdata = {
 	&h4_smc91x_device,
 	&h4_flash_device,
+	&h4_kp_device,
 };
 
 static inline void __init h4_init_smc91x(void)
diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index ea46548..ab4eaae 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -54,6 +54,26 @@ MUX_CFG_24XX("W19_24XX_SYS_NIRQ",	0x12c,
 MUX_CFG_24XX("Y20_24XX_GPIO60",		0x12c,	3,	0,	0,	1)
 MUX_CFG_24XX("M15_24XX_GPIO92",		0x10a,	3,	0,	0,	1)
 
+/* Keypad GPIO*/
+MUX_CFG_24XX("T19_24XX_KBR0",		0x106,	3,	1,	1,	1)
+MUX_CFG_24XX("R19_24XX_KBR1",		0x107,	3,	1,	1,	1)
+MUX_CFG_24XX("V18_24XX_KBR2",		0x139,	3,	1,	1,	1)
+MUX_CFG_24XX("M21_24XX_KBR3",		0xc9,	3,	1,	1,	1)
+MUX_CFG_24XX("E5__24XX_KBR4",		0x138,	3,	1,	1,	1)
+MUX_CFG_24XX("M18_24XX_KBR5",		0x10e,	3,	1,	1,	1)
+MUX_CFG_24XX("R20_24XX_KBC0",		0x108,	3,	0,	0,	1)
+MUX_CFG_24XX("M14_24XX_KBC1",		0x109,	3,	0,	0,	1)
+MUX_CFG_24XX("H19_24XX_KBC2",		0x114,	3,	0,	0,	1)
+MUX_CFG_24XX("V17_24XX_KBC3",		0x135,	3,	0,	0,	1)
+MUX_CFG_24XX("P21_24XX_KBC4",		0xca,	3,	0,	0,	1)
+MUX_CFG_24XX("L14_24XX_KBC5",		0x10f,	3,	0,	0,	1)
+MUX_CFG_24XX("N19_24XX_KBC6",		0x110,	3,	0,	0,	1)
+
+/* 24xx Meneluase Keypad GPIO */
+MUX_CFG_24XX("B3__24XX_KBR5",		0x30,	3,	1,	1,	1)
+MUX_CFG_24XX("AA4_24XX_KBC2",		0xe7,	3,	0,	0,	1)
+MUX_CFG_24XX("B13_24XX_KBC6",		0x110,	3,	0,	0,	1)
+
 };
 
 int __init omap2_mux_init(void)
diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 1bb1058..cc22364 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -24,6 +24,7 @@
 #include <asm/arch/board.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/gpio.h>
+#include <asm/arch/menelaus.h>
 
 
 void omap_nop_release(struct device *dev)
@@ -126,6 +127,26 @@ static void omap_init_kp(void)
 		omap_cfg_reg(E4_730_KBC2);
 		omap_cfg_reg(F4_730_KBC3);
 		omap_cfg_reg(E3_730_KBC4);
+	} else if (machine_is_omap_h4()) {
+		omap_cfg_reg(T19_24XX_KBR0);
+		omap_cfg_reg(R19_24XX_KBR1);
+		omap_cfg_reg(V18_24XX_KBR2);
+		omap_cfg_reg(M21_24XX_KBR3);
+		omap_cfg_reg(E5__24XX_KBR4);
+		if (omap_has_menelaus()) {
+			omap_cfg_reg(B3__24XX_KBR5);
+			omap_cfg_reg(AA4_24XX_KBC2);
+			omap_cfg_reg(B13_24XX_KBC6);
+		} else {
+			omap_cfg_reg(M18_24XX_KBR5);
+			omap_cfg_reg(H19_24XX_KBC2);
+			omap_cfg_reg(N19_24XX_KBC6);
+		}
+		omap_cfg_reg(R20_24XX_KBC0);
+		omap_cfg_reg(M14_24XX_KBC1);
+		omap_cfg_reg(V17_24XX_KBC3);
+		omap_cfg_reg(P21_24XX_KBC4);
+		omap_cfg_reg(L14_24XX_KBC5);
 	}
 }
 #else
diff --git a/drivers/char/omap-rtc.c b/drivers/char/omap-rtc.c
diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
index a52757c..303915d 100644
--- a/drivers/input/keyboard/Kconfig
+++ b/drivers/input/keyboard/Kconfig
@@ -196,7 +196,7 @@ config KEYBOARD_HIL
 
 config KEYBOARD_OMAP
 	tristate "TI OMAP keypad support"
-	depends on ARCH_OMAP1
+	depends on (ARCH_OMAP1 || ARCH_OMAP2)
 	help
 	  Say Y here if you want to use the OMAP keypad.
 
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index 15351bb..95c6967 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -35,6 +35,8 @@
 #include <asm/arch/irqs.h>
 #include <asm/arch/gpio.h>
 #include <asm/arch/hardware.h>
+#include <asm/arch/keypad.h>
+#include <asm/arch/menelaus.h>
 #include <asm/io.h>
 #include <asm/errno.h>
 #include <asm/mach-types.h>
@@ -42,60 +44,30 @@
 
 #undef NEW_BOARD_LEARNING_MODE
 
+#ifdef CONFIG_MACH_OMAP_H4
+#define NUM_ROWS 6
+#define NUM_COLS 7
+#else
+#define NUM_ROWS 8
+#define NUM_COLS 8
+#endif
+
 static void omap_kp_tasklet(unsigned long);
 static void omap_kp_timer(unsigned long);
 
 static unsigned char keypad_state[8];
-static unsigned int keypad_irq = INT_KEYBOARD;
+
+static unsigned int row_gpio_num[NUM_ROWS] = { 88, 89, 124, 11, 6, 96 };
+static unsigned int col_gpio_num[NUM_COLS] = { 90, 91, 100, 36, 12, 97, 98 };
 
 struct omap_kp {
 	struct input_dev *input;
 	struct timer_list timer;
+	unsigned int irq;
 };
 
 DECLARE_TASKLET_DISABLED(kp_tasklet, omap_kp_tasklet, 0);
 
-#define KEY(col, row, val) (((col) << 28) | ((row) << 24) | (val))
-
-static int h2_keymap[] = {
-	KEY(0, 0, KEY_LEFT),
-	KEY(0, 1, KEY_RIGHT),
-	KEY(0, 2, KEY_3),
-	KEY(0, 3, KEY_F10),
-	KEY(0, 4, KEY_F5),
-	KEY(0, 5, KEY_9),
-	KEY(1, 0, KEY_DOWN),
-	KEY(1, 1, KEY_UP),
-	KEY(1, 2, KEY_2),
-	KEY(1, 3, KEY_F9),
-	KEY(1, 4, KEY_F7),
-	KEY(1, 5, KEY_0),
-	KEY(2, 0, KEY_ENTER),
-	KEY(2, 1, KEY_6),
-	KEY(2, 2, KEY_1),
-	KEY(2, 3, KEY_F2),
-	KEY(2, 4, KEY_F6),
-	KEY(2, 5, KEY_HOME),
-	KEY(3, 0, KEY_8),
-	KEY(3, 1, KEY_5),
-	KEY(3, 2, KEY_F12),
-	KEY(3, 3, KEY_F3),
-	KEY(3, 4, KEY_F8),
-	KEY(3, 5, KEY_END),
-	KEY(4, 0, KEY_7),
-	KEY(4, 1, KEY_4),
-	KEY(4, 2, KEY_F11),
-	KEY(4, 3, KEY_F1),
-	KEY(4, 4, KEY_F4),
-	KEY(4, 5, KEY_ESC),
-	KEY(5, 0, KEY_F13),
-	KEY(5, 1, KEY_F14),
-	KEY(5, 2, KEY_F15),
-	KEY(5, 3, KEY_F16),
-	KEY(5, 4, KEY_SLEEP),
-	0
-};
-
 static int test_keymap[] = {
 	KEY(0, 0, KEY_F4),
 	KEY(1, 0, KEY_LEFT),
@@ -109,73 +81,44 @@ static int test_keymap[] = {
 	0
 };
 
-static int innovator_keymap[] = {
-	KEY(0, 0, KEY_F1),
-	KEY(0, 3, KEY_DOWN),
-	KEY(1, 1, KEY_F2),
-	KEY(1, 2, KEY_RIGHT),
-	KEY(2, 0, KEY_F3),
-	KEY(2, 1, KEY_F4),
-	KEY(2, 2, KEY_UP),
-	KEY(3, 2, KEY_ENTER),
-	KEY(3, 3, KEY_LEFT),
-	0
-};
+static int *keymap;
 
-static int osk_keymap[] = {
-	KEY(0, 0, KEY_F1),
-	KEY(0, 3, KEY_UP),
-	KEY(1, 1, KEY_LEFTCTRL),
-	KEY(1, 2, KEY_LEFT),
-	KEY(2, 0, KEY_SPACE),
-	KEY(2, 1, KEY_ESC),
-	KEY(2, 2, KEY_DOWN),
-	KEY(3, 2, KEY_ENTER),
-	KEY(3, 3, KEY_RIGHT),
-	0 
-}; 
-
-static int p2_keymap[] = {
-	KEY(0,0,KEY_UP),
-	KEY(0,1,KEY_RIGHT),
-	KEY(0,2,KEY_LEFT),
-	KEY(0,3,KEY_DOWN),
-	KEY(0,4,KEY_CENTER),
-	KEY(0,5,KEY_0_5),
-	KEY(1,0,KEY_SOFT2),
-	KEY(1,1,KEY_SEND),
-	KEY(1,2,KEY_END),
-	KEY(1,3,KEY_VOLUMEDOWN),
-	KEY(1,4,KEY_VOLUMEUP),
-	KEY(1,5,KEY_RECORD),
-	KEY(2,0,KEY_SOFT1),
-	KEY(2,1,KEY_3),
-	KEY(2,2,KEY_6),
-	KEY(2,3,KEY_9),
-	KEY(2,4,KEY_SHARP),
-	KEY(2,5,KEY_2_5),
-	KEY(3,0,KEY_BACK),
-	KEY(3,1,KEY_2),
-	KEY(3,2,KEY_5),
-	KEY(3,3,KEY_8),
-	KEY(3,4,KEY_0),
-	KEY(3,5,KEY_HEADSETHOOK),
-	KEY(4,0,KEY_HOME),
-	KEY(4,1,KEY_1),
-	KEY(4,2,KEY_4),
-	KEY(4,3,KEY_7),
-	KEY(4,4,KEY_STAR),
-	KEY(4,5,KEY_POWER),
-	0
-};
+static void set_col_gpio_val(u8 value)
+{
+	int col;
 
-static int *keymap;
+	for (col = 0; col < NUM_COLS; col++) {
+		if (value & (1 << col))
+			omap_set_gpio_dataout(col_gpio_num[col], 1);
+		else
+			omap_set_gpio_dataout(col_gpio_num[col], 0);
+	}
+}
+
+static u8 get_row_gpio_val(void)
+{
+	int row;
+	u8 value = 0;
+
+	for (row = 0; row < NUM_ROWS; row++) {
+		if (omap_get_gpio_datain(row_gpio_num[row]))
+			value |= (1 << row);
+	}
+	return value;
+}
 
 static irqreturn_t omap_kp_interrupt(int irq, void *dev_id,
 				     struct pt_regs *regs)
 {
 	/* disable keyboard interrupt and schedule for handling */
-	omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+	if (machine_is_omap_h4()) {
+		int i;
+		for (i = 0; i < NUM_ROWS; i++)
+			disable_irq(OMAP_GPIO_IRQ(row_gpio_num[i]));
+	} else {
+		/* disable keyboard interrupt and schedule for handling */
+		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+	}
 	tasklet_schedule(&kp_tasklet);
 
 	return IRQ_HANDLED;
@@ -190,21 +133,29 @@ static void omap_kp_scan_keypad(unsigned
 {
 	int col = 0;
 
-	/* read the keypad status */
-	omap_writew(0xff, OMAP_MPUIO_BASE + OMAP_MPUIO_KBC);
-	for (col = 0; col < 8; col++) {
-		omap_writew(~(1 << col) & 0xff, OMAP_MPUIO_BASE + OMAP_MPUIO_KBC);
-
-		if (machine_is_omap_osk() || machine_is_omap_h2() || machine_is_omap_h3()) {
-			udelay(9);
-		} else {
-			udelay(4);
+	if (!machine_is_omap_h4()) {
+		/* read the keypad status */
+		omap_writew(0xff, OMAP_MPUIO_BASE + OMAP_MPUIO_KBC);
+		for (col = 0; col < 8; col++) {
+			omap_writew(~(1 << col) & 0xff, OMAP_MPUIO_BASE + OMAP_MPUIO_KBC);
+
+			if (machine_is_omap_osk() || machine_is_omap_h2() || machine_is_omap_h3()) {
+				udelay(9);
+			} else {
+				udelay(4);
+			}
+			state[col] = ~omap_readw(OMAP_MPUIO_BASE + OMAP_MPUIO_KBR_LATCH) & 0xff;
 		}
-
-		state[col] = ~omap_readw(OMAP_MPUIO_BASE + OMAP_MPUIO_KBR_LATCH) & 0xff;
+		omap_writew(0x00, OMAP_MPUIO_BASE + OMAP_MPUIO_KBC);
+		udelay(2);
+	} else {
+		/* read the keypad status */
+		for (col = 0; col < NUM_COLS; col++) {
+			set_col_gpio_val(~(1 << col));
+			state[col] = ~(get_row_gpio_val()) & 0x3f;
+		}
+		set_col_gpio_val(0);
 	}
-	omap_writew(0x00, OMAP_MPUIO_BASE + OMAP_MPUIO_KBC);
-	udelay(2);
 }
 
 static inline int omap_kp_find_key(int col, int row)
@@ -221,7 +172,7 @@ static inline int omap_kp_find_key(int c
 static void omap_kp_tasklet(unsigned long data)
 {
 	struct omap_kp *omap_kp_data = (struct omap_kp *) data;
-	unsigned char new_state[8], changed, key_down = 0;
+	unsigned char new_state[NUM_COLS], changed, key_down = 0;
 	int col, row;
 	int spurious = 0;
 
@@ -229,13 +180,13 @@ static void omap_kp_tasklet(unsigned lon
 	omap_kp_scan_keypad(new_state);
 
 	/* check for changes and print those */
-	for (col = 0; col < 8; col++) {
+	for (col = 0; col < NUM_COLS; col++) {
 		changed = new_state[col] ^ keypad_state[col];
 		key_down |= new_state[col];
 		if (changed == 0)
 			continue;
 
-		for (row = 0; row < 8; row++) {
+		for (row = 0; row < NUM_ROWS; row++) {
 			int key;
 			if (!(changed & (1 << row)))
 				continue;
@@ -266,8 +217,14 @@ static void omap_kp_tasklet(unsigned lon
 			delay = 2 * HZ;
 		mod_timer(&omap_kp_data->timer, jiffies + delay);
 	} else {
-		/* enable interrupts */
-		omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+		if (machine_is_omap_h4()) {
+			int i;
+			for (i = 0; i < NUM_ROWS; i++)
+				enable_irq(OMAP_GPIO_IRQ(row_gpio_num[i]));
+		} else {
+			/* enable interrupts */
+			omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+		}
 	}
 }
 
@@ -294,6 +251,8 @@ static int __init omap_kp_probe(struct p
 {
 	struct omap_kp *omap_kp;
 	struct input_dev *input_dev;
+	struct omap_kp_platform_data *pdata =
+	    pdev->dev.platform_data;
 	int i;
 
 	omap_kp = kzalloc(sizeof(struct omap_kp), GFP_KERNEL);
@@ -309,20 +268,46 @@ static int __init omap_kp_probe(struct p
 	omap_kp->input = input_dev;
 
 	/* Disable the interrupt for the MPUIO keyboard */
-	omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+	if (!machine_is_omap_h4())
+		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 
-	if (machine_is_omap_h2() || machine_is_omap_h3()) {
-		keymap = h2_keymap;
-		set_bit(EV_REP, input_dev->evbit);
-	} else if (machine_is_omap_innovator()) {
-		keymap = innovator_keymap;
-	} else if (machine_is_omap_osk()) {
-		keymap = osk_keymap;
-	} else if (machine_is_omap_perseus2()) {
-		keymap = p2_keymap;
-		keypad_irq = INT_730_MPUIO_KEYPAD;
-	} else {
+	if (!pdata->keymap)
 		keymap = test_keymap;
+	else
+		keymap = pdata->keymap;
+
+	if (pdata->rep)
+		set_bit(EV_REP, input_dev->evbit);
+
+	if (machine_is_omap_h4()) {
+		if (omap_has_menelaus()) {
+			row_gpio_num[5] = 0;
+			col_gpio_num[2] = 15;
+			col_gpio_num[6] = 18;
+		}
+	}
+
+	if (machine_is_omap_h4()) {
+		/* Cols: outputs */
+		for (i = 0; i < NUM_COLS; i++) {
+			if (omap_request_gpio(col_gpio_num[i]) < 0) {
+				printk(KERN_ERR "Failed to request"
+				       "GPIO%d for keypad\n",
+				       col_gpio_num[i]);
+				return -EINVAL;
+			}
+			omap_set_gpio_direction(col_gpio_num[i], 0);
+		}
+		/* Rows: inputs */
+		for (i = 0; i < NUM_ROWS; i++) {
+			if (omap_request_gpio(row_gpio_num[i]) < 0) {
+				printk(KERN_ERR "Failed to request"
+				       "GPIO%d for keypad\n",
+				       row_gpio_num[i]);
+				return -EINVAL;
+			}
+			omap_set_gpio_direction(row_gpio_num[i], 1);
+		}
 	}
 
 	init_timer(&omap_kp->timer);
@@ -331,9 +316,14 @@ static int __init omap_kp_probe(struct p
 
 	/* get the irq and init timer*/
 	tasklet_enable(&kp_tasklet);
-	if (request_irq(keypad_irq, omap_kp_interrupt, 0,
-			"omap-keypad", 0) < 0)
-		return -EINVAL;
+	kp_tasklet.data = (unsigned long) omap_kp;
+
+	omap_kp->irq = platform_get_irq(pdev, 0);
+	if (omap_kp->irq) {
+		if (request_irq(omap_kp->irq, omap_kp_interrupt, 0,
+				"omap-keypad", 0) < 0)
+			return -EINVAL;
+	}
 
 	/* setup input device */
 	set_bit(EV_KEY, input_dev->evbit);
@@ -350,8 +340,17 @@ static int __init omap_kp_probe(struct p
 	}
 	/* scan current status and enable interrupt */
 	omap_kp_scan_keypad(keypad_state);
-	omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
 
+	if (!machine_is_omap_h4()) {
+		omap_writew(0, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+	} else {
+		for (i = 0; i < NUM_ROWS; i++) {
+			if (request_irq(OMAP_GPIO_IRQ(row_gpio_num[i]), omap_kp_interrupt, 0,
+						"omap-keypad", 0) < 0) 
+				return -EINVAL;
+			set_irq_type(OMAP_GPIO_IRQ(row_gpio_num[i]), IRQT_FALLING);
+		}
+	}
 	return 0;
 }
 
@@ -361,9 +360,19 @@ static int omap_kp_remove(struct platfor
 
 	/* disable keypad interrupt handling */
 	tasklet_disable(&kp_tasklet);
-	omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+	if (machine_is_omap_h4()) {
+		int i;
+		for (i = 0; i < NUM_COLS; i++)
+	    		omap_free_gpio(col_gpio_num[i]);
+		for (i = 0; i < NUM_ROWS; i++) {
+	    		omap_free_gpio(row_gpio_num[i]);
+			free_irq(OMAP_GPIO_IRQ(row_gpio_num[i]), 0);
+		}
+	} else {
+		omap_writew(1, OMAP_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
+		free_irq(omap_kp->irq, 0);
+	}
 
-	free_irq(keypad_irq, 0);
 	del_timer_sync(&omap_kp->timer);
 
 	/* unregister everything */
diff --git a/drivers/mmc/omap.c b/drivers/mmc/omap.c
diff --git a/drivers/mtd/maps/omap_nor.c b/drivers/mtd/maps/omap_nor.c
diff --git a/include/asm-arm/arch-omap/keypad.h b/include/asm-arm/arch-omap/keypad.h
new file mode 100644
index 0000000..5884529
--- /dev/null
+++ b/include/asm-arm/arch-omap/keypad.h
@@ -0,0 +1,13 @@
+#ifndef ASMARM_ARCH_KEYPAD_H
+#define ASMARM_ARCH_KEYPAD_H
+
+struct omap_kp_platform_data {
+	int rows;
+	int cols;
+	int *keymap;
+	unsigned int rep:1;
+};
+
+#define KEY(col, row, val) (((col) << 28) | ((row) << 24) | (val))
+
+#endif
diff --git a/include/asm-arm/arch-omap/menelaus.h b/include/asm-arm/arch-omap/menelaus.h
diff --git a/include/asm-arm/arch-omap/mux.h b/include/asm-arm/arch-omap/mux.h
index 8d1c62e..a9ec625 100644
--- a/include/asm-arm/arch-omap/mux.h
+++ b/include/asm-arm/arch-omap/mux.h
@@ -410,6 +410,27 @@ enum omap24xx_index {
 	/* 24xx GPIO */
 	Y20_24XX_GPIO60,
 	M15_24XX_GPIO92,
+
+
+	/* Keypad GPIO*/
+	T19_24XX_KBR0,
+	R19_24XX_KBR1,
+	V18_24XX_KBR2,
+	M21_24XX_KBR3,
+	E5__24XX_KBR4,
+	M18_24XX_KBR5,
+	R20_24XX_KBC0,
+	M14_24XX_KBC1,
+	H19_24XX_KBC2,
+	V17_24XX_KBC3,
+	P21_24XX_KBC4,
+	L14_24XX_KBC5,
+	N19_24XX_KBC6,
+
+	/* 24xx Meneluas Keypad GPIO */
+	B3__24XX_KBR5,
+	AA4_24XX_KBC2,
+	B13_24XX_KBC6,
 };
 
 #ifdef	CONFIG_OMAP_MUX
diff --git a/include/asm-arm/arch-pxa/mmc.h b/include/asm-arm/arch-pxa/mmc.h
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c

--0-358508944-1134219748=:87302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--0-358508944-1134219748=:87302--
