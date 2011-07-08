From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 03/11] cbus: tahvo: a switch looks better
Date: Sat,  9 Jul 2011 01:52:31 +0300
Message-ID: <1310165559-31037-4-git-send-email-balbi@ti.com>
References: <1310165559-31037-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:59229 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752258Ab1GHWwy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 18:52:54 -0400
Received: by mail-bw0-f47.google.com with SMTP id 20so2484507bwf.20
        for <linux-omap@vger.kernel.org>; Fri, 08 Jul 2011 15:52:53 -0700 (PDT)
In-Reply-To: <1310165559-31037-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

cleanup only, no functional changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/cbus/tahvo.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/cbus/tahvo.c b/drivers/cbus/tahvo.c
index 0da156e..647d263 100644
--- a/drivers/cbus/tahvo.c
+++ b/drivers/cbus/tahvo.c
@@ -284,13 +284,17 @@ static int __devinit tahvo_probe(struct platform_device *pdev)
 	rev = tahvo_read_reg(TAHVO_REG_ASICR);
 
 	id = (rev >> 8) & 0xff;
-	if (id == 0x03) {
+
+	switch (id) {
+	case 0x03:
 		if ((rev & 0xff) >= 0x50)
 			tahvo_7bit_backlight = 1;
-	} else if (id == 0x0b) {
+		break;
+	case 0x0b:
 		tahvo_is_betty = 1;
 		tahvo_7bit_backlight = 1;
-	} else {
+		break;
+	default:
 		dev_err(&pdev->dev, "Tahvo/Betty chip not found");
 		return -ENODEV;
 	}
-- 
1.7.6

