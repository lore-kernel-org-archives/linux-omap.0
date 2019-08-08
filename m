From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 11/22] clocksource: ti-dmtimer: avoid using mach/hardware.h
Date: Thu,  8 Aug 2019 23:22:20 +0200
Message-ID: <20190808212234.2213262-12-arnd@arndb.de>
References: <20190808212234.2213262-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190808212234.2213262-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

As a preparation for future omap1 multiplatform support, stop
using mach/hardware.h and instead include the omap1-io.h
for low-level register access to MOD_CONF_CTRL_1.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clocksource/timer-ti-dm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 5394d9dbdfbc..422f96384dc5 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -448,7 +448,7 @@ int omap_dm_timer_get_irq(struct omap_dm_timer *timer)
 }
 
 #if defined(CONFIG_ARCH_OMAP1)
-#include <mach/hardware.h>
+#include <linux/soc/ti/omap1-io.h>
 
 static struct clk *omap_dm_timer_get_fclk(struct omap_dm_timer *timer)
 {
-- 
2.20.0
