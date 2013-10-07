From: Taras Kondratiuk <taras.kondratiuk@linaro.org>
Subject: [PATCH] i2c: omap: Clear ARDY bit twice
Date: Mon,  7 Oct 2013 13:41:59 +0300
Message-ID: <1381142519-29382-1-git-send-email-taras.kondratiuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: patches@linaro.org, steve.mcintyre@linaro.org, Grygorii Strashko <grygorii.strashko@ti.com>, Felipe Balbi <balbi@ti.com>, Richard woodruff <r-woodruff2@ti.com>, Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Initially commit cb527ede1bf6ff2008a025606f25344b8ed7b4ac
"i2c-omap: Double clear of ARDY status in IRQ handler"
added a workaround for undocumented errata ProDB0017052.
But then commit 1d7afc95946487945cc7f5019b41255b72224b70
"i2c: omap: ack IRQ in parts" refactored code and missed
one of ARDY clearings. So current code violates errata.
It causes often i2c bus timeouts on my Pandaboard.

This patch adds a second clearing in place.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
---
Cc: Felipe Balbi <balbi@ti.com>
Cc: Richard woodruff <r-woodruff2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-omap@vger.kernel.org
Cc: linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/i2c/busses/i2c-omap.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f5d6de0..d69826e 100644
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
