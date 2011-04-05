From: "Avinash.H.M" <avinashhm@ti.com>
Subject: [PATCH 1/2 v2] OMAP2/3: hwmod: fix the i2c-reset timeout during bootup
Date: Tue,  5 Apr 2011 21:10:14 +0530
Message-ID: <1302018015-8858-2-git-send-email-avinashhm@ti.com>
References: <1302018015-8858-1-git-send-email-avinashhm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51669 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753889Ab1DEPkr (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Apr 2011 11:40:47 -0400
In-Reply-To: <1302018015-8858-1-git-send-email-avinashhm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Avinash.H.M" <avinashhm@ti.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

The i2c module has a special reset sequence. The sequence is
- Disable the I2C.
- Write to SOFTRESET bit.
- Enable the I2C.
- Poll on the RESETDONE bit.
This sequence must be followed for i2c reset in omap2, omap3. The sequence is
implemented as a function and the i2c_class is updated with the correct
'reset' pointer.

Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Avinash.H.M <avinashhm@ti.com>
---
 arch/arm/mach-omap2/i2c.c                  |   58 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |    1 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    1 +
 arch/arm/plat-omap/include/plat/i2c.h      |    3 +
 5 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
index 79c478c..67c7957 100644
--- a/arch/arm/mach-omap2/i2c.c
+++ b/arch/arm/mach-omap2/i2c.c
@@ -21,9 +21,16 @@
 
 #include <plat/cpu.h>
 #include <plat/i2c.h>
+#include <plat/common.h>
 
 #include "mux.h"
 
+/* In register I2C_CON, Bit 15 is the I2C enable bit */
+#define I2C_EN				BIT(15)
+#define I2C_CON_OFFSET			0x24
+/* Maximum microseconds to wait for OMAP module to softreset */
+#define MAX_MODULE_SOFTRESET_WAIT	10000
+
 void __init omap2_i2c_mux_pins(int bus_id)
 {
 	char mux_name[sizeof("i2c2_scl.i2c2_scl")];
@@ -37,3 +44,54 @@ void __init omap2_i2c_mux_pins(int bus_id)
 	sprintf(mux_name, "i2c%i_sda.i2c%i_sda", bus_id, bus_id);
 	omap_mux_init_signal(mux_name, OMAP_PIN_INPUT);
 }
+
+/**
+ * omap_i2c_reset- reset the omap i2c module.
+ * @oh: struct omap_hwmod *
+ *
+ * The i2c moudle in omap2, omap3 had a special sequence to reset. The
+ * sequence is:
+ * - Disable the I2C.
+ * - Write to SOFTRESET bit.
+ * - Enable the I2C.
+ * - Poll on the RESETDONE bit.
+ * The sequence is implemented in below function. This is called for 2420,
+ * 2430 and omap3.
+ */
+int omap_i2c_reset(struct omap_hwmod *oh)
+{
+	u32 v;
+	int c = 0;
+
+	/* Disable I2C */
+	v = omap_hwmod_read(oh, I2C_CON_OFFSET);
+	v = v & ~I2C_EN;
+	omap_hwmod_write(v, oh, I2C_CON_OFFSET);
+
+	/* Write to the SOFTRESET bit */
+	v = oh->_sysc_cache;
+	v |= (0x1 << oh->class->sysc->sysc_fields->srst_shift);
+
+	oh->_sysc_cache = v;
+	omap_hwmod_write(v, oh, oh->class->sysc->sysc_offs);
+
+	/* Enable I2C */
+	v = omap_hwmod_read(oh, I2C_CON_OFFSET);
+	v |= I2C_EN;
+	omap_hwmod_write(v, oh, I2C_CON_OFFSET);
+
+	/* Poll on RESETDONE bit */
+	omap_test_timeout((omap_hwmod_read(oh,
+				oh->class->sysc->syss_offs)
+				& SYSS_RESETDONE_MASK),
+				MAX_MODULE_SOFTRESET_WAIT, c);
+
+	if (c == MAX_MODULE_SOFTRESET_WAIT)
+		pr_warning("%s: %s: softreset failed (waited %d usec)\n",
+			__func__, oh->name, MAX_MODULE_SOFTRESET_WAIT);
+	else
+		pr_debug("%s: %s: softreset in %d usec\n", __func__,
+			oh->name, c);
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 8eb3ce1..82ff5f7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -1447,6 +1447,7 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
 static struct omap_hwmod_class i2c_class = {
 	.name		= "i2c",
 	.sysc		= &i2c_sysc,
+	.reset		= &omap_i2c_reset,
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr;
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index a860fb5..ce292f0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1524,6 +1524,7 @@ static struct omap_hwmod_class_sysconfig i2c_sysc = {
 static struct omap_hwmod_class i2c_class = {
 	.name		= "i2c",
 	.sysc		= &i2c_sysc,
+	.reset		= &omap_i2c_reset,
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index b98e2df..c74f972 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1460,6 +1460,7 @@ static struct omap_hwmod omap3xxx_uart4_hwmod = {
 static struct omap_hwmod_class i2c_class = {
 	.name = "i2c",
 	.sysc = &i2c_sysc,
+	.reset = &omap_i2c_reset,
 };
 
 /*
diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
index 878d632..749306f 100644
--- a/arch/arm/plat-omap/include/plat/i2c.h
+++ b/arch/arm/plat-omap/include/plat/i2c.h
@@ -22,6 +22,7 @@
 #define __ASM__ARCH_OMAP_I2C_H
 
 #include <linux/i2c.h>
+#include <plat/omap_hwmod.h>
 
 #if defined(CONFIG_I2C_OMAP) || defined(CONFIG_I2C_OMAP_MODULE)
 extern int omap_register_i2c_bus(int bus_id, u32 clkrate,
@@ -52,4 +53,6 @@ struct omap_i2c_dev_attr {
 void __init omap1_i2c_mux_pins(int bus_id);
 void __init omap2_i2c_mux_pins(int bus_id);
 
+int omap_i2c_reset(struct omap_hwmod *oh);
+
 #endif /* __ASM__ARCH_OMAP_I2C_H */
-- 
1.7.1

