From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] I2C: TWL4030: Give a name to twl4030 irq_chip
Date: Tue, 13 May 2008 17:20:44 +0300
Message-ID: <1210688444-17768-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:49682 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756922AbYEMOVu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 10:21:50 -0400
Received: from esebh108.NOE.Nokia.com (esebh108.ntc.nokia.com [172.21.143.145])
	by mgw-mx09.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4DELkcP008637
	for <linux-omap@vger.kernel.org>; Tue, 13 May 2008 09:21:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Small cleanup to beautify /proc/interrupts.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/twl4030-core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index b8ee8e1..8822653 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -238,6 +238,7 @@ static void twl4030_i2c_enableint(unsigned int irq) {}
 
 /* information for processing in the Work Item */
 static struct irq_chip twl4030_irq_chip = {
+	.name	= "twl4030",
 	.ack	= twl4030_i2c_ackirq,
 	.mask	= twl4030_i2c_disableint,
 	.unmask	= twl4030_i2c_enableint,
-- 
1.5.5.1.125.gc697a

