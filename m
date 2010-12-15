From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 7/7] OMAP2430: hwmod data: Use common dev_attr for i2c1 and i2c2
Date: Wed, 15 Dec 2010 14:51:43 +0100
Message-ID: <1292421103-19282-8-git-send-email-b-cousson@ti.com>
References: <1292421103-19282-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39561 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754045Ab0LONxc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 08:53:32 -0500
In-Reply-To: <1292421103-19282-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, Benoit Cousson <b-cousson@ti.com>, Charulatha V <charu@ti.com>

Since i2c1 and i2c2 are using the same data, remove the two previous
instances and use a common i2c_dev_attr one.

Moreover, that will fix the following warning:
arch/arm/mach-omap2/omap_hwmod_2430_data.c:485:
warning: 'i2c_dev_attr' defined but not used

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Acked-by: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Charulatha V <charu@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   16 +++++-----------
 1 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 0f87736..eb73e5c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -482,14 +482,12 @@ static struct omap_hwmod_class i2c_class = {
 	.sysc		= &i2c_sysc,
 };
 
-static struct omap_i2c_dev_attr i2c_dev_attr;
-
-/* I2C1 */
-
-static struct omap_i2c_dev_attr i2c1_dev_attr = {
+static struct omap_i2c_dev_attr i2c_dev_attr = {
 	.fifo_depth	= 8, /* bytes */
 };
 
+/* I2C1 */
+
 static struct omap_hwmod_irq_info i2c1_mpu_irqs[] = {
 	{ .irq = INT_24XX_I2C1_IRQ, },
 };
@@ -530,16 +528,12 @@ static struct omap_hwmod omap2430_i2c1_hwmod = {
 	.slaves		= omap2430_i2c1_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_i2c1_slaves),
 	.class		= &i2c_class,
-	.dev_attr	= &i2c1_dev_attr,
+	.dev_attr	= &i2c_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
 /* I2C2 */
 
-static struct omap_i2c_dev_attr i2c2_dev_attr = {
-	.fifo_depth	= 8, /* bytes */
-};
-
 static struct omap_hwmod_irq_info i2c2_mpu_irqs[] = {
 	{ .irq = INT_24XX_I2C2_IRQ, },
 };
@@ -572,7 +566,7 @@ static struct omap_hwmod omap2430_i2c2_hwmod = {
 	.slaves		= omap2430_i2c2_slaves,
 	.slaves_cnt	= ARRAY_SIZE(omap2430_i2c2_slaves),
 	.class		= &i2c_class,
-	.dev_attr	= &i2c2_dev_attr,
+	.dev_attr	= &i2c_dev_attr,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
-- 
1.7.0.4

