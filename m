From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/9] TWL4030: use correct register addresses for BCI IMR
	registers
Date: Tue, 22 Jul 2008 17:51:29 -0600
Message-ID: <20080722235127.16719.83352.stgit@localhost.localdomain>
References: <20080722234351.16719.89367.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34590 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571AbYGWFLZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jul 2008 01:11:25 -0400
In-Reply-To: <20080722234351.16719.89367.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The existing code to mask and clear BCI interrupts in twl_init_irq() is
wrong.  It uses the wrong register offsets, it does not mask all of the
BCI IMR registers, and it does not clear all of the BCI ISR registers.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 drivers/i2c/chips/twl4030-core.c |   40 ++++++++++++++++++++++++++++++++------
 1 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index dfc3805..bb0732c 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -750,29 +750,57 @@ static void twl_init_irq(void)
 	/* POWER HACK (END) */
 	/* Slave address 0x4A */
 
-	/* BCIIMR1_1 */
+	/* BCIIMR1A */
+	res = twl4030_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xFF, 0x2);
+	if (res < 0) {
+		pr_err("%s[%d][%d]\n", msg, res, __LINE__);
+		return;
+	}
+
+	/* BCIIMR2A */
 	res = twl4030_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xFF, 0x3);
 	if (res < 0) {
 		pr_err("%s[%d][%d]\n", msg, res, __LINE__);
 		return;
 	}
 
-	/* BCIIMR1_2 */
-	res = twl4030_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xFF, 0x4);
+	/* BCIIMR1B */
+	res = twl4030_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xFF, 0x6);
 	if (res < 0) {
 		pr_err("%s[%d][%d]\n", msg, res, __LINE__);
 		return;
 	}
 
-	/* BCIIMR2_1 */
+	/* BCIIMR2B */
 	res = twl4030_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xFF, 0x7);
 	if (res < 0) {
 		pr_err("%s[%d][%d]\n", msg, res, __LINE__);
 		return;
 	}
 
-	/* BCIIMR2_2 */
-	res = twl4030_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xFF, 0x8);
+	/* BCIISR1A */
+	res = twl4030_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xFF, 0x0);
+	if (res < 0) {
+		pr_err("%s[%d][%d]\n", msg, res, __LINE__);
+		return;
+	}
+
+	/* BCIISR2A */
+	res = twl4030_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xFF, 0x1);
+	if (res < 0) {
+		pr_err("%s[%d][%d]\n", msg, res, __LINE__);
+		return;
+	}
+
+	/* BCIISR1B */
+	res = twl4030_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xFF, 0x4);
+	if (res < 0) {
+		pr_err("%s[%d][%d]\n", msg, res, __LINE__);
+		return;
+	}
+
+	/* BCIISR2B */
+	res = twl4030_i2c_write_u8(TWL4030_MODULE_INTERRUPTS, 0xFF, 0x5);
 	if (res < 0) {
 		pr_err("%s[%d][%d]\n", msg, res, __LINE__);
 		return;


