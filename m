From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: GPIO IRQSTATUS2 workaround applies to 2430
Date: Wed, 03 Oct 2007 17:48:16 -0700
Message-ID: <20071004004816.190243397@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

The workaround to clear both sides of GPIO IRQ applies to 2430 as well
as 2420.  Use cpu_is_omap24xx() instead of cpu_is_omap2420()

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 arch/arm/plat-omap/gpio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: dev/arch/arm/plat-omap/gpio.c
===================================================================
--- dev.orig/arch/arm/plat-omap/gpio.c
+++ dev/arch/arm/plat-omap/gpio.c
@@ -709,7 +709,7 @@ static void _clear_gpio_irqbank(struct g
 
 	/* Workaround for clearing DSP GPIO interrupts to allow retention */
 #if defined(CONFIG_ARCH_OMAP24XX) || defined(CONFIG_ARCH_OMAP34XX)
-	if (cpu_is_omap2420() || cpu_is_omap34xx())
+	if (cpu_is_omap24xx() || cpu_is_omap34xx())
 		__raw_writel(gpio_mask, bank->base + OMAP24XX_GPIO_IRQSTATUS2);
 #endif
 }
--
