From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: Re: [PATCH 2 15/18] I2C: OMAP2+: add correct functionality flags
 to all omap2plus i2c dev_attr
Date: Wed, 9 Mar 2011 16:43:27 +0100
Message-ID: <4D77A01F.8080706@ti.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com> <20110308110912.23531.6379.stgit@otae.warmcat.com> <4D778551.5010900@ti.com> <4D7788D5.8040603@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45560 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753857Ab1CIPns (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 Mar 2011 10:43:48 -0500
In-Reply-To: <4D7788D5.8040603@linaro.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "andy.green@linaro.org" <andy.green@linaro.org>
Cc: Andy Green <andy@warmcat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, Ben Dooks <ben-linux@fluff.org>

On 3/9/2011 3:04 PM, Andy Green wrote:
> On 03/09/2011 01:49 PM, Somebody in the thread at some point said:
> 
> Hi -
> 
>> I have one minor comment about the OMAP4 dev_attr position in the
>> structure. The point here is just to be aligned with the template
>> used by the generator.
>>
>> Acked-by: Benoit Cousson<b-cousson@ti.com>
> 
>> The generator is adding a (probably useless...) comment on top of the
>> structure. For the comment I'd prefer to stick to the template. I'll
>> do a massive cleanup when every OMAP4 drivers will be migrated to
>> hwmod. And then OMAP2&   3 at some point will stick to that as well.
> 
>> The OMAP4 part should look like the patch below. I've just updated
>> the scripts to add the new data you introduced.
> 
> I'm fine if you just want to replace that stanza with yours that matches
> the script's member ordering.  Thanks for a rapid review ^^

You can find it below. I changed as well the subject as suggested.

Benoit

---
>From 561068054176af4574b5bf3a1d1258f19dc186e8 Mon Sep 17 00:00:00 2001
From: Andy Green <andy@warmcat.com>
Date: Tue, 8 Mar 2011 11:09:12 +0000
Subject: [PATCH] OMAP2+: hwmod data: add correct functionality flags to all omap2plus i2c dev_attr

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
index 5d3f684..c2edb21 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -27,6 +27,7 @@
 #include <plat/mcspi.h>
 #include <plat/mcbsp.h>
 #include <plat/mmc.h>
+#include <plat/i2c.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -2090,6 +2091,11 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
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
@@ -2138,6 +2144,7 @@ static struct omap_hwmod omap44xx_i2c1_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_I2C1_CLKCTRL,
 		},
 	},
+	.dev_attr	= &i2c_dev_attr,
 	.slaves		= omap44xx_i2c1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c1_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -2191,6 +2198,7 @@ static struct omap_hwmod omap44xx_i2c2_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_I2C2_CLKCTRL,
 		},
 	},
+	.dev_attr	= &i2c_dev_attr,
 	.slaves		= omap44xx_i2c2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c2_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -2244,6 +2252,7 @@ static struct omap_hwmod omap44xx_i2c3_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_I2C3_CLKCTRL,
 		},
 	},
+	.dev_attr	= &i2c_dev_attr,
 	.slaves		= omap44xx_i2c3_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c3_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -2297,6 +2306,7 @@ static struct omap_hwmod omap44xx_i2c4_hwmod = {
 			.clkctrl_reg = OMAP4430_CM_L4PER_I2C4_CLKCTRL,
 		},
 	},
+	.dev_attr	= &i2c_dev_attr,
 	.slaves		= omap44xx_i2c4_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap44xx_i2c4_slaves),
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
-- 
1.7.0.4





