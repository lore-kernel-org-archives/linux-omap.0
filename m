From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/9] OMAP: GPIO: Avoid generating extra IRQs
Date: Tue, 11 Aug 2009 12:50:32 +0300
Message-ID: <20090811095032.32577.69831.stgit@localhost>
References: <20090811094348.32577.81307.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <20090811094348.32577.81307.stgit@localhost>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Eero Nurkkala <ext-eero.nurkkala@nokia.com>
List-Id: linux-omap@vger.kernel.org

From: Eero Nurkkala <ext-eero.nurkkala@nokia.com>

It is possible for GPIO IRQ lines configured with
falling edge triggering only to get IRQs at the
rising edge upon the exit of offmode. And vice
versa. Prevent such IRQs to arrive by generating
the IRQ obeying the detection scheme.

Signed-off-by: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |   27 +++++++++++++++++++++++----
 1 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 555bab0..19d4dfb 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -1804,7 +1804,7 @@ void omap2_gpio_resume_after_retention(void)
 		return;
 	for (i = 0; i < gpio_bank_count; i++) {
 		struct gpio_bank *bank = &gpio_bank[i];
-		u32 l;
+		u32 l, gen, gen0, gen1;
 
 		if (!(bank->enabled_non_wakeup_gpios))
 			continue;
@@ -1825,14 +1825,33 @@ void omap2_gpio_resume_after_retention(void)
 #endif
 		l ^= bank->saved_datain;
 		l &= bank->non_wakeup_gpios;
-		if (l) {
+
+		/*
+		 * No need to generate IRQs for the rising edge for gpio IRQs
+		 * configured with falling edge only; and vice versa.
+		 */
+		gen0 = l & bank->saved_fallingdetect;
+		gen0 &= bank->saved_datain;
+
+		gen1 = l & bank->saved_risingdetect;
+		gen1 &= ~(bank->saved_datain);
+
+		/* FIXME: Consider GPIO IRQs with level detections properly! */
+		gen = l & (~(bank->saved_fallingdetect) &
+				~(bank->saved_risingdetect));
+		/* Consider all GPIO IRQs needed to be updated */
+		gen |= gen0 | gen1;
+
+		if (gen) {
 			u32 old0, old1;
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX) || \
 			defined(CONFIG_ARCH_OMAP4)
 			old0 = __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT0);
 			old1 = __raw_readl(bank->base + OMAP24XX_GPIO_LEVELDETECT1);
-			__raw_writel(old0 | l, bank->base + OMAP24XX_GPIO_LEVELDETECT0);
-			__raw_writel(old1 | l, bank->base + OMAP24XX_GPIO_LEVELDETECT1);
+			__raw_writel(old0 | gen, bank->base +
+					OMAP24XX_GPIO_LEVELDETECT0);
+			__raw_writel(old1 | gen, bank->base +
+					OMAP24XX_GPIO_LEVELDETECT1);
 			__raw_writel(old0, bank->base + OMAP24XX_GPIO_LEVELDETECT0);
 			__raw_writel(old1, bank->base + OMAP24XX_GPIO_LEVELDETECT1);
 #endif


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
