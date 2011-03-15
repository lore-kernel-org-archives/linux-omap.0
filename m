From: Andy Green <andy@warmcat.com>
Subject: [PATCH 3 15/18] OMAP2+: hwmod data: add correct functionality flags
 to all omap2plus i2c dev_attr
Date: Tue, 15 Mar 2011 19:57:42 +0000
Message-ID: <20110315195742.30000.87259.stgit@otae.warmcat.com>
References: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:61553 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757194Ab1COT5p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Mar 2011 15:57:45 -0400
Received: by wwk4 with SMTP id 4so3299748wwk.1
        for <linux-omap@vger.kernel.org>; Tue, 15 Mar 2011 12:57:44 -0700 (PDT)
In-Reply-To: <20110315195147.30000.86184.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Ben Dooks <ben-linux@fluff.org>, Andy Green <andy.green@linaro.org>, Benoit Cousson <b-cousson@ti.com>

From: Andy Green <andy@warmcat.com>

This adds the new functionality flags for OMAP i2c unit to all OMAP2+
hwmod definitions.

Cc: patches@linaro.org
Cc: Ben Dooks <ben-linux@fluff.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
[b-cousson@ti.com: Move dev_attr to stick to
hwmod template, update the subject]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---

 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    7 ++++++-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    3 +++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    9 +++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   10 ++++++++++
 4 files changed, 28 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 64f60f9..698d467 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -485,7 +485,12 @@ static struct omap_hwmod_class i2c_class = {
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
index feb8655..2afbf0e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -486,6 +486,9 @@ static struct omap_hwmod_class i2c_class = {
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
+	.flags		= OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
+			  OMAP_I2C_FLAG_BUS_SHIFT_2 |
+			  OMAP_I2C_FLAG_FORCE_19200_INT_CLK,
 };
 
 /* I2C1 */
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 6b3ccb6..bc19a1e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -669,6 +669,9 @@ static struct omap_hwmod_class i2c_class = {
 
 static struct omap_i2c_dev_attr i2c1_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
+	.flags = OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
+		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
+		 OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_hwmod_irq_info i2c1_mpu_irqs[] = {
@@ -712,6 +715,9 @@ static struct omap_hwmod omap3xxx_i2c1_hwmod = {
 
 static struct omap_i2c_dev_attr i2c2_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
+	.flags = OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
+		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
+		 OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_hwmod_irq_info i2c2_mpu_irqs[] = {
@@ -755,6 +761,9 @@ static struct omap_hwmod omap3xxx_i2c2_hwmod = {
 
 static struct omap_i2c_dev_attr i2c3_dev_attr = {
 	.fifo_depth	= 64, /* bytes */
+	.flags = OMAP_I2C_FLAG_APPLY_ERRATA_I207 |
+		 OMAP_I2C_FLAG_RESET_REGS_POSTIDLE |
+		 OMAP_I2C_FLAG_BUS_SHIFT_2,
 };
 
 static struct omap_hwmod_irq_info i2c3_mpu_irqs[] = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index e50a79b..006c92a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -24,6 +24,7 @@
 #include <plat/cpu.h>
 #include <plat/gpio.h>
 #include <plat/dma.h>
+#include <plat/i2c.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -1114,6 +1115,11 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 	.rev	= OMAP_I2C_IP_VERSION_2,
 };
 
+/* i2c dev_attr */
+static struct omap_i2c_dev_attr i2c_dev_attr = {
+	.flags	= OMAP_I2C_FLAG_BUS_SHIFT_NONE,
+};
+
 /* i2c1 */
 static struct omap_hwmod omap44xx_i2c1_hwmod;
 static struct omap_hwmod_irq_info omap44xx_i2c1_irqs[] = {
@@ -1162,6 +1168,7 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_I2C1_CLKCTRL,
 		},
 	},
+	.dev_attr	= &i2c_dev_attr,
 	.slaves		= omap44xx_i2c1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c1_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1215,6 +1222,7 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_I2C2_CLKCTRL,
 		},
 	},
+	.dev_attr	= &i2c_dev_attr,
 	.slaves		= omap44xx_i2c2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c2_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1268,6 +1276,7 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_I2C3_CLKCTRL,
 		},
 	},
+	.dev_attr	= &i2c_dev_attr,
 	.slaves		= omap44xx_i2c3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c3_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -1321,6 +1330,7 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_I2C4_CLKCTRL,
 		},
 	},
+	.dev_attr	= &i2c_dev_attr,
 	.slaves		= omap44xx_i2c4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c4_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),

