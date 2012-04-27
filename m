From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH] gpio/omap: fix incorrect initialization of omap_gpio_mod_init
Date: Fri, 27 Apr 2012 14:09:11 +0530
Message-ID: <1335515951-6907-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57754 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759831Ab2D0InM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Apr 2012 04:43:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, stable@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Grant Likely <grant.likely@secretlab.ca>

Breaking commit: ab985f0f7c2c0ef90b7c832f0c04f470dda0593d

Initialization of irqenable, irqstatus registers is the common
operation done in this function for all OMAP platforms, viz.
OMAP1, OMAP2+. The latter _gpio_rmw()'s to irqenable register
was overwriting the correctly programmed OMAP1 value at the
beginning. As a result, even though it worked on OMAP2+
platforms it was breaking OMAP1 functionality. On close
observation it is found that the first _gpio_rmw() which is
supposedly done to take care of OMAP1 platform is generic enough
and takes care of OMAP2+ platform as well. Therefore remove the
latter _gpio_rmw() to irqenable as they are redundant now.

Writing to ctrl and debounce_en registers for OMAP2+ platforms
are modified to match the original(pre-cleanup) code where the
registers are initialized with 0. In the cleanup series since
we are using _gpio_rmw(reg, 0, 1), instead of __raw_writel(),
we are just reading and writing the same values to ctrl and
debounce_en. This is not an issue for debounce_en register
because it has 0x0 as the default value. But in the case of
ctrl register the default value is 0x2 (GATINGRATIO = 0x1)
so that we end up writing 0x2 instead of intended 0 value.
Therefore correcting it to _gpio_rmw(reg, l, 0), where
l = 0xffffffff so that registers are initialized to 0.

Also, changing the sequence and logic of initializing the irqstatus.

Cc: stable@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Reported-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
---
Tested on OMAP2+ platforms and bootup test on OMAP1710.
Janusz,
Please help me in validating the patch on OMAP1 platform.

 drivers/gpio/gpio-omap.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 1adc2ec..910fd14 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -964,19 +964,16 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
 		return;
 	}
 
+	_gpio_rmw(base, bank->regs->irqstatus, l, !bank->regs->irqenable_inv);
 	_gpio_rmw(base, bank->regs->irqenable, l, bank->regs->irqenable_inv);
-	_gpio_rmw(base, bank->regs->irqstatus, l,
-					bank->regs->irqenable_inv == false);
-	_gpio_rmw(base, bank->regs->irqenable, l, bank->regs->debounce_en != 0);
-	_gpio_rmw(base, bank->regs->irqenable, l, bank->regs->ctrl != 0);
 	if (bank->regs->debounce_en)
-		_gpio_rmw(base, bank->regs->debounce_en, 0, 1);
+		_gpio_rmw(base, bank->regs->debounce_en, l, 0);
 
 	/* Save OE default value (0xffffffff) in the context */
 	bank->context.oe = __raw_readl(bank->base + bank->regs->direction);
 	 /* Initialize interface clk ungated, module enabled */
 	if (bank->regs->ctrl)
-		_gpio_rmw(base, bank->regs->ctrl, 0, 1);
+		_gpio_rmw(base, bank->regs->ctrl, l, 0);
 }
 
 static __devinit void
-- 
1.7.0.4

