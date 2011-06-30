From: "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH 4/5] OMAP4: Panda: Update panda board file to use DT
Date: Thu, 30 Jun 2011 15:07:26 +0500
Message-ID: <1309426647-31587-5-git-send-email-manjugk@ti.com>
References: <1309426647-31587-1-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
List-Id: linux-omap@vger.kernel.org


The OMAP4 panda board file is updated to use i2c nodes from device
tree data structures.

Signed-off-by: G, Manjunath Kondaiah <manjugk-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/board-omap4panda.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index c9d1e13..b3151a0 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -22,12 +22,15 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/leds.h>
+#include <linux/of_platform.h>
+#include <linux/of_address.h>
 #include <linux/gpio.h>
 #include <linux/usb/otg.h>
 #include <linux/i2c/twl.h>
 #include <linux/regulator/machine.h>
 #include <linux/regulator/fixed.h>
 #include <linux/wl12xx.h>
+#include <linux/irq.h>
 
 #include <mach/hardware.h>
 #include <mach/omap4-common.h>
@@ -410,6 +413,7 @@ static struct i2c_board_info __initdata panda_i2c_eeprom[] = {
 static int __init omap4_panda_i2c_init(void)
 {
 	omap4_pmic_init("twl6030", &omap4_panda_twldata);
+#if !defined(CONFIG_OF)
 	omap_register_i2c_bus(2, 400, NULL, 0);
 	/*
 	 * Bus 3 is attached to the DVI port where devices like the pico DLP
@@ -418,6 +422,7 @@ static int __init omap4_panda_i2c_init(void)
 	omap_register_i2c_bus(3, 100, panda_i2c_eeprom,
 					ARRAY_SIZE(panda_i2c_eeprom));
 	omap_register_i2c_bus(4, 400, NULL, 0);
+#endif
 	return 0;
 }
 
@@ -681,9 +686,25 @@ void omap4_panda_display_init(void)
 	omap_display_init(&omap4_panda_dss_data);
 }
 
+static struct of_device_id omap_dt_gic_match[] __initdata = {
+	{ .compatible = "ti,omap-gic", },
+	{}
+};
+
+static struct of_device_id omap_dt_match_table[] __initdata = {
+	{ .compatible = "ti,omap4-panda", },
+	{}
+};
+
 static void __init omap4_panda_init(void)
 {
 	int package = OMAP_PACKAGE_CBS;
+	struct device_node *node;
+
+	node = of_find_matching_node_by_address(NULL, omap_dt_gic_match,
+						OMAP44XX_GIC_DIST_BASE);
+	if (node)
+		irq_domain_add_simple(node, 0);
 
 	if (omap_rev() == OMAP4430_REV_ES1_0)
 		package = OMAP_PACKAGE_CBL;
@@ -700,6 +721,7 @@ static void __init omap4_panda_init(void)
 	omap4_ehci_init();
 	usb_musb_init(&musb_board_data);
 	omap4_panda_display_init();
+	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
 }
 
 static void __init omap4_panda_map_io(void)
-- 
1.7.4.1
