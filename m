From: Andy Green <andy@warmcat.com>
Subject: [PATCH 2 15/18] I2C: OMAP2+: add correct functionality flags to all
 omap2plus i2c dev_attr
Date: Tue, 08 Mar 2011 11:09:12 +0000
Message-ID: <20110308110912.23531.6379.stgit@otae.warmcat.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:56816 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753902Ab1CHLJP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 06:09:15 -0500
Received: by mail-ww0-f42.google.com with SMTP id 17so809401wwi.1
        for <linux-omap@vger.kernel.org>; Tue, 08 Mar 2011 03:09:14 -0800 (PST)
In-Reply-To: <20110308105934.23531.83540.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Ben Dooks <ben-linux@fluff.org>, Andy Green <andy.green@linaro.org>

This adds the new functionality flags for omap i2c unit to all OMAP2
hwmod definitions

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    7 ++++++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    3 +++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    9 +++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    9 +++++++++
 4 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index de92d75..fe70365 100644
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
index d737b99..a30b100 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1527,6 +1527,9 @@ static struct omap_hwmod_class i2c_class = {
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
+	.flags		= OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
+			  OMAP_I2C_FLAG_BUS_SHIFT_2 |
+			  OMAP_I2C_FLAG_FORCE_19200_INT_CLK,
 };
 
 /* I2C1 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 324162d..f804e78 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1876,6 +1876,9 @@ static struct omap_hwmod omap3xxx_dss_venc_hwmod = {
 
 static struct omap_i2c_dev_attr i2c1_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
+	.flags = OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
+		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
+		 OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_hwmod_irq_info i2c1_mpu_irqs[] = {
@@ -1919,6 +1922,9 @@ static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 
 static struct omap_i2c_dev_attr i2c2_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
+	.flags = OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
+		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
+		 OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_hwmod_irq_info i2c2_mpu_irqs[] = {
@@ -1962,6 +1968,9 @@ static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 
 static struct omap_i2c_dev_attr i2c3_dev_attr = {
 	.fifo_depth	= 64, /* bytes */
+	.flags = OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
+		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
+		 OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_hwmod_irq_info i2c3_mpu_irqs[] = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 4b903c7..bad4b8e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -27,6 +27,7 @@
 #include <plat/mcspi.h>
 #include <plat/mcbsp.h>
 #include <plat/mmc.h>
+#include <plat/i2c.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -2090,6 +2091,10 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 	.rev	= OMAP_I2C_IP_VERSION_2,
 };
 
+static struct omap_i2c_dev_attr i2c_dev_attr = {
+	.flags  = OMAP_I2C_FLAG_BUS_SHIFT_NONE,
+};
+
 /* i2c1 */
 static struct omap_hwmod omap44xx_i2c1_hwmod;
 static struct omap_hwmod_irq_info omap44xx_i2c1_irqs[] = {
@@ -2140,6 +2145,7 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	},
 	.slaves		= omap44xx_i2c1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c1_slaves),
+	.dev_attr	= &i2c_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
@@ -2193,6 +2199,7 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 	},
 	.slaves		= omap44xx_i2c2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c2_slaves),
+	.dev_attr	= &i2c_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
@@ -2246,6 +2253,7 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 	},
 	.slaves		= omap44xx_i2c3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c3_slaves),
+	.dev_attr	= &i2c_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 
@@ -2299,6 +2307,7 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 	},
 	.slaves		= omap44xx_i2c4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c4_slaves),
+	.dev_attr	= &i2c_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 };
 

