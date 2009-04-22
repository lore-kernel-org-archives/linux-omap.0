From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH 1/1] Activate VDD1, VDD2 and VPLL1 at startup
Date: Wed, 22 Apr 2009 18:35:29 +0300
Message-ID: <1240414529-16258-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:59911 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbZDVPf5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 11:35:57 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n3MFZGCJ026416
	for <linux-omap@vger.kernel.org>; Wed, 22 Apr 2009 10:35:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch activates VDD1, VDD2 and VPLL1 when booting. This is necessary
because these resources are in warm reset state after a reboot. This means
their voltage levels cannot be modified so DVFS and smartreflex don't work.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 drivers/regulator/twl4030-regulator.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/drivers/regulator/twl4030-regulator.c b/drivers/regulator/twl4030-regulator.c
index 80a4e10..ab2a726 100644
--- a/drivers/regulator/twl4030-regulator.c
+++ b/drivers/regulator/twl4030-regulator.c
@@ -506,6 +506,22 @@ static int twl4030reg_probe(struct platform_device *pdev)
 	}
 	platform_set_drvdata(pdev, rdev);
 
+	/* VDD1, VDD2 and VPLL1 are left in warm reset state after a reboot.
+	 * We need to put them back to active state for DVFS and smartreflex.
+	 */
+
+	if (twl4030_send_pb_msg(MSG_SINGULAR(DEV_GRP_P1, RES_VDD1,
+		RES_STATE_ACTIVE)) < 0)
+		pr_err("Unable to activate VDD1\n");
+
+	if (twl4030_send_pb_msg(MSG_SINGULAR(DEV_GRP_P1, RES_VDD2,
+		RES_STATE_ACTIVE)) < 0)
+		pr_err("Unable to activate VDD2\n");
+
+	if (twl4030_send_pb_msg(MSG_SINGULAR(DEV_GRP_P1, RES_VPLL1,
+		RES_STATE_ACTIVE)) < 0)
+		pr_err("Unable to activate VPLL1\n");
+
 	/* NOTE:  many regulators support short-circuit IRQs (presentable
 	 * as REGULATOR_OVER_CURRENT notifications?) configured via:
 	 *  - SC_CONFIG
-- 
1.5.6.3

