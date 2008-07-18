From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/9] TWL4030: clear TWL GPIO interrupt status registers
Date: Thu, 17 Jul 2008 19:34:50 -0600
Message-ID: <20080718013449.18943.78895.stgit@localhost.localdomain>
References: <20080718013205.18943.34047.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49362 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754168AbYGRBfY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2008 21:35:24 -0400
In-Reply-To: <20080718013205.18943.34047.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

twl_init_irq() does not clear the TWL GPIO ISR registers, but the PIH
ISR thinks that it has.  This causes any previously-latched GPIO interrupts
to be stuck on until twl4030-gpio.c initializes, often drowning the console in

    TWL4030 module irq 368 is disabled but can't be masked!

messages.  This seems to be a particular problem when booting on Beagle.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 drivers/i2c/chips/twl4030-core.c |   42 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 42 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index ff662bc..dfc3805 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -857,6 +857,48 @@ static void twl_init_irq(void)
 		return;
 	}
 
+	/* GPIO_ISR1A */
+	res = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, 0xff, 0x19);
+	if (res < 0) {
+		pr_err("%s[%d][%d]\n", msg, res, __LINE__);
+		return;
+	}
+
+	/* GPIO_ISR2A */
+	res = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, 0xff, 0x1a);
+	if (res < 0) {
+		pr_err("%s[%d][%d]\n", msg, res, __LINE__);
+		return;
+	}
+
+	/* GPIO_ISR3A */
+	res = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, 0xff, 0x1b);
+	if (res < 0) {
+		pr_err("%s[%d][%d]\n", msg, res, __LINE__);
+		return;
+	}
+
+	/* GPIO_ISR1B */
+	res = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, 0xff, 0x1f);
+	if (res < 0) {
+		pr_err("%s[%d][%d]\n", msg, res, __LINE__);
+		return;
+	}
+
+	/* GPIO_ISR2B */
+	res = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, 0xff, 0x20);
+	if (res < 0) {
+		pr_err("%s[%d][%d]\n", msg, res, __LINE__);
+		return;
+	}
+
+	/* GPIO_ISR3B */
+	res = twl4030_i2c_write_u8(TWL4030_MODULE_GPIO, 0xff, 0x21);
+	if (res < 0) {
+		pr_err("%s[%d][%d]\n", msg, res, __LINE__);
+		return;
+	}
+
 	/* install an irq handler for each of the PIH modules */
 	for (i = TWL4030_IRQ_BASE; i < TWL4030_IRQ_END; i++) {
 		set_irq_chip(i, &twl4030_irq_chip);


