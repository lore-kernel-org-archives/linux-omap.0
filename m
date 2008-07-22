From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/9] TWL4030: remove superfluous PWR interrupt status clear
	before masking
Date: Tue, 22 Jul 2008 17:51:25 -0600
Message-ID: <20080722235124.16719.42294.stgit@localhost.localdomain>
References: <20080722234351.16719.89367.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34588 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbYGWFLY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jul 2008 01:11:24 -0400
In-Reply-To: <20080722234351.16719.89367.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

twl_irq_init() clears PWR interrupt status bits, then masks the interrupts
off, then clears the PWR interrupt status bits again.  The first clear
seems unnecessary, so, remove it.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 drivers/i2c/chips/twl4030-core.c |   18 ------------------
 1 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index adc45d4..ff662bc 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -719,24 +719,6 @@ static void twl_init_irq(void)
 	char	*msg = "Unable to register interrupt subsystem";
 	unsigned int irq_num;
 
-	/*
-	 * We end up with interrupts from other modules before
-	 * they get a chance to handle them...
-	 */
-	/* PWR_ISR1 */
-	res = twl4030_i2c_write_u8(TWL4030_MODULE_INT, 0xFF, 0x00);
-	if (res < 0) {
-		pr_err("%s[%d][%d]\n", msg, res, __LINE__);
-		return;
-	}
-
-	/* PWR_ISR2 */
-	res = twl4030_i2c_write_u8(TWL4030_MODULE_INT, 0xFF, 0x02);
-	if (res < 0) {
-		pr_err("%s[%d][%d]\n", msg, res, __LINE__);
-		return;
-	}
-
 	/* PWR_IMR1 */
 	res = twl4030_i2c_write_u8(TWL4030_MODULE_INT, 0xFF, 0x1);
 	if (res < 0) {


