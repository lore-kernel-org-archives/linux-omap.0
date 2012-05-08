From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 4/7] ARM: OMAP2: Add MMC hwmod data for 2420
Date: Tue, 8 May 2012 17:32:32 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1205081729450.28088@utopia.booyaka.com>
References: <20120424000607.17783.81686.stgit@muffinssi.local> <20120424000832.17783.21327.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34781 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655Ab2EHXcd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 May 2012 19:32:33 -0400
In-Reply-To: <20120424000832.17783.21327.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hi

On Mon, 23 Apr 2012, Tony Lindgren wrote:

> Add MMC for 2420 so we can pass the DMA request lines the same
> way as we already do on omap2430 and later.
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

During some testing of the updated patch with the SYSCONFIG registers 
added in, it was discovered that the MSDI IP block was not completing its 
soft reset.  Investigation and some trial and error revealed that the IP 
block requires that its POW bit be set and a clock divisor be programmed 
into CLKD in order for the reset to complete.  So, this patch has been 
updated to implement the custom reset sequence; updated patch below.


- Paul

From: Tony Lindgren <tony@atomide.com>
Date: Tue, 8 May 2012 17:23:33 -0600
Subject: [PATCH] ARM: OMAP2420: hwmod data: Add MMC hwmod data for 2420

Add MMC for 2420 so we can pass the DMA request lines the same
way as we already do on omap2430 and later.

Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
[paul@pwsan.com: updated to apply on top of the 3.5 hwmod cleanup;
 changed mmc hwmod name/class to "msdi" as documented in the 2420 TRM Rev X;
 added sysconfig register information; added 16 bit register width flag;
 added MSDI custom reset code]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile               |    3 +
 arch/arm/mach-omap2/msdi.c                 |   88 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c |   64 ++++++++++++++++++++
 arch/arm/plat-omap/include/plat/mmc.h      |    4 ++
 4 files changed, 159 insertions(+)
 create mode 100644 arch/arm/mach-omap2/msdi.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index d8604a3..4eee0f1 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -189,6 +189,9 @@ ifneq ($(CONFIG_TIDSPBRIDGE),)
 obj-y					+= dsp.o
 endif
 
+# OMAP2420 MSDI controller integration support ("MMC")
+obj-$(CONFIG_SOC_OMAP2420)		+= msdi.o
+
 # Specific board support
 obj-$(CONFIG_MACH_OMAP_GENERIC)		+= board-generic.o
 obj-$(CONFIG_MACH_OMAP_H4)		+= board-h4.o
diff --git a/arch/arm/mach-omap2/msdi.c b/arch/arm/mach-omap2/msdi.c
new file mode 100644
index 0000000..ef2a692
--- /dev/null
+++ b/arch/arm/mach-omap2/msdi.c
@@ -0,0 +1,88 @@
+/*
+ * MSDI IP block reset
+ *
+ * Copyright (C) 2012 Texas Instruments, Inc.
+ * Paul Walmsley
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ * XXX What about pad muxing?
+ */
+
+#include <linux/kernel.h>
+
+#include <plat/omap_hwmod.h>
+#include <plat/mmc.h>
+
+#include "common.h"
+
+/*
+ * MSDI_CON_OFFSET: offset in bytes of the MSDI IP block's CON register
+ *     from the IP block's base address
+ */
+#define MSDI_CON_OFFSET				0x0c
+
+/* Register bitfields in the CON register */
+#define MSDI_CON_POW_MASK			BIT(11)
+#define MSDI_CON_CLKD_MASK			(0x3f << 0)
+#define MSDI_CON_CLKD_SHIFT			0
+
+/* Maximum microseconds to wait for OMAP module to softreset */
+#define MAX_MODULE_SOFTRESET_WAIT	10000
+
+/* MSDI_TARGET_RESET_CLKD: clock divisor to use throughout the reset */
+#define MSDI_TARGET_RESET_CLKD		0x3ff
+
+/**
+ * omap_msdi_reset - reset the MSDI IP block
+ * @oh: struct omap_hwmod *
+ *
+ * The MSDI IP block on OMAP2420 has to have both the POW and CLKD
+ * fields set inside its CON register for a reset to complete
+ * successfully.  This is not documented in the TRM.  For CLKD, we use
+ * the value that results in the lowest possible clock rate, to attempt
+ * to avoid disturbing any cards.
+ */
+int omap_msdi_reset(struct omap_hwmod *oh)
+{
+	u16 v = 0;
+	int c = 0;
+
+	/* Write to the SOFTRESET bit */
+	omap_hwmod_softreset(oh);
+
+	/* Enable the MSDI core and internal clock */
+	v |= MSDI_CON_POW_MASK;
+	v |= MSDI_TARGET_RESET_CLKD << MSDI_CON_CLKD_SHIFT;
+	omap_hwmod_write(v, oh, MSDI_CON_OFFSET);
+
+	/* Poll on RESETDONE bit */
+	omap_test_timeout((omap_hwmod_read(oh, oh->class->sysc->syss_offs)
+			   & SYSS_RESETDONE_MASK),
+			  MAX_MODULE_SOFTRESET_WAIT, c);
+
+	if (c == MAX_MODULE_SOFTRESET_WAIT)
+		pr_warning("%s: %s: softreset failed (waited %d usec)\n",
+			   __func__, oh->name, MAX_MODULE_SOFTRESET_WAIT);
+	else
+		pr_debug("%s: %s: softreset in %d usec\n", __func__,
+			 oh->name, c);
+
+	/* Disable the MSDI internal clock */
+	v &= ~MSDI_CON_CLKD_MASK;
+	omap_hwmod_write(v, oh, MSDI_CON_OFFSET);
+
+	return 0;
+}
diff --git a/arch/arm/mach-omap2/omap_hwmod_2420_data.c b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
index 2c087ff..0c08d3f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2420_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2420_data.c
@@ -23,6 +23,7 @@
 #include <plat/dmtimer.h>
 #include <plat/l3_2xxx.h>
 #include <plat/l4_2xxx.h>
+#include <plat/mmc.h>
 
 #include "omap_hwmod_common_data.h"
 
@@ -239,6 +240,50 @@ static struct omap_hwmod omap2420_mcbsp2_hwmod = {
 	},
 };
 
+static struct omap_hwmod_class_sysconfig omap2420_msdi_sysc = {
+	.rev_offs	= 0x3c,
+	.sysc_offs	= 0x64,
+	.syss_offs	= 0x68,
+	.sysc_flags	= (SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap2420_msdi_hwmod_class = {
+	.name	= "msdi",
+	.sysc	= &omap2420_msdi_sysc,
+	.reset	= &omap_msdi_reset,
+};
+
+/* msdi1 */
+static struct omap_hwmod_irq_info omap2420_msdi1_irqs[] = {
+	{ .irq = 83 },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap2420_msdi1_sdma_reqs[] = {
+	{ .name = "tx", .dma_req = 61 }, /* OMAP24XX_DMA_MMC1_TX */
+	{ .name = "rx", .dma_req = 62 }, /* OMAP24XX_DMA_MMC1_RX */
+	{ .dma_req = -1 }
+};
+
+static struct omap_hwmod omap2420_msdi1_hwmod = {
+	.name		= "msdi1",
+	.class		= &omap2420_msdi_hwmod_class,
+	.mpu_irqs	= omap2420_msdi1_irqs,
+	.sdma_reqs	= omap2420_msdi1_sdma_reqs,
+	.main_clk	= "mmc_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id = 1,
+			.module_bit = OMAP2420_EN_MMC_SHIFT,
+			.module_offs = CORE_MOD,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP2420_ST_MMC_SHIFT,
+		},
+	},
+	.flags		= HWMOD_16BIT_REG,
+};
+
 /*
  * interfaces
  */
@@ -428,6 +473,24 @@ static struct omap_hwmod_ocp_if omap2420_l4_core__mcbsp2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_addr_space omap2420_msdi1_addrs[] = {
+	{
+		.pa_start	= 0x4809c000,
+		.pa_end		= 0x4809c000 + SZ_128 - 1,
+		.flags		= ADDR_TYPE_RT,
+	},
+	{ }
+};
+
+/* l4_core -> msdi1 */
+static struct omap_hwmod_ocp_if omap2420_l4_core__msdi1 = {
+	.master		= &omap2xxx_l4_core_hwmod,
+	.slave		= &omap2420_msdi1_hwmod,
+	.clk		= "mmc_ick",
+	.addr		= omap2420_msdi1_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_ocp_if *omap2420_hwmod_ocp_ifs[] __initdata = {
 	&omap2xxx_l3_main__l4_core,
 	&omap2xxx_mpu__l3_main,
@@ -468,6 +531,7 @@ static struct omap_hwmod_ocp_if *omap2420_hwmod_ocp_ifs[] __initdata = {
 	&omap2420_l4_core__mailbox,
 	&omap2420_l4_core__mcbsp1,
 	&omap2420_l4_core__mcbsp2,
+	&omap2420_l4_core__msdi1,
 	NULL,
 };
 
diff --git a/arch/arm/plat-omap/include/plat/mmc.h b/arch/arm/plat-omap/include/plat/mmc.h
index 7a38750..3e7ae0f 100644
--- a/arch/arm/plat-omap/include/plat/mmc.h
+++ b/arch/arm/plat-omap/include/plat/mmc.h
@@ -16,6 +16,7 @@
 #include <linux/mmc/host.h>
 
 #include <plat/board.h>
+#include <plat/omap_hwmod.h>
 
 #define OMAP15XX_NR_MMC		1
 #define OMAP16XX_NR_MMC		2
@@ -195,4 +196,7 @@ static inline int omap_mmc_add(const char *name, int id, unsigned long base,
 }
 
 #endif
+
+extern int omap_msdi_reset(struct omap_hwmod *oh);
+
 #endif
-- 
1.7.10

