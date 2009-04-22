From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] TWL4030: Make sure the regulator is active after calling twl4030reg_enable
Date: Wed, 22 Apr 2009 16:43:53 +0300
Message-ID: <1240407833-28060-2-git-send-email-peter.de-schrijver@nokia.com>
References: <1240407833-28060-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:17783 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbZDVNpS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 22 Apr 2009 09:45:18 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n3MDj9RM021126
	for <linux-omap@vger.kernel.org>; Wed, 22 Apr 2009 16:45:13 +0300
In-Reply-To: <1240407833-28060-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This patch makes sure a regulator is active when enabled. After a warm reboot, only adding
a regulator to a power group is not enough to activate it.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 drivers/regulator/twl4030-regulator.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/twl4030-regulator.c b/drivers/regulator/twl4030-regulator.c
index df9a94b..80a4e10 100644
--- a/drivers/regulator/twl4030-regulator.c
+++ b/drivers/regulator/twl4030-regulator.c
@@ -177,14 +177,21 @@ static int twl4030reg_is_enabled(struct regulator_dev *rdev)
 static int twl4030reg_enable(struct regulator_dev *rdev)
 {
 	struct twlreg_info	*info = rdev_get_drvdata(rdev);
-	int			grp;
+	int			grp, status;
+	unsigned 		message;
 
 	grp = twl4030reg_read(info, VREG_GRP);
 	if (grp < 0)
 		return grp;
 
 	grp |= P1_GRP;
-	return twl4030reg_write(info, VREG_GRP, grp);
+	status =  twl4030reg_write(info, VREG_GRP, grp);
+	if (status < 0)
+		return status;
+
+	message = MSG_SINGULAR(DEV_GRP_P1, info->id, RES_STATE_ACTIVE);
+
+	return twl4030_send_pb_msg(message);
 }
 
 static int twl4030reg_disable(struct regulator_dev *rdev)
-- 
1.5.6.3

