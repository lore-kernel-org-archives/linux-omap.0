From: "Kyungmin Park" <kmpark@infradead.org>
Subject: [PATCH] ARM: OMAP: Add apollon gpio keys using gpio-keys input
Date: Thu, 8 Mar 2007 13:21:23 +0900
Message-ID: <005101c76139$3e154540$c7a3580a@swcenter.sec.samsung.co.kr>
Reply-To: kmpark@infradead.org
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0052_01C76184.ADFCED40"
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

This is a multi-part message in MIME format.

------=_NextPart_000_0052_01C76184.ADFCED40
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit


This patch is adding apollon gpio keys using gpio-keys input.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

------=_NextPart_000_0052_01C76184.ADFCED40
Content-Type: text/plain;
	name="ARM-OMAP-Add-apollon-gpio-keys-using-gpio-keys-input.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ARM-OMAP-Add-apollon-gpio-keys-using-gpio-keys-input.txt"

>From 6ecac901e5c881effe8e234ae36714b626c6a1ee Mon Sep 17 00:00:00 2001=0A=
From: Kyungmin Park <kyungmin.park@samsung.com>=0A=
Date: Thu, 8 Mar 2007 13:12:28 +0900=0A=
Subject: [PATCH] ARM: OMAP: Add apollon gpio keys using gpio-keys input=0A=
=0A=
Add apollon gpio keys using gpio-keys input=0A=
=0A=
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>=0A=
---=0A=
 arch/arm/mach-omap2/Makefile             |    3 +-=0A=
 arch/arm/mach-omap2/board-apollon-keys.c |   79 =
++++++++++++++++++++++++++++++=0A=
 arch/arm/mach-omap2/board-apollon.c      |   53 --------------------=0A=
 3 files changed, 81 insertions(+), 54 deletions(-)=0A=
=0A=
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile=0A=
index 6842b28..853b8e4 100644=0A=
--- a/arch/arm/mach-omap2/Makefile=0A=
+++ b/arch/arm/mach-omap2/Makefile=0A=
@@ -21,7 +21,8 @@ mmu_mach-objs			:=3D mmu.o=0A=
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+=3D board-generic.o=0A=
 obj-$(CONFIG_MACH_OMAP_H4)		+=3D board-h4.o=0A=
 obj-$(CONFIG_MACH_OMAP_2430SDP)		+=3D board-2430sdp.o=0A=
-obj-$(CONFIG_MACH_OMAP_APOLLON)		+=3D board-apollon.o=0A=
+obj-$(CONFIG_MACH_OMAP_APOLLON)		+=3D board-apollon.o \=0A=
+					   board-apollon-keys.o=0A=
 obj-$(CONFIG_MACH_NOKIA_N800)		+=3D board-n800.o board-n800-flash.o \=0A=
 					   board-n800-mmc.o board-n800-bt.o \=0A=
 					   board-n800-audio.o board-n800-usb.o \=0A=
diff --git a/arch/arm/mach-omap2/board-apollon-keys.c =
b/arch/arm/mach-omap2/board-apollon-keys.c=0A=
new file mode 100644=0A=
index 0000000..6cd29ec=0A=
--- /dev/null=0A=
+++ b/arch/arm/mach-omap2/board-apollon-keys.c=0A=
@@ -0,0 +1,79 @@=0A=
+/*=0A=
+ * linux/arch/arm/mach-omap2/board-apollon-keys.c=0A=
+ *=0A=
+ * Copyright (C) 2007 Samsung Electronics=0A=
+ * Author: Kyungmin Park <kyungmin.park@samsung.com>=0A=
+ *=0A=
+ * This program is free software; you can redistribute it and/or modify=0A=
+ * it under the terms of the GNU General Public License version 2 as=0A=
+ * published by the Free Software Foundation.=0A=
+ */=0A=
+=0A=
+#include <linux/kernel.h>=0A=
+#include <linux/init.h>=0A=
+#include <linux/platform_device.h>=0A=
+#include <linux/input.h>=0A=
+#include <linux/gpio_keys.h>=0A=
+=0A=
+#include <asm/arch/gpio.h>=0A=
+#include <asm/arch/mux.h>=0A=
+=0A=
+#define SW_ENTER_GPIO16		16=0A=
+#define SW_UP_GPIO17		17=0A=
+#define SW_DOWN_GPIO58		58=0A=
+=0A=
+static struct gpio_keys_button apollon_gpio_keys_buttons[] =3D {=0A=
+	[0] =3D {=0A=
+		.keycode	=3D KEY_ENTER,=0A=
+		.gpio		=3D SW_ENTER_GPIO16,=0A=
+		.desc		=3D "enter sw",=0A=
+	},=0A=
+	[1] =3D {=0A=
+		.keycode	=3D KEY_UP,=0A=
+		.gpio		=3D SW_UP_GPIO17,=0A=
+		.desc		=3D "up sw",=0A=
+	},=0A=
+	[2] =3D {=0A=
+		.keycode	=3D KEY_DOWN,=0A=
+		.gpio		=3D SW_DOWN_GPIO58,=0A=
+		.desc		=3D "down sw",=0A=
+	},=0A=
+};=0A=
+=0A=
+static struct gpio_keys_platform_data apollon_gpio_keys =3D {=0A=
+	.buttons		=3D apollon_gpio_keys_buttons,=0A=
+	.nbuttons		=3D ARRAY_SIZE(apollon_gpio_keys_buttons),=0A=
+};=0A=
+=0A=
+static struct platform_device apollon_gpio_keys_device =3D {=0A=
+	.name			=3D "gpio-keys",=0A=
+	.id			=3D -1,=0A=
+	.dev			=3D {=0A=
+		.platform_data	=3D &apollon_gpio_keys,=0A=
+	},=0A=
+};=0A=
+=0A=
+static void __init apollon_sw_init(void)=0A=
+{=0A=
+	/* Enter SW - Y11 */=0A=
+	omap_cfg_reg(Y11_242X_GPIO16);=0A=
+	omap_request_gpio(SW_ENTER_GPIO16);=0A=
+	omap_set_gpio_direction(SW_ENTER_GPIO16, 1);=0A=
+	/* Up SW - AA12 */=0A=
+	omap_cfg_reg(AA12_242X_GPIO17);=0A=
+	omap_request_gpio(SW_UP_GPIO17);=0A=
+	omap_set_gpio_direction(SW_UP_GPIO17, 1);=0A=
+	/* Down SW - AA8 */=0A=
+	omap_cfg_reg(AA8_242X_GPIO58);=0A=
+	omap_request_gpio(SW_DOWN_GPIO58);=0A=
+	omap_set_gpio_direction(SW_DOWN_GPIO58, 1);=0A=
+}=0A=
+=0A=
+static int __init omap_apollon_keys_init(void)=0A=
+{=0A=
+	apollon_sw_init();=0A=
+=0A=
+	return platform_device_register(&apollon_gpio_keys_device);=0A=
+}=0A=
+=0A=
+arch_initcall(omap_apollon_keys_init);=0A=
diff --git a/arch/arm/mach-omap2/board-apollon.c =
b/arch/arm/mach-omap2/board-apollon.c=0A=
index 5488961..9e6dd0b 100644=0A=
--- a/arch/arm/mach-omap2/board-apollon.c=0A=
+++ b/arch/arm/mach-omap2/board-apollon.c=0A=
@@ -22,11 +22,8 @@=0A=
 #include <linux/mtd/mtd.h>=0A=
 #include <linux/mtd/partitions.h>=0A=
 #include <linux/mtd/onenand.h>=0A=
-#include <linux/irq.h>=0A=
-#include <linux/interrupt.h>=0A=
 #include <linux/delay.h>=0A=
 #include <linux/leds.h>=0A=
-#include <linux/irq.h>=0A=
 #include <linux/err.h>=0A=
 #include <linux/clk.h>=0A=
 =0A=
@@ -48,9 +45,6 @@=0A=
 #define LED0_GPIO13		13=0A=
 #define LED1_GPIO14		14=0A=
 #define LED2_GPIO15		15=0A=
-#define SW_ENTER_GPIO16		16=0A=
-#define SW_UP_GPIO17		17=0A=
-#define SW_DOWN_GPIO58		58=0A=
 =0A=
 #define APOLLON_FLASH_CS	0=0A=
 #define APOLLON_ETH_CS		1=0A=
@@ -302,52 +296,6 @@ static void __init apollon_led_init(void)=0A=
 	omap_set_gpio_dataout(LED2_GPIO15, 0);=0A=
 }=0A=
 =0A=
-static irqreturn_t apollon_sw_interrupt(int irq, void *ignored)=0A=
-{=0A=
-	static unsigned int led0, led1, led2;=0A=
-=0A=
-	if (irq =3D=3D OMAP_GPIO_IRQ(SW_ENTER_GPIO16))=0A=
-		omap_set_gpio_dataout(LED0_GPIO13, led0 ^=3D 1);=0A=
-	else if (irq =3D=3D OMAP_GPIO_IRQ(SW_UP_GPIO17))=0A=
-		omap_set_gpio_dataout(LED1_GPIO14, led1 ^=3D 1);=0A=
-	else if (irq =3D=3D OMAP_GPIO_IRQ(SW_DOWN_GPIO58))=0A=
-		omap_set_gpio_dataout(LED2_GPIO15, led2 ^=3D 1);=0A=
-=0A=
-	return IRQ_HANDLED;=0A=
-}=0A=
-=0A=
-static void __init apollon_sw_init(void)=0A=
-{=0A=
-	/* Enter SW - Y11 */=0A=
-	omap_cfg_reg(Y11_242X_GPIO16);=0A=
-	omap_request_gpio(SW_ENTER_GPIO16);=0A=
-	omap_set_gpio_direction(SW_ENTER_GPIO16, 1);=0A=
-	/* Up SW - AA12 */=0A=
-	omap_cfg_reg(AA12_242X_GPIO17);=0A=
-	omap_request_gpio(SW_UP_GPIO17);=0A=
-	omap_set_gpio_direction(SW_UP_GPIO17, 1);=0A=
-	/* Down SW - AA8 */=0A=
-	omap_cfg_reg(AA8_242X_GPIO58);=0A=
-	omap_request_gpio(SW_DOWN_GPIO58);=0A=
-	omap_set_gpio_direction(SW_DOWN_GPIO58, 1);=0A=
-=0A=
-	set_irq_type(OMAP_GPIO_IRQ(SW_ENTER_GPIO16), IRQT_RISING);=0A=
-	if (request_irq(OMAP_GPIO_IRQ(SW_ENTER_GPIO16), &apollon_sw_interrupt,=0A=
-				IRQF_SHARED, "enter sw",=0A=
-				&apollon_sw_interrupt))=0A=
-		return;=0A=
-	set_irq_type(OMAP_GPIO_IRQ(SW_UP_GPIO17), IRQT_RISING);=0A=
-	if (request_irq(OMAP_GPIO_IRQ(SW_UP_GPIO17), &apollon_sw_interrupt,=0A=
-				IRQF_SHARED, "up sw",=0A=
-				&apollon_sw_interrupt))=0A=
-		return;=0A=
-	set_irq_type(OMAP_GPIO_IRQ(SW_DOWN_GPIO58), IRQT_RISING);=0A=
-	if (request_irq(OMAP_GPIO_IRQ(SW_DOWN_GPIO58), &apollon_sw_interrupt,=0A=
-				IRQF_SHARED, "down sw",=0A=
-				&apollon_sw_interrupt))=0A=
-		return;=0A=
-}=0A=
-=0A=
 static void __init apollon_usb_init(void)=0A=
 {=0A=
 	/* USB device */=0A=
@@ -361,7 +309,6 @@ static void __init apollon_usb_init(void)=0A=
 static void __init omap_apollon_init(void)=0A=
 {=0A=
 	apollon_led_init();=0A=
-	apollon_sw_init();=0A=
 	apollon_flash_init();=0A=
 	apollon_usb_init();=0A=
 =0A=
-- =0A=
1.4.4.2=0A=
=0A=

------=_NextPart_000_0052_01C76184.ADFCED40
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


------=_NextPart_000_0052_01C76184.ADFCED40--
