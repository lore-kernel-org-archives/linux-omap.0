From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 03/15] ARM: OMAP3xxx: hwmod: Convert SHAM crypto device
 data to hwmod
Date: Fri, 8 Feb 2013 17:42:13 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302081630150.28008@utopia.booyaka.com>
References: <1356107295-11121-1-git-send-email-mgreer@animalcreek.com> <1356107295-11121-4-git-send-email-mgreer@animalcreek.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:50532 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760131Ab3BHRmP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 12:42:15 -0500
In-Reply-To: <1356107295-11121-4-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mark A. Greer" <mgreer@animalcreek.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Mark,

On Fri, 21 Dec 2012, Mark A. Greer wrote:

> From: "Mark A. Greer" <mgreer@animalcreek.com>
> 
> Convert the device data for the OMAP3 SHAM2 (SHA1/MD5) crypto IP
> from explicit platform_data to hwmod.
> 
> CC: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>

This one has been updated here to split the OMAP3xxx GP hwmod lists, as we 
discussed.  Updated patch follows.

- Paul

From: "Mark A. Greer" <mgreer@animalcreek.com>
Date: Fri, 21 Dec 2012 09:28:03 -0700
Subject: [PATCH] ARM: OMAP3xxx: hwmod: Convert SHAM crypto device data to
 hwmod

Convert the device data for the OMAP3 SHAM2 (SHA1/MD5) crypto IP
from explicit platform_data to hwmod.

CC: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
[paul@pwsan.com: updated to use per-SoC registration lists for GP-only hwmods;
 fixed lines causing sparse warnings]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cclock3xxx_data.c      |    1 +
 arch/arm/mach-omap2/devices.c              |   41 +----------
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |  107 +++++++++++++++++++++++++---
 3 files changed, 101 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/cclock3xxx_data.c
index 6ef8758..2853d72 100644
--- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -3336,6 +3336,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"icr_ick",	&icr_ick,	CK_34XX | CK_36XX),
 	CLK("omap-aes",	"ick",	&aes2_ick,	CK_34XX | CK_36XX),
 	CLK("omap-sham",	"ick",	&sha12_ick,	CK_34XX | CK_36XX),
+	CLK(NULL,	"sha12_ick",	&sha12_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"des2_ick",	&des2_ick,	CK_34XX | CK_36XX),
 	CLK("omap_hsmmc.1",	"ick",	&mmchs2_ick,	CK_3XXX),
 	CLK("omap_hsmmc.0",	"ick",	&mmchs1_ick,	CK_3XXX),
diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index b3f6818..8afc592 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -464,38 +464,9 @@ static void omap_init_rng(void)
 	WARN(IS_ERR(pdev), "Can't build omap_device for omap_rng\n");
 }
 
-#if defined(CONFIG_CRYPTO_DEV_OMAP_SHAM) || defined(CONFIG_CRYPTO_DEV_OMAP_SHAM_MODULE)
-
-#ifdef CONFIG_ARCH_OMAP3
-static struct resource omap3_sham_resources[] = {
-	{
-		.start	= OMAP34XX_SEC_SHA1MD5_BASE,
-		.end	= OMAP34XX_SEC_SHA1MD5_BASE + 0x64,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.start	= 49 + OMAP_INTC_START,
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.start	= OMAP34XX_DMA_SHA1MD5_RX,
-		.flags	= IORESOURCE_DMA,
-	}
-};
-static int omap3_sham_resources_sz = ARRAY_SIZE(omap3_sham_resources);
-#else
-#define omap3_sham_resources		NULL
-#define omap3_sham_resources_sz		0
-#endif
-
-static struct platform_device sham_device = {
-	.name		= "omap-sham",
-	.id		= -1,
-};
-
-static void omap_init_sham(void)
+static void __init omap_init_sham(void)
 {
-	if (cpu_is_omap24xx()) {
+	if (cpu_is_omap24xx() || cpu_is_omap34xx()) {
 		struct omap_hwmod *oh;
 		struct platform_device *pdev;
 
@@ -506,18 +477,10 @@ static void omap_init_sham(void)
 		pdev = omap_device_build("omap-sham", -1, oh, NULL, 0, NULL,
 					 0, 0);
 		WARN(IS_ERR(pdev), "Can't build omap_device for omap-sham\n");
-	} else if (cpu_is_omap34xx()) {
-		sham_device.resource = omap3_sham_resources;
-		sham_device.num_resources = omap3_sham_resources_sz;
-		platform_device_register(&sham_device);
 	} else {
 		pr_err("%s: platform not supported\n", __func__);
-		return;
 	}
 }
-#else
-static inline void omap_init_sham(void) { }
-#endif
 
 #if defined(CONFIG_CRYPTO_DEV_OMAP_AES) || defined(CONFIG_CRYPTO_DEV_OMAP_AES_MODULE)
 
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 8bb2628..8f54564 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3540,6 +3540,71 @@ static struct omap_hwmod_ocp_if omap3xxx_l3_main__gpmc = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l4_core -> SHAM2 (SHA1/MD5) (similar to omap24xx) */
+static struct omap_hwmod_sysc_fields omap3_sham_sysc_fields = {
+	.sidle_shift	= 4,
+	.srst_shift	= 1,
+	.autoidle_shift	= 0,
+};
+
+static struct omap_hwmod_class_sysconfig omap3_sham_sysc = {
+	.rev_offs	= 0x5c,
+	.sysc_offs	= 0x60,
+	.syss_offs	= 0x64,
+	.sysc_flags	= (SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
+			   SYSC_HAS_AUTOIDLE | SYSS_HAS_RESET_STATUS),
+	.sysc_fields	= &omap3_sham_sysc_fields,
+};
+
+static struct omap_hwmod_class omap3xxx_sham_class = {
+	.name	= "sham",
+	.sysc	= &omap3_sham_sysc,
+};
+
+static struct omap_hwmod_irq_info omap3_sham_mpu_irqs[] = {
+	{ .irq = 49 + OMAP_INTC_START, },
+	{ .irq = -1 }
+};
+
+static struct omap_hwmod_dma_info omap3_sham_sdma_reqs[] = {
+	{ .name = "rx", .dma_req = OMAP34XX_DMA_SHA1MD5_RX, },
+	{ .dma_req = -1 }
+};
+
+static struct omap_hwmod omap3xxx_sham_hwmod = {
+	.name		= "sham",
+	.mpu_irqs	= omap3_sham_mpu_irqs,
+	.sdma_reqs	= omap3_sham_sdma_reqs,
+	.main_clk	= "sha12_ick",
+	.prcm		= {
+		.omap2 = {
+			.module_offs = CORE_MOD,
+			.prcm_reg_id = 1,
+			.module_bit = OMAP3430_EN_SHA12_SHIFT,
+			.idlest_reg_id = 1,
+			.idlest_idle_bit = OMAP3430_ST_SHA12_SHIFT,
+		},
+	},
+	.class		= &omap3xxx_sham_class,
+};
+
+static struct omap_hwmod_addr_space omap3xxx_sham_addrs[] = {
+	{
+		.pa_start	= 0x480c3000,
+		.pa_end		= 0x480c3000 + 0x64 - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+	{ }
+};
+
+static struct omap_hwmod_ocp_if omap3xxx_l4_core__sham = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap3xxx_sham_hwmod,
+	.clk		= "sha12_ick",
+	.addr		= omap3xxx_sham_addrs,
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_ocp_if *omap3xxx_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l3_main__l4_core,
 	&omap3xxx_l3_main__l4_per,
@@ -3591,8 +3656,28 @@ static struct omap_hwmod_ocp_if *omap3xxx_hwmod_ocp_ifs[] __initdata = {
 };
 
 /* GP-only hwmod links */
-static struct omap_hwmod_ocp_if *omap3xxx_gp_hwmod_ocp_ifs[] __initdata = {
+static struct omap_hwmod_ocp_if *omap34xx_gp_hwmod_ocp_ifs[] __initdata = {
+	&omap3xxx_l4_sec__timer12,
+	&omap3xxx_l4_core__sham,
+	NULL
+};
+
+static struct omap_hwmod_ocp_if *omap36xx_gp_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l4_sec__timer12,
+	&omap3xxx_l4_core__sham,
+	NULL
+};
+
+static struct omap_hwmod_ocp_if *am35xx_gp_hwmod_ocp_ifs[] __initdata = {
+	&omap3xxx_l4_sec__timer12,
+	/*
+	 * Apparently the SHA/MD5 accelerator IP block is only present
+	 * on some AM35xx chips, and no one knows which ones.  See
+	 * http://www.spinics.net/lists/arm-kernel/msg215466.html So
+	 * if you need this IP block on an AM35xx, try uncommenting
+	 * the next line.
+	 */
+	/* &omap3xxx_l4_core__sham, */
 	NULL
 };
 
@@ -3699,7 +3784,7 @@ static struct omap_hwmod_ocp_if *omap3xxx_dss_hwmod_ocp_ifs[] __initdata = {
 int __init omap3xxx_hwmod_init(void)
 {
 	int r;
-	struct omap_hwmod_ocp_if **h = NULL;
+	struct omap_hwmod_ocp_if **h = NULL, **h_gp = NULL;
 	unsigned int rev;
 
 	omap_hwmod_init();
@@ -3709,13 +3794,6 @@ int __init omap3xxx_hwmod_init(void)
 	if (r < 0)
 		return r;
 
-	/* Register GP-only hwmod links. */
-	if (omap_type() == OMAP2_DEVICE_TYPE_GP) {
-		r = omap_hwmod_register_links(omap3xxx_gp_hwmod_ocp_ifs);
-		if (r < 0)
-			return r;
-	}
-
 	rev = omap_rev();
 
 	/*
@@ -3727,11 +3805,14 @@ int __init omap3xxx_hwmod_init(void)
 	    rev == OMAP3430_REV_ES2_1 || rev == OMAP3430_REV_ES3_0 ||
 	    rev == OMAP3430_REV_ES3_1 || rev == OMAP3430_REV_ES3_1_2) {
 		h = omap34xx_hwmod_ocp_ifs;
+		h_gp = omap34xx_gp_hwmod_ocp_ifs;
 	} else if (rev == AM35XX_REV_ES1_0 || rev == AM35XX_REV_ES1_1) {
 		h = am35xx_hwmod_ocp_ifs;
+		h_gp = am35xx_gp_hwmod_ocp_ifs;
 	} else if (rev == OMAP3630_REV_ES1_0 || rev == OMAP3630_REV_ES1_1 ||
 		   rev == OMAP3630_REV_ES1_2) {
 		h = omap36xx_hwmod_ocp_ifs;
+		h_gp = omap36xx_gp_hwmod_ocp_ifs;
 	} else {
 		WARN(1, "OMAP3 hwmod family init: unknown chip type\n");
 		return -EINVAL;
@@ -3741,6 +3822,14 @@ int __init omap3xxx_hwmod_init(void)
 	if (r < 0)
 		return r;
 
+	/* Register GP-only hwmod links. */
+	if (h_gp && omap_type() == OMAP2_DEVICE_TYPE_GP) {
+		r = omap_hwmod_register_links(h_gp);
+		if (r < 0)
+			return r;
+	}
+
+
 	/*
 	 * Register hwmod links specific to certain ES levels of a
 	 * particular family of silicon (e.g., 34xx ES1.0)
-- 
1.7.10.4

