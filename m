From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.28-rc6-omap] twl4030-power: minor cleanup
Date: Wed, 26 Nov 2008 13:09:08 -0800
Message-ID: <200811261309.08320.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:28554 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752222AbYKZVJL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Nov 2008 16:09:11 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: David Brownell <dbrownell@users.sourceforge.net>

Minor cleanups to the twl4030 power script support:  move its
init code out of the "add children" call (it adds no children!),
and move the power bus messages earlier in the header file to
unclutter the platform data section and since they're not used
only for those scripts.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/mfd/twl4030-core.c  |    7 +--
 include/linux/i2c/twl4030.h |   94 +++++++++++++++++++++---------------------
 2 files changed, 53 insertions(+), 48 deletions(-)

--- a/drivers/mfd/twl4030-core.c
+++ b/drivers/mfd/twl4030-core.c
@@ -503,9 +503,6 @@ add_children(struct twl4030_platform_dat
 			return PTR_ERR(child);
 	}
 
-	if (twl_has_power() && pdata->power)
-		twl4030_power_init(pdata->power);
-
 	if (twl_has_rtc()) {
 		/*
 		 * REVISIT platform_data here currently might expose the
@@ -788,6 +785,10 @@ twl4030_probe(struct i2c_client *client,
 	/* setup clock framework */
 	clocks_init();
 
+	/* load power event scripts */
+	if (twl_has_power() && pdata->power)
+		twl4030_power_init(pdata->power);
+
 	/* Maybe init the T2 Interrupt subsystem */
 	if (client->irq
 			&& pdata->irq_base
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -168,7 +168,7 @@ int twl4030_i2c_read(u8 mod_no, u8 *valu
 /*----------------------------------------------------------------------*/
 
 /*
- * Multichannel ADC register offsets (use TWL4030_MODULE_MADC)
+ * Monitoring ADC register offsets (use TWL4030_MODULE_MADC)
  * ... SIH/interrupt only
  */
 
@@ -218,6 +218,53 @@ int twl4030_i2c_read(u8 mod_no, u8 *valu
 
 /*----------------------------------------------------------------------*/
 
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
+ * Power Bus Message Format ... these can be sent individually by Linux,
+ * but are usually part of downloaded scripts that are run when various
+ * power events are triggered.
+ *
+ *  Broadcast Message (16 Bits):
+ *    DEV_GRP[15:13] MT[12]  RES_GRP[11:9]  RES_TYPE2[8:7] RES_TYPE[6:4]
+ *    RES_STATE[3:0]
+ *
+ *  Singular Message (16 Bits):
+ *    DEV_GRP[15:13] MT[12]  RES_ID[11:4]  RES_STATE[3:0]
+ */
+
+#define MSG_BROADCAST(devgrp, grp, type, type2, state) \
+	( (devgrp) << 13 | 1 << 12 | (grp) << 9 | (type2) << 7 \
+	| (type) << 4 | (state))
+
+#define MSG_SINGULAR(devgrp, id, state) \
+	((devgrp) << 13 | 0 << 12 | (id) << 4 | (state))
+
+/*----------------------------------------------------------------------*/
+
 struct twl4030_bci_platform_data {
 	int *battery_tmp_tbl;
 	unsigned int tblsize;
@@ -281,60 +328,17 @@ struct twl4030_script {
 	struct twl4030_ins *script;
 	unsigned size;
 	u8 flags;
-};
 #define TRITON_WRST_SCRIPT	(1<<0)
 #define TRITON_WAKEUP12_SCRIPT	(1<<1)
 #define TRITON_WAKEUP3_SCRIPT	(1<<2)
 #define TRITON_SLEEP_SCRIPT	(1<<3)
+};
 
 struct twl4030_power_data {
 	struct twl4030_script **scripts;
 	unsigned size;
 };
 
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
 struct twl4030_platform_data {
 	unsigned				irq_base, irq_end;
 	struct twl4030_bci_platform_data	*bci;
