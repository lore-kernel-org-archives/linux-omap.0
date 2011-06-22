From: "Avinash.H.M" <avinashhm@ti.com>
Subject: [PATCH v5 2/2] OMAP: hwmod: fix the i2c-reset timeout during bootup
Date: Wed, 22 Jun 2011 17:16:14 +0530
Message-ID: <1308743174-12265-2-git-send-email-avinashhm@ti.com>
References: <1308743174-12265-1-git-send-email-avinashhm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58598 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753450Ab1FVLqd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Jun 2011 07:46:33 -0400
In-Reply-To: <1308743174-12265-1-git-send-email-avinashhm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "Avinash.H.M" <avinashhm@ti.com>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

The sequence of _ocp_softreset doesn't work for i2c. The i2c module has a
special sequence to reset the module. The sequence is
 - Disable the I2C.
 - Write to SOFTRESET bit.
 - Enable the I2C.
 - Poll on the RESETDONE bit.
The sequence is implemented as a function and the i2c_class is updated with
the correct 'reset' pointer.  omap_hwmod_softreset function is implemented
which triggers the softreset by writing into sysconfig register. On following
this sequence, i2c module resets properly and timeouts are not seen.

Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Signed-off-by: Avinash.H.M <avinashhm@ti.com>
---
The patch is based on
 * git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
 * master branch.
 * 5629937 commit (Linux 3.0-rc4).

Changes from previous versions:
from v4:
	- Fixed Tomi's comment. Removed including hwmod.h in i2c.h
	- The sequence is applicable even for omap4. So removed the
	  INIT_NO_RESET flags from i2c hwmods and extend the patch to omap4
	  also. ( .reset pointer is populated accordingly ).
	- http://www.spinics.net/lists/linux-omap/msg51377.html
from v3:
	- Addressed comments from Paul Walmsley.
	- http://www.spinics.net/lists/arm-kernel/msg124120.html
from v2: 
	- Avoided direct SYSCONFIG access in i2c.c
	- http://www.spinics.net/lists/linux-omap/msg49632.html
from v1:
	- moved i2c specific things from hwmod files to i2c files.
	- fixed comments from Paul.
	- http://www.spinics.net/lists/linux-omap/msg49483.html

Testing:
* build tested omap2plus_defconfig for warnings and errors. none introduced.
* boot tested on 2430, 4430.  No timeouts are seen with this patch.
* tested for 'core off' in suspend resume on 3430 sdp. core off counters
  increment after suspend resume. 

Dependency: 
* This needs "OMAP2+: hwmod data: Set hwmod flags to only allow 16-bit
  accesses to i2c" from Andry Green for accessing i2c_sysc. Without this even
  with this patch, we will see i2c reset timeouts.

 arch/arm/mach-omap2/i2c.c                    |   63 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.c             |   27 +++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    1 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    1 +
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    2 +
 arch/arm/plat-omap/include/plat/i2c.h        |    3 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 8 files changed, 99 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
index 79c478c..5c2445e 100644
--- a/arch/arm/mach-omap2/i2c.c
+++ b/arch/arm/mach-omap2/i2c.c
@@ -21,9 +21,19 @@
 
 #include <plat/cpu.h>
 #include <plat/i2c.h>
+#include <plat/common.h>
+#include <plat/omap_hwmod.h>
 
 #include "mux.h"
 
+/* In register I2C_CON, Bit 15 is the I2C enable bit */
+#define I2C_EN					BIT(15)
+#define OMAP2_I2C_CON_OFFSET			0x24
+#define OMAP4_I2C_CON_OFFSET			0xA4
+
+/* Maximum microseconds to wait for OMAP module to softreset */
+#define MAX_MODULE_SOFTRESET_WAIT	10000
+
 void __init omap2_i2c_mux_pins(int bus_id)
 {
 	char mux_name[sizeof("i2c2_scl.i2c2_scl")];
@@ -37,3 +47,56 @@ void __init omap2_i2c_mux_pins(int bus_id)
 	sprintf(mux_name, "i2c%i_sda.i2c%i_sda", bus_id, bus_id);
 	omap_mux_init_signal(mux_name, OMAP_PIN_INPUT);
 }
+
+/**
+ * omap_i2c_reset - reset the omap i2c module.
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
+	u16 i2c_con;
+	int c = 0;
+
+	if (cpu_is_omap44xx())
+		i2c_con = OMAP4_I2C_CON_OFFSET;
+	else
+		i2c_con = OMAP2_I2C_CON_OFFSET;
+
+	/* Disable I2C */
+	v = omap_hwmod_read(oh, i2c_con);
+	v = v & ~I2C_EN;
+	omap_hwmod_write(v, oh, i2c_con);
+
+	/* Write to the SOFTRESET bit */
+	omap_hwmod_softreset(oh);
+
+	/* Enable I2C */
+	v = omap_hwmod_read(oh, i2c_con);
+	v |= I2C_EN;
+	omap_hwmod_write(v, oh, i2c_con);
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
diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 293fa6c..64ffec4 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1562,6 +1562,33 @@ void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs)
 }
 
 /**
+ * omap_hwmod_softreset - reset a module via SYSCONFIG.SOFTRESET bit
+ * @oh: struct omap_hwmod *
+ *
+ * This is a public function exposed to drivers. Some drivers may need to do
+ * some settings before and after resetting the device.  Those drivers after
+ * doing the necessary settings could use this function to start a reset by
+ * setting the SYSCONFIG.SOFTRESET bit.
+ */
+int omap_hwmod_softreset(struct omap_hwmod *oh)
+{
+	u32 v;
+	int ret;
+
+	if (!oh || !(oh->_sysc_cache))
+		return -EINVAL;
+
+	v = oh->_sysc_cache;
+	ret = _set_softreset(oh, &v);
+	if (ret)
+		goto error;
+	_write_sysconfig(v, oh);
+
+error:
+	return ret;
+}
+
+/**
  * omap_hwmod_set_slave_idlemode - set the hwmod's OCP slave idlemode
  * @oh: struct omap_hwmod *
  * @idlemode: SIDLEMODE field bits (shifted to bit 0)
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index c4d0ae8..8950ad3 100644
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
index 9682dd5..6b5413b 100644
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
index 909a84d..2e21e2d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1460,6 +1460,7 @@ static struct omap_hwmod omap3xxx_uart4_hwmod = {
 static struct omap_hwmod_class i2c_class = {
 	.name = "i2c",
 	.sysc = &i2c_sysc,
+	.reset = &omap_i2c_reset,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 2eaf40a..5e11c0b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -22,6 +22,7 @@
 
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
+#include <plat/i2c.h>
 #include <plat/gpio.h>
 #include <plat/dma.h>
 #include <plat/mcspi.h>
@@ -2125,6 +2126,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_i2c_sysc = {
 static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 	.name	= "i2c",
 	.sysc	= &omap44xx_i2c_sysc,
+	.reset = &omap_i2c_reset,
 };
 
 /* i2c1 */
diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
index 878d632..ad53959 100644
--- a/arch/arm/plat-omap/include/plat/i2c.h
+++ b/arch/arm/plat-omap/include/plat/i2c.h
@@ -52,4 +52,7 @@ struct omap_i2c_dev_attr {
 void __init omap1_i2c_mux_pins(int bus_id);
 void __init omap2_i2c_mux_pins(int bus_id);
 
+struct omap_hwmod;
+int omap_i2c_reset(struct omap_hwmod *oh);
+
 #endif /* __ASM__ARCH_OMAP_I2C_H */
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 1adea9c..fe8a0a2 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -572,6 +572,7 @@ void omap_hwmod_ocp_barrier(struct omap_hwmod *oh);
 
 void omap_hwmod_write(u32 v, struct omap_hwmod *oh, u16 reg_offs);
 u32 omap_hwmod_read(struct omap_hwmod *oh, u16 reg_offs);
+int omap_hwmod_softreset(struct omap_hwmod *oh);
 
 int omap_hwmod_count_resources(struct omap_hwmod *oh);
 int omap_hwmod_fill_resources(struct omap_hwmod *oh, struct resource *res);
-- 
1.7.1

