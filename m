From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/9] TWL4030: clear MADC interrupt status registers upon init
Date: Thu, 17 Jul 2008 19:34:51 -0600
Message-ID: <20080718013450.18943.33397.stgit@localhost.localdomain>
References: <20080718013205.18943.34047.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:49364 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754758AbYGRBfY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jul 2008 21:35:24 -0400
In-Reply-To: <20080718013205.18943.34047.stgit@localhost.localdomain>
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


