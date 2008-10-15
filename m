From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 1/6] Add defines and data types for twl4030.
Date: Wed, 15 Oct 2008 16:37:29 +0300
Message-ID: <1224077854-23481-2-git-send-email-peter.de-schrijver@nokia.com>
References: <1224077854-23481-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59625 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934AbYJONiB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Oct 2008 09:38:01 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9FDblTK029721
	for <linux-omap@vger.kernel.org>; Wed, 15 Oct 2008 16:37:58 +0300
In-Reply-To: <1224077854-23481-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch adds a bunch of data types and defines to handle the twl4030 power sequence scripts.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 include/linux/i2c/twl4030.h |   64 +++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index cdb4531..7dc4ee1 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -264,6 +264,69 @@ struct twl4030_usb_data {
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
@@ -271,6 +334,7 @@ struct twl4030_platform_data {
 	struct twl4030_madc_platform_data	*madc;
 	struct twl4030_keypad_data		*keypad;
 	struct twl4030_usb_data			*usb;
+	struct twl4030_power_data		*power;
 
 	/* REVISIT more to come ... _nothing_ should be hard-wired */
 };
-- 
1.5.6.3

