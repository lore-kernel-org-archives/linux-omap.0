From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/3] gpio: omap: Get rid of pm_runtime_irq_safe()
Date: Thu, 20 Sep 2018 12:35:32 -0700
Message-ID: <20180920193532.7714-4-tony@atomide.com>
References: <20180920193532.7714-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180920193532.7714-1-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-gpio@vger.kernel.org, Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

If a gpio instance has any GPIO bits requested we do a pm_runtime_get()
on the device. Now with cpu_pm handling the deeper SoC idle state quirks,
let's just remove pm_runtime_irq_safe() call and add a warning in case we
ever happen to encounter it.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Ladislav Michl <ladis@linux-mips.org>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/gpio/gpio-omap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -763,7 +763,9 @@ static irqreturn_t omap_gpio_irq_handler(int irq, void *gpiobank)
 	if (WARN_ON(!isr_reg))
 		goto exit;
 
-	pm_runtime_get_sync(bank->chip.parent);
+	if (WARN_ONCE(!pm_runtime_active(bank->chip.parent),
+		      "gpio irq%i while runtime suspended?\n", irq))
+		return IRQ_NONE;
 
 	while (1) {
 		raw_spin_lock_irqsave(&bank->lock, lock_flags);
@@ -814,7 +816,6 @@ static irqreturn_t omap_gpio_irq_handler(int irq, void *gpiobank)
 		}
 	}
 exit:
-	pm_runtime_put(bank->chip.parent);
 	return IRQ_HANDLED;
 }
 
@@ -1466,7 +1467,6 @@ static int omap_gpio_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, bank);
 
 	pm_runtime_enable(dev);
-	pm_runtime_irq_safe(dev);
 	pm_runtime_get_sync(dev);
 
 	if (bank->is_mpuio)
-- 
2.19.0
