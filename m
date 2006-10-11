From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: [PATCH] ARM: OMAP: Fix apollon boot
Date: Wed, 11 Oct 2006 16:35:45 +0900
Message-ID: <000801c6ed07$dd1172a0$c7a3580a@swcenter.sec.samsung.co.kr>
Reply-To: kyungmin.park@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

In previous GPMC patch, there was a typo. Fix typo and add header files for
set_irq_type() warnings.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

--

diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-
omap2/board-apollon.c
index 5d455d4..99651b2 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -25,6 +25,7 @@ #include <linux/mtd/onenand.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/leds.h>
+#include <linux/irq.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>
@@ -199,7 +200,7 @@ static inline void __init apollon_init_s
 		return;
 	}
 	apollon_smc91x_resources[0].start = base + 0x300;
-	apollon_smc91x_resources[1].end   = base + 0x30f;
+	apollon_smc91x_resources[0].end   = base + 0x30f;
 	udelay(100);
 
 	omap_cfg_reg(W4__24XX_GPIO74);
