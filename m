From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 3/3] I2C: OMAP2+: add correct functionality flags to all omap2plus i2c dev_attr
Date: Fri,  8 Jul 2011 09:11:44 -0700
Message-ID: <1310141504-13688-4-git-send-email-khilman@ti.com>
References: <1310141504-13688-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:54557 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752484Ab1GHQLy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 12:11:54 -0400
Received: by mail-pz0-f47.google.com with SMTP id 36so1726999pzk.20
        for <linux-omap@vger.kernel.org>; Fri, 08 Jul 2011 09:11:53 -0700 (PDT)
In-Reply-To: <1310141504-13688-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, Andy Green <andy@warmcat.com>, linux-arm-kernel@lists.infradead.org

From: Andy Green <andy@warmcat.com>

This adds the new functionality flags for omap i2c unit to all OMAP2
hwmod definitions

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    7 ++++++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    3 +++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    9 +++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    9 +++++++++
 4 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 2223c44..e9a416c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -1450,7 +1450,12 @@ static struct omap_hwmod_class i2c_class = {
 	.rev		= OMAP_I2C_IP_VERSION_1,
 };
 
-static struct omap_i2c_dev_attr i2c_dev_attr;
+static struct omap_i2c_dev_attr i2c_dev_attr = {
+	.flags		= OMAP_I2C_FLAG_NO_FIFO |
+			  OMAP_I2C_FLAG_SIMPLE_CLOCK |
+			  OMAP_I2C_FLAG_16BIT_DATA_REG |
+			  OMAP_I2C_FLAG_BUS_SHIFT_2,
+};
 
 /* I2C1 */
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index dbcc36e..beedda6 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1529,6 +1529,9 @@ static struct omap_hwmod_class i2c_class = {
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
+	.flags		= OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
+			  OMAP_I2C_FLAG_BUS_SHIFT_2 |
+			  OMAP_I2C_FLAG_FORCE_19200_INT_CLK,
 };
 
 /* I2C1 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 80839b1..dec1a38 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1875,6 +1875,9 @@ static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
 
 static struct omap_i2c_dev_attr i2c1_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
+	.flags = OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
+		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
+		 OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_hwmod_irq_info i2c1_mpu_irqs[] = {
@@ -1918,6 +1921,9 @@ static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 
 static struct omap_i2c_dev_attr i2c2_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
+	.flags = OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
+		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
+		 OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_hwmod_irq_info i2c2_mpu_irqs[] = {
@@ -1961,6 +1967,9 @@ static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 
 static struct omap_i2c_dev_attr i2c3_dev_attr = {
 	.fifo_depth	= 64, /* bytes */
+	.flags = OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
+		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
+		 OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_hwmod_irq_info i2c3_mpu_irqs[] = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 6578a36..0fe9556 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -27,6 +27,7 @@
 #include <plat/mcspi.h>
 #include <plat/mcbsp.h>
 #include <plat/mmc.h>
+#include <plat/i2c.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -2128,6 +2129,10 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 	.rev	= OMAP_I2C_IP_VERSION_2,
 };
 
+static struct omap_i2c_dev_attr i2c_dev_attr = {
+	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE,
+};
+
 /* i2c1 */
 static struct omap_hwmod omap44xx_i2c1_hwmod;
 static struct omap_hwmod_irq_info omap44xx_i2c1_irqs[] = {
@@ -2178,6 +2183,7 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	},
 	.slaves		= omap44xx_i2c1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c1_slaves),
+	.dev_attr	= &i2c_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
@@ -2231,6 +2237,7 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 	},
 	.slaves		= omap44xx_i2c2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c2_slaves),
+	.dev_attr	= &i2c_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
@@ -2284,6 +2291,7 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 	},
 	.slaves		= omap44xx_i2c3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c3_slaves),
+	.dev_attr	= &i2c_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
@@ -2337,6 +2345,7 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 	},
 	.slaves		= omap44xx_i2c4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c4_slaves),
+	.dev_attr	= &i2c_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
-- 
1.7.6

