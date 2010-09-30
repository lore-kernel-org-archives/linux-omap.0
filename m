From: Abraham Arce <x0066660@ti.com>
Subject: [PATCH v6 4/8] Input: omap4 - Interrupt line configuration
Date: Thu, 30 Sep 2010 00:29:21 -0500
Message-ID: <1285824565-24906-5-git-send-email-x0066660@ti.com>
References: <1285824565-24906-1-git-send-email-x0066660@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45957 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753137Ab0I3FaV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 30 Sep 2010 01:30:21 -0400
In-Reply-To: <1285824565-24906-1-git-send-email-x0066660@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-input@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Abraham Arce <x0066660@ti.com>

Select correct interrupt line behaviour

Signed-off-by: Abraham Arce <x0066660@ti.com>
---
 drivers/input/keyboard/omap4-keypad.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 2b61f5f..07e792e 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -238,7 +238,7 @@ static int __devinit omap4_keypad_probe(struct platform_device *pdev)
 	omap4_keypad_config(keypad_data);
 
 	error = request_irq(keypad_data->irq, omap4_keypad_interrupt,
-			     IRQF_TRIGGER_FALLING,
+			     IRQF_TRIGGER_RISING,
 			     "omap4-keypad", keypad_data);
 	if (error) {
 		dev_err(&pdev->dev, "failed to register interrupt\n");
-- 
1.6.3.3

