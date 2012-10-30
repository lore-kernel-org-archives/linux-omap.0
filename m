From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 05/11] ARM: OMAP: Make plat-omap/i2c.c port checks local
Date: Tue, 30 Oct 2012 16:52:51 -0700
Message-ID: <20121030235251.25936.92446.stgit@muffinssi.local>
References: <20121030234852.25936.12482.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:56274 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754464Ab2J3Xww (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Oct 2012 19:52:52 -0400
In-Reply-To: <20121030234852.25936.12482.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

The common code should not have any omap1 or omap2+
specific code, and should not need to call the cpu_is_omap
macros.

The only remaining user for cpu_is_omap macros is
omap_i2c_nr_ports(). Let's make those checks in
the omap specific implementation of omap_i2c_add_bus()
instead in order to remove cpu_is_omap usage from
the common code.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/i2c.c |    3 +++
 arch/arm/mach-omap2/i2c.c |   16 ++++++++++++++++
 arch/arm/plat-omap/i2c.c  |   26 +++-----------------------
 3 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/arch/arm/mach-omap1/i2c.c b/arch/arm/mach-omap1/i2c.c
index 32bcbb8..54097a2 100644
--- a/arch/arm/mach-omap1/i2c.c
+++ b/arch/arm/mach-omap1/i2c.c
@@ -54,6 +54,9 @@ int __init omap_i2c_add_bus(struct omap_i2c_bus_platform_data *pdata,
 	struct platform_device *pdev;
 	struct resource *res;
 
+	if (bus_id > 1)
+		return -EINVAL;
+
 	omap1_i2c_mux_pins(bus_id);
 
 	pdev = &omap_i2c_devices[bus_id - 1];
diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
index ad55b94..4e63097 100644
--- a/arch/arm/mach-omap2/i2c.c
+++ b/arch/arm/mach-omap2/i2c.c
@@ -109,6 +109,19 @@ int omap_i2c_reset(struct omap_hwmod *oh)
 	return 0;
 }
 
+static int __init omap_i2c_nr_ports(void)
+{
+	int ports = 0;
+
+	if (cpu_is_omap24xx())
+		ports = 2;
+	else if (cpu_is_omap34xx())
+		ports = 3;
+	else if (cpu_is_omap44xx())
+		ports = 4;
+	return ports;
+}
+
 static const char name[] = "omap_i2c";
 
 int __init omap_i2c_add_bus(struct omap_i2c_bus_platform_data *i2c_pdata,
@@ -121,6 +134,9 @@ int __init omap_i2c_add_bus(struct omap_i2c_bus_platform_data *i2c_pdata,
 	struct omap_i2c_bus_platform_data *pdata;
 	struct omap_i2c_dev_attr *dev_attr;
 
+	if (bus_id > omap_i2c_nr_ports())
+		return -EINVAL;
+
 	omap2_i2c_mux_pins(bus_id);
 
 	l = snprintf(oh_name, MAX_OMAP_I2C_HWMOD_NAME_LEN, "i2c%d", bus_id);
diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index be6deb7..d094273 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -33,9 +33,6 @@
 
 #include <mach/irqs.h>
 
-#include "../mach-omap1/soc.h"
-#include "../mach-omap2/soc.h"
-
 #include "i2c.h"
 
 #define OMAP_I2C_MAX_CONTROLLERS 4
@@ -43,22 +40,6 @@ static struct omap_i2c_bus_platform_data i2c_pdata[OMAP_I2C_MAX_CONTROLLERS];
 
 #define OMAP_I2C_CMDLINE_SETUP	(BIT(31))
 
-static int __init omap_i2c_nr_ports(void)
-{
-	int ports = 0;
-
-	if (cpu_class_is_omap1())
-		ports = 1;
-	else if (cpu_is_omap24xx())
-		ports = 2;
-	else if (cpu_is_omap34xx())
-		ports = 3;
-	else if (cpu_is_omap44xx())
-		ports = 4;
-
-	return ports;
-}
-
 /**
  * omap_i2c_bus_setup - Process command line options for the I2C bus speed
  * @str: String of options
@@ -72,12 +53,11 @@ static int __init omap_i2c_nr_ports(void)
  */
 static int __init omap_i2c_bus_setup(char *str)
 {
-	int ports;
 	int ints[3];
 
-	ports = omap_i2c_nr_ports();
 	get_options(str, 3, ints);
-	if (ints[0] < 2 || ints[1] < 1 || ints[1] > ports)
+	if (ints[0] < 2 || ints[1] < 1 ||
+			ints[1] > OMAP_I2C_MAX_CONTROLLERS)
 		return 0;
 	i2c_pdata[ints[1] - 1].clkrate = ints[2];
 	i2c_pdata[ints[1] - 1].clkrate |= OMAP_I2C_CMDLINE_SETUP;
@@ -122,7 +102,7 @@ int __init omap_register_i2c_bus(int bus_id, u32 clkrate,
 {
 	int err;
 
-	BUG_ON(bus_id < 1 || bus_id > omap_i2c_nr_ports());
+	BUG_ON(bus_id < 1 || bus_id > OMAP_I2C_MAX_CONTROLLERS);
 
 	if (info) {
 		err = i2c_register_board_info(bus_id, info, len);

