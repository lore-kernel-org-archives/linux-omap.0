From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: [PATCH] TWL4030: Reset header file to mainline
Date: Wed, 17 Jun 2009 14:29:42 +0300
Message-ID: <1245238182-11697-1-git-send-email-amit.kucheria@verdurent.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:59418 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbZFQLaq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Jun 2009 07:30:46 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id n5HBToRI005695
	for <linux-omap@vger.kernel.org>; Wed, 17 Jun 2009 06:30:49 -0500
Received: from localhost.localdomain (esdhcp04173.research.nokia.com [172.21.41.73])
	by mgw-sa01.ext.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n5HBTigR025781
	for <linux-omap@vger.kernel.org>; Wed, 17 Jun 2009 14:29:44 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Reset twl4030.h to what is upstream. Patches to restore twl4030_power
functionality will follow directly to lkml.

Compile-tested only.

Signed-off-by: Amit Kucheria <amit.kucheria@verdurent.com>
---
 include/linux/i2c/twl4030.h |   78 +++---------------------------------------
 1 files changed, 6 insertions(+), 72 deletions(-)

diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index 87accda..0dc80ef 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -243,37 +243,6 @@ int twl4030_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 #define RES_STATE_SLEEP		0x8
 #define RES_STATE_OFF		0x0
 
-/* Power resources */
-
-#define RES_VAUX1               1
-#define RES_VAUX2               2
-#define RES_VAUX3               3
-#define RES_VAUX4               4
-#define RES_VMMC1               5
-#define RES_VMMC2               6
-#define RES_VPLL1               7
-#define RES_VPLL2               8
-#define RES_VSIM                9
-#define RES_VDAC                10
-#define RES_VINTANA1            11
-#define RES_VINTANA2            12
-#define RES_VINTDIG             13
-#define RES_VIO                 14
-#define RES_VDD1                15
-#define RES_VDD2                16
-#define RES_VUSB_1V5            17
-#define RES_VUSB_1V8            18
-#define RES_VUSB_3V1            19
-#define RES_VUSBCP              20
-#define RES_REGEN               21
-#define RES_NRES_PWRON          22
-#define RES_CLKEN               23
-#define RES_SYSEN               24
-#define RES_HFCLKOUT            25
-#define RES_32KCLKOUT           26
-#define RES_RESET               27
-#define RES_Main_Ref            28
-
 /*
  * Power Bus Message Format ... these can be sent individually by Linux,
  * but are usually part of downloaded scripts that are run when various
@@ -333,19 +302,12 @@ struct twl4030_madc_platform_data {
 	int		irq_line;
 };
 
-/* Boards have uniqe mappings of {col, row} --> keycode.
- * Column and row are 4 bits, but range only from 0..7;
- * a PERSISTENT_KEY is "always on" and never reported.
- */
-#define KEY_PERSISTENT		0x00800000
-#define KEY(col, row, keycode)	(((col) << 28) | ((row) << 24) | (keycode))
-#define PERSISTENT_KEY(c, r)	KEY(c, r, KEY_PERSISTENT)
-
 struct twl4030_keypad_data {
-	unsigned rows;
-	unsigned cols;
-	unsigned *keymap;
-	unsigned short keymapsize;
+	int rows;
+	int cols;
+	int *keymap;
+	int irq;
+	unsigned int keymapsize;
 	unsigned int rep:1;
 };
 
@@ -358,34 +320,6 @@ struct twl4030_usb_data {
 	enum twl4030_usb_mode	usb_mode;
 };
 
-struct twl4030_ins {
-	u16 pmb_message;
-	u8 delay;
-};
-
-struct twl4030_script {
-	struct twl4030_ins *script;
-	unsigned size;
-	u8 flags;
-#define TRITON_WRST_SCRIPT	(1<<0)
-#define TRITON_WAKEUP12_SCRIPT	(1<<1)
-#define TRITON_WAKEUP3_SCRIPT	(1<<2)
-#define TRITON_SLEEP_SCRIPT	(1<<3)
-};
-
-struct twl4030_resconfig {
-	u8 resource;
-	u8 devgroup;
-	u8 type;
-	u8 type2;
-};
-
-struct twl4030_power_data {
-	struct twl4030_script **scripts;
-	unsigned size;
-	const struct twl4030_resconfig *resource_config;
-};
-
 struct twl4030_platform_data {
 	unsigned				irq_base, irq_end;
 	struct twl4030_bci_platform_data	*bci;
@@ -393,7 +327,6 @@ struct twl4030_platform_data {
 	struct twl4030_madc_platform_data	*madc;
 	struct twl4030_keypad_data		*keypad;
 	struct twl4030_usb_data			*usb;
-	struct twl4030_power_data		*power;
 
 	/* LDO regulators */
 	struct regulator_init_data		*vdac;
@@ -424,6 +357,7 @@ int twl4030_sih_setup(int module);
 #define TWL4030_VAUX3_DEV_GRP		0x1F
 #define TWL4030_VAUX3_DEDICATED		0x22
 
+
 #if defined(CONFIG_TWL4030_BCI_BATTERY) || \
 	defined(CONFIG_TWL4030_BCI_BATTERY_MODULE)
 	extern int twl4030charger_usb_en(int enable);
-- 
1.6.3.1

