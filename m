From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] Fix build for beagleboard
Date: Tue, 16 Sep 2008 15:29:23 +0300
Message-ID: <1221568163-30976-1-git-send-email-peter.de-schrijver@nokia.com>
References: <20080915182259.GB7782@frodo>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:27268 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbYIPM3m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Sep 2008 08:29:42 -0400
In-Reply-To: <20080915182259.GB7782@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, me@felipebalbi.com
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 drivers/i2c/chips/twl4030-power.c |   25 +++++++++++++++----------
 1 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-power.c b/drivers/i2c/chips/twl4030-power.c
index 195c3c4..ea8f447 100644
--- a/drivers/i2c/chips/twl4030-power.c
+++ b/drivers/i2c/chips/twl4030-power.c
@@ -212,7 +216,6 @@ static int __init twl4030_write_script(u8 address, struct triton_ins *script,
 static int __init config_sleep_wake_sequence(void)
 {
 	int err = 0;
-	u8 data;
 
 	/*
 	 * CLKREQ is pulled high on the 2430SDP, therefore, we need to take
@@ -242,14 +245,16 @@ static int __init config_sleep_wake_sequence(void)
 	err |= twl4030_write_script(0x2F, sleep_off_seq,
 					ARRAY_SIZE(sleep_off_seq));
 
-#if defined(CONFIG_MACH_OMAP_3430SDP) || defined(CONFIG_MACH_OMAP_3430LABRADOR)
-	/* Disabling AC charger effect on sleep-active transitions */
-	err |= twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &data,
-					R_CFG_P1_TRANSITION);
-	data &= 0x0;
-	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, data ,
-					R_CFG_P1_TRANSITION);
-#endif
+	if (machine_is_omap_3430sdp() || machine_is_omap_ldp()) {
+		u8 data;
+		/* Disabling AC charger effect on sleep-active transitions */
+		err |= twl4030_i2c_read_u8(TWL4030_MODULE_PM_MASTER, &data,
+						R_CFG_P1_TRANSITION);
+		data &= ~(1<<1);
+		err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, data ,
+						R_CFG_P1_TRANSITION);
+	}
+
 	/* P1/P2/P3 LVL_WAKEUP should be on LEVEL */
 	err |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_MASTER, LVL_WAKEUP,
 					R_P1_SW_EVENTS);
-- 
1.5.6.3

