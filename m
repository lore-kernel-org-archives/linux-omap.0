From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] usb: phy: omap-usb3: Fix return value
Date: Mon, 16 Sep 2013 11:10:10 +0530
Message-ID: <1379310010-7822-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:51572 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753047Ab3IPF62 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Sep 2013 01:58:28 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so3691371pdj.17
        for <linux-omap@vger.kernel.org>; Sun, 15 Sep 2013 22:58:26 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: balbi@ti.com, gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, sachin.kamat@linaro.org, kishon@ti.com

The function returns a pointer. Hence return NULL instead of 0.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/usb/phy/phy-omap-usb3.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/phy/phy-omap-usb3.c b/drivers/usb/phy/phy-omap-usb3.c
index fc15694..4e8a040 100644
--- a/drivers/usb/phy/phy-omap-usb3.c
+++ b/drivers/usb/phy/phy-omap-usb3.c
@@ -79,7 +79,7 @@ static struct usb_dpll_params *omap_usb3_get_dpll_params(unsigned long rate)
 			return &dpll_map[i].params;
 	}
 
-	return 0;
+	return NULL;
 }
 
 static int omap_usb3_suspend(struct usb_phy *x, int suspend)
-- 
1.7.9.5

