From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 07/12] ARM: omap1: avoid unused variable warning
Date: Thu, 20 Jul 2017 17:51:45 +0200
Message-ID: <20170720155209.3250880-4-arnd@arndb.de>
References: <20170720154616.3250481-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170720154616.3250481-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The osk_mistral_init() contains code that is only compiled when
CONFIG_PM is set, but it uses a variable that is declared outside
of the #ifdef:

arch/arm/mach-omap1/board-osk.c: In function 'osk_mistral_init':
arch/arm/mach-omap1/board-osk.c:513:7: warning: unused variable 'ret' [-Wunused-variable]

This removes the #ifdef around the user of the variable,
make it always used.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Tony Lindgren <tony@atomide.com>
Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/mach-omap1/board-osk.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-omap1/board-osk.c b/arch/arm/mach-omap1/board-osk.c
index 4dfb99504810..95ac1929aede 100644
--- a/arch/arm/mach-omap1/board-osk.c
+++ b/arch/arm/mach-omap1/board-osk.c
@@ -441,13 +441,11 @@ static struct spi_board_info __initdata mistral_boardinfo[] = { {
 	.chip_select		= 0,
 } };
 
-#ifdef	CONFIG_PM
 static irqreturn_t
 osk_mistral_wake_interrupt(int irq, void *ignored)
 {
 	return IRQ_HANDLED;
 }
-#endif
 
 static void __init osk_mistral_init(void)
 {
@@ -515,7 +513,6 @@ static void __init osk_mistral_init(void)
 
 		gpio_direction_input(OMAP_MPUIO(2));
 		irq_set_irq_type(irq, IRQ_TYPE_EDGE_RISING);
-#ifdef	CONFIG_PM
 		/* share the IRQ in case someone wants to use the
 		 * button for more than wakeup from system sleep.
 		 */
@@ -529,7 +526,6 @@ static void __init osk_mistral_init(void)
 				ret);
 		} else
 			enable_irq_wake(irq);
-#endif
 	} else
 		printk(KERN_ERR "OSK+Mistral: wakeup button is awol\n");
 
-- 
2.9.0
