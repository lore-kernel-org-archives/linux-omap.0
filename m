From: Ameya Palande <ameya.palande@nokia.com>
Subject: [PATCH] DSPBRIDGE: Use GT_trace for CLk_Disable message
Date: Thu,  4 Jun 2009 16:25:53 +0300
Message-ID: <1244121953-24866-1-git-send-email-ameya.palande@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:49411 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbZFDN0E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Jun 2009 09:26:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: omar.ramirez@ti.com

From: Ameya Palande <ameya.palande@nokia.com>

To reduce the unnecessary debug messages polluting the console,
pr_err is replaced by GT_trace which provides finer control for
the visibility of debug messages.

Signed-off-by: Ameya Palande <ameya.palande@nokia.com>
---
 drivers/dsp/bridge/services/clk.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/services/clk.c b/drivers/dsp/bridge/services/clk.c
index b499b14..f0e46a3 100644
--- a/drivers/dsp/bridge/services/clk.c
+++ b/drivers/dsp/bridge/services/clk.c
@@ -277,8 +277,8 @@ DSP_STATUS CLK_Disable(IN enum SERVICES_ClkId clk_id)
 				SERVICES_Clks[clk_id].clk_name,
 				SERVICES_Clks[clk_id].id);
 	} else if (clkUseCnt == 0) {
-		pr_err("CLK_Disable: CLK %s, CLK dev id= %d is already"
-				"disabled\n",
+		GT_2trace(CLK_debugMask, GT_4CLASS, "CLK_Disable: CLK %s,"
+				"CLK dev id= %d is already disabled\n",
 				SERVICES_Clks[clk_id].clk_name,
 				SERVICES_Clks[clk_id].id);
 		return status;
-- 
1.6.2.4

