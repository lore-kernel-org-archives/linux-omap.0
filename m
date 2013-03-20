From: Laurent Navet <laurent.navet@gmail.com>
Subject: [PATCH 08/10] gpio: gpio-tc3589x.c: fix checkpatch errors
Date: Wed, 20 Mar 2013 13:16:02 +0100
Message-ID: <1363781764-17330-9-git-send-email-laurent.navet@gmail.com>
References: <1363781764-17330-1-git-send-email-laurent.navet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363781764-17330-1-git-send-email-laurent.navet@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grant.likely@secretlab.ca, linus.walleij@linaro.org
Cc: santosh.shilimkar@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Navet <laurent.navet@gmail.com>
List-Id: linux-omap@vger.kernel.org

Fix :
 gpio/gpio-tc3589x.c:285: ERROR: code indent should use tabs where possible
 gpio/gpio-tc3589x.c:286: ERROR: code indent should use tabs where possible
 gpio/gpio-tc3589x.c:287: ERROR: code indent should use tabs where possible
 gpio/gpio-tc3589x.c:347: ERROR: code indent should use tabs where possible

Signed-off-by: Laurent Navet <laurent.navet@gmail.com>
---
 drivers/gpio/gpio-tc3589x.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-tc3589x.c b/drivers/gpio/gpio-tc3589x.c
index c0595bb..d34d80d 100644
--- a/drivers/gpio/gpio-tc3589x.c
+++ b/drivers/gpio/gpio-tc3589x.c
@@ -282,9 +282,9 @@ static void tc3589x_gpio_irq_unmap(struct irq_domain *d, unsigned int virq)
 }
 
 static struct irq_domain_ops tc3589x_irq_ops = {
-        .map    = tc3589x_gpio_irq_map,
-        .unmap  = tc3589x_gpio_irq_unmap,
-        .xlate  = irq_domain_xlate_twocell,
+	.map    = tc3589x_gpio_irq_map,
+	.unmap  = tc3589x_gpio_irq_unmap,
+	.xlate  = irq_domain_xlate_twocell,
 };
 
 static int tc3589x_gpio_irq_init(struct tc3589x_gpio *tc3589x_gpio,
@@ -344,7 +344,7 @@ static int tc3589x_gpio_probe(struct platform_device *pdev)
 	tc3589x_gpio->chip.base = (pdata) ? pdata->gpio_base : -1;
 
 #ifdef CONFIG_OF_GPIO
-        tc3589x_gpio->chip.of_node = np;
+	tc3589x_gpio->chip.of_node = np;
 #endif
 
 	tc3589x_gpio->irq_base = tc3589x->irq_base ?
-- 
1.7.10.4
