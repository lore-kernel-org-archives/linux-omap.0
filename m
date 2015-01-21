From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: Add clock domain support for dm816x
Date: Tue, 20 Jan 2015 20:11:46 -0800
Message-ID: <20150121041145.GO7718@atomide.com>
References: <1421191355-12835-1-git-send-email-tony@atomide.com>
 <1421191355-12835-2-git-send-email-tony@atomide.com>
 <alpine.DEB.2.02.1501210128020.5450@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.ore.mailhop.org ([54.186.57.195]:51067 "EHLO
	smtp2.ore.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753448AbbAUEPQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Jan 2015 23:15:16 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1501210128020.5450@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Aida Mynzhasova <aida.mynzhasova@skitlab.ru>, Brian Hutchinson <b.hutchman@gmail.com>

Hi,

* Paul Walmsley <paul@pwsan.com> [150120 18:08]:
> On Tue, 13 Jan 2015, Tony Lindgren wrote:
> > +
> > +/*
> > + * - Add other domains as required
> > + * - Fill up associated powerdomans (especially ALWON powerdomains are NULL at
> > + *   the moment
> > + * - Consider dependencies across domains (probably not applicable till now)
> 
> Minor comment: I guess these are to-do items; would suggest explicitly 
> putting a "To-do" header on this list.

Replacing them with better comments.
 
> > + */
> > +
> > +/* Common TI81XX */
> 
> I can't comment on how many of these are truly common; since I haven't 
> cross-checked this file against the 814x TRM.  But if you haven't had the 
> chance to cross-check it against the 814x TRM either, I'd suggest starting 
> by making this file explicitly 816x-specific.

Seem to be common in the old TI PSP tree too at:
http://arago-project.org/git/projects/?p=linux-omap3.git;a=summary

Except it seems that dm814x has CLKDM_CAN_SWSUP while dm816x
has CLKDM_CAN_HWSUP_SWSUP. I've booted that tree only on dm816x
but let's assume it also works for dm814x as that's the TI tree
for it.
 
> > +static struct clockdomain alwon_l3_slow_81xx_clkdm = {
> > +	.name		= "l3s_clkdm",
> 
> This should mention "alwon" in the name like the other L3 always-on 
> clockdomains, since there's another L3 Slow clockdomain on this chip 
> that's in the DEFAULT power domain, according to Section 18.7.6.4 
> "CM_DEFAULT_L3_SLOW_CLKSTCTRL Register"

Oops I missed that one while cleaning up Aida's patch trying to
unify it with am33xx. Will search and replace also in the
omap_hwmod_81xx_data.c.
 
> > +	.pwrdm		= { .name = "alwon_pwrdm" },
> > +	.cm_inst	= TI81XX_CM_ALWON_MOD,
> > +	.clkdm_offs	= TI81XX_CM_ALWON_L3_SLOW_CLKDM,
> > +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> 
> According to Table 18-136 "CM_ALWON_L3_SLOW_CLKSTCTRL Register Field 
> Descriptions", only SW_SLEEP and SW_WKUP are supported.  So if that's 
> correct, this should be CLKDM_CAN_SWSUP.

Looks like TI's tree has these ifdef else and 816x seems to
have both CAN_HWSUP_SWSUP so probably the TRM is wrong.

My guess the TRM for 816x has tons of copy-paste errors from the
dm814x TRM. So I've kept all them the same way as the TI tree has
them.

> > +/* OCMC clock domain */
> 
> Hmm I think this comment is wrong, there are two other clock domains 
> labeled "OCMC".

Removed, that seems to have come from the TI tree for 814x.
 
> > +static struct clockdomain default_ducati_816x_clkdm = {
> 
> I can't find any mention of the Ducati in the TRM.  Does this SoC have a 
> Ducati?

So it seems for dm816x. Also clock816x_data.c references ducati_ick.
 
> According to the TRM here, looks like this should just be 
> "default_816x_clkdm" ?  The corresponding register is named 
> CM_DEFAULT_CLKSTCTRL.  It references two clockdomains, GCLKINTR and 
> GCLKIN200TR, but I can't find any other mention of those in the TRM, so, 
> no idea what they're associated with.

No mention of CM_DEFAULT_CLKSTCTRL in the TI tree. It seems the
TRM is wrong here too.
 
> > +	.name		= "default_ducati_clkdm",
> > +	.pwrdm		= { .name = "default_pwrdm" },
> > +	.cm_inst	= TI816X_CM_DEFAULT_MOD,
> > +	.clkdm_offs	= TI816X_CM_DEFAULT_DUCATI_CLKDM,
> 
> (see 'Ducati' comments above)
> 
> > +	.flags		= CLKDM_CAN_HWSUP_SWSUP,
> 
> According to Table 18-81 "CM_DEFAULT_CLKSTCTRL Register Field 
> Descriptions", only SW_SLEEP and SW_WKUP are supported.  So if that's 
> correct, this should be CLKDM_CAN_SWSUP.

That too is CLKDM_CAN_HWSUP_SWSUP in the TI tree so keeping it
that way like the others.
 
> > +};
> > +
> > +static struct clockdomain default_pcie_816x_clkdm = {
> > +	.name		= "default_pcie_clkdm",
> 
> The TRM calls this the "DEFAULT_PCI" clockdomain - would suggest sticking 
> to the TRM and register name to avoid confusion.

OK fixed.
 
> > +static struct clockdomain default_usb_816x_clkdm = {
> 
> The TRM calls this "DEFAULT_L3_SLOW" - would suggest sticking to the TRM 
> and register name to avoid confusion.
> 
> > +	.name		= "default_usb_clkdm",
> 
> As above

OK fixed.
 
> > +static struct clockdomain *clockdomains_ti81xx[] __initdata = {
> > +	&alwon_mpu_816x_clkdm,
> > +	&alwon_l3_slow_81xx_clkdm,
> > +	&alwon_l3_med_81xx_clkdm,
> > +	&alwon_l3_fast_81xx_clkdm,
> > +	&alwon_ethernet_81xx_clkdm,
> > +	&mmu_81xx_clkdm,
> > +	&mmu_cfg_81xx_clkdm,
> > +	&active_gem_816x_clkdm,
> > +	&ivahd0_816x_clkdm,
> > +	&ivahd1_816x_clkdm,
> > +	&ivahd2_816x_clkdm,
> > +	&sgx_816x_clkdm,
> > +	&default_l3_med_816x_clkdm,
> > +	&default_ducati_816x_clkdm,
> > +	&default_pcie_816x_clkdm,
> > +	&default_usb_816x_clkdm,
> > +	NULL,
> > +};
> 
> As the comment at the top of the file suggests, this is missing a lot 
> of clockdomains.  The TRM lists 56 ALWON clockdomains, 13 DEFAULT 
> clockdomains, 4 ACTIVE clockdomains, etc. 

Yes it seems incomplete. Also the TI tree has only 27 clockdomains..
Out of which 17 are 814x specific.
 
> > +
> > +/* ALWON */
> > +#define TI81XX_CM_ALWON_MPU_CLKDM		0x001C
> > +#define TI81XX_CM_ALWON_L3_SLOW_CLKDM		0x0000
> > +#define TI81XX_CM_ALWON_L3_MED_CLKDM		0x0004
> > +#define TI81XX_CM_ALWON_L3_FAST_CLKDM		0x0030
> > +#define TI81XX_CM_ETHERNET_CLKDM		0x0004
> > +#define TI81XX_CM_MMU_CLKDM			0x000C
> > +#define TI81XX_CM_MMUCFG_CLKDM			0x0010
> 
> Nit: please consider ordering these macros by offset, rather than 
> alphabetically by name.

OK fixed.
 
> > +
> > +/* ACTIVE */
> > +#define TI816X_CM_ACTIVE_GEM_CLKDM		0x0000
> > +
> > +/* IVAHD0 */
> > +#define TI816X_CM_IVAHD0_CLKDM			0x0000
> > +
> > +/* IVAHD1 */
> > +#define TI816X_CM_IVAHD1_CLKDM			0x0000
> > +
> > +/* IVAHD2 */
> > +#define TI816X_CM_IVAHD2_CLKDM			0x0000
> > +
> > +/* SGX */
> > +#define TI816X_CM_SGX_CLKDM			0x0000
> > +
> > +/* DEFAULT */
> > +#define TI816X_CM_DEFAULT_L3_MED_CLKDM		0x0004
> > +#define TI816X_CM_DEFAULT_DUCATI_CLKDM		0x0018
> 
> There's no Ducati clockdomain listed in the TRM, it's just 
> "DEFAULT".  

I've kept Ducati here as the TI tree has that. Probably copy-paste
error from the dm814x TRM again.
 
> > +#define TI816X_CM_DEFAULT_PCI_CLKDM		0x0010
> > +#define TI816X_CM_DEFAULT_L3_SLOW_CLKDM		0x0014
> 
> Consider ordering these macros by offset, rather than 
> alphabetically by name.

Fixed.

Thanks for the review, updated patch below.

Regards,

Tony 
8< ----------------
From: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
Date: Tue, 20 Jan 2015 18:24:46 -0800
Subject: [PATCH] ARM: OMAP2+: Add clock domain support for dm816x

This patch adds required definitions and structures for clockdomain
initialization, so omap3xxx_clockdomains_init() was substituted by
new ti81xx_clockdomains_init() while early initialization of
TI81XX platform.

Note that we now need to have 81xx in a separate CONFIG_SOC_TI81XX
block instead inside the ifdef block for omap3 to avoid make
randconfig build errors.

This code is based on the TI81XX-LINUX-PSP-04.04.00.02 patches
published at:

http://downloads.ti.com/dsps/dsps_public_sw/psp/LinuxPSP/TI81XX_04_04/04_04_00_02/index_FDS.html

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Aida Mynzhasova <aida.mynzhasova@skitlab.ru>
[tony@atomide.com: updated to apply, renamed to clockdomains81xx.c
 fixed to use am33xx_clkdm_operations]
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -171,6 +171,8 @@ obj-$(CONFIG_ARCH_OMAP4)		+= $(clockdomain-common)
 obj-$(CONFIG_ARCH_OMAP4)		+= clockdomains44xx_data.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(clockdomain-common)
 obj-$(CONFIG_SOC_AM33XX)		+= clockdomains33xx_data.o
+obj-$(CONFIG_SOC_TI81XX)		+= $(clockdomain-common)
+obj-$(CONFIG_SOC_TI81XX)		+= clockdomains81xx_data.o
 obj-$(CONFIG_SOC_AM43XX)		+= $(clockdomain-common)
 obj-$(CONFIG_SOC_AM43XX)		+= clockdomains43xx_data.o
 obj-$(CONFIG_SOC_OMAP5)			+= $(clockdomain-common)
--- a/arch/arm/mach-omap2/clockdomain.h
+++ b/arch/arm/mach-omap2/clockdomain.h
@@ -216,6 +216,7 @@ extern void __init omap242x_clockdomains_init(void);
 extern void __init omap243x_clockdomains_init(void);
 extern void __init omap3xxx_clockdomains_init(void);
 extern void __init am33xx_clockdomains_init(void);
+extern void __init ti81xx_clockdomains_init(void);
 extern void __init omap44xx_clockdomains_init(void);
 extern void __init omap54xx_clockdomains_init(void);
 extern void __init dra7xx_clockdomains_init(void);
--- /dev/null
+++ b/arch/arm/mach-omap2/clockdomains81xx_data.c
@@ -0,0 +1,192 @@
+/*
+ * TI81XX Clock Domain data.
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc. - http://www.ti.com/
+ * Copyright (C) 2013 SKTB SKiT, http://www.skitlab.ru/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS_81XX_H
+#define __ARCH_ARM_MACH_OMAP2_CLOCKDOMAINS_81XX_H
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+
+#include "clockdomain.h"
+#include "cm81xx.h"
+
+/*
+ * Note that 814x seems to have CLKDM_CAN_SWSUP while 816x
+ * CLKDM_CAN_HWSUP_SWSUP. And the 816x TRM only claims
+ * CLKDM_CAN_SWSUP for 816x, which is probably a copy-paste
+ * error from 816x TRM. Also note that this is not a complete
+ * set of clockdomains according to the 816x TRM.
+ */
+
+/* Common for 81xx */
+
+static struct clockdomain alwon_l3_slow_81xx_clkdm = {
+	.name		= "alwon_l3s_clkdm",
+	.pwrdm		= { .name = "alwon_pwrdm" },
+	.cm_inst	= TI81XX_CM_ALWON_MOD,
+	.clkdm_offs	= TI81XX_CM_ALWON_L3_SLOW_CLKDM,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain alwon_l3_med_81xx_clkdm = {
+	.name		= "alwon_l3_med_clkdm",
+	.pwrdm		= { .name = "alwon_pwrdm" },
+	.cm_inst	= TI81XX_CM_ALWON_MOD,
+	.clkdm_offs	= TI81XX_CM_ALWON_L3_MED_CLKDM,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain alwon_l3_fast_81xx_clkdm = {
+	.name		= "alwon_l3_fast_clkdm",
+	.pwrdm		= { .name = "alwon_pwrdm" },
+	.cm_inst	= TI81XX_CM_ALWON_MOD,
+	.clkdm_offs	= TI81XX_CM_ALWON_L3_FAST_CLKDM,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain alwon_ethernet_81xx_clkdm = {
+	.name		= "alwon_ethernet_clkdm",
+	.pwrdm		= { .name = "alwon_pwrdm" },
+	.cm_inst	= TI81XX_CM_ALWON_MOD,
+	.clkdm_offs	= TI81XX_CM_ETHERNET_CLKDM,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain mmu_81xx_clkdm = {
+	.name		= "mmu_clkdm",
+	.pwrdm		= { .name = "alwon_pwrdm" },
+	.cm_inst	= TI81XX_CM_ALWON_MOD,
+	.clkdm_offs	= TI81XX_CM_MMU_CLKDM,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain mmu_cfg_81xx_clkdm = {
+	.name		= "mmu_cfg_clkdm",
+	.pwrdm		= { .name = "alwon_pwrdm" },
+	.cm_inst	= TI81XX_CM_ALWON_MOD,
+	.clkdm_offs	= TI81XX_CM_MMUCFG_CLKDM,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+/* 816x only */
+
+static struct clockdomain alwon_mpu_816x_clkdm = {
+	.name		= "alwon_mpu_clkdm",
+	.pwrdm		= { .name = "alwon_pwrdm" },
+	.cm_inst	= TI81XX_CM_ALWON_MOD,
+	.clkdm_offs	= TI81XX_CM_ALWON_MPU_CLKDM,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain active_gem_816x_clkdm = {
+	.name		= "active_gem_clkdm",
+	.pwrdm		= { .name = "active_pwrdm" },
+	.cm_inst	= TI816X_CM_ACTIVE_MOD,
+	.clkdm_offs	= TI816X_CM_ACTIVE_GEM_CLKDM,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain ivahd0_816x_clkdm = {
+	.name		= "ivahd0_clkdm",
+	.pwrdm		= { .name = "ivahd0_pwrdm" },
+	.cm_inst	= TI816X_CM_IVAHD0_MOD,
+	.clkdm_offs	= TI816X_CM_IVAHD0_CLKDM,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain ivahd1_816x_clkdm = {
+	.name		= "ivahd1_clkdm",
+	.pwrdm		= { .name = "ivahd1_pwrdm" },
+	.cm_inst	= TI816X_CM_IVAHD1_MOD,
+	.clkdm_offs	= TI816X_CM_IVAHD1_CLKDM,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain ivahd2_816x_clkdm = {
+	.name		= "ivahd2_clkdm",
+	.pwrdm		= { .name = "ivahd2_pwrdm" },
+	.cm_inst	= TI816X_CM_IVAHD2_MOD,
+	.clkdm_offs	= TI816X_CM_IVAHD2_CLKDM,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain sgx_816x_clkdm = {
+	.name		= "sgx_clkdm",
+	.pwrdm		= { .name = "sgx_pwrdm" },
+	.cm_inst	= TI816X_CM_SGX_MOD,
+	.clkdm_offs	= TI816X_CM_SGX_CLKDM,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain default_l3_med_816x_clkdm = {
+	.name		= "default_l3_med_clkdm",
+	.pwrdm		= { .name = "default_pwrdm" },
+	.cm_inst	= TI816X_CM_DEFAULT_MOD,
+	.clkdm_offs	= TI816X_CM_DEFAULT_L3_MED_CLKDM,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain default_ducati_816x_clkdm = {
+	.name		= "default_ducati_clkdm",
+	.pwrdm		= { .name = "default_pwrdm" },
+	.cm_inst	= TI816X_CM_DEFAULT_MOD,
+	.clkdm_offs	= TI816X_CM_DEFAULT_DUCATI_CLKDM,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain default_pci_816x_clkdm = {
+	.name		= "default_pci_clkdm",
+	.pwrdm		= { .name = "default_pwrdm" },
+	.cm_inst	= TI816X_CM_DEFAULT_MOD,
+	.clkdm_offs	= TI816X_CM_DEFAULT_PCI_CLKDM,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain default_l3_slow_816x_clkdm = {
+	.name		= "default_l3_slow_clkdm",
+	.pwrdm		= { .name = "default_pwrdm" },
+	.cm_inst	= TI816X_CM_DEFAULT_MOD,
+	.clkdm_offs	= TI816X_CM_DEFAULT_L3_SLOW_CLKDM,
+	.flags		= CLKDM_CAN_HWSUP_SWSUP,
+};
+
+static struct clockdomain *clockdomains_ti81xx[] __initdata = {
+	&alwon_mpu_816x_clkdm,
+	&alwon_l3_slow_81xx_clkdm,
+	&alwon_l3_med_81xx_clkdm,
+	&alwon_l3_fast_81xx_clkdm,
+	&alwon_ethernet_81xx_clkdm,
+	&mmu_81xx_clkdm,
+	&mmu_cfg_81xx_clkdm,
+	&active_gem_816x_clkdm,
+	&ivahd0_816x_clkdm,
+	&ivahd1_816x_clkdm,
+	&ivahd2_816x_clkdm,
+	&sgx_816x_clkdm,
+	&default_l3_med_816x_clkdm,
+	&default_ducati_816x_clkdm,
+	&default_pci_816x_clkdm,
+	&default_l3_slow_816x_clkdm,
+	NULL,
+};
+
+void __init ti81xx_clockdomains_init(void)
+{
+	clkdm_register_platform_funcs(&am33xx_clkdm_operations);
+	clkdm_register_clkdms(clockdomains_ti81xx);
+	clkdm_complete_init();
+}
+#endif
--- /dev/null
+++ b/arch/arm/mach-omap2/cm81xx.h
@@ -0,0 +1,61 @@
+/*
+ * Clock domain register offsets for TI81XX.
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc. - http://www.ti.com/
+ * Copyright (C) 2013 SKTB SKiT, http://www.skitlab.ru/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef __ARCH_ARM_MACH_OMAP2_CM_TI81XX_H
+#define __ARCH_ARM_MACH_OMAP2_CM_TI81XX_H
+
+/* TI81XX common CM module offsets */
+#define TI81XX_CM_ALWON_MOD			0x1400	/* 1KB */
+
+/* TI816X CM module offsets */
+#define TI816X_CM_ACTIVE_MOD			0x0400	/* 256B */
+#define TI816X_CM_DEFAULT_MOD			0x0500	/* 256B */
+#define TI816X_CM_IVAHD0_MOD			0x0600	/* 256B */
+#define TI816X_CM_IVAHD1_MOD			0x0700	/* 256B */
+#define TI816X_CM_IVAHD2_MOD			0x0800	/* 256B */
+#define TI816X_CM_SGX_MOD			0x0900	/* 256B */
+
+/* ALWON */
+#define TI81XX_CM_ALWON_L3_SLOW_CLKDM		0x0000
+#define TI81XX_CM_ALWON_L3_MED_CLKDM		0x0004
+#define TI81XX_CM_ETHERNET_CLKDM		0x0004
+#define TI81XX_CM_MMU_CLKDM			0x000C
+#define TI81XX_CM_MMUCFG_CLKDM			0x0010
+#define TI81XX_CM_ALWON_MPU_CLKDM		0x001C
+#define TI81XX_CM_ALWON_L3_FAST_CLKDM		0x0030
+
+/* ACTIVE */
+#define TI816X_CM_ACTIVE_GEM_CLKDM		0x0000
+
+/* IVAHD0 */
+#define TI816X_CM_IVAHD0_CLKDM			0x0000
+
+/* IVAHD1 */
+#define TI816X_CM_IVAHD1_CLKDM			0x0000
+
+/* IVAHD2 */
+#define TI816X_CM_IVAHD2_CLKDM			0x0000
+
+/* SGX */
+#define TI816X_CM_SGX_CLKDM			0x0000
+
+/* DEFAULT */
+#define TI816X_CM_DEFAULT_L3_MED_CLKDM		0x0004
+#define TI816X_CM_DEFAULT_PCI_CLKDM		0x0010
+#define TI816X_CM_DEFAULT_L3_SLOW_CLKDM		0x0014
+#define TI816X_CM_DEFAULT_DUCATI_CLKDM		0x0018
+
+#endif
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -492,44 +492,6 @@ void __init am35xx_init_early(void)
 		omap_clk_soc_init = am35xx_dt_clk_init;
 }
 
-void __init ti814x_init_early(void)
-{
-	omap2_set_globals_tap(TI814X_CLASS,
-			      OMAP2_L4_IO_ADDRESS(TI81XX_TAP_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(TI81XX_CTRL_BASE),
-				  NULL);
-	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE));
-	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE), NULL);
-	omap3xxx_check_revision();
-	ti81xx_check_features();
-	omap3xxx_voltagedomains_init();
-	omap3xxx_powerdomains_init();
-	omap3xxx_clockdomains_init();
-	omap3xxx_hwmod_init();
-	omap_hwmod_init_postsetup();
-	if (of_have_populated_dt())
-		omap_clk_soc_init = ti81xx_dt_clk_init;
-}
-
-void __init ti816x_init_early(void)
-{
-	omap2_set_globals_tap(TI816X_CLASS,
-			      OMAP2_L4_IO_ADDRESS(TI81XX_TAP_BASE));
-	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(TI81XX_CTRL_BASE),
-				  NULL);
-	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE));
-	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE), NULL);
-	omap3xxx_check_revision();
-	ti81xx_check_features();
-	omap3xxx_voltagedomains_init();
-	omap3xxx_powerdomains_init();
-	omap3xxx_clockdomains_init();
-	omap3xxx_hwmod_init();
-	omap_hwmod_init_postsetup();
-	if (of_have_populated_dt())
-		omap_clk_soc_init = ti81xx_dt_clk_init;
-}
-
 void __init omap3_init_late(void)
 {
 	omap_common_late_init();
@@ -572,6 +534,46 @@ void __init ti81xx_init_late(void)
 }
 #endif
 
+#ifdef CONFIG_SOC_TI81XX
+void __init ti814x_init_early(void)
+{
+	omap2_set_globals_tap(TI814X_CLASS,
+			      OMAP2_L4_IO_ADDRESS(TI81XX_TAP_BASE));
+	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(TI81XX_CTRL_BASE),
+				  NULL);
+	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE));
+	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE), NULL);
+	omap3xxx_check_revision();
+	ti81xx_check_features();
+	omap3xxx_voltagedomains_init();
+	omap3xxx_powerdomains_init();
+	ti81xx_clockdomains_init();
+	omap3xxx_hwmod_init();
+	omap_hwmod_init_postsetup();
+	if (of_have_populated_dt())
+		omap_clk_soc_init = ti81xx_dt_clk_init;
+}
+
+void __init ti816x_init_early(void)
+{
+	omap2_set_globals_tap(TI816X_CLASS,
+			      OMAP2_L4_IO_ADDRESS(TI81XX_TAP_BASE));
+	omap2_set_globals_control(OMAP2_L4_IO_ADDRESS(TI81XX_CTRL_BASE),
+				  NULL);
+	omap2_set_globals_prm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE));
+	omap2_set_globals_cm(OMAP2_L4_IO_ADDRESS(TI81XX_PRCM_BASE), NULL);
+	omap3xxx_check_revision();
+	ti81xx_check_features();
+	omap3xxx_voltagedomains_init();
+	omap3xxx_powerdomains_init();
+	ti81xx_clockdomains_init();
+	omap3xxx_hwmod_init();
+	omap_hwmod_init_postsetup();
+	if (of_have_populated_dt())
+		omap_clk_soc_init = ti81xx_dt_clk_init;
+}
+#endif
+
 #ifdef CONFIG_SOC_AM33XX
 void __init am33xx_init_early(void)
 {
