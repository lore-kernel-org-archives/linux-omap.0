From: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Subject: [PATCH 1/2] gpio/omap: move bank->dbck initialization to omap_gpio_mod_init()
Date: Wed, 11 Jul 2012 14:43:14 +0530
Message-ID: <1341997995-14020-2-git-send-email-tarun.kanti@ti.com>
References: <1341997995-14020-1-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1341997995-14020-1-git-send-email-tarun.kanti@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>, Kevin Hilman <khilman@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

Since the bank->dbck initialization in a one time operation there
is no need to keep this within gpio_debounce(). Therefore, moving
clk_get(bank->dbck) to omap_gpio_mod_init(). Since the value of
bank->dbck would be NULL at the beginning, this check has been
removed.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Reported-by: Paul Walmsley <paul@pwsan.com>
Reviewed-by: Jon Hunter <jon-hunter@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 drivers/gpio/gpio-omap.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index c4ed172..afecdcc 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -889,12 +889,6 @@ static int gpio_debounce(struct gpio_chip *chip, unsigned offset,
 
 	bank = container_of(chip, struct gpio_bank, chip);
 
-	if (!bank->dbck) {
-		bank->dbck = clk_get(bank->dev, "dbclk");
-		if (IS_ERR(bank->dbck))
-			dev_err(bank->dev, "Could not get gpio dbck\n");
-	}
-
 	spin_lock_irqsave(&bank->lock, flags);
 	_set_gpio_debounce(bank, offset, debounce);
 	spin_unlock_irqrestore(&bank->lock, flags);
@@ -966,6 +960,10 @@ static void omap_gpio_mod_init(struct gpio_bank *bank)
 	 /* Initialize interface clk ungated, module enabled */
 	if (bank->regs->ctrl)
 		__raw_writel(0, base + bank->regs->ctrl);
+
+	bank->dbck = clk_get(bank->dev, "dbclk");
+	if (IS_ERR(bank->dbck))
+		dev_err(bank->dev, "Could not get gpio dbck\n");
 }
 
 static __devinit void
-- 
1.7.0.4
