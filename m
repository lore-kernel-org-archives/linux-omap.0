From: Manikandan Pillai <mani.pillai@ti.com>
Subject: [PATCH 2/2] Fixing some comments for TPS6235x driver.
Date: Mon,  8 Dec 2008 15:38:45 +0530
Message-ID: <1228730925-22368-1-git-send-email-mani.pillai@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:44801 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751181AbYLHKIx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Dec 2008 05:08:53 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id mB8A8lYS003965
	for <linux-omap@vger.kernel.org>; Mon, 8 Dec 2008 04:08:52 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manikandan Pillai <mani.pillai@ti.com>

Comments fixed in this patch
Incorrect comments
consumer.h header file is not required
dump_reg is removed

Signed-off-by: Manikandan Pillai <mani.pillai@ti.com>
---
 drivers/regulator/tps6235x-regulator.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/drivers/regulator/tps6235x-regulator.c b/drivers/regulator/tps6235x-regulator.c
index 26ddb78..1c8c16c 100644
--- a/drivers/regulator/tps6235x-regulator.c
+++ b/drivers/regulator/tps6235x-regulator.c
@@ -19,7 +19,6 @@
 #include <linux/regulator/machine.h>
 #include <linux/i2c.h>
 #include <linux/delay.h>
-#include <linux/regulator/consumer.h>
 
 /* Minimum and Maximum dc-dc voltage supported by the TPS6235x devices
 All voltages given in millivolts */
@@ -28,7 +27,7 @@ All voltages given in millivolts */
 #define PR785_MIN_MPU_VOLT      750
 #define PR785_MAX_MPU_VOLT      1537
 
-/* Maximum number of bytes to be read in a single read */
+/* Maximum number of Retry count */
 #define PR785_RETRY_COUNT       0x3
 
 /* Register bit settings */
@@ -77,17 +76,6 @@ static struct tps_6235x_info    tps_6235x_infodata[2];
 
 #define	MODULE_NAME		"tps6235x_power"
 
-/* Debug functions */
-#ifdef	DEBUG
-
-#define dump_reg(client, reg, val)                                      \
-	do {                                                            \
-		tps6235x_read_reg(client, reg, &val);                   \
-		dev_dbg(&(client)->dev, "Reg(0x%.2X): 0x%.2X\n", reg, val); \
-	} while (0)
-
-#endif	/* #ifdef DEBUG */
-
 /* Device addresses for PR785 card */
 #define	PR785_62352_CORE_ADDR	0x4A
 #define	PR785_62353_MPU_ADDR	0x48
-- 
1.5.6

