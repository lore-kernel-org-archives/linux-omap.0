From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 2/2] gpio: omap: Improve a size determination in
 omap_gpio_probe()
Date: Sat, 10 Feb 2018 22:08:28 +0100
Message-ID: <422a4c63-5ffc-2b40-4d9a-cf947d4af2fd@users.sourceforge.net>
References: <8ec31664-badc-5454-b759-ae9132833589@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <8ec31664-badc-5454-b759-ae9132833589@users.sourceforge.net>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 10 Feb 2018 21:49:22 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpio/gpio-omap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 4db6f13fa133..35971a341c40 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1157,7 +1157,7 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	if (!pdata)
 		return -EINVAL;
 
-	bank = devm_kzalloc(dev, sizeof(struct gpio_bank), GFP_KERNEL);
+	bank = devm_kzalloc(dev, sizeof(*bank), GFP_KERNEL);
 	if (!bank)
 		return -ENOMEM;
 
-- 
2.16.1

