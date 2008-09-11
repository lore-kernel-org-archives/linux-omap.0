From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] Fix build for beagleboard
Date: Thu, 11 Sep 2008 14:50:02 +0300
Message-ID: <1221133802-19613-2-git-send-email-peter.de-schrijver@nokia.com>
References: <1221133802-19613-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:44036 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbYIKLuf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 07:50:35 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8BBoMtu025964
	for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 14:50:33 +0300
In-Reply-To: <1221133802-19613-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

---
 drivers/i2c/chips/twl4030-power.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-power.c b/drivers/i2c/chips/twl4030-power.c
index 195c3c4..04a13aa 100644
--- a/drivers/i2c/chips/twl4030-power.c
+++ b/drivers/i2c/chips/twl4030-power.c
@@ -149,7 +149,7 @@ struct triton_ins t2_wrst_seq[] __initdata = {
 struct triton_ins sleep_on_seq[] __initdata = {
 	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_RC, RES_TYPE_ALL, RES_TYPE2_R0,
 			RES_STATE_SLEEP), 4},
-	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_ALL, RES_TYPE_R7,
+	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_ALL, RES_TYPE2_R0,
 			RES_STATE_SLEEP), 4},
 };
 
@@ -160,6 +160,9 @@ struct triton_ins sleep_off_seq[] __initdata = {
 	{MSG_BROADCAST(DEV_GRP_NULL, RES_GRP_ALL, RES_TYPE_ALL, RES_TYPE2_R0,
 			RES_STATE_ACTIVE), 0x2},
 };
+
+struct triton_ins t2_wrst_seq[] __initdata = { };
+
 #endif
 
 static int __init twl4030_write_script_byte(u8 address, u8 byte)
-- 
1.5.6.3

