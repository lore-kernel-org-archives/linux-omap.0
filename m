From: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Subject: [RFC PATCH] i2c: omap: Clear ARDY bit twice
Date: Wed,  2 Oct 2013 13:58:46 +0300
Message-ID: <1380711526-20365-1-git-send-email-taras.kondratiuk@linaro.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:41889 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753992Ab3JBK7b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Oct 2013 06:59:31 -0400
Received: by mail-la0-f43.google.com with SMTP id ep20so468564lab.16
        for <linux-omap@vger.kernel.org>; Wed, 02 Oct 2013 03:59:30 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Richard woodruff <r-woodruff2@ti.com>, linux-omap@vger.kernel.org, Taras Kondratiuk <taras.kondratiuk@linaro.org>

Initially commit cb527ede1bf6ff2008a025606f25344b8ed7b4ac
"i2c-omap: Double clear of ARDY status in IRQ handler"
added a workaround for undocumented errata ProDB0017052.
But then commit 1d7afc95946487945cc7f5019b41255b72224b70
"i2c: omap: ack IRQ in parts" refactored code and missed
one of ARDY clearings. So current code violates errata.
It causes often i2c bus timeouts on my Pandaboard.

This patch adds a second clearing in place.

Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
---
 drivers/i2c/busses/i2c-omap.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 6d8308d..9967a6f 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -939,6 +939,9 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
 		/*
 		 * ProDB0017052: Clear ARDY bit twice
 		 */
+		if (stat & OMAP_I2C_STAT_ARDY)
+			omap_i2c_ack_stat(dev, OMAP_I2C_STAT_ARDY);
+
 		if (stat & (OMAP_I2C_STAT_ARDY | OMAP_I2C_STAT_NACK |
 					OMAP_I2C_STAT_AL)) {
 			omap_i2c_ack_stat(dev, (OMAP_I2C_STAT_RRDY |
-- 
1.7.9.5

