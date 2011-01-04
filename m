From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: Start using CONFIG_SOC_OMAP (Re: [PATCH v3 1/4]
 TI816X: Update common omap platform files)
Date: Tue, 4 Jan 2011 15:57:07 -0800
Message-ID: <20110104235706.GQ7771@atomide.com>
References: <1294075737-22320-1-git-send-email-hemantp@ti.com>
 <alpine.DEB.2.00.1101031603070.10403@utopia.booyaka.com>
 <20110104015008.GX7771@atomide.com>
 <2A3DCF3DA181AD40BDE86A3150B27B6B036A57AF93@dbde02.ent.ti.com>
 <alpine.DEB.2.00.1101041046540.9203@utopia.booyaka.com>
 <20110104232547.GP7771@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:45370 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892Ab1ADX5M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 18:57:12 -0500
Content-Disposition: inline
In-Reply-To: <20110104232547.GP7771@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: "Pedanekar, Hemant" <hemantp@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>

* Tony Lindgren <tony@atomide.com> [110104 15:25]:
> * Paul Walmsley <paul@pwsan.com> [110104 09:48]:
> > On Tue, 4 Jan 2011, Pedanekar, Hemant wrote:
> > 
> > > Looking at above, it seems another config option like 
> > > CONFIG_SOC_OMAP3XXX is also needed in addition to CONFIG_SOC_OMAPTI816X.
> > 
> > We already have CONFIG_ARCH_OMAP3430, CONFIG_ARCH_OMAP2430, and 
> > CONFIG_ARCH_OMAP2420.  I guess at some point those need to be renamed to 
> > CONFIG_SOC_*.
> 
> Yes that's what I was thinking too. Keep CONFIG_ARCH_OMAP2, 3, and 4,
> and rename CONFIG_ARCH_OMAP3430 etc to CONFIG_SO_COMAP3430 and so on.

Here's a patch to do that for 2.6.39, will update this after the
merge window is over. Note that we should keep this separate from
adding CONFIG_SOC_OMAPTI816X, that can be already done even without
this patch.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Tue, 4 Jan 2011 15:32:32 -0800
Subject: [PATCH] omap: Start using CONFIG_SOC_OMAP

We want to have just CONFIG_ARCH_OMAP2, 3 and 4. The rest
are nowadays just subcategories of these.

Search and replace the following:

ARCH_OMAP2420		SOC_OMAP2420
ARCH_OMAP2430		SOC_OMAP2430
ARCH_OMAP3430		SOC_OMAP3430

No functional changes.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 3e8c9e8..fe9f079 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -52,20 +52,20 @@ config ARCH_OMAP4
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
 
-config ARCH_OMAP2420
+config SOC_OMAP2420
 	bool "OMAP2420 support"
 	depends on ARCH_OMAP2
 	default y
 	select OMAP_DM_TIMER
 	select ARCH_OMAP_OTG
 
-config ARCH_OMAP2430
+config SOC_OMAP2430
 	bool "OMAP2430 support"
 	depends on ARCH_OMAP2
 	default y
 	select ARCH_OMAP_OTG
 
-config ARCH_OMAP3430
+config SOC_OMAP3430
 	bool "OMAP3430 support"
 	depends on ARCH_OMAP3
 	default y
@@ -105,25 +105,25 @@ config MACH_OMAP_GENERIC
 
 config MACH_OMAP2_TUSB6010
 	bool
-	depends on ARCH_OMAP2 && ARCH_OMAP2420
+	depends on ARCH_OMAP2 && SOC_OMAP2420
 	default y if MACH_NOKIA_N8X0
 
 config MACH_OMAP_H4
 	bool "OMAP 2420 H4 board"
-	depends on ARCH_OMAP2420
+	depends on SOC_OMAP2420
 	default y
 	select OMAP_PACKAGE_ZAF
 	select OMAP_DEBUG_DEVICES
 
 config MACH_OMAP_APOLLON
 	bool "OMAP 2420 Apollon board"
-	depends on ARCH_OMAP2420
+	depends on SOC_OMAP2420
 	default y
 	select OMAP_PACKAGE_ZAC
 
 config MACH_OMAP_2430SDP
 	bool "OMAP 2430 SDP board"
-	depends on ARCH_OMAP2430
+	depends on SOC_OMAP2430
 	default y
 	select OMAP_PACKAGE_ZAC
 
@@ -218,7 +218,7 @@ config MACH_NOKIA_N810_WIMAX
 
 config MACH_NOKIA_N8X0
 	bool "Nokia N800/N810"
-	depends on ARCH_OMAP2420
+	depends on SOC_OMAP2420
 	default y
 	select OMAP_PACKAGE_ZAC
 	select MACH_NOKIA_N800
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 4ab82f6..0cbdf30 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -31,8 +31,8 @@ AFLAGS_omap-headsmp.o			:=-Wa,-march=armv7-a$(plus_sec)
 AFLAGS_omap44xx-smc.o			:=-Wa,-march=armv7-a$(plus_sec)
 
 # Functions loaded to SRAM
-obj-$(CONFIG_ARCH_OMAP2420)		+= sram242x.o
-obj-$(CONFIG_ARCH_OMAP2430)		+= sram243x.o
+obj-$(CONFIG_SOC_OMAP2420)		+= sram242x.o
+obj-$(CONFIG_SOC_OMAP2430)		+= sram243x.o
 obj-$(CONFIG_ARCH_OMAP3)		+= sram34xx.o
 
 AFLAGS_sram242x.o			:=-Wa,-march=armv6
@@ -40,8 +40,8 @@ AFLAGS_sram243x.o			:=-Wa,-march=armv6
 AFLAGS_sram34xx.o			:=-Wa,-march=armv7-a
 
 # Pin multiplexing
-obj-$(CONFIG_ARCH_OMAP2420)		+= mux2420.o
-obj-$(CONFIG_ARCH_OMAP2430)		+= mux2430.o
+obj-$(CONFIG_SOC_OMAP2420)		+= mux2420.o
+obj-$(CONFIG_SOC_OMAP2430)		+= mux2430.o
 obj-$(CONFIG_ARCH_OMAP3)		+= mux34xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= mux44xx.o
 
@@ -113,8 +113,8 @@ obj-$(CONFIG_ARCH_OMAP2)		+= $(clock-common) clock2xxx.o \
 					   clkt2xxx_dpllcore.o \
 					   clkt2xxx_virt_prcm_set.o \
 					   clkt2xxx_apll.o clkt2xxx_osc.o
-obj-$(CONFIG_ARCH_OMAP2420)		+= clock2420_data.o
-obj-$(CONFIG_ARCH_OMAP2430)		+= clock2430.o clock2430_data.o
+obj-$(CONFIG_SOC_OMAP2420)		+= clock2420_data.o
+obj-$(CONFIG_SOC_OMAP2430)		+= clock2430.o clock2430_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(clock-common) clock3xxx.o \
 					   clock34xx.o clkt34xx_dpll3m2.o \
 					   clock3517.o clock36xx.o \
@@ -123,12 +123,12 @@ obj-$(CONFIG_ARCH_OMAP4)		+= $(clock-common) clock44xx_data.o \
 					   dpll3xxx.o
 
 # OMAP2 clock rate set data (old "OPP" data)
-obj-$(CONFIG_ARCH_OMAP2420)		+= opp2420_data.o
-obj-$(CONFIG_ARCH_OMAP2430)		+= opp2430_data.o
+obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o
+obj-$(CONFIG_SOC_OMAP2430)		+= opp2430_data.o
 
 # hwmod data
-obj-$(CONFIG_ARCH_OMAP2420)		+= omap_hwmod_2420_data.o
-obj-$(CONFIG_ARCH_OMAP2430)		+= omap_hwmod_2430_data.o
+obj-$(CONFIG_SOC_OMAP2420)		+= omap_hwmod_2420_data.o
+obj-$(CONFIG_SOC_OMAP2430)		+= omap_hwmod_2430_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= omap_hwmod_3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= omap_hwmod_44xx_data.o
 
diff --git a/arch/arm/mach-omap2/clock2xxx.h b/arch/arm/mach-omap2/clock2xxx.h
index 6a658b89..cc5c8d4 100644
--- a/arch/arm/mach-omap2/clock2xxx.h
+++ b/arch/arm/mach-omap2/clock2xxx.h
@@ -20,13 +20,13 @@ u32 omap2xxx_get_apll_clkin(void);
 u32 omap2xxx_get_sysclkdiv(void);
 void omap2xxx_clk_prepare_for_reboot(void);
 
-#ifdef CONFIG_ARCH_OMAP2420
+#ifdef CONFIG_SOC_OMAP2420
 int omap2420_clk_init(void);
 #else
 #define omap2420_clk_init()	0
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2430
+#ifdef CONFIG_SOC_OMAP2430
 int omap2430_clk_init(void);
 #else
 #define omap2430_clk_init()	0
diff --git a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
index e4a7133..e6f0d18 100644
--- a/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c
@@ -171,7 +171,7 @@ static struct clkdm_dep core_24xx_wkdeps[] = {
 
 /* 2430-specific possible wakeup dependencies */
 
-#ifdef CONFIG_ARCH_OMAP2430
+#ifdef CONFIG_SOC_OMAP2430
 
 /* 2430 PM_WKDEP_MDM: CORE, MPU, WKUP */
 static struct clkdm_dep mdm_2430_wkdeps[] = {
@@ -194,7 +194,7 @@ static struct clkdm_dep mdm_2430_wkdeps[] = {
 	{ NULL },
 };
 
-#endif /* CONFIG_ARCH_OMAP2430 */
+#endif /* CONFIG_SOC_OMAP2430 */
 
 
 /* OMAP3-specific possible dependencies */
@@ -450,7 +450,7 @@ static struct clockdomain cm_clkdm = {
  * 2420-only clockdomains
  */
 
-#if defined(CONFIG_ARCH_OMAP2420)
+#if defined(CONFIG_SOC_OMAP2420)
 
 static struct clockdomain mpu_2420_clkdm = {
 	.name		= "mpu_clkdm",
@@ -514,14 +514,14 @@ static struct clockdomain dss_2420_clkdm = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2420),
 };
 
-#endif   /* CONFIG_ARCH_OMAP2420 */
+#endif   /* CONFIG_SOC_OMAP2420 */
 
 
 /*
  * 2430-only clockdomains
  */
 
-#if defined(CONFIG_ARCH_OMAP2430)
+#if defined(CONFIG_SOC_OMAP2430)
 
 static struct clockdomain mpu_2430_clkdm = {
 	.name		= "mpu_clkdm",
@@ -600,7 +600,7 @@ static struct clockdomain dss_2430_clkdm = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP2430),
 };
 
-#endif    /* CONFIG_ARCH_OMAP2430 */
+#endif    /* CONFIG_SOC_OMAP2430 */
 
 
 /*
@@ -811,7 +811,7 @@ static struct clockdomain *clockdomains_omap2[] __initdata = {
 	&cm_clkdm,
 	&prm_clkdm,
 
-#ifdef CONFIG_ARCH_OMAP2420
+#ifdef CONFIG_SOC_OMAP2420
 	&mpu_2420_clkdm,
 	&iva1_2420_clkdm,
 	&dsp_2420_clkdm,
@@ -821,7 +821,7 @@ static struct clockdomain *clockdomains_omap2[] __initdata = {
 	&dss_2420_clkdm,
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2430
+#ifdef CONFIG_SOC_OMAP2430
 	&mpu_2430_clkdm,
 	&mdm_clkdm,
 	&dsp_2430_clkdm,
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 778929f..d5eaee3 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -40,7 +40,7 @@ static void __init __omap2_set_globals(struct omap_globals *omap2_globals)
 
 #endif
 
-#if defined(CONFIG_ARCH_OMAP2420)
+#if defined(CONFIG_SOC_OMAP2420)
 
 static struct omap_globals omap242x_globals = {
 	.class	= OMAP242X_CLASS,
@@ -61,7 +61,7 @@ void __init omap2_set_globals_242x(void)
 }
 #endif
 
-#if defined(CONFIG_ARCH_OMAP2430)
+#if defined(CONFIG_SOC_OMAP2430)
 
 static struct omap_globals omap243x_globals = {
 	.class	= OMAP243X_CLASS,
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 381f4eb..87b9658 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -333,7 +333,7 @@ static struct platform_device omap2_mcspi2 = {
 	},
 };
 
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
+#if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
 	defined(CONFIG_ARCH_OMAP4)
 static struct omap2_mcspi_platform_config omap2_mcspi3_config = {
 	.num_cs		= 2,
@@ -400,7 +400,7 @@ static inline void omap4_mcspi_fixup(void)
 }
 #endif
 
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
+#if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
 	defined(CONFIG_ARCH_OMAP4)
 static inline void omap2_mcspi3_init(void)
 {
@@ -895,7 +895,7 @@ void __init omap2_init_mmc(struct omap_mmc_platform_data **mmc_data,
 /*-------------------------------------------------------------------------*/
 
 #if defined(CONFIG_HDQ_MASTER_OMAP) || defined(CONFIG_HDQ_MASTER_OMAP_MODULE)
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)
+#if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_SOC_OMAP3430)
 #define OMAP_HDQ_BASE	0x480B2000
 #endif
 static struct resource omap_hdq_resources[] = {
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e66687b..aea8631 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -66,7 +66,7 @@ static struct map_desc omap24xx_io_desc[] __initdata = {
 	},
 };
 
-#ifdef CONFIG_ARCH_OMAP2420
+#ifdef CONFIG_SOC_OMAP2420
 static struct map_desc omap242x_io_desc[] __initdata = {
 	{
 		.virtual	= DSP_MEM_2420_VIRT,
@@ -90,7 +90,7 @@ static struct map_desc omap242x_io_desc[] __initdata = {
 
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2430
+#ifdef CONFIG_SOC_OMAP2430
 static struct map_desc omap243x_io_desc[] __initdata = {
 	{
 		.virtual	= L4_WK_243X_VIRT,
@@ -241,7 +241,7 @@ static void __init _omap2_map_common_io(void)
 	omap_sram_init();
 }
 
-#ifdef CONFIG_ARCH_OMAP2420
+#ifdef CONFIG_SOC_OMAP2420
 void __init omap242x_map_common_io(void)
 {
 	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
@@ -250,7 +250,7 @@ void __init omap242x_map_common_io(void)
 }
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2430
+#ifdef CONFIG_SOC_OMAP2430
 void __init omap243x_map_common_io(void)
 {
 	iotable_init(omap24xx_io_desc, ARRAY_SIZE(omap24xx_io_desc));
diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 394413d..29b9dc3 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -310,7 +310,7 @@ struct omap_mbox mbox_dsp_info = {
 struct omap_mbox *omap3_mboxes[] = { &mbox_dsp_info, NULL };
 #endif
 
-#if defined(CONFIG_ARCH_OMAP2420)
+#if defined(CONFIG_SOC_OMAP2420)
 /* IVA */
 static struct omap_mbox2_priv omap2_mbox_iva_priv = {
 	.tx_fifo = {
diff --git a/arch/arm/mach-omap2/mcbsp.c b/arch/arm/mach-omap2/mcbsp.c
index f9c9df5..0526b75 100644
--- a/arch/arm/mach-omap2/mcbsp.c
+++ b/arch/arm/mach-omap2/mcbsp.c
@@ -104,7 +104,7 @@ EXPORT_SYMBOL(omap2_mcbsp_set_clks_src);
 
 /* Platform data */
 
-#ifdef CONFIG_ARCH_OMAP2420
+#ifdef CONFIG_SOC_OMAP2420
 static struct omap_mcbsp_platform_data omap2420_mcbsp_pdata[] = {
 	{
 		.phys_base	= OMAP24XX_MCBSP1_BASE,
@@ -129,7 +129,7 @@ static struct omap_mcbsp_platform_data omap2420_mcbsp_pdata[] = {
 #define OMAP2420_MCBSP_REG_NUM		0
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2430
+#ifdef CONFIG_SOC_OMAP2430
 static struct omap_mcbsp_platform_data omap2430_mcbsp_pdata[] = {
 	{
 		.phys_base	= OMAP24XX_MCBSP1_BASE,
diff --git a/arch/arm/mach-omap2/opp2xxx.h b/arch/arm/mach-omap2/opp2xxx.h
index 38b7305..8affc66 100644
--- a/arch/arm/mach-omap2/opp2xxx.h
+++ b/arch/arm/mach-omap2/opp2xxx.h
@@ -418,7 +418,7 @@ struct prcm_config {
 
 extern const struct prcm_config omap2420_rate_table[];
 
-#ifdef CONFIG_ARCH_OMAP2430
+#ifdef CONFIG_SOC_OMAP2430
 extern const struct prcm_config omap2430_rate_table[];
 #else
 #define omap2430_rate_table	NULL
diff --git a/arch/arm/mach-omap2/powerdomains2xxx_data.c b/arch/arm/mach-omap2/powerdomains2xxx_data.c
index 9b1a335..78739e1 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_data.c
@@ -78,7 +78,7 @@ static struct powerdomain core_24xx_pwrdm = {
  * 2430-specific powerdomains
  */
 
-#ifdef CONFIG_ARCH_OMAP2430
+#ifdef CONFIG_SOC_OMAP2430
 
 /* XXX 2430 KILLDOMAINWKUP bit?  No current users apparently */
 
@@ -97,7 +97,7 @@ static struct powerdomain mdm_pwrdm = {
 	},
 };
 
-#endif     /* CONFIG_ARCH_OMAP2430 */
+#endif     /* CONFIG_SOC_OMAP2430 */
 
 /* As powerdomains are added or removed above, this list must also be changed */
 static struct powerdomain *powerdomains_omap2xxx[] __initdata = {
@@ -111,7 +111,7 @@ static struct powerdomain *powerdomains_omap2xxx[] __initdata = {
 	&core_24xx_pwrdm,
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2430
+#ifdef CONFIG_SOC_OMAP2430
 	&mdm_pwrdm,
 #endif
 	NULL
diff --git a/arch/arm/plat-omap/counter_32k.c b/arch/arm/plat-omap/counter_32k.c
index 8722a13..05d5a89 100644
--- a/arch/arm/plat-omap/counter_32k.c
+++ b/arch/arm/plat-omap/counter_32k.c
@@ -53,7 +53,7 @@ static cycle_t omap16xx_32k_read(struct clocksource *cs)
 #define omap16xx_32k_read	NULL
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2420
+#ifdef CONFIG_SOC_OMAP2420
 static cycle_t omap2420_32k_read(struct clocksource *cs)
 {
 	return omap_readl(OMAP2420_32KSYNCT_BASE + 0x10) - offset_32k;
@@ -62,7 +62,7 @@ static cycle_t omap2420_32k_read(struct clocksource *cs)
 #define omap2420_32k_read	NULL
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2430
+#ifdef CONFIG_SOC_OMAP2430
 static cycle_t omap2430_32k_read(struct clocksource *cs)
 {
 	return omap_readl(OMAP2430_32KSYNCT_BASE + 0x10) - offset_32k;
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 3fd8b40..73d91ee 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -170,11 +170,11 @@ IS_OMAP_SUBCLASS(443x, 0x443)
 #  undef  cpu_is_omap24xx
 #  define cpu_is_omap24xx()		is_omap24xx()
 # endif
-# if defined (CONFIG_ARCH_OMAP2420)
+# if defined (CONFIG_SOC_OMAP2420)
 #  undef  cpu_is_omap242x
 #  define cpu_is_omap242x()		is_omap242x()
 # endif
-# if defined (CONFIG_ARCH_OMAP2430)
+# if defined (CONFIG_SOC_OMAP2430)
 #  undef  cpu_is_omap243x
 #  define cpu_is_omap243x()		is_omap243x()
 # endif
@@ -189,11 +189,11 @@ IS_OMAP_SUBCLASS(443x, 0x443)
 #  undef  cpu_is_omap24xx
 #  define cpu_is_omap24xx()		1
 # endif
-# if defined(CONFIG_ARCH_OMAP2420)
+# if defined(CONFIG_SOC_OMAP2420)
 #  undef  cpu_is_omap242x
 #  define cpu_is_omap242x()		1
 # endif
-# if defined(CONFIG_ARCH_OMAP2430)
+# if defined(CONFIG_SOC_OMAP2430)
 #  undef  cpu_is_omap243x
 #  define cpu_is_omap243x()		1
 # endif
@@ -201,7 +201,7 @@ IS_OMAP_SUBCLASS(443x, 0x443)
 #  undef  cpu_is_omap34xx
 #  define cpu_is_omap34xx()		1
 # endif
-# if defined(CONFIG_ARCH_OMAP3430)
+# if defined(CONFIG_SOC_OMAP3430)
 #  undef  cpu_is_omap343x
 #  define cpu_is_omap343x()		1
 # endif
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index ef4106c..478c5d9 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -259,7 +259,7 @@ struct omap_sdrc_params;
 extern void omap1_map_common_io(void);
 extern void omap1_init_common_hw(void);
 
-#ifdef CONFIG_ARCH_OMAP2420
+#ifdef CONFIG_SOC_OMAP2420
 extern void omap242x_map_common_io(void);
 #else
 static inline void omap242x_map_common_io(void)
@@ -267,7 +267,7 @@ static inline void omap242x_map_common_io(void)
 }
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2430
+#ifdef CONFIG_SOC_OMAP2430
 extern void omap243x_map_common_io(void);
 #else
 static inline void omap243x_map_common_io(void)
diff --git a/arch/arm/plat-omap/include/plat/multi.h b/arch/arm/plat-omap/include/plat/multi.h
index ffd909f..999ffba 100644
--- a/arch/arm/plat-omap/include/plat/multi.h
+++ b/arch/arm/plat-omap/include/plat/multi.h
@@ -66,7 +66,7 @@
 #  error "OMAP1 and OMAP2PLUS can't be selected at the same time"
 # endif
 #endif
-#ifdef CONFIG_ARCH_OMAP2420
+#ifdef CONFIG_SOC_OMAP2420
 # ifdef OMAP_NAME
 #  undef  MULTI_OMAP2
 #  define MULTI_OMAP2
@@ -74,7 +74,7 @@
 #  define OMAP_NAME omap2420
 # endif
 #endif
-#ifdef CONFIG_ARCH_OMAP2430
+#ifdef CONFIG_SOC_OMAP2430
 # ifdef OMAP_NAME
 #  undef  MULTI_OMAP2
 #  define MULTI_OMAP2
diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index e26e504..aedcb3b 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -312,7 +312,7 @@ u32 omap2_set_prcm(u32 dpll_ctrl_val, u32 sdrc_rfr_val, int bypass)
 }
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2420
+#ifdef CONFIG_SOC_OMAP2420
 static int __init omap242x_sram_init(void)
 {
 	_omap2_sram_ddr_init = omap_sram_push(omap242x_sram_ddr_init,
@@ -333,7 +333,7 @@ static inline int omap242x_sram_init(void)
 }
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2430
+#ifdef CONFIG_SOC_OMAP2430
 static int __init omap243x_sram_init(void)
 {
 	_omap2_sram_ddr_init = omap_sram_push(omap243x_sram_ddr_init,
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index d618e86..cc531d3 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -202,7 +202,7 @@ config MMC_OMAP
 
 config MMC_OMAP_HS
 	tristate "TI OMAP High Speed Multimedia Card Interface support"
-	depends on ARCH_OMAP2430 || ARCH_OMAP3 || ARCH_OMAP4
+	depends on SOC_OMAP2430 || ARCH_OMAP3 || ARCH_OMAP4
 	help
 	  This selects the TI OMAP High Speed Multimedia card Interface.
 	  If you have an OMAP2430 or OMAP3 board or OMAP4 board with a
diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 2a651e6..74d44dd 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -1116,7 +1116,7 @@ static u8 __initdata spi2_txdma_id[] = {
 	OMAP24XX_DMA_SPI2_TX1,
 };
 
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) \
+#if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_ARCH_OMAP3) \
 	|| defined(CONFIG_ARCH_OMAP4)
 static u8 __initdata spi3_rxdma_id[] = {
 	OMAP24XX_DMA_SPI3_RX0,
@@ -1159,7 +1159,7 @@ static int __init omap2_mcspi_probe(struct platform_device *pdev)
 		txdma_id = spi2_txdma_id;
 		num_chipselect = 2;
 		break;
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) \
+#if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_ARCH_OMAP3) \
 	|| defined(CONFIG_ARCH_OMAP4)
 	case 3:
 		rxdma_id = spi3_rxdma_id;
diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 341a37a..9205494 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -36,7 +36,7 @@ config USB_MUSB_SOC
 	boolean
 	depends on USB_MUSB_HDRC
 	default y if ARCH_DAVINCI
-	default y if ARCH_OMAP2430
+	default y if SOC_OMAP2430
 	default y if ARCH_OMAP3
 	default y if ARCH_OMAP4
 	default y if (BF54x && !BF544)
@@ -49,7 +49,7 @@ comment "DA8xx/OMAP-L1x USB support"
 	depends on USB_MUSB_HDRC && ARCH_DAVINCI_DA8XX
 
 comment "OMAP 243x high speed USB support"
-	depends on USB_MUSB_HDRC && ARCH_OMAP2430
+	depends on USB_MUSB_HDRC && SOC_OMAP2430
 
 comment "OMAP 343x high speed USB support"
 	depends on USB_MUSB_HDRC && ARCH_OMAP3
@@ -62,7 +62,7 @@ comment "Blackfin high speed USB Support"
 
 config USB_MUSB_AM35X
 	bool
-	depends on USB_MUSB_HDRC && !ARCH_OMAP2430 && !ARCH_OMAP4
+	depends on USB_MUSB_HDRC && !SOC_OMAP2430 && !ARCH_OMAP4
 	select NOP_USB_XCEIV
 	default MACH_OMAP3517EVM
 	help
@@ -171,7 +171,7 @@ config MUSB_PIO_ONLY
 config USB_INVENTRA_DMA
 	bool
 	depends on USB_MUSB_HDRC && !MUSB_PIO_ONLY
-	default ARCH_OMAP2430 || ARCH_OMAP3 || BLACKFIN || ARCH_OMAP4
+	default SOC_OMAP2430 || ARCH_OMAP3 || BLACKFIN || ARCH_OMAP4
 	help
 	  Enable DMA transfers using Mentor's engine.
 
diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
index ce164e8..5c3da89b 100644
--- a/drivers/usb/musb/Makefile
+++ b/drivers/usb/musb/Makefile
@@ -11,11 +11,11 @@ musb_hdrc-y := musb_core.o
 musb_hdrc-$(CONFIG_ARCH_DAVINCI_DMx)		+= davinci.o
 musb_hdrc-$(CONFIG_ARCH_DAVINCI_DA8XX)		+= da8xx.o
 musb_hdrc-$(CONFIG_USB_TUSB6010)		+= tusb6010.o
-musb_hdrc-$(CONFIG_ARCH_OMAP2430)		+= omap2430.o
+musb_hdrc-$(CONFIG_SOC_OMAP2430)		+= omap2430.o
 ifeq ($(CONFIG_USB_MUSB_AM35X),y)
-	musb_hdrc-$(CONFIG_ARCH_OMAP3430)	+= am35x.o
+	musb_hdrc-$(CONFIG_SOC_OMAP3430)	+= am35x.o
 else
-	musb_hdrc-$(CONFIG_ARCH_OMAP3430)	+= omap2430.o
+	musb_hdrc-$(CONFIG_SOC_OMAP3430)	+= omap2430.o
 endif
 musb_hdrc-$(CONFIG_ARCH_OMAP4)			+= omap2430.o
 musb_hdrc-$(CONFIG_BF54x)			+= blackfin.o
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 99beebc..ba003be 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1075,7 +1075,7 @@ static void musb_shutdown(struct platform_device *pdev)
  * more than selecting one of a bunch of predefined configurations.
  */
 #if defined(CONFIG_USB_TUSB6010) || \
-	defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) \
+	defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_ARCH_OMAP3) \
 	|| defined(CONFIG_ARCH_OMAP4)
 static ushort __initdata fifo_mode = 4;
 #else
@@ -1547,7 +1547,7 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
 
 /*-------------------------------------------------------------------------*/
 
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430) || \
+#if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_SOC_OMAP3430) || \
 	defined(CONFIG_ARCH_OMAP4)
 
 static irqreturn_t generic_interrupt(int irq, void *__hci)
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index febaabc..db15ad9 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -212,8 +212,8 @@ enum musb_g_ep0_state {
  * directly with the "flat" model, or after setting up an index register.
  */
 
-#if defined(CONFIG_ARCH_DAVINCI) || defined(CONFIG_ARCH_OMAP2430) \
-		|| defined(CONFIG_ARCH_OMAP3430) || defined(CONFIG_BLACKFIN) \
+#if defined(CONFIG_ARCH_DAVINCI) || defined(CONFIG_SOC_OMAP2430) \
+		|| defined(CONFIG_SOC_OMAP3430) || defined(CONFIG_BLACKFIN) \
 		|| defined(CONFIG_ARCH_OMAP4)
 /* REVISIT indexed access seemed to
  * misbehave (on DaVinci) for at least peripheral IN ...
@@ -471,7 +471,7 @@ struct musb_csr_regs {
 
 struct musb_context_registers {
 
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
+#if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
     defined(CONFIG_ARCH_OMAP4)
 	u32 otg_sysconfig, otg_forcestandby;
 #endif
@@ -486,7 +486,7 @@ struct musb_context_registers {
 	struct musb_csr_regs index_regs[MUSB_C_NUM_EPS];
 };
 
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
+#if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
     defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_BLACKFIN)
 extern void musb_platform_save_context(struct musb *musb,
 		struct musb_context_registers *musb_context);
@@ -601,7 +601,7 @@ extern int musb_platform_set_mode(struct musb *musb, u8 musb_mode);
 
 #if defined(CONFIG_USB_TUSB6010) || defined(CONFIG_BLACKFIN) || \
 	defined(CONFIG_ARCH_DAVINCI_DA8XX) || \
-	defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
+	defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
 	defined(CONFIG_ARCH_OMAP4)
 extern void musb_platform_try_idle(struct musb *musb, unsigned long timeout);
 #else
diff --git a/drivers/usb/musb/musbhsdma.h b/drivers/usb/musb/musbhsdma.h
index f763d62..cc651cd 100644
--- a/drivers/usb/musb/musbhsdma.h
+++ b/drivers/usb/musb/musbhsdma.h
@@ -31,7 +31,7 @@
  *
  */
 
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3430)
+#if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_SOC_OMAP3430)
 #include "omap2430.h"
 #endif
 
diff --git a/drivers/w1/masters/Kconfig b/drivers/w1/masters/Kconfig
index 80b3b12..7c608c5 100644
--- a/drivers/w1/masters/Kconfig
+++ b/drivers/w1/masters/Kconfig
@@ -60,7 +60,7 @@ config W1_MASTER_GPIO
 
 config HDQ_MASTER_OMAP
 	tristate "OMAP HDQ driver"
-	depends on ARCH_OMAP2430 || ARCH_OMAP3
+	depends on SOC_OMAP2430 || ARCH_OMAP3
 	help
 	  Say Y here if you want support for the 1-wire or HDQ Interface
 	  on an OMAP processor.
diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 7e84f24..c5b5b0b 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -92,7 +92,7 @@ static const unsigned long omap1_mcbsp_port[][2] = {};
 static const int omap24xx_dma_reqs[][2] = {
 	{ OMAP24XX_DMA_MCBSP1_TX, OMAP24XX_DMA_MCBSP1_RX },
 	{ OMAP24XX_DMA_MCBSP2_TX, OMAP24XX_DMA_MCBSP2_RX },
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
 	{ OMAP24XX_DMA_MCBSP3_TX, OMAP24XX_DMA_MCBSP3_RX },
 	{ OMAP24XX_DMA_MCBSP4_TX, OMAP24XX_DMA_MCBSP4_RX },
 	{ OMAP24XX_DMA_MCBSP5_TX, OMAP24XX_DMA_MCBSP5_RX },
@@ -102,7 +102,7 @@ static const int omap24xx_dma_reqs[][2] = {
 static const int omap24xx_dma_reqs[][2] = {};
 #endif
 
-#if defined(CONFIG_ARCH_OMAP2420)
+#if defined(CONFIG_SOC_OMAP2420)
 static const unsigned long omap2420_mcbsp_port[][2] = {
 	{ OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DXR1,
 	  OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DRR1 },
@@ -113,7 +113,7 @@ static const unsigned long omap2420_mcbsp_port[][2] = {
 static const unsigned long omap2420_mcbsp_port[][2] = {};
 #endif
 
-#if defined(CONFIG_ARCH_OMAP2430)
+#if defined(CONFIG_SOC_OMAP2430)
 static const unsigned long omap2430_mcbsp_port[][2] = {
 	{ OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DXR,
 	  OMAP24XX_MCBSP1_BASE + OMAP_MCBSP_REG_DRR },
diff --git a/sound/soc/omap/omap-mcbsp.h b/sound/soc/omap/omap-mcbsp.h
index ffdcc5a..c6cfb2e 100644
--- a/sound/soc/omap/omap-mcbsp.h
+++ b/sound/soc/omap/omap-mcbsp.h
@@ -43,14 +43,14 @@ enum omap_mcbsp_div {
 	OMAP_MCBSP_CLKGDV,		/* Sample rate generator divider */
 };
 
-#if defined(CONFIG_ARCH_OMAP2420)
+#if defined(CONFIG_SOC_OMAP2420)
 #define NUM_LINKS	2
 #endif
 #if defined(CONFIG_ARCH_OMAP15XX) || defined(CONFIG_ARCH_OMAP16XX)
 #undef  NUM_LINKS
 #define NUM_LINKS	3
 #endif
-#if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
+#if defined(CONFIG_SOC_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
 #undef  NUM_LINKS
 #define NUM_LINKS	5
 #endif
