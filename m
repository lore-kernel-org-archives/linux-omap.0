From: Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [git:v4l-dvb/for_v3.7] [media] ARM: mach-omap2:
	board-rx51-peripherals: Add lirc-rx51 data
Date: Mon, 13 Aug 2012 21:54:26 +0200
Message-ID: <E1T10iu-0000Xe-JR@www.linuxtv.org>
Reply-To: linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxtv-commits-bounces+gcvl-linuxtv-commits=m.gmane.org-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <http://www.linuxtv.org/cgi-bin/mailman/options/linuxtv-commits>,
	<mailto:linuxtv-commits-request-dJidKbW2IEtAfugRpC6u6w@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:linuxtv-commits-dJidKbW2IEtAfugRpC6u6w@public.gmane.org>
List-Help: <mailto:linuxtv-commits-request-dJidKbW2IEtAfugRpC6u6w@public.gmane.org?subject=help>
List-Subscribe: <http://www.linuxtv.org/cgi-bin/mailman/listinfo/linuxtv-commits>,
	<mailto:linuxtv-commits-request-dJidKbW2IEtAfugRpC6u6w@public.gmane.org?subject=subscribe>
Sender: linuxtv-commits-bounces-dJidKbW2IEtAfugRpC6u6w@public.gmane.org
Errors-To: linuxtv-commits-bounces+gcvl-linuxtv-commits=m.gmane.org-dJidKbW2IEtAfugRpC6u6w@public.gmane.org
To: linuxtv-commits-dJidKbW2IEtAfugRpC6u6w@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Timo Kokkonen <timo.t.kokkonen-X3B1VOXEql0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This is an automatic generated email to let you know that the following patch were queued at the 
http://git.linuxtv.org/media_tree.git tree:

Subject: [media] ARM: mach-omap2: board-rx51-peripherals: Add lirc-rx51 data
Author:  Timo Kokkonen <timo.t.kokkonen-X3B1VOXEql0@public.gmane.org>
Date:    Fri Aug 10 06:16:37 2012 -0300

The IR diode on the RX51 is connected to the GPT9. This data is needed
for the IR driver to function.

Signed-off-by: Timo Kokkonen <timo.t.kokkonen-X3B1VOXEql0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Mauro Carvalho Chehab <mchehab-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

 arch/arm/mach-omap2/board-rx51-peripherals.c |   30 ++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

---

http://git.linuxtv.org/media_tree.git?a=commitdiff;h=322c183cdc5f041d0f6a25fe519c7836649a6c8b

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index df2534d..ca07264 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -34,6 +34,7 @@
 #include <plat/gpmc.h>
 #include <plat/onenand.h>
 #include <plat/gpmc-smc91x.h>
+#include <plat/omap-pm.h>
 
 #include <mach/board-rx51.h>
 
@@ -46,6 +47,10 @@
 #include <../drivers/staging/iio/light/tsl2563.h>
 #include <linux/lis3lv02d.h>
 
+#if defined(CONFIG_IR_RX51) || defined(CONFIG_IR_RX51_MODULE)
+#include <media/ir-rx51.h>
+#endif
+
 #include "mux.h"
 #include "hsmmc.h"
 #include "common-board-devices.h"
@@ -1220,6 +1225,30 @@ static void __init rx51_init_tsc2005(void)
 				gpio_to_irq(RX51_TSC2005_IRQ_GPIO);
 }
 
+#if defined(CONFIG_IR_RX51) || defined(CONFIG_IR_RX51_MODULE)
+static struct lirc_rx51_platform_data rx51_lirc_data = {
+	.set_max_mpu_wakeup_lat = omap_pm_set_max_mpu_wakeup_lat,
+	.pwm_timer = 9, /* Use GPT 9 for CIR */
+};
+
+static struct platform_device rx51_lirc_device = {
+	.name           = "lirc_rx51",
+	.id             = -1,
+	.dev            = {
+		.platform_data = &rx51_lirc_data,
+	},
+};
+
+static void __init rx51_init_lirc(void)
+{
+	platform_device_register(&rx51_lirc_device);
+}
+#else
+static void __init rx51_init_lirc(void)
+{
+}
+#endif
+
 void __init rx51_peripherals_init(void)
 {
 	rx51_i2c_init();
@@ -1230,6 +1259,7 @@ void __init rx51_peripherals_init(void)
 	rx51_init_wl1251();
 	rx51_init_tsc2005();
 	rx51_init_si4713();
+	rx51_init_lirc();
 	spi_register_board_info(rx51_peripherals_spi_board_info,
 				ARRAY_SIZE(rx51_peripherals_spi_board_info));
