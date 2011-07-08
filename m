From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v5 2/2] OMAP: hwmod: fix the i2c-reset timeout during
 bootup
Date: Fri, 8 Jul 2011 17:43:58 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1107081740470.15984@utopia.booyaka.com>
References: <1308743174-12265-1-git-send-email-avinashhm@ti.com> <1308743174-12265-2-git-send-email-avinashhm@ti.com> <BANLkTim8uuAv0=OfMyNt07mDr40F2AzUWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35820 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904Ab1GHXn7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jul 2011 19:43:59 -0400
In-Reply-To: <BANLkTim8uuAv0=OfMyNt07mDr40F2AzUWA@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mahadeva, Avinash" <avinashhm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

Hi Avinash

On Thu, 30 Jun 2011, Mahadeva, Avinash wrote:

> Hi Paul , Kevin ,
> 
> Ping. Could you please review this patch.
> 
> thanks ,
> - Avinash
> 
> On Wed, Jun 22, 2011 at 5:16 PM, Avinash.H.M <avinashhm@ti.com> wrote:
> 
> > The sequence of _ocp_softreset doesn't work for i2c. The i2c module has a
> > special sequence to reset the module. The sequence is
> >  - Disable the I2C.
> >  - Write to SOFTRESET bit.
> >  - Enable the I2C.
> >  - Poll on the RESETDONE bit.
> > The sequence is implemented as a function and the i2c_class is updated with
> > the correct 'reset' pointer.  omap_hwmod_softreset function is implemented
> > which triggers the softreset by writing into sysconfig register. On
> > following
> > this sequence, i2c module resets properly and timeouts are not seen.
> >
> > Cc: Rajendra Nayak <rnayak@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
> > Cc: Kevin Hilman <khilman@ti.com>
> > Signed-off-by: Avinash.H.M <avinashhm@ti.com>

I combined this patch with your patch to remove HWMOD_INIT_NO_RESET from 
the OMAP4 hwmod data, and modified your register offset selection code to 
use the hwmod class revision data.  The updated patch is below.  

It's been queued for 3.1 at git://git.pwsan.com/linux-2.6 in the 
'i2c_fixes_3.1' branch.
 

- Paul

From: "Avinash.H.M" <avinashhm@ti.com>
Date: Wed, 22 Jun 2011 17:16:14 +0530
Subject: [PATCH] OMAP: hwmod: fix the i2c-reset timeout during bootup

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
[paul@pwsan.com: combined this patch with a patch to remove
 HWMOD_INIT_NO_RESET from the 44xx hwmod flags; change register
 offset conditional code to use the IP block revision; minor code
 cleanup]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/i2c.c                    |   68 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.c             |   27 ++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    1 +
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    1 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    7 ++-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |   10 ++--
 arch/arm/plat-omap/include/plat/i2c.h        |    3 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 8 files changed, 111 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/i2c.c b/arch/arm/mach-omap2/i2c.c
index 79c478c..ace9994 100644
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
@@ -37,3 +47,61 @@ void __init omap2_i2c_mux_pins(int bus_id)
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
+	if (oh->class->rev == OMAP_I2C_IP_VERSION_2) {
+		i2c_con = OMAP4_I2C_CON_OFFSET;
+	} else if (oh->class->rev == OMAP_I2C_IP_VERSION_1) {
+		i2c_con = OMAP2_I2C_CON_OFFSET;
+	} else {
+		WARN(1, "Cannot reset I2C block %s: unsupported revision\n",
+		     oh->name);
+		return -EINVAL;
+	}
+
+	/* Disable I2C */
+	v = omap_hwmod_read(oh, i2c_con);
+	v &= ~I2C_EN;
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
index e9a416c..575e062 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -1448,6 +1448,7 @@ static struct omap_hwmod_class i2c_class = {
 	.name		= "i2c",
 	.sysc		= &i2c_sysc,
 	.rev		= OMAP_I2C_IP_VERSION_1,
+	.reset		= &omap_i2c_reset,
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index beedda6..710dd64 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -1525,6 +1525,7 @@ static struct omap_hwmod_class i2c_class = {
 	.name		= "i2c",
 	.sysc		= &i2c_sysc,
 	.rev		= OMAP_I2C_IP_VERSION_1,
+	.reset		= &omap_i2c_reset,
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index c9fc5ab..e32fed2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -1458,9 +1458,10 @@ static struct omap_hwmod omap3xxx_uart4_hwmod = {
 };
 
 static struct omap_hwmod_class i2c_class = {
-	.name = "i2c",
-	.sysc = &i2c_sysc,
-	.rev  = OMAP_I2C_IP_VERSION_1,
+	.name	= "i2c",
+	.sysc	= &i2c_sysc,
+	.rev	= OMAP_I2C_IP_VERSION_1,
+	.reset	= &omap_i2c_reset,
 };
 
 /*
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index d9ad2a6..5c1bbb2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -22,6 +22,7 @@
 
 #include <plat/omap_hwmod.h>
 #include <plat/cpu.h>
+#include <plat/i2c.h>
 #include <plat/gpio.h>
 #include <plat/dma.h>
 #include <plat/mcspi.h>
@@ -2127,6 +2128,7 @@ static struct omap_hwmod_class omap44xx_i2c_hwmod_class = {
 	.name	= "i2c",
 	.sysc	= &omap44xx_i2c_sysc,
 	.rev	= OMAP_I2C_IP_VERSION_2,
+	.reset	= &omap_i2c_reset,
 };
 
 static struct omap_i2c_dev_attr i2c_dev_attr = {
@@ -2170,7 +2172,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c1_slaves[] = {
 static struct omap_hwmod omap44xx_i2c1_hwmod = {
 	.name		= "i2c1",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_16BIT_REG | HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_16BIT_REG,
 	.mpu_irqs	= omap44xx_i2c1_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c1_irqs),
 	.sdma_reqs	= omap44xx_i2c1_sdma_reqs,
@@ -2224,7 +2226,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c2_slaves[] = {
 static struct omap_hwmod omap44xx_i2c2_hwmod = {
 	.name		= "i2c2",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_16BIT_REG | HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_16BIT_REG,
 	.mpu_irqs	= omap44xx_i2c2_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c2_irqs),
 	.sdma_reqs	= omap44xx_i2c2_sdma_reqs,
@@ -2278,7 +2280,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c3_slaves[] = {
 static struct omap_hwmod omap44xx_i2c3_hwmod = {
 	.name		= "i2c3",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_16BIT_REG | HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_16BIT_REG,
 	.mpu_irqs	= omap44xx_i2c3_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c3_irqs),
 	.sdma_reqs	= omap44xx_i2c3_sdma_reqs,
@@ -2332,7 +2334,7 @@ static struct omap_hwmod_ocp_if *omap44xx_i2c4_slaves[] = {
 static struct omap_hwmod omap44xx_i2c4_hwmod = {
 	.name		= "i2c4",
 	.class		= &omap44xx_i2c_hwmod_class,
-	.flags		= HWMOD_16BIT_REG | HWMOD_INIT_NO_RESET,
+	.flags		= HWMOD_16BIT_REG,
 	.mpu_irqs	= omap44xx_i2c4_irqs,
 	.mpu_irqs_cnt	= ARRAY_SIZE(omap44xx_i2c4_irqs),
 	.sdma_reqs	= omap44xx_i2c4_sdma_reqs,
diff --git a/arch/arm/plat-omap/include/plat/i2c.h b/arch/arm/plat-omap/include/plat/i2c.h
index fd75dad..7c22b9e 100644
--- a/arch/arm/plat-omap/include/plat/i2c.h
+++ b/arch/arm/plat-omap/include/plat/i2c.h
@@ -53,4 +53,7 @@ struct omap_i2c_dev_attr {
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
1.7.5.4

