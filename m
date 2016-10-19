From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 4/5] gpio: davinci: Store both irqs into the controller
Date: Wed, 19 Oct 2016 11:03:58 +0530
Message-ID: <1476855239-32730-5-git-send-email-j-keerthy@ti.com>
References: <1476855239-32730-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1476855239-32730-1-git-send-email-j-keerthy@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: linus.walleij@linaro.org
Cc: gnurou@gmail.com, lokeshvutla@ti.com, robh+dt@kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, rogerq@ti.com, grygorii.strashko@ti.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

There are 32 GPIOs per controller which means 2 banks with 16 gpios
and 2 separate irqs. Hence store the both the irq numbers for the
controller which makes it easier to distnguish the bank in irq handler.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/gpio/gpio-davinci.c                | 8 +++++++-
 include/linux/platform_data/gpio-davinci.h | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-davinci.c b/drivers/gpio/gpio-davinci.c
index 2bc308a..f7c506b 100644
--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -326,7 +326,7 @@ static void gpio_irq_handler(struct irq_desc *desc)
 	g = (struct davinci_gpio_regs __iomem *)d->regs;
 
 	/* we only care about one bank */
-	if (irq & 1)
+	if (irq == d->birq2)
 		mask <<= 16;
 
 	/* temporarily mask (level sensitive) parent IRQ */
@@ -578,6 +578,12 @@ static int davinci_gpio_irq_setup(struct platform_device *pdev)
 		writel_relaxed(~0, &g->clr_falling);
 		writel_relaxed(~0, &g->clr_rising);
 
+		bank_irq = platform_get_irq(pdev, bank);
+		if (bank % 2)
+			chips[bank / 2].birq2 = bank_irq;
+		else
+			chips[bank / 2].birq1 = bank_irq;
+
 		/*
 		 * Each chip handles 32 gpios, and each irq bank consists of 16
 		 * gpio irqs. Pass the irq bank's corresponding controller to
diff --git a/include/linux/platform_data/gpio-davinci.h b/include/linux/platform_data/gpio-davinci.h
index 0a0cdd7..6439b81 100644
--- a/include/linux/platform_data/gpio-davinci.h
+++ b/include/linux/platform_data/gpio-davinci.h
@@ -39,6 +39,8 @@ struct davinci_gpio_controller {
 	int			gpio_unbanked;
 	unsigned		gpio_irq;
 	unsigned		ctrl_base;
+	unsigned int		birq1;
+	unsigned int		birq2;
 };
 
 /*
-- 
1.9.1

