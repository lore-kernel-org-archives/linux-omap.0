From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] I2C: TWL4030: Fix wrong variable warning
Date: Fri, 11 Apr 2008 14:51:36 +0300
Message-ID: <1207914696-24035-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:51921 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759804AbYDKLw4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 07:52:56 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3BBqQsA026815
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 14:52:53 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

twl4030_i2c_write_u8 expects a u8 variable.
Change ctrl to be u8 in power_companion_init().

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-core.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index eedbebd..934433e 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -679,7 +679,8 @@ static int unprotect_pm_master(void)
 static int power_companion_init(void)
 {
 	struct clk *osc;
-	u32 rate, ctrl = HFCLK_FREQ_26_MHZ;
+	u32 rate;
+	u8 ctrl = HFCLK_FREQ_26_MHZ;
 	int e = 0;
 
 	if (cpu_is_omap2430())
-- 
1.5.5.29.g7134

