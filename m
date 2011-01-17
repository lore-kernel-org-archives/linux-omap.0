From: Thomas Weber <weber@corscience.de>
Subject: [PATCHv2 2/2] omap3: devkit8000: fix tps65930 pullup/pulldown configuration
Date: Mon, 17 Jan 2011 15:11:59 +0100
Message-ID: <1295273519-6189-3-git-send-email-weber@corscience.de>
References: <1295273519-6189-1-git-send-email-weber@corscience.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1295273519-6189-1-git-send-email-weber@corscience.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Daniel Morsing <daniel.morsing@gmail.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Daniel Morsing <daniel.morsing@gmail.com>

gpio7 on the tps65930 is used as an output on the devkit8000 and gpio1
is not connected. Remove gpio7 and change gpio1 to pulldown

Signed-off-by: Daniel Morsing <daniel.morsing@gmail.com>
---
 arch/arm/mach-omap2/board-devkit8000.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
index 719f4e5..9fb416b 100644
--- a/arch/arm/mach-omap2/board-devkit8000.c
+++ b/arch/arm/mach-omap2/board-devkit8000.c
@@ -262,8 +262,7 @@ static struct twl4030_gpio_platform_data devkit8000_gpio_data = {
 	.irq_base	= TWL4030_GPIO_IRQ_BASE,
 	.irq_end	= TWL4030_GPIO_IRQ_END,
 	.use_leds	= true,
-	.pullups	= BIT(1),
-	.pulldowns	= BIT(2) | BIT(6) | BIT(7) | BIT(8) | BIT(13)
+	.pulldowns	= BIT(1) | BIT(2) | BIT(6) | BIT(8) | BIT(13)
 				| BIT(15) | BIT(16) | BIT(17),
 	.setup		= devkit8000_twl_gpio_setup,
 };
-- 
1.7.4.rc2
