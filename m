From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: [PATCH] CBUS: Fix retu-headset driver by not using removed input_dev->private field
Date: Tue,  6 May 2008 11:33:08 +0300
Message-ID: <1210062788-15087-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:40557 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203AbYEFIdS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 May 2008 04:33:18 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m468VSPI030950
	for <linux-omap@vger.kernel.org>; Tue, 6 May 2008 03:33:16 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 drivers/cbus/retu-headset.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/cbus/retu-headset.c b/drivers/cbus/retu-headset.c
index f9de5cd..e798bc2 100644
--- a/drivers/cbus/retu-headset.c
+++ b/drivers/cbus/retu-headset.c
@@ -232,7 +232,6 @@ static int __init retu_headset_probe(struct platform_device *pdev)
 	}
 	hs->idev->name = "retu-headset";
 	hs->idev->dev.parent = &pdev->dev;
-	hs->idev->private = hs;
 	set_bit(EV_KEY, hs->idev->evbit);
 	set_bit(RETU_HEADSET_KEY, hs->idev->keybit);
 	r = input_register_device(hs->idev);
-- 
1.5.4.4

