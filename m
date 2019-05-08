From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] gpio: gpio-omap: Fix lost edge wake-up interrupts
Date: Wed,  8 May 2019 11:19:39 -0700
Message-ID: <20190508181939.1990-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Tero Kristo <t-kristo@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Keerthy <j-keerthy@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-gpio@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

If an edge interrupt triggers while entering idle just before we save
GPIO datain register to saved_datain, the triggered GPIO will not be
noticed on wake-up. This is because the saved_datain and GPIO datain
are the same. Let's fix this by ignoring any pending edge interrupts
in saved_datain.

This can be somewhat easily reproduced by pinging an idle system with
smsc911x Ethernet interface configured IRQ_TYPE_EDGE_FALLING. At some
point the smsc911x interrupts will just stop triggering.

Note that in the long run we may be able to cancel entering idle by
returning an error in gpio_omap_cpu_notifier(). But let's fix the bug
first.

Also note that because of the recent clean-up efforts this patch does
not apply directly to older kernels. This does fix a long term issue
though, and can be backported as needed.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Ladislav Michl <ladis@linux-mips.org>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/gpio/gpio-omap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1279,7 +1279,14 @@ static void omap_gpio_idle(struct gpio_bank *bank, bool may_lose_context)
 	void __iomem *base = bank->base;
 	u32 nowake;
 
+	/*
+	 * Save datain register to trigger edge interrupts on unidle for GPIOS
+	 * that are not wake-up capable. Ignore any enabled_non_wakeup_gpios
+	 * that may have just triggered as we're entering idle. Otherwise unidle
+	 * will not notice them.
+	 */
 	bank->saved_datain = readl_relaxed(base + bank->regs->datain);
+	bank->saved_datain |= bank->enabled_non_wakeup_gpios;
 
 	if (!bank->enabled_non_wakeup_gpios)
 		goto update_gpio_context_count;
-- 
2.21.0
