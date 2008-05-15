From: Nishant Kamat <nskamat@ti.com>
Subject: [RESENDING PATCH 1/4] ARM: OMAP: Add register defines for TWL4030 vaux1
Date: Thu, 15 May 2008 09:42:39 -0500
Message-ID: <1210862562-5903-1-git-send-email-nskamat@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from soda.ext.ti.com ([198.47.26.145]:58191 "EHLO soda.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754499AbYEOOms (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 May 2008 10:42:48 -0400
Received: from dlep32.itg.ti.com ([157.170.170.70])
	by soda.ext.ti.com (8.13.7/8.13.7) with ESMTP id m4FEghGn003881
	for <linux-omap@vger.kernel.org>; Thu, 15 May 2008 09:42:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Nishant Kamat <nskamat@ti.com>

This patch adds the register defines for TWL4030 VAUX1.

Signed-off-by: Nishant Kamat <nskamat@ti.com>
---
 include/linux/i2c/twl4030.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index 05d07f9..40af46e 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -77,6 +77,8 @@
 /* Offsets to Power Registers */
 #define TWL4030_VDAC_DEV_GRP		0x3B
 #define TWL4030_VDAC_DEDICATED		0x3E
+#define TWL4030_VAUX1_DEV_GRP		0x17
+#define TWL4030_VAUX1_DEDICATED		0x1A
 #define TWL4030_VAUX2_DEV_GRP		0x1B
 #define TWL4030_VAUX2_DEDICATED		0x1E
 #define TWL4030_VAUX3_DEV_GRP		0x1F
-- 
1.5.3.2

