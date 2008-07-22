From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/9] TWL4030: clear MADC interrupt status registers upon init
Date: Tue, 22 Jul 2008 17:51:30 -0600
Message-ID: <20080722235129.16719.75009.stgit@localhost.localdomain>
References: <20080722234351.16719.89367.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34591 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614AbYGWFLZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jul 2008 01:11:25 -0400
In-Reply-To: <20080722234351.16719.89367.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

twl_init_irq() does not clear MADC interrupt status registers upon init -
fix.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 drivers/i2c/chips/twl4030-core.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/i2c/chips/twl4030-core.c b/drivers/i2c/chips/twl4030-core.c
index bb0732c..9d93524 100644
--- a/drivers/i2c/chips/twl4030-core.c
+++ b/drivers/i2c/chips/twl4030-core.c
@@ -821,6 +821,20 @@ static void twl_init_irq(void)
 		return;
 	}
 
+	/* MADC_ISR1 */
+	res = twl4030_i2c_write_u8(TWL4030_MODULE_MADC, 0xFF, 0x61);
+	if (res < 0) {
+		pr_err("%s[%d][%d]\n", msg, res, __LINE__);
+		return;
+	}
+
+	/* MADC_ISR2 */
+	res = twl4030_i2c_write_u8(TWL4030_MODULE_MADC, 0xFF, 0x63);
+	if (res < 0) {
+		pr_err("%s[%d][%d]\n", msg, res, __LINE__);
+		return;
+	}
+
 	/* key Pad */
 	/* KEYPAD - IMR1 */
 	res = twl4030_i2c_write_u8(TWL4030_MODULE_KEYPAD, 0xFF, (0x12));


