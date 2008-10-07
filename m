From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 2/3] Adapt twl4030 power code to new twl4030 code
Date: Tue,  7 Oct 2008 17:34:09 +0300
Message-ID: <1223390050-11499-3-git-send-email-peter.de-schrijver@nokia.com>
References: <1223390050-11499-1-git-send-email-peter.de-schrijver@nokia.com>
 <1223390050-11499-2-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:53627 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbYJGOea (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Oct 2008 10:34:30 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m97EYPJk020127
	for <linux-omap@vger.kernel.org>; Tue, 7 Oct 2008 17:34:27 +0300
In-Reply-To: <1223390050-11499-2-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 drivers/i2c/chips/twl4030-power.c |  290 +++++++++++++++----------------------
 include/linux/i2c/twl4030.h       |   64 ++++++++
 2 files changed, 181 insertions(+), 173 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-power.c b/drivers/i2c/chips/twl4030-power.c
index cb325b0..4a543a2 100644
--- a/drivers/i2c/chips/twl4030-power.c
+++ b/drivers/i2c/chips/twl4030-power.c
@@ -26,17 +26,20 @@
 #include <linux/module.h>
 #include <linux/pm.h>
 #include <linux/i2c/twl4030.h>
+#include <linux/platform_device.h>
 
 #include <asm/mach-types.h>
 
+static u8 triton_next_free_address = 0x2b;
+
 #define PWR_P1_SW_EVENTS	0x10
 #define PWR_DEVOFF	(1<<0)
 
 #define PHY_TO_OFF_PM_MASTER(p)		(p - 0x36)
-#define PHY_TO_OFF_PM_RECIEVER(p)	(p - 0x5b)
+#define PHY_TO_OFF_PM_RECEIVER(p)	(p - 0x5b)
 
 /* resource - hfclk */
-#define R_HFCLKOUT_DEV_GRP 	PHY_TO_OFF_PM_RECIEVER(0xe6)
+#define R_HFCLKOUT_DEV_GRP 	PHY_TO_OFF_PM_RECEIVER(0xe6)
 
 /* PM events */
 #define R_P1_SW_EVENTS		PHY_TO_OFF_PM_MASTER(0x46)
@@ -50,8 +53,6 @@
 
 #define ENABLE_WARMRESET (1<<4)
 
-/* sequence script */
-
 #define END_OF_SCRIPT		0x3f
 
 #define R_SEQ_ADD_A2S		PHY_TO_OFF_PM_MASTER(0x55)
@@ -61,112 +62,10 @@
 #define R_MEMORY_ADDRESS	PHY_TO_OFF_PM_MASTER(0x59)
 #define R_MEMORY_DATA		PHY_TO_OFF_PM_MASTER(0x5a)
 
-/* Power bus message definitions */
-
-#define DEV_GRP_NULL		0x0
-#define DEV_GRP_P1		0x1
-#define DEV_GRP_P2		0x2
-#define DEV_GRP_P3		0x4
-
-#define RES_GRP_RES		0x0
-#define RES_GRP_PP		0x1
-#define RES_GRP_RC		0x2
-#define RES_GRP_PP_RC		0x3
-#define RES_GRP_PR		0x4
-#define RES_GRP_PP_PR		0x5
-#define RES_GRP_RC_PR		0x6
-#define RES_GRP_ALL		0x7
-
-#define RES_TYPE2_R0		0x0
-
-#define RES_TYPE_ALL		0x7
-
-#define RES_STATE_WRST		0xF
-#define RES_STATE_ACTIVE	0xE
-#define RES_STATE_SLEEP		0x8
-#define RES_STATE_OFF		0x0
-
-/*
-*	Power Bus Message Format
-*
-*	Broadcast Message (16 Bits)
-*	DEV_GRP[15:13] MT[12]  RES_GRP[11:9]  RES_TYPE2[8:7] RES_TYPE[6:4]
-*	RES_STATE[3:0]
-*
-*	Singular Message (16 Bits)
-*	DEV_GRP[15:13] MT[12]  RES_ID[11:4]  RES_STATE[3:0]
-*
-*/
-
-#define MSG_BROADCAST(devgrp, grp, type, type2, state) \
-	(devgrp << 13 | 1 << 12 | grp << 9 | type2 << 7 | type << 4 | state)
-
-#define MSG_SINGULAR(devgrp, id, state) \
-	(devgrp << 13 | 0 << 12 | id << 4 | state)
-
 #define R_PROTECT_KEY		0x0E
 #define KEY_1			0xC0
 #define KEY_2			0x0C
 
-struct triton_ins {
-	u16 pmb_message;
-	u8 delay;
-};
-
-
-#define CONFIG_DISABLE_HFCLK	1
-
-#if defined(CONFIG_MACH_OMAP_3430SDP) || defined(CONFIG_MACH_OMAP_3430LABRADOR)
-
-struct triton_ins sleep_on_seq[] __initdata = {
-	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_OFF), 4},
-	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_OFF), 2},
-#ifdef CONFIG_DISABLE_HFCLK
-	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_OFF), 3},
-	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_OFF), 3},
-#endif /* #ifdef CONFIG_DISABLE_HFCLK */
-};
-
-struct triton_ins sleep_off_seq[] __initdata = {
-#ifndef CONFIG_DISABLE_HFCLK
-	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_ACTIVE), 4},
-	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_ACTIVE), 2},
-#else
-	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_ACTIVE), 0x30},
-	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_ACTIVE), 0x30},
-	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_ACTIVE), 0x37},
-	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 3},
-#endif /* #ifndef CONFIG_DISABLE_HFCLK */
-};
-
-struct triton_ins t2_wrst_seq[] __initdata = {
-	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_OFF), 2},
-	{MSG_SINGULAR(DEV_GRP_P1, 0xf, RES_STATE_WRST), 15},
-	{MSG_SINGULAR(DEV_GRP_P1, 0x10, RES_STATE_WRST), 15},
-	{MSG_SINGULAR(DEV_GRP_P1, 0x7, RES_STATE_WRST), 0x60},
-	{MSG_SINGULAR(DEV_GRP_P1, 0x19, RES_STATE_ACTIVE), 2},
-	{MSG_SINGULAR(DEV_GRP_NULL, 0x1b, RES_STATE_ACTIVE), 2},
-};
-#else
-struct triton_ins sleep_on_seq[] __initdata = {
-	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_RC, RES_TYPE_ALL, RES_TYPE2_R0,
-			RES_STATE_SLEEP), 4},
-	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_ALL, RES_TYPE2_R0,
-			RES_STATE_SLEEP), 4},
-};
-
-struct triton_ins sleep_off_seq[] __initdata = {
-	{MSG_SINGULAR(DEV_GRP_NULL, 0x17, RES_STATE_ACTIVE), 0x30},
-	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_PP_PR, RES_TYPE_ALL, RES_TYPE2_R0,
-			RES_STATE_ACTIVE), 0x37},
-	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_ALL, RES_TYPE2_R0,
-			RES_STATE_ACTIVE), 0x2},
-};
-
-struct triton_ins t2_wrst_seq[] __initdata = { };
-
-#endif
-
 static int __init twl4030_write_script_byte(u8 address, u8 byte)
 {
 	int err;
@@ -193,7 +92,7 @@ static int __init twl4030_write_script_ins(u8 address, u16 pmb_message,
 	return err;
 }
 
-static int __init twl4030_write_script(u8 address, struct triton_ins *script,
+static int __init twl4030_write_script(u8 address, struct twl4030_ins *script,
 					int len)
 {
 	int err = 0;
@@ -214,37 +113,37 @@ static int __init twl4030_write_script(u8 address, struct triton_ins *script,
 	return err;
 }
 
-static int __init config_sleep_wake_sequence(void)
+static int __init config_wakeup3_sequence(u8 address)
 {
+
 	int err = 0;
 
-	/*
-	 * CLKREQ is pulled high on the 2430SDP, therefore, we need to take
-	 * it out of the HFCLKOUT DEV_GRP for P1 else HFCLKOUT can't be stopped.
-	 */
+	/* Set SLEEP to ACTIVE SEQ address for P3 */
+	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, address,
+				  R_SEQ_ADD_S2A3);
 
-	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
-				  0x20, R_HFCLKOUT_DEV_GRP);
+	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, LVL_WAKEUP,
+					R_P3_SW_EVENTS);
+	if (err)
+		printk(KERN_ERR "TWL4030 wakeup sequence for P3" \
+				"config error\n");
 
-	/* Set ACTIVE to SLEEP SEQ address in T2 memory*/
-	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0x2B,
-				  R_SEQ_ADD_A2S);
+	return err;
+}
+
+static int __init config_wakeup12_sequence(u8 address)
+{
+	int err = 0;
 
 	/* Set SLEEP to ACTIVE SEQ address for P1 and P2 */
-	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0x2F,
+	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, address,
 				  R_SEQ_ADD_SA12);
 
-	/* Set SLEEP to ACTIVE SEQ address for P3 */
-	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0x2F,
-				  R_SEQ_ADD_S2A3);
-
-	/* Install Active->Sleep (A2S) sequence */
-	err |= twl4030_write_script(0x2B, sleep_on_seq,
-					ARRAY_SIZE(sleep_on_seq));
-
-	/* Install Sleep->Active (S2A) sequence */
-	err |= twl4030_write_script(0x2F, sleep_off_seq,
-					ARRAY_SIZE(sleep_off_seq));
+	/* P1/P2/P3 LVL_WAKEUP should be on LEVEL */
+	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, LVL_WAKEUP,
+					R_P1_SW_EVENTS);
+	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, LVL_WAKEUP,
+					R_P2_SW_EVENTS);
 
 	if (machine_is_omap_3430sdp() || machine_is_omap_ldp()) {
 		u8 data;
@@ -256,83 +155,115 @@ static int __init config_sleep_wake_sequence(void)
 						R_CFG_P1_TRANSITION);
 	}
 
-	/* P1/P2/P3 LVL_WAKEUP should be on LEVEL */
-	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, LVL_WAKEUP,
-					R_P1_SW_EVENTS);
-	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, LVL_WAKEUP,
-					R_P2_SW_EVENTS);
-	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, LVL_WAKEUP,
-				R_P3_SW_EVENTS);
-
 	if (err)
-		printk(KERN_ERR "TWL4030 sleep-wake sequence config error\n");
+		printk(KERN_ERR "TWL4030 wakeup sequence for P1 and P2" \
+				"config error\n");
 
 	return err;
 }
 
+static int __init config_sleep_sequence(u8 address)
+{
+	int err = 0;
+
+	/*
+	 * CLKREQ is pulled high on the 2430SDP, therefore, we need to take
+	 * it out of the HFCLKOUT DEV_GRP for P1 else HFCLKOUT can't be stopped.
+	 */
+
+	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
+				  0x20, R_HFCLKOUT_DEV_GRP);
+
+	/* Set ACTIVE to SLEEP SEQ address in T2 memory*/
+	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, address,
+				  R_SEQ_ADD_A2S);
 
-/* Programming the WARMRESET Sequence on TRITON */
-static int __init config_warmreset_sequence(void)
+	if (err)
+		printk(KERN_ERR "TWL4030 sleep sequence config error\n");
+
+	return err;
+}
+
+static int __init config_warmreset_sequence(u8 address)
 {
 
-	int e = 0;
+	int err = 0;
 	u8 rd_data;
 
-	if (!ARRAY_SIZE(t2_wrst_seq))
-		return 0;
-
 	/* Set WARM RESET SEQ address for P1 */
-	e |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0x38,
-				R_SEQ_ADD_WARM);
-
-	/* Install Warm Reset sequence */
-	e |= twl4030_write_script(0x38, t2_wrst_seq,
-					ARRAY_SIZE(t2_wrst_seq));
+	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, address,
+					R_SEQ_ADD_WARM);
 
 	/* P1/P2/P3 enable WARMRESET */
-	e |= twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &rd_data,
-				R_P1_SW_EVENTS);
+	err |= twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &rd_data,
+					R_P1_SW_EVENTS);
 	rd_data |= ENABLE_WARMRESET;
-	e |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, rd_data,
-				R_P1_SW_EVENTS);
+	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, rd_data,
+					R_P1_SW_EVENTS);
 
-	e |= twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &rd_data,
-				R_P2_SW_EVENTS);
+	err |= twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &rd_data,
+					R_P2_SW_EVENTS);
 	rd_data |= ENABLE_WARMRESET;
-	e |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, rd_data,
-				R_P2_SW_EVENTS);
+	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, rd_data,
+					R_P2_SW_EVENTS);
 
-	e |= twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &rd_data,
-				R_P3_SW_EVENTS);
+	err |= twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &rd_data,
+					R_P3_SW_EVENTS);
 	rd_data |= ENABLE_WARMRESET;
-	e |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, rd_data,
-				R_P3_SW_EVENTS);
+	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, rd_data,
+					R_P3_SW_EVENTS);
 
-	if (e)
+	if (err)
 		printk(KERN_ERR
 			"TWL4030 Power Companion Warmreset seq config error\n");
-	return e;
+	return err;
 }
 
-static int __init twl4030_power_init(void)
+static int __init load_triton_script(struct twl4030_script *tscript)
+{
+	u8 address = triton_next_free_address;
+	int err;
+
+	err = twl4030_write_script(address, tscript->script, tscript->size);
+	if (err)
+		return err;
+
+	triton_next_free_address += tscript->size;
+
+	if (tscript->flags & TRITON_WRST_SCRIPT)
+		err |= config_warmreset_sequence(address);
+
+	if (tscript->flags & TRITON_WAKEUP12_SCRIPT)
+		err |= config_wakeup12_sequence(address);
+
+	if (tscript->flags & TRITON_WAKEUP3_SCRIPT)
+		err |= config_wakeup3_sequence(address);
+
+	if (tscript->flags & TRITON_SLEEP_SCRIPT)
+		err |= config_sleep_sequence(address);
+
+	return err;
+}
+
+static int __init twl4030_power_probe(struct platform_device *pdev)
 {
+	struct twl4030_power_data *triton2_scripts =
+		(struct twl4030_power_data *)pdev->dev.platform_data;
 	int err = 0;
+	int i;
 
 	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, KEY_1,
 				R_PROTECT_KEY);
 	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, KEY_2,
 				R_PROTECT_KEY);
-
 	if (err)
 		return err;
 
-	err = config_sleep_wake_sequence();
-	if (err)
-		return err;
-
-	err = config_warmreset_sequence();
-	if (err)
-		return err;
+	for (i = 0; i < triton2_scripts->size; i++) {
+		err = load_triton_script(triton2_scripts->scripts[i]);
+		if (err)
+			return err;
+	}
 
 	err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, 0, R_PROTECT_KEY);
 
@@ -340,4 +271,17 @@ static int __init twl4030_power_init(void)
 
 }
 
+static struct platform_driver twl4030_power = {
+	.probe		= twl4030_power_probe,
+	.driver		= {
+		.name = "twl4030_power",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init twl4030_power_init(void)
+{
+	return platform_driver_register(&twl4030_power);
+}
+
 module_init(twl4030_power_init);
diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index f5a1bfa..0ef5695 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -98,6 +98,69 @@ struct twl4030_usb_data {
 	enum twl4030_usb_mode	usb_mode;
 };
 
+struct twl4030_ins {
+	u16 pmb_message;
+	u8 delay;
+};
+
+struct twl4030_script {
+	struct twl4030_ins *script;
+	unsigned size;
+	u8 flags;
+};
+#define TRITON_WRST_SCRIPT	(1<<0)
+#define TRITON_WAKEUP12_SCRIPT	(1<<1)
+#define TRITON_WAKEUP3_SCRIPT	(1<<2)
+#define TRITON_SLEEP_SCRIPT	(1<<3)
+
+struct twl4030_power_data {
+	struct twl4030_script **scripts;
+	unsigned size;
+};
+
+/* Power bus message definitions */
+
+#define DEV_GRP_NULL		0x0
+#define DEV_GRP_P1		0x1
+#define DEV_GRP_P2		0x2
+#define DEV_GRP_P3		0x4
+
+#define RES_GRP_RES		0x0
+#define RES_GRP_PP		0x1
+#define RES_GRP_RC		0x2
+#define RES_GRP_PP_RC		0x3
+#define RES_GRP_PR		0x4
+#define RES_GRP_PP_PR		0x5
+#define RES_GRP_RC_PR		0x6
+#define RES_GRP_ALL		0x7
+
+#define RES_TYPE2_R0		0x0
+
+#define RES_TYPE_ALL		0x7
+
+#define RES_STATE_WRST		0xF
+#define RES_STATE_ACTIVE	0xE
+#define RES_STATE_SLEEP		0x8
+#define RES_STATE_OFF		0x0
+
+/*
+*	Power Bus Message Format
+*
+*	Broadcast Message (16 Bits)
+*	DEV_GRP[15:13] MT[12]  RES_GRP[11:9]  RES_TYPE2[8:7] RES_TYPE[6:4]
+*	RES_STATE[3:0]
+*
+*	Singular Message (16 Bits)
+*	DEV_GRP[15:13] MT[12]  RES_ID[11:4]  RES_STATE[3:0]
+*
+*/
+
+#define MSG_BROADCAST(devgrp, grp, type, type2, state) \
+	(devgrp << 13 | 1 << 12 | grp << 9 | type2 << 7 | type << 4 | state)
+
+#define MSG_SINGULAR(devgrp, id, state) \
+	(devgrp << 13 | 0 << 12 | id << 4 | state)
+
 struct twl4030_platform_data {
 	unsigned				irq_base, irq_end;
 	struct twl4030_bci_platform_data	*bci;
@@ -105,6 +168,7 @@ struct twl4030_platform_data {
 	struct twl4030_madc_platform_data	*madc;
 	struct twl4030_keypad_data		*keypad;
 	struct twl4030_usb_data			*usb;
+	struct twl4030_power_data		*power;
 
 	/* REVISIT more to come ... _nothing_ should be hard-wired */
 };
-- 
1.5.6.3

