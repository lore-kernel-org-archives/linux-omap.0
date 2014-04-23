From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 1/2] gpio: omap: prepare and unprepare the debounce clock
Date: Wed, 23 Apr 2014 11:41:03 +0530
Message-ID: <1398233465-8845-2-git-send-email-rnayak@ti.com>
References: <1398233465-8845-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1398233465-8845-1-git-send-email-rnayak@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, Rajendra Nayak <rnayak@ti.com>, linux-gpio@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>
List-Id: linux-omap@vger.kernel.org

Replace the clk_enable()s with a clk_prepare_enable() and
the clk_disables()s with a clk_disable_unprepare()

This never showed issues due to the OMAP platform code (hwmod)
leaving these clocks in clk_prepare()ed state by default.

Reported-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: linux-gpio@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/gpio/gpio-omap.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 19b886c..78bc5a4 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -180,7 +180,7 @@ static inline void _gpio_rmw(void __iomem *base, u32 reg, u32 mask, bool set)
 static inline void _gpio_dbck_enable(struct gpio_bank *bank)
 {
 	if (bank->dbck_enable_mask && !bank->dbck_enabled) {
-		clk_enable(bank->dbck);
+		clk_prepare_enable(bank->dbck);
 		bank->dbck_enabled = true;
 
 		writel_relaxed(bank->dbck_enable_mask,
@@ -198,7 +198,7 @@ static inline void _gpio_dbck_disable(struct gpio_bank *bank)
 		 */
 		writel_relaxed(0, bank->base + bank->regs->debounce_en);
 
-		clk_disable(bank->dbck);
+		clk_disable_unprepare(bank->dbck);
 		bank->dbck_enabled = false;
 	}
 }
@@ -231,7 +231,7 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 
 	l = GPIO_BIT(bank, gpio);
 
-	clk_enable(bank->dbck);
+	clk_prepare_enable(bank->dbck);
 	reg = bank->base + bank->regs->debounce;
 	writel_relaxed(debounce, reg);
 
@@ -245,7 +245,7 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 	bank->dbck_enable_mask = val;
 
 	writel_relaxed(val, reg);
-	clk_disable(bank->dbck);
+	clk_disable_unprepare(bank->dbck);
 	/*
 	 * Enable debounce clock per module.
 	 * This call is mandatory because in omap_gpio_request() when
@@ -290,7 +290,7 @@ static void _clear_gpio_debounce(struct gpio_bank *bank, unsigned gpio)
 		bank->context.debounce = 0;
 		writel_relaxed(bank->context.debounce, bank->base +
 			     bank->regs->debounce);
-		clk_disable(bank->dbck);
+		clk_disable_unprepare(bank->dbck);
 		bank->dbck_enabled = false;
 	}
 }
-- 
1.7.9.5

