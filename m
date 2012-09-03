From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 3/4] ARM: AM33XX: board-generic: Add of_dev_auxdata to pass d_can raminit
Date: Mon, 3 Sep 2012 17:22:18 +0530
Message-ID: <1346673139-14540-4-git-send-email-anilkumar@ti.com>
References: <1346673139-14540-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43339 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756334Ab2ICLwt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Sep 2012 07:52:49 -0400
In-Reply-To: <1346673139-14540-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de
Cc: tony@atomide.com, linux-can@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, AnilKumar Ch <anilkumar@ti.com>

Add of_dev_auxdata to pass d_can raminit callback APIs to initialize
d_can RAM. D_CAN RAM initialization bits are present in CONTROL module
address space, which can be accessed by platform specific code. So
callback functions are added to serve this purpose, this can done by
using of_dev_auxdata.

Callback API is added to of_dev_auxdata with different instance numbers
for two instances of D_CAN IP. These callback functions are used to
enable/disable D_CAN RAM from CAN driver.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/mach-omap2/board-generic.c |   40 ++++++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/control.h       |    4 ++++
 2 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 6f93a20..b68e642 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -15,6 +15,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 #include <linux/irqdomain.h>
+#include <linux/can/platform/c_can.h>
 
 #include <mach/hardware.h>
 #include <asm/hardware/gic.h>
@@ -22,6 +23,8 @@
 
 #include <plat/board.h>
 #include "common.h"
+#include "control.h"
+#include "iomap.h"
 #include "common-board-devices.h"
 
 #if !(defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3))
@@ -37,11 +40,46 @@ static struct of_device_id omap_dt_match_table[] __initdata = {
 	{ }
 };
 
+void d_can_hw_raminit(unsigned int instance, bool enable)
+{
+	u32 val;
+
+	val = readl(AM33XX_CTRL_REGADDR(AM33XX_CONTROL_DCAN_RAMINIT));
+	if (enable) {
+		val &= ~AM33XX_DCAN_RAMINIT_START_MASK(instance);
+		val |= AM33XX_DCAN_RAMINIT_START_MASK(instance);
+		writel(val, AM33XX_CTRL_REGADDR(AM33XX_CONTROL_DCAN_RAMINIT));
+	} else {
+		val &= ~AM33XX_DCAN_RAMINIT_START_MASK(instance);
+		writel(val, AM33XX_CTRL_REGADDR(AM33XX_CONTROL_DCAN_RAMINIT));
+	}
+}
+
+static struct c_can_platform_data d_can0_pdata = {
+	.ram_init	= d_can_hw_raminit,
+	.instance	= 0,
+};
+
+static struct c_can_platform_data d_can1_pdata = {
+	.ram_init	= d_can_hw_raminit,
+	.instance	= 1,
+};
+
+static const struct of_dev_auxdata am33xx_auxdata_lookup[] __initconst = {
+	OF_DEV_AUXDATA("bosch,d_can", 0x481cc000, NULL, &d_can0_pdata),
+	OF_DEV_AUXDATA("bosch,d_can", 0x481d0000, NULL, &d_can1_pdata),
+	{ },
+};
+
 static void __init omap_generic_init(void)
 {
 	omap_sdrc_init(NULL, NULL);
 
-	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
+	if (of_machine_is_compatible("ti,am33xx"))
+		of_platform_populate(NULL, omap_dt_match_table,
+				am33xx_auxdata_lookup, NULL);
+	else
+		of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
 }
 
 #ifdef CONFIG_SOC_OMAP2420
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index b8cdc85..afd189b 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -356,6 +356,10 @@
 #define AM33XX_CONTROL_STATUS_SYSBOOT1_SHIFT		22
 #define AM33XX_CONTROL_STATUS_SYSBOOT1_MASK		(0x3 << 22)
 
+/* AM33XX DCAN bitfields */
+#define AM33XX_CONTROL_DCAN_RAMINIT		0x644
+#define AM33XX_DCAN_RAMINIT_START_MASK(i)	(1 << (i))
+
 /* CONTROL OMAP STATUS register to identify OMAP3 features */
 #define OMAP3_CONTROL_OMAP_STATUS	0x044c
 
-- 
1.7.9.5

