From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 03/27] cbus: tahvo: a switch looks better
Date: Thu, 13 Oct 2011 11:34:38 +0300
Message-ID: <1318494902-13093-3-git-send-email-balbi@ti.com>
References: <1318494902-13093-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:57725 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753871Ab1JMIfQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 Oct 2011 04:35:16 -0400
Received: by mail-bw0-f54.google.com with SMTP id zs8so1387127bkb.13
        for <linux-omap@vger.kernel.org>; Thu, 13 Oct 2011 01:35:15 -0700 (PDT)
In-Reply-To: <1318494902-13093-1-git-send-email-balbi@ti.com>
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
1.7.6.396.ge0613

