From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 1/2] gpio: omap: Delete an error message for a failed memory
 allocation in omap_gpio_probe()
Date: Sat, 10 Feb 2018 22:07:17 +0100
Message-ID: <86570340-688b-34ec-2d99-ff728ccbe4a9@users.sourceforge.net>
References: <8ec31664-badc-5454-b759-ae9132833589@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8ec31664-badc-5454-b759-ae9132833589@users.sourceforge.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 10 Feb 2018 21:46:30 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpio/gpio-omap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index ab5035b96886..4db6f13fa133 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1158,10 +1158,8 @@ static int omap_gpio_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	bank = devm_kzalloc(dev, sizeof(struct gpio_bank), GFP_KERNEL);
-	if (!bank) {
-		dev_err(dev, "Memory alloc failed\n");
+	if (!bank)
 		return -ENOMEM;
-	}
 
 	irqc = devm_kzalloc(dev, sizeof(*irqc), GFP_KERNEL);
 	if (!irqc)
-- 
2.16.1
