From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v2 08/10] TWL IRQ: Fix fucntion declaration warnings
Date: Tue, 21 Sep 2010 15:31:18 +0530
Message-ID: <1285063280-4057-9-git-send-email-manjugk@ti.com>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47813 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756997Ab0IUKCN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 06:02:13 -0400
In-Reply-To: <1285063280-4057-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

Fixes following sparse warnings for twl4030 and twl6030 irq files.

drivers/mfd/twl4030-irq.c:783:5: warning: symbol 'twl4030_init_irq' was not declared. Should it be static?
drivers/mfd/twl4030-irq.c:863:5: warning: symbol 'twl4030_exit_irq' was not declared. Should it be static?
drivers/mfd/twl4030-irq.c:873:5: warning: symbol 'twl4030_init_chip_irq' was not declared. Should it be static?

drivers/mfd/twl6030-irq.c:226:5: warning: symbol 'twl6030_init_irq' was not declared. Should it be static?
drivers/mfd/twl6030-irq.c:290:5: warning: symbol 'twl6030_exit_irq' was not declared. Should it be static?

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
---
 include/linux/i2c/twl.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
index 6de90bf..c61e90a 100644
--- a/include/linux/i2c/twl.h
+++ b/include/linux/i2c/twl.h
@@ -172,6 +172,11 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes);
 
 int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
 int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
+int twl6030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end);
+int twl6030_exit_irq(void);
+int twl4030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end);
+int twl4030_exit_irq(void);
+int twl4030_init_chip_irq(const char *chip);
 
 /*----------------------------------------------------------------------*/
 
-- 
1.7.0.4

