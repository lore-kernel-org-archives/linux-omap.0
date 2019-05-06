From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] Remove MODULE_ALIAS() calls that take undefined macro
Date: Tue,  7 May 2019 02:28:17 +0900
Message-ID: <1557163697-17882-1-git-send-email-yamada.masahiro@socionext.com>
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
To: linux-kbuild@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Alexey Gladkov <gladkov.alexey@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Thomas Gleixner <tglx@linutronix.de>, linux-omap@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

These files do not define (USBHS_)DRIVER_NAME. Yet, they can be
successfully compiled because they are never built as a module by
anyone, i.e, the MODULE_ALIAS() calls are always no-op.

A problem showed up when a patch "moduleparam: Save information about
built-in modules in separate file" is applied. With this new feature,
MODULE_*() are populated even if the callers are built-in.

To avoid the build errors, the lines referencing to the undefined
macro must be removed.

The complete fix is to remove all MODULE_* and #include <linux/module.h>
like many "make ... explicitly non-modular" commits did.

For now, I am touching the offending lines.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I will insert this commit before
"moduleparam: Save information about built-in modules in separate file"


 arch/arm/plat-omap/dma.c          | 1 -
 drivers/clocksource/timer-ti-dm.c | 1 -
 drivers/mfd/omap-usb-tll.c        | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index d4012d6..5ca4c5f 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -1449,7 +1449,6 @@ static void __exit omap_system_dma_exit(void)
 
 MODULE_DESCRIPTION("OMAP SYSTEM DMA DRIVER");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" DRIVER_NAME);
 MODULE_AUTHOR("Texas Instruments Inc");
 
 /*
diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 3352da6..2b7cee81 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -998,5 +998,4 @@ module_platform_driver(omap_dm_timer_driver);
 
 MODULE_DESCRIPTION("OMAP Dual-Mode Timer Driver");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:" DRIVER_NAME);
 MODULE_AUTHOR("Texas Instruments Inc");
diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 446713d..93177d8 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -459,7 +459,6 @@ EXPORT_SYMBOL_GPL(omap_tll_disable);
 
 MODULE_AUTHOR("Keshava Munegowda <keshava_mgowda@ti.com>");
 MODULE_AUTHOR("Roger Quadros <rogerq@ti.com>");
-MODULE_ALIAS("platform:" USBHS_DRIVER_NAME);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("usb tll driver for TI OMAP EHCI and OHCI controllers");
 
-- 
2.7.4
