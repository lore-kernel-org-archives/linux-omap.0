From: Paul Walmsley <paul@pwsan.com>
Subject: RE: [PATCH] ARM: OMAP: Clock: Remove CK_* flags
Date: Fri, 8 Feb 2013 18:08:27 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1302081805450.28008@utopia.booyaka.com>
References: <1359966525-7603-1-git-send-email-j-keerthy@ti.com> <alpine.DEB.2.00.1302080248550.8539@utopia.booyaka.com> <DC88CAD03C0052499C1907B327FC63229B92FF@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:50659 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946838Ab3BHSI2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Feb 2013 13:08:28 -0500
In-Reply-To: <DC88CAD03C0052499C1907B327FC63229B92FF@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org

cc lakml

Hi,

On Fri, 8 Feb 2013, J, KEERTHY wrote:

> Thanks for updating. Yes renaming the 'omap_clocks_register_links()
> Is fine. I had blindly followed the hwmod function naming convention.
> The new name makes sense.

OK great.  BTW don't forget to cc the linux-arm-kernel mailing list for 
all patches, otherwise we won't be able to merge the patches.  Taking care 
of it now in this case.


- Paul


From: J Keerthy <j-keerthy@ti.com>
Date: Thu, 7 Feb 2013 16:19:18 -0700
Subject: [PATCH] ARM: OMAP2+: clock data: Remove CK_* flags

The patch removes all the CK_* which were used to identify the family of
processors for which the individual clocks belonged to. Instead now separate
lists are created based on the family of processors.

Boot Tested on: OMAP4430, OMAP4460, Beagle-board, AM33X boards, OMAP2 boards.

Signed-off-by: J Keerthy <j-keerthy@ti.com>
Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Tested-by: Jon Hunter <jon-hunter@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
[paul@pwsan.com: changed omap_clock_register_links() to omap_clocks_register();
 updated to apply]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/cclock2420_data.c |  283 +++++++-------
 arch/arm/mach-omap2/cclock2430_data.c |  311 ++++++++-------
 arch/arm/mach-omap2/cclock33xx_data.c |  165 ++++----
 arch/arm/mach-omap2/cclock3xxx_data.c |  685 ++++++++++++++++++---------------
 arch/arm/mach-omap2/cclock44xx_data.c |  515 ++++++++++++-------------
 arch/arm/mach-omap2/clock.c           |   17 +-
 arch/arm/mach-omap2/clock.h           |   20 +-
 7 files changed, 1008 insertions(+), 988 deletions(-)

diff --git a/arch/arm/mach-omap2/cclock2420_data.c b/arch/arm/mach-omap2/cclock2420_data.c
index 0f0a97c..3662f4d 100644
--- a/arch/arm/mach-omap2/cclock2420_data.c
+++ b/arch/arm/mach-omap2/cclock2420_data.c
@@ -1739,153 +1739,153 @@ DEFINE_STRUCT_CLK(wdt4_ick, aes_ick_parent_names, aes_ick_ops);
 
 static struct omap_clk omap2420_clks[] = {
 	/* external root sources */
-	CLK(NULL,	"func_32k_ck",	&func_32k_ck,	CK_242X),
-	CLK(NULL,	"secure_32k_ck", &secure_32k_ck, CK_242X),
-	CLK(NULL,	"osc_ck",	&osc_ck,	CK_242X),
-	CLK(NULL,	"sys_ck",	&sys_ck,	CK_242X),
-	CLK(NULL,	"alt_ck",	&alt_ck,	CK_242X),
-	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks,	CK_242X),
+	CLK(NULL,	"func_32k_ck",	&func_32k_ck),
+	CLK(NULL,	"secure_32k_ck", &secure_32k_ck),
+	CLK(NULL,	"osc_ck",	&osc_ck),
+	CLK(NULL,	"sys_ck",	&sys_ck),
+	CLK(NULL,	"alt_ck",	&alt_ck),
+	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks),
 	/* internal analog sources */
-	CLK(NULL,	"dpll_ck",	&dpll_ck,	CK_242X),
-	CLK(NULL,	"apll96_ck",	&apll96_ck,	CK_242X),
-	CLK(NULL,	"apll54_ck",	&apll54_ck,	CK_242X),
+	CLK(NULL,	"dpll_ck",	&dpll_ck),
+	CLK(NULL,	"apll96_ck",	&apll96_ck),
+	CLK(NULL,	"apll54_ck",	&apll54_ck),
 	/* internal prcm root sources */
-	CLK(NULL,	"func_54m_ck",	&func_54m_ck,	CK_242X),
-	CLK(NULL,	"core_ck",	&core_ck,	CK_242X),
-	CLK(NULL,	"func_96m_ck",	&func_96m_ck,	CK_242X),
-	CLK(NULL,	"func_48m_ck",	&func_48m_ck,	CK_242X),
-	CLK(NULL,	"func_12m_ck",	&func_12m_ck,	CK_242X),
-	CLK(NULL,	"sys_clkout_src", &sys_clkout_src, CK_242X),
-	CLK(NULL,	"sys_clkout",	&sys_clkout,	CK_242X),
-	CLK(NULL,	"sys_clkout2_src", &sys_clkout2_src, CK_242X),
-	CLK(NULL,	"sys_clkout2",	&sys_clkout2,	CK_242X),
-	CLK(NULL,	"emul_ck",	&emul_ck,	CK_242X),
+	CLK(NULL,	"func_54m_ck",	&func_54m_ck),
+	CLK(NULL,	"core_ck",	&core_ck),
+	CLK(NULL,	"func_96m_ck",	&func_96m_ck),
+	CLK(NULL,	"func_48m_ck",	&func_48m_ck),
+	CLK(NULL,	"func_12m_ck",	&func_12m_ck),
+	CLK(NULL,	"sys_clkout_src", &sys_clkout_src),
+	CLK(NULL,	"sys_clkout",	&sys_clkout),
+	CLK(NULL,	"sys_clkout2_src", &sys_clkout2_src),
+	CLK(NULL,	"sys_clkout2",	&sys_clkout2),
+	CLK(NULL,	"emul_ck",	&emul_ck),
 	/* mpu domain clocks */
-	CLK(NULL,	"mpu_ck",	&mpu_ck,	CK_242X),
+	CLK(NULL,	"mpu_ck",	&mpu_ck),
 	/* dsp domain clocks */
-	CLK(NULL,	"dsp_fck",	&dsp_fck,	CK_242X),
-	CLK(NULL,	"dsp_ick",	&dsp_ick,	CK_242X),
-	CLK(NULL,	"iva1_ifck",	&iva1_ifck,	CK_242X),
-	CLK(NULL,	"iva1_mpu_int_ifck", &iva1_mpu_int_ifck, CK_242X),
+	CLK(NULL,	"dsp_fck",	&dsp_fck),
+	CLK(NULL,	"dsp_ick",	&dsp_ick),
+	CLK(NULL,	"iva1_ifck",	&iva1_ifck),
+	CLK(NULL,	"iva1_mpu_int_ifck", &iva1_mpu_int_ifck),
 	/* GFX domain clocks */
-	CLK(NULL,	"gfx_3d_fck",	&gfx_3d_fck,	CK_242X),
-	CLK(NULL,	"gfx_2d_fck",	&gfx_2d_fck,	CK_242X),
-	CLK(NULL,	"gfx_ick",	&gfx_ick,	CK_242X),
+	CLK(NULL,	"gfx_3d_fck",	&gfx_3d_fck),
+	CLK(NULL,	"gfx_2d_fck",	&gfx_2d_fck),
+	CLK(NULL,	"gfx_ick",	&gfx_ick),
 	/* DSS domain clocks */
-	CLK("omapdss_dss",	"ick",		&dss_ick,	CK_242X),
-	CLK(NULL,	"dss_ick",		&dss_ick,	CK_242X),
-	CLK(NULL,	"dss1_fck",		&dss1_fck,	CK_242X),
-	CLK(NULL,	"dss2_fck",	&dss2_fck,	CK_242X),
-	CLK(NULL,	"dss_54m_fck",	&dss_54m_fck,	CK_242X),
+	CLK("omapdss_dss",	"ick",		&dss_ick),
+	CLK(NULL,	"dss_ick",		&dss_ick),
+	CLK(NULL,	"dss1_fck",		&dss1_fck),
+	CLK(NULL,	"dss2_fck",	&dss2_fck),
+	CLK(NULL,	"dss_54m_fck",	&dss_54m_fck),
 	/* L3 domain clocks */
-	CLK(NULL,	"core_l3_ck",	&core_l3_ck,	CK_242X),
-	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck, CK_242X),
-	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick,	CK_242X),
+	CLK(NULL,	"core_l3_ck",	&core_l3_ck),
+	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck),
+	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick),
 	/* L4 domain clocks */
-	CLK(NULL,	"l4_ck",	&l4_ck,		CK_242X),
-	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_242X),
+	CLK(NULL,	"l4_ck",	&l4_ck),
+	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick),
 	/* virtual meta-group clock */
-	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_242X),
+	CLK(NULL,	"virt_prcm_set", &virt_prcm_set),
 	/* general l4 interface ck, multi-parent functional clk */
-	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_242X),
-	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_242X),
-	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_242X),
-	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_242X),
-	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_242X),
-	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_242X),
-	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_242X),
-	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_242X),
-	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_242X),
-	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_242X),
-	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_242X),
-	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_242X),
-	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_242X),
-	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_242X),
-	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_242X),
-	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_242X),
-	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_242X),
-	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_242X),
-	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_242X),
-	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_242X),
-	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_242X),
-	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_242X),
-	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_242X),
-	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_242X),
-	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_242X),
-	CLK(NULL,	"mcbsp1_ick",	&mcbsp1_ick,	CK_242X),
-	CLK(NULL,	"mcbsp1_fck",	&mcbsp1_fck,	CK_242X),
-	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_242X),
-	CLK(NULL,	"mcbsp2_ick",	&mcbsp2_ick,	CK_242X),
-	CLK(NULL,	"mcbsp2_fck",	&mcbsp2_fck,	CK_242X),
-	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_242X),
-	CLK(NULL,	"mcspi1_ick",	&mcspi1_ick,	CK_242X),
-	CLK(NULL,	"mcspi1_fck",	&mcspi1_fck,	CK_242X),
-	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_242X),
-	CLK(NULL,	"mcspi2_ick",	&mcspi2_ick,	CK_242X),
-	CLK(NULL,	"mcspi2_fck",	&mcspi2_fck,	CK_242X),
-	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_242X),
-	CLK(NULL,	"uart1_fck",	&uart1_fck,	CK_242X),
-	CLK(NULL,	"uart2_ick",	&uart2_ick,	CK_242X),
-	CLK(NULL,	"uart2_fck",	&uart2_fck,	CK_242X),
-	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_242X),
-	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_242X),
-	CLK(NULL,	"gpios_ick",	&gpios_ick,	CK_242X),
-	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_242X),
-	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_242X),
-	CLK(NULL,	"mpu_wdt_ick",		&mpu_wdt_ick,	CK_242X),
-	CLK(NULL,	"mpu_wdt_fck",	&mpu_wdt_fck,	CK_242X),
-	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_242X),
-	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_242X),
-	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_242X),
-	CLK("omap24xxcam", "fck",	&cam_fck,	CK_242X),
-	CLK(NULL,	"cam_fck",	&cam_fck,	CK_242X),
-	CLK("omap24xxcam", "ick",	&cam_ick,	CK_242X),
-	CLK(NULL,	"cam_ick",	&cam_ick,	CK_242X),
-	CLK(NULL,	"mailboxes_ick", &mailboxes_ick,	CK_242X),
-	CLK(NULL,	"wdt4_ick",	&wdt4_ick,	CK_242X),
-	CLK(NULL,	"wdt4_fck",	&wdt4_fck,	CK_242X),
-	CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_242X),
-	CLK(NULL,	"wdt3_fck",	&wdt3_fck,	CK_242X),
-	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_242X),
-	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_242X),
-	CLK("mmci-omap.0", "ick",	&mmc_ick,	CK_242X),
-	CLK(NULL,	"mmc_ick",	&mmc_ick,	CK_242X),
-	CLK("mmci-omap.0", "fck",	&mmc_fck,	CK_242X),
-	CLK(NULL,	"mmc_fck",	&mmc_fck,	CK_242X),
-	CLK(NULL,	"fac_ick",	&fac_ick,	CK_242X),
-	CLK(NULL,	"fac_fck",	&fac_fck,	CK_242X),
-	CLK(NULL,	"eac_ick",	&eac_ick,	CK_242X),
-	CLK(NULL,	"eac_fck",	&eac_fck,	CK_242X),
-	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_242X),
-	CLK(NULL,	"hdq_ick",	&hdq_ick,	CK_242X),
-	CLK("omap_hdq.0", "fck",	&hdq_fck,	CK_242X),
-	CLK(NULL,	"hdq_fck",	&hdq_fck,	CK_242X),
-	CLK("omap_i2c.1", "ick",	&i2c1_ick,	CK_242X),
-	CLK(NULL,	"i2c1_ick",	&i2c1_ick,	CK_242X),
-	CLK(NULL,	"i2c1_fck",	&i2c1_fck,	CK_242X),
-	CLK("omap_i2c.2", "ick",	&i2c2_ick,	CK_242X),
-	CLK(NULL,	"i2c2_ick",	&i2c2_ick,	CK_242X),
-	CLK(NULL,	"i2c2_fck",	&i2c2_fck,	CK_242X),
-	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_242X),
-	CLK(NULL,	"sdma_fck",	&sdma_fck,	CK_242X),
-	CLK(NULL,	"sdma_ick",	&sdma_ick,	CK_242X),
-	CLK(NULL,	"sdrc_ick",	&sdrc_ick,	CK_242X),
-	CLK(NULL,	"vlynq_ick",	&vlynq_ick,	CK_242X),
-	CLK(NULL,	"vlynq_fck",	&vlynq_fck,	CK_242X),
-	CLK(NULL,	"des_ick",	&des_ick,	CK_242X),
-	CLK("omap-sham",	"ick",	&sha_ick,	CK_242X),
-	CLK(NULL,	"sha_ick",	&sha_ick,	CK_242X),
-	CLK("omap_rng",	"ick",		&rng_ick,	CK_242X),
-	CLK(NULL,	"rng_ick",		&rng_ick,	CK_242X),
-	CLK("omap-aes",	"ick",	&aes_ick,	CK_242X),
-	CLK(NULL,	"aes_ick",	&aes_ick,	CK_242X),
-	CLK(NULL,	"pka_ick",	&pka_ick,	CK_242X),
-	CLK(NULL,	"usb_fck",	&usb_fck,	CK_242X),
-	CLK("musb-hdrc",	"fck",	&osc_ck,	CK_242X),
-	CLK(NULL,	"timer_32k_ck",	&func_32k_ck,	CK_242X),
-	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_242X),
-	CLK(NULL,	"timer_ext_ck",	&alt_ck,	CK_242X),
-	CLK(NULL,	"cpufreq_ck",	&virt_prcm_set,	CK_242X),
+	CLK(NULL,	"gpt1_ick",	&gpt1_ick),
+	CLK(NULL,	"gpt1_fck",	&gpt1_fck),
+	CLK(NULL,	"gpt2_ick",	&gpt2_ick),
+	CLK(NULL,	"gpt2_fck",	&gpt2_fck),
+	CLK(NULL,	"gpt3_ick",	&gpt3_ick),
+	CLK(NULL,	"gpt3_fck",	&gpt3_fck),
+	CLK(NULL,	"gpt4_ick",	&gpt4_ick),
+	CLK(NULL,	"gpt4_fck",	&gpt4_fck),
+	CLK(NULL,	"gpt5_ick",	&gpt5_ick),
+	CLK(NULL,	"gpt5_fck",	&gpt5_fck),
+	CLK(NULL,	"gpt6_ick",	&gpt6_ick),
+	CLK(NULL,	"gpt6_fck",	&gpt6_fck),
+	CLK(NULL,	"gpt7_ick",	&gpt7_ick),
+	CLK(NULL,	"gpt7_fck",	&gpt7_fck),
+	CLK(NULL,	"gpt8_ick",	&gpt8_ick),
+	CLK(NULL,	"gpt8_fck",	&gpt8_fck),
+	CLK(NULL,	"gpt9_ick",	&gpt9_ick),
+	CLK(NULL,	"gpt9_fck",	&gpt9_fck),
+	CLK(NULL,	"gpt10_ick",	&gpt10_ick),
+	CLK(NULL,	"gpt10_fck",	&gpt10_fck),
+	CLK(NULL,	"gpt11_ick",	&gpt11_ick),
+	CLK(NULL,	"gpt11_fck",	&gpt11_fck),
+	CLK(NULL,	"gpt12_ick",	&gpt12_ick),
+	CLK(NULL,	"gpt12_fck",	&gpt12_fck),
+	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick),
+	CLK(NULL,	"mcbsp1_ick",	&mcbsp1_ick),
+	CLK(NULL,	"mcbsp1_fck",	&mcbsp1_fck),
+	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick),
+	CLK(NULL,	"mcbsp2_ick",	&mcbsp2_ick),
+	CLK(NULL,	"mcbsp2_fck",	&mcbsp2_fck),
+	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick),
+	CLK(NULL,	"mcspi1_ick",	&mcspi1_ick),
+	CLK(NULL,	"mcspi1_fck",	&mcspi1_fck),
+	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick),
+	CLK(NULL,	"mcspi2_ick",	&mcspi2_ick),
+	CLK(NULL,	"mcspi2_fck",	&mcspi2_fck),
+	CLK(NULL,	"uart1_ick",	&uart1_ick),
+	CLK(NULL,	"uart1_fck",	&uart1_fck),
+	CLK(NULL,	"uart2_ick",	&uart2_ick),
+	CLK(NULL,	"uart2_fck",	&uart2_fck),
+	CLK(NULL,	"uart3_ick",	&uart3_ick),
+	CLK(NULL,	"uart3_fck",	&uart3_fck),
+	CLK(NULL,	"gpios_ick",	&gpios_ick),
+	CLK(NULL,	"gpios_fck",	&gpios_fck),
+	CLK("omap_wdt",	"ick",		&mpu_wdt_ick),
+	CLK(NULL,	"mpu_wdt_ick",		&mpu_wdt_ick),
+	CLK(NULL,	"mpu_wdt_fck",	&mpu_wdt_fck),
+	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick),
+	CLK(NULL,	"wdt1_ick",	&wdt1_ick),
+	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick),
+	CLK("omap24xxcam", "fck",	&cam_fck),
+	CLK(NULL,	"cam_fck",	&cam_fck),
+	CLK("omap24xxcam", "ick",	&cam_ick),
+	CLK(NULL,	"cam_ick",	&cam_ick),
+	CLK(NULL,	"mailboxes_ick", &mailboxes_ick),
+	CLK(NULL,	"wdt4_ick",	&wdt4_ick),
+	CLK(NULL,	"wdt4_fck",	&wdt4_fck),
+	CLK(NULL,	"wdt3_ick",	&wdt3_ick),
+	CLK(NULL,	"wdt3_fck",	&wdt3_fck),
+	CLK(NULL,	"mspro_ick",	&mspro_ick),
+	CLK(NULL,	"mspro_fck",	&mspro_fck),
+	CLK("mmci-omap.0", "ick",	&mmc_ick),
+	CLK(NULL,	"mmc_ick",	&mmc_ick),
+	CLK("mmci-omap.0", "fck",	&mmc_fck),
+	CLK(NULL,	"mmc_fck",	&mmc_fck),
+	CLK(NULL,	"fac_ick",	&fac_ick),
+	CLK(NULL,	"fac_fck",	&fac_fck),
+	CLK(NULL,	"eac_ick",	&eac_ick),
+	CLK(NULL,	"eac_fck",	&eac_fck),
+	CLK("omap_hdq.0", "ick",	&hdq_ick),
+	CLK(NULL,	"hdq_ick",	&hdq_ick),
+	CLK("omap_hdq.0", "fck",	&hdq_fck),
+	CLK(NULL,	"hdq_fck",	&hdq_fck),
+	CLK("omap_i2c.1", "ick",	&i2c1_ick),
+	CLK(NULL,	"i2c1_ick",	&i2c1_ick),
+	CLK(NULL,	"i2c1_fck",	&i2c1_fck),
+	CLK("omap_i2c.2", "ick",	&i2c2_ick),
+	CLK(NULL,	"i2c2_ick",	&i2c2_ick),
+	CLK(NULL,	"i2c2_fck",	&i2c2_fck),
+	CLK(NULL,	"gpmc_fck",	&gpmc_fck),
+	CLK(NULL,	"sdma_fck",	&sdma_fck),
+	CLK(NULL,	"sdma_ick",	&sdma_ick),
+	CLK(NULL,	"sdrc_ick",	&sdrc_ick),
+	CLK(NULL,	"vlynq_ick",	&vlynq_ick),
+	CLK(NULL,	"vlynq_fck",	&vlynq_fck),
+	CLK(NULL,	"des_ick",	&des_ick),
+	CLK("omap-sham",	"ick",	&sha_ick),
+	CLK(NULL,	"sha_ick",	&sha_ick),
+	CLK("omap_rng",	"ick",		&rng_ick),
+	CLK(NULL,	"rng_ick",		&rng_ick),
+	CLK("omap-aes",	"ick",	&aes_ick),
+	CLK(NULL,	"aes_ick",	&aes_ick),
+	CLK(NULL,	"pka_ick",	&pka_ick),
+	CLK(NULL,	"usb_fck",	&usb_fck),
+	CLK("musb-hdrc",	"fck",	&osc_ck),
+	CLK(NULL,	"timer_32k_ck",	&func_32k_ck),
+	CLK(NULL,	"timer_sys_ck",	&sys_ck),
+	CLK(NULL,	"timer_ext_ck",	&alt_ck),
+	CLK(NULL,	"cpufreq_ck",	&virt_prcm_set),
 };
 
 
@@ -1904,8 +1904,6 @@ static const char *enable_init_clks[] = {
 
 int __init omap2420_clk_init(void)
 {
-	struct omap_clk *c;
-
 	prcm_clksrc_ctrl = OMAP2420_PRCM_CLKSRC_CTRL;
 	cpu_mask = RATE_IN_242X;
 	rate_table = omap2420_rate_table;
@@ -1914,12 +1912,7 @@ int __init omap2420_clk_init(void)
 
 	omap2xxx_clkt_vps_check_bootloader_rates();
 
-	for (c = omap2420_clks; c < omap2420_clks + ARRAY_SIZE(omap2420_clks);
-	     c++) {
-		clkdev_add(&c->lk);
-		if (!__clk_init(NULL, c->lk.clk))
-			omap2_init_clk_hw_omap_clocks(c->lk.clk);
-	}
+	omap_clocks_register(omap2420_clks, ARRAY_SIZE(omap2420_clks));
 
 	omap2xxx_clkt_vps_late_init();
 
diff --git a/arch/arm/mach-omap2/cclock2430_data.c b/arch/arm/mach-omap2/cclock2430_data.c
index aed8f74..bda353b 100644
--- a/arch/arm/mach-omap2/cclock2430_data.c
+++ b/arch/arm/mach-omap2/cclock2430_data.c
@@ -1840,168 +1840,168 @@ DEFINE_STRUCT_CLK(wdt4_ick, aes_ick_parent_names, aes_ick_ops);
 
 static struct omap_clk omap2430_clks[] = {
 	/* external root sources */
-	CLK(NULL,	"func_32k_ck",	&func_32k_ck,	CK_243X),
-	CLK(NULL,	"secure_32k_ck", &secure_32k_ck, CK_243X),
-	CLK(NULL,	"osc_ck",	&osc_ck,	CK_243X),
-	CLK("twl",	"fck",		&osc_ck,	CK_243X),
-	CLK(NULL,	"sys_ck",	&sys_ck,	CK_243X),
-	CLK(NULL,	"alt_ck",	&alt_ck,	CK_243X),
-	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks,	CK_243X),
+	CLK(NULL,	"func_32k_ck",	&func_32k_ck),
+	CLK(NULL,	"secure_32k_ck", &secure_32k_ck),
+	CLK(NULL,	"osc_ck",	&osc_ck),
+	CLK("twl",	"fck",		&osc_ck),
+	CLK(NULL,	"sys_ck",	&sys_ck),
+	CLK(NULL,	"alt_ck",	&alt_ck),
+	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks),
 	/* internal analog sources */
-	CLK(NULL,	"dpll_ck",	&dpll_ck,	CK_243X),
-	CLK(NULL,	"apll96_ck",	&apll96_ck,	CK_243X),
-	CLK(NULL,	"apll54_ck",	&apll54_ck,	CK_243X),
+	CLK(NULL,	"dpll_ck",	&dpll_ck),
+	CLK(NULL,	"apll96_ck",	&apll96_ck),
+	CLK(NULL,	"apll54_ck",	&apll54_ck),
 	/* internal prcm root sources */
-	CLK(NULL,	"func_54m_ck",	&func_54m_ck,	CK_243X),
-	CLK(NULL,	"core_ck",	&core_ck,	CK_243X),
-	CLK(NULL,	"func_96m_ck",	&func_96m_ck,	CK_243X),
-	CLK(NULL,	"func_48m_ck",	&func_48m_ck,	CK_243X),
-	CLK(NULL,	"func_12m_ck",	&func_12m_ck,	CK_243X),
-	CLK(NULL,	"sys_clkout_src", &sys_clkout_src, CK_243X),
-	CLK(NULL,	"sys_clkout",	&sys_clkout,	CK_243X),
-	CLK(NULL,	"emul_ck",	&emul_ck,	CK_243X),
+	CLK(NULL,	"func_54m_ck",	&func_54m_ck),
+	CLK(NULL,	"core_ck",	&core_ck),
+	CLK(NULL,	"func_96m_ck",	&func_96m_ck),
+	CLK(NULL,	"func_48m_ck",	&func_48m_ck),
+	CLK(NULL,	"func_12m_ck",	&func_12m_ck),
+	CLK(NULL,	"sys_clkout_src", &sys_clkout_src),
+	CLK(NULL,	"sys_clkout",	&sys_clkout),
+	CLK(NULL,	"emul_ck",	&emul_ck),
 	/* mpu domain clocks */
-	CLK(NULL,	"mpu_ck",	&mpu_ck,	CK_243X),
+	CLK(NULL,	"mpu_ck",	&mpu_ck),
 	/* dsp domain clocks */
-	CLK(NULL,	"dsp_fck",	&dsp_fck,	CK_243X),
-	CLK(NULL,	"iva2_1_ick",	&iva2_1_ick,	CK_243X),
+	CLK(NULL,	"dsp_fck",	&dsp_fck),
+	CLK(NULL,	"iva2_1_ick",	&iva2_1_ick),
 	/* GFX domain clocks */
-	CLK(NULL,	"gfx_3d_fck",	&gfx_3d_fck,	CK_243X),
-	CLK(NULL,	"gfx_2d_fck",	&gfx_2d_fck,	CK_243X),
-	CLK(NULL,	"gfx_ick",	&gfx_ick,	CK_243X),
+	CLK(NULL,	"gfx_3d_fck",	&gfx_3d_fck),
+	CLK(NULL,	"gfx_2d_fck",	&gfx_2d_fck),
+	CLK(NULL,	"gfx_ick",	&gfx_ick),
 	/* Modem domain clocks */
-	CLK(NULL,	"mdm_ick",	&mdm_ick,	CK_243X),
-	CLK(NULL,	"mdm_osc_ck",	&mdm_osc_ck,	CK_243X),
+	CLK(NULL,	"mdm_ick",	&mdm_ick),
+	CLK(NULL,	"mdm_osc_ck",	&mdm_osc_ck),
 	/* DSS domain clocks */
-	CLK("omapdss_dss",	"ick",		&dss_ick,	CK_243X),
-	CLK(NULL,	"dss_ick",		&dss_ick,	CK_243X),
-	CLK(NULL,	"dss1_fck",		&dss1_fck,	CK_243X),
-	CLK(NULL,	"dss2_fck",	&dss2_fck,	CK_243X),
-	CLK(NULL,	"dss_54m_fck",	&dss_54m_fck,	CK_243X),
+	CLK("omapdss_dss",	"ick",		&dss_ick),
+	CLK(NULL,	"dss_ick",		&dss_ick),
+	CLK(NULL,	"dss1_fck",		&dss1_fck),
+	CLK(NULL,	"dss2_fck",	&dss2_fck),
+	CLK(NULL,	"dss_54m_fck",	&dss_54m_fck),
 	/* L3 domain clocks */
-	CLK(NULL,	"core_l3_ck",	&core_l3_ck,	CK_243X),
-	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck, CK_243X),
-	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick,	CK_243X),
+	CLK(NULL,	"core_l3_ck",	&core_l3_ck),
+	CLK(NULL,	"ssi_fck",	&ssi_ssr_sst_fck),
+	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick),
 	/* L4 domain clocks */
-	CLK(NULL,	"l4_ck",	&l4_ck,		CK_243X),
-	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_243X),
+	CLK(NULL,	"l4_ck",	&l4_ck),
+	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick),
 	/* virtual meta-group clock */
-	CLK(NULL,	"virt_prcm_set", &virt_prcm_set, CK_243X),
+	CLK(NULL,	"virt_prcm_set", &virt_prcm_set),
 	/* general l4 interface ck, multi-parent functional clk */
-	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_243X),
-	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_243X),
-	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_243X),
-	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_243X),
-	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_243X),
-	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_243X),
-	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_243X),
-	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_243X),
-	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_243X),
-	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_243X),
-	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_243X),
-	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_243X),
-	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_243X),
-	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_243X),
-	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_243X),
-	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_243X),
-	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_243X),
-	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_243X),
-	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_243X),
-	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_243X),
-	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_243X),
-	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_243X),
-	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_243X),
-	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_243X),
-	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_243X),
-	CLK(NULL,	"mcbsp1_ick",	&mcbsp1_ick,	CK_243X),
-	CLK(NULL,	"mcbsp1_fck",	&mcbsp1_fck,	CK_243X),
-	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_243X),
-	CLK(NULL,	"mcbsp2_ick",	&mcbsp2_ick,	CK_243X),
-	CLK(NULL,	"mcbsp2_fck",	&mcbsp2_fck,	CK_243X),
-	CLK("omap-mcbsp.3", "ick",	&mcbsp3_ick,	CK_243X),
-	CLK(NULL,	"mcbsp3_ick",	&mcbsp3_ick,	CK_243X),
-	CLK(NULL,	"mcbsp3_fck",	&mcbsp3_fck,	CK_243X),
-	CLK("omap-mcbsp.4", "ick",	&mcbsp4_ick,	CK_243X),
-	CLK(NULL,	"mcbsp4_ick",	&mcbsp4_ick,	CK_243X),
-	CLK(NULL,	"mcbsp4_fck",	&mcbsp4_fck,	CK_243X),
-	CLK("omap-mcbsp.5", "ick",	&mcbsp5_ick,	CK_243X),
-	CLK(NULL,	"mcbsp5_ick",	&mcbsp5_ick,	CK_243X),
-	CLK(NULL,	"mcbsp5_fck",	&mcbsp5_fck,	CK_243X),
-	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_243X),
-	CLK(NULL,	"mcspi1_ick",	&mcspi1_ick,	CK_243X),
-	CLK(NULL,	"mcspi1_fck",	&mcspi1_fck,	CK_243X),
-	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_243X),
-	CLK(NULL,	"mcspi2_ick",	&mcspi2_ick,	CK_243X),
-	CLK(NULL,	"mcspi2_fck",	&mcspi2_fck,	CK_243X),
-	CLK("omap2_mcspi.3", "ick",	&mcspi3_ick,	CK_243X),
-	CLK(NULL,	"mcspi3_ick",	&mcspi3_ick,	CK_243X),
-	CLK(NULL,	"mcspi3_fck",	&mcspi3_fck,	CK_243X),
-	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_243X),
-	CLK(NULL,	"uart1_fck",	&uart1_fck,	CK_243X),
-	CLK(NULL,	"uart2_ick",	&uart2_ick,	CK_243X),
-	CLK(NULL,	"uart2_fck",	&uart2_fck,	CK_243X),
-	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_243X),
-	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_243X),
-	CLK(NULL,	"gpios_ick",	&gpios_ick,	CK_243X),
-	CLK(NULL,	"gpios_fck",	&gpios_fck,	CK_243X),
-	CLK("omap_wdt",	"ick",		&mpu_wdt_ick,	CK_243X),
-	CLK(NULL,	"mpu_wdt_ick",	&mpu_wdt_ick,	CK_243X),
-	CLK(NULL,	"mpu_wdt_fck",	&mpu_wdt_fck,	CK_243X),
-	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick,	CK_243X),
-	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_243X),
-	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_243X),
-	CLK(NULL,	"icr_ick",	&icr_ick,	CK_243X),
-	CLK("omap24xxcam", "fck",	&cam_fck,	CK_243X),
-	CLK(NULL,	"cam_fck",	&cam_fck,	CK_243X),
-	CLK("omap24xxcam", "ick",	&cam_ick,	CK_243X),
-	CLK(NULL,	"cam_ick",	&cam_ick,	CK_243X),
-	CLK(NULL,	"mailboxes_ick", &mailboxes_ick,	CK_243X),
-	CLK(NULL,	"wdt4_ick",	&wdt4_ick,	CK_243X),
-	CLK(NULL,	"wdt4_fck",	&wdt4_fck,	CK_243X),
-	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_243X),
-	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_243X),
-	CLK(NULL,	"fac_ick",	&fac_ick,	CK_243X),
-	CLK(NULL,	"fac_fck",	&fac_fck,	CK_243X),
-	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_243X),
-	CLK(NULL,	"hdq_ick",	&hdq_ick,	CK_243X),
-	CLK("omap_hdq.1", "fck",	&hdq_fck,	CK_243X),
-	CLK(NULL,	"hdq_fck",	&hdq_fck,	CK_243X),
-	CLK("omap_i2c.1", "ick",	&i2c1_ick,	CK_243X),
-	CLK(NULL,	"i2c1_ick",	&i2c1_ick,	CK_243X),
-	CLK(NULL,	"i2chs1_fck",	&i2chs1_fck,	CK_243X),
-	CLK("omap_i2c.2", "ick",	&i2c2_ick,	CK_243X),
-	CLK(NULL,	"i2c2_ick",	&i2c2_ick,	CK_243X),
-	CLK(NULL,	"i2chs2_fck",	&i2chs2_fck,	CK_243X),
-	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_243X),
-	CLK(NULL,	"sdma_fck",	&sdma_fck,	CK_243X),
-	CLK(NULL,	"sdma_ick",	&sdma_ick,	CK_243X),
-	CLK(NULL,	"sdrc_ick",	&sdrc_ick,	CK_243X),
-	CLK(NULL,	"des_ick",	&des_ick,	CK_243X),
-	CLK("omap-sham",	"ick",	&sha_ick,	CK_243X),
-	CLK("omap_rng",	"ick",		&rng_ick,	CK_243X),
-	CLK(NULL,	"rng_ick",	&rng_ick,	CK_243X),
-	CLK("omap-aes",	"ick",	&aes_ick,	CK_243X),
-	CLK(NULL,	"pka_ick",	&pka_ick,	CK_243X),
-	CLK(NULL,	"usb_fck",	&usb_fck,	CK_243X),
-	CLK("musb-omap2430",	"ick",	&usbhs_ick,	CK_243X),
-	CLK(NULL,	"usbhs_ick",	&usbhs_ick,	CK_243X),
-	CLK("omap_hsmmc.0", "ick",	&mmchs1_ick,	CK_243X),
-	CLK(NULL,	"mmchs1_ick",	&mmchs1_ick,	CK_243X),
-	CLK(NULL,	"mmchs1_fck",	&mmchs1_fck,	CK_243X),
-	CLK("omap_hsmmc.1", "ick",	&mmchs2_ick,	CK_243X),
-	CLK(NULL,	"mmchs2_ick",	&mmchs2_ick,	CK_243X),
-	CLK(NULL,	"mmchs2_fck",	&mmchs2_fck,	CK_243X),
-	CLK(NULL,	"gpio5_ick",	&gpio5_ick,	CK_243X),
-	CLK(NULL,	"gpio5_fck",	&gpio5_fck,	CK_243X),
-	CLK(NULL,	"mdm_intc_ick",	&mdm_intc_ick,	CK_243X),
-	CLK("omap_hsmmc.0", "mmchsdb_fck",	&mmchsdb1_fck,	CK_243X),
-	CLK(NULL,	 "mmchsdb1_fck",	&mmchsdb1_fck,	CK_243X),
-	CLK("omap_hsmmc.1", "mmchsdb_fck",	&mmchsdb2_fck,	CK_243X),
-	CLK(NULL,	 "mmchsdb2_fck",	&mmchsdb2_fck,	CK_243X),
-	CLK(NULL,	"timer_32k_ck",  &func_32k_ck,   CK_243X),
-	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_243X),
-	CLK(NULL,	"timer_ext_ck",	&alt_ck,	CK_243X),
-	CLK(NULL,	"cpufreq_ck",	&virt_prcm_set,	CK_243X),
+	CLK(NULL,	"gpt1_ick",	&gpt1_ick),
+	CLK(NULL,	"gpt1_fck",	&gpt1_fck),
+	CLK(NULL,	"gpt2_ick",	&gpt2_ick),
+	CLK(NULL,	"gpt2_fck",	&gpt2_fck),
+	CLK(NULL,	"gpt3_ick",	&gpt3_ick),
+	CLK(NULL,	"gpt3_fck",	&gpt3_fck),
+	CLK(NULL,	"gpt4_ick",	&gpt4_ick),
+	CLK(NULL,	"gpt4_fck",	&gpt4_fck),
+	CLK(NULL,	"gpt5_ick",	&gpt5_ick),
+	CLK(NULL,	"gpt5_fck",	&gpt5_fck),
+	CLK(NULL,	"gpt6_ick",	&gpt6_ick),
+	CLK(NULL,	"gpt6_fck",	&gpt6_fck),
+	CLK(NULL,	"gpt7_ick",	&gpt7_ick),
+	CLK(NULL,	"gpt7_fck",	&gpt7_fck),
+	CLK(NULL,	"gpt8_ick",	&gpt8_ick),
+	CLK(NULL,	"gpt8_fck",	&gpt8_fck),
+	CLK(NULL,	"gpt9_ick",	&gpt9_ick),
+	CLK(NULL,	"gpt9_fck",	&gpt9_fck),
+	CLK(NULL,	"gpt10_ick",	&gpt10_ick),
+	CLK(NULL,	"gpt10_fck",	&gpt10_fck),
+	CLK(NULL,	"gpt11_ick",	&gpt11_ick),
+	CLK(NULL,	"gpt11_fck",	&gpt11_fck),
+	CLK(NULL,	"gpt12_ick",	&gpt12_ick),
+	CLK(NULL,	"gpt12_fck",	&gpt12_fck),
+	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick),
+	CLK(NULL,	"mcbsp1_ick",	&mcbsp1_ick),
+	CLK(NULL,	"mcbsp1_fck",	&mcbsp1_fck),
+	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick),
+	CLK(NULL,	"mcbsp2_ick",	&mcbsp2_ick),
+	CLK(NULL,	"mcbsp2_fck",	&mcbsp2_fck),
+	CLK("omap-mcbsp.3", "ick",	&mcbsp3_ick),
+	CLK(NULL,	"mcbsp3_ick",	&mcbsp3_ick),
+	CLK(NULL,	"mcbsp3_fck",	&mcbsp3_fck),
+	CLK("omap-mcbsp.4", "ick",	&mcbsp4_ick),
+	CLK(NULL,	"mcbsp4_ick",	&mcbsp4_ick),
+	CLK(NULL,	"mcbsp4_fck",	&mcbsp4_fck),
+	CLK("omap-mcbsp.5", "ick",	&mcbsp5_ick),
+	CLK(NULL,	"mcbsp5_ick",	&mcbsp5_ick),
+	CLK(NULL,	"mcbsp5_fck",	&mcbsp5_fck),
+	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick),
+	CLK(NULL,	"mcspi1_ick",	&mcspi1_ick),
+	CLK(NULL,	"mcspi1_fck",	&mcspi1_fck),
+	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick),
+	CLK(NULL,	"mcspi2_ick",	&mcspi2_ick),
+	CLK(NULL,	"mcspi2_fck",	&mcspi2_fck),
+	CLK("omap2_mcspi.3", "ick",	&mcspi3_ick),
+	CLK(NULL,	"mcspi3_ick",	&mcspi3_ick),
+	CLK(NULL,	"mcspi3_fck",	&mcspi3_fck),
+	CLK(NULL,	"uart1_ick",	&uart1_ick),
+	CLK(NULL,	"uart1_fck",	&uart1_fck),
+	CLK(NULL,	"uart2_ick",	&uart2_ick),
+	CLK(NULL,	"uart2_fck",	&uart2_fck),
+	CLK(NULL,	"uart3_ick",	&uart3_ick),
+	CLK(NULL,	"uart3_fck",	&uart3_fck),
+	CLK(NULL,	"gpios_ick",	&gpios_ick),
+	CLK(NULL,	"gpios_fck",	&gpios_fck),
+	CLK("omap_wdt",	"ick",		&mpu_wdt_ick),
+	CLK(NULL,	"mpu_wdt_ick",	&mpu_wdt_ick),
+	CLK(NULL,	"mpu_wdt_fck",	&mpu_wdt_fck),
+	CLK(NULL,	"sync_32k_ick",	&sync_32k_ick),
+	CLK(NULL,	"wdt1_ick",	&wdt1_ick),
+	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick),
+	CLK(NULL,	"icr_ick",	&icr_ick),
+	CLK("omap24xxcam", "fck",	&cam_fck),
+	CLK(NULL,	"cam_fck",	&cam_fck),
+	CLK("omap24xxcam", "ick",	&cam_ick),
+	CLK(NULL,	"cam_ick",	&cam_ick),
+	CLK(NULL,	"mailboxes_ick", &mailboxes_ick),
+	CLK(NULL,	"wdt4_ick",	&wdt4_ick),
+	CLK(NULL,	"wdt4_fck",	&wdt4_fck),
+	CLK(NULL,	"mspro_ick",	&mspro_ick),
+	CLK(NULL,	"mspro_fck",	&mspro_fck),
+	CLK(NULL,	"fac_ick",	&fac_ick),
+	CLK(NULL,	"fac_fck",	&fac_fck),
+	CLK("omap_hdq.0", "ick",	&hdq_ick),
+	CLK(NULL,	"hdq_ick",	&hdq_ick),
+	CLK("omap_hdq.1", "fck",	&hdq_fck),
+	CLK(NULL,	"hdq_fck",	&hdq_fck),
+	CLK("omap_i2c.1", "ick",	&i2c1_ick),
+	CLK(NULL,	"i2c1_ick",	&i2c1_ick),
+	CLK(NULL,	"i2chs1_fck",	&i2chs1_fck),
+	CLK("omap_i2c.2", "ick",	&i2c2_ick),
+	CLK(NULL,	"i2c2_ick",	&i2c2_ick),
+	CLK(NULL,	"i2chs2_fck",	&i2chs2_fck),
+	CLK(NULL,	"gpmc_fck",	&gpmc_fck),
+	CLK(NULL,	"sdma_fck",	&sdma_fck),
+	CLK(NULL,	"sdma_ick",	&sdma_ick),
+	CLK(NULL,	"sdrc_ick",	&sdrc_ick),
+	CLK(NULL,	"des_ick",	&des_ick),
+	CLK("omap-sham",	"ick",	&sha_ick),
+	CLK("omap_rng",	"ick",		&rng_ick),
+	CLK(NULL,	"rng_ick",	&rng_ick),
+	CLK("omap-aes",	"ick",	&aes_ick),
+	CLK(NULL,	"pka_ick",	&pka_ick),
+	CLK(NULL,	"usb_fck",	&usb_fck),
+	CLK("musb-omap2430",	"ick",	&usbhs_ick),
+	CLK(NULL,	"usbhs_ick",	&usbhs_ick),
+	CLK("omap_hsmmc.0", "ick",	&mmchs1_ick),
+	CLK(NULL,	"mmchs1_ick",	&mmchs1_ick),
+	CLK(NULL,	"mmchs1_fck",	&mmchs1_fck),
+	CLK("omap_hsmmc.1", "ick",	&mmchs2_ick),
+	CLK(NULL,	"mmchs2_ick",	&mmchs2_ick),
+	CLK(NULL,	"mmchs2_fck",	&mmchs2_fck),
+	CLK(NULL,	"gpio5_ick",	&gpio5_ick),
+	CLK(NULL,	"gpio5_fck",	&gpio5_fck),
+	CLK(NULL,	"mdm_intc_ick",	&mdm_intc_ick),
+	CLK("omap_hsmmc.0", "mmchsdb_fck",	&mmchsdb1_fck),
+	CLK(NULL,	 "mmchsdb1_fck",	&mmchsdb1_fck),
+	CLK("omap_hsmmc.1", "mmchsdb_fck",	&mmchsdb2_fck),
+	CLK(NULL,	 "mmchsdb2_fck",	&mmchsdb2_fck),
+	CLK(NULL,	"timer_32k_ck",  &func_32k_ck),
+	CLK(NULL,	"timer_sys_ck",	&sys_ck),
+	CLK(NULL,	"timer_ext_ck",	&alt_ck),
+	CLK(NULL,	"cpufreq_ck",	&virt_prcm_set),
 };
 
 static const char *enable_init_clks[] = {
@@ -2019,8 +2019,6 @@ static const char *enable_init_clks[] = {
 
 int __init omap2430_clk_init(void)
 {
-	struct omap_clk *c;
-
 	prcm_clksrc_ctrl = OMAP2430_PRCM_CLKSRC_CTRL;
 	cpu_mask = RATE_IN_243X;
 	rate_table = omap2430_rate_table;
@@ -2029,12 +2027,7 @@ int __init omap2430_clk_init(void)
 
 	omap2xxx_clkt_vps_check_bootloader_rates();
 
-	for (c = omap2430_clks; c < omap2430_clks + ARRAY_SIZE(omap2430_clks);
-	     c++) {
-		clkdev_add(&c->lk);
-		if (!__clk_init(NULL, c->lk.clk))
-			omap2_init_clk_hw_omap_clocks(c->lk.clk);
-	}
+	omap_clocks_register(omap2430_clks, ARRAY_SIZE(omap2430_clks));
 
 	omap2xxx_clkt_vps_late_init();
 
diff --git a/arch/arm/mach-omap2/cclock33xx_data.c b/arch/arm/mach-omap2/cclock33xx_data.c
index ea64ad6..15a483c 100644
--- a/arch/arm/mach-omap2/cclock33xx_data.c
+++ b/arch/arm/mach-omap2/cclock33xx_data.c
@@ -836,80 +836,80 @@ DEFINE_STRUCT_CLK(wdt1_fck, wdt_ck_parents, gpio_fck_ops);
  * clkdev
  */
 static struct omap_clk am33xx_clks[] = {
-	CLK(NULL,	"clk_32768_ck",		&clk_32768_ck,	CK_AM33XX),
-	CLK(NULL,	"clk_rc32k_ck",		&clk_rc32k_ck,	CK_AM33XX),
-	CLK(NULL,	"virt_19200000_ck",	&virt_19200000_ck,	CK_AM33XX),
-	CLK(NULL,	"virt_24000000_ck",	&virt_24000000_ck,	CK_AM33XX),
-	CLK(NULL,	"virt_25000000_ck",	&virt_25000000_ck,	CK_AM33XX),
-	CLK(NULL,	"virt_26000000_ck",	&virt_26000000_ck,	CK_AM33XX),
-	CLK(NULL,	"sys_clkin_ck",		&sys_clkin_ck,	CK_AM33XX),
-	CLK(NULL,	"tclkin_ck",		&tclkin_ck,	CK_AM33XX),
-	CLK(NULL,	"dpll_core_ck",		&dpll_core_ck,	CK_AM33XX),
-	CLK(NULL,	"dpll_core_x2_ck",	&dpll_core_x2_ck,	CK_AM33XX),
-	CLK(NULL,	"dpll_core_m4_ck",	&dpll_core_m4_ck,	CK_AM33XX),
-	CLK(NULL,	"dpll_core_m5_ck",	&dpll_core_m5_ck,	CK_AM33XX),
-	CLK(NULL,	"dpll_core_m6_ck",	&dpll_core_m6_ck,	CK_AM33XX),
-	CLK(NULL,	"dpll_mpu_ck",		&dpll_mpu_ck,	CK_AM33XX),
-	CLK("cpu0",	NULL,			&dpll_mpu_ck,	CK_AM33XX),
-	CLK(NULL,	"dpll_mpu_m2_ck",	&dpll_mpu_m2_ck,	CK_AM33XX),
-	CLK(NULL,	"dpll_ddr_ck",		&dpll_ddr_ck,	CK_AM33XX),
-	CLK(NULL,	"dpll_ddr_m2_ck",	&dpll_ddr_m2_ck,	CK_AM33XX),
-	CLK(NULL,	"dpll_ddr_m2_div2_ck",	&dpll_ddr_m2_div2_ck,	CK_AM33XX),
-	CLK(NULL,	"dpll_disp_ck",		&dpll_disp_ck,	CK_AM33XX),
-	CLK(NULL,	"dpll_disp_m2_ck",	&dpll_disp_m2_ck,	CK_AM33XX),
-	CLK(NULL,	"dpll_per_ck",		&dpll_per_ck,	CK_AM33XX),
-	CLK(NULL,	"dpll_per_m2_ck",	&dpll_per_m2_ck,	CK_AM33XX),
-	CLK(NULL,	"dpll_per_m2_div4_wkupdm_ck",	&dpll_per_m2_div4_wkupdm_ck,	CK_AM33XX),
-	CLK(NULL,	"dpll_per_m2_div4_ck",	&dpll_per_m2_div4_ck,	CK_AM33XX),
-	CLK(NULL,	"adc_tsc_fck",		&adc_tsc_fck,	CK_AM33XX),
-	CLK(NULL,	"cefuse_fck",		&cefuse_fck,	CK_AM33XX),
-	CLK(NULL,	"clkdiv32k_ck",		&clkdiv32k_ck,	CK_AM33XX),
-	CLK(NULL,	"clkdiv32k_ick",	&clkdiv32k_ick,	CK_AM33XX),
-	CLK(NULL,	"dcan0_fck",		&dcan0_fck,	CK_AM33XX),
-	CLK("481cc000.d_can",	NULL,		&dcan0_fck,	CK_AM33XX),
-	CLK(NULL,	"dcan1_fck",		&dcan1_fck,	CK_AM33XX),
-	CLK("481d0000.d_can",	NULL,		&dcan1_fck,	CK_AM33XX),
-	CLK(NULL,	"debugss_ick",		&debugss_ick,	CK_AM33XX),
-	CLK(NULL,	"pruss_ocp_gclk",	&pruss_ocp_gclk,	CK_AM33XX),
-	CLK(NULL,	"mcasp0_fck",		&mcasp0_fck,	CK_AM33XX),
-	CLK(NULL,	"mcasp1_fck",		&mcasp1_fck,	CK_AM33XX),
-	CLK(NULL,	"mmu_fck",		&mmu_fck,	CK_AM33XX),
-	CLK(NULL,	"smartreflex0_fck",	&smartreflex0_fck,	CK_AM33XX),
-	CLK(NULL,	"smartreflex1_fck",	&smartreflex1_fck,	CK_AM33XX),
-	CLK(NULL,	"timer1_fck",		&timer1_fck,	CK_AM33XX),
-	CLK(NULL,	"timer2_fck",		&timer2_fck,	CK_AM33XX),
-	CLK(NULL,	"timer3_fck",		&timer3_fck,	CK_AM33XX),
-	CLK(NULL,	"timer4_fck",		&timer4_fck,	CK_AM33XX),
-	CLK(NULL,	"timer5_fck",		&timer5_fck,	CK_AM33XX),
-	CLK(NULL,	"timer6_fck",		&timer6_fck,	CK_AM33XX),
-	CLK(NULL,	"timer7_fck",		&timer7_fck,	CK_AM33XX),
-	CLK(NULL,	"usbotg_fck",		&usbotg_fck,	CK_AM33XX),
-	CLK(NULL,	"ieee5000_fck",		&ieee5000_fck,	CK_AM33XX),
-	CLK(NULL,	"wdt1_fck",		&wdt1_fck,	CK_AM33XX),
-	CLK(NULL,	"l4_rtc_gclk",		&l4_rtc_gclk,	CK_AM33XX),
-	CLK(NULL,	"l3_gclk",		&l3_gclk,	CK_AM33XX),
-	CLK(NULL,	"dpll_core_m4_div2_ck",	&dpll_core_m4_div2_ck,	CK_AM33XX),
-	CLK(NULL,	"l4hs_gclk",		&l4hs_gclk,	CK_AM33XX),
-	CLK(NULL,	"l3s_gclk",		&l3s_gclk,	CK_AM33XX),
-	CLK(NULL,	"l4fw_gclk",		&l4fw_gclk,	CK_AM33XX),
-	CLK(NULL,	"l4ls_gclk",		&l4ls_gclk,	CK_AM33XX),
-	CLK(NULL,	"clk_24mhz",		&clk_24mhz,	CK_AM33XX),
-	CLK(NULL,	"sysclk_div_ck",	&sysclk_div_ck,	CK_AM33XX),
-	CLK(NULL,	"cpsw_125mhz_gclk",	&cpsw_125mhz_gclk,	CK_AM33XX),
-	CLK(NULL,	"cpsw_cpts_rft_clk",	&cpsw_cpts_rft_clk,	CK_AM33XX),
-	CLK(NULL,	"gpio0_dbclk_mux_ck",	&gpio0_dbclk_mux_ck,	CK_AM33XX),
-	CLK(NULL,	"gpio0_dbclk",		&gpio0_dbclk,	CK_AM33XX),
-	CLK(NULL,	"gpio1_dbclk",		&gpio1_dbclk,	CK_AM33XX),
-	CLK(NULL,	"gpio2_dbclk",		&gpio2_dbclk,	CK_AM33XX),
-	CLK(NULL,	"gpio3_dbclk",		&gpio3_dbclk,	CK_AM33XX),
-	CLK(NULL,	"lcd_gclk",		&lcd_gclk,	CK_AM33XX),
-	CLK(NULL,	"mmc_clk",		&mmc_clk,	CK_AM33XX),
-	CLK(NULL,	"gfx_fclk_clksel_ck",	&gfx_fclk_clksel_ck,	CK_AM33XX),
-	CLK(NULL,	"gfx_fck_div_ck",	&gfx_fck_div_ck,	CK_AM33XX),
-	CLK(NULL,	"sysclkout_pre_ck",	&sysclkout_pre_ck,	CK_AM33XX),
-	CLK(NULL,	"clkout2_div_ck",	&clkout2_div_ck,	CK_AM33XX),
-	CLK(NULL,	"timer_32k_ck",		&clkdiv32k_ick,	CK_AM33XX),
-	CLK(NULL,	"timer_sys_ck",		&sys_clkin_ck,	CK_AM33XX),
+	CLK(NULL,	"clk_32768_ck",		&clk_32768_ck),
+	CLK(NULL,	"clk_rc32k_ck",		&clk_rc32k_ck),
+	CLK(NULL,	"virt_19200000_ck",	&virt_19200000_ck),
+	CLK(NULL,	"virt_24000000_ck",	&virt_24000000_ck),
+	CLK(NULL,	"virt_25000000_ck",	&virt_25000000_ck),
+	CLK(NULL,	"virt_26000000_ck",	&virt_26000000_ck),
+	CLK(NULL,	"sys_clkin_ck",		&sys_clkin_ck),
+	CLK(NULL,	"tclkin_ck",		&tclkin_ck),
+	CLK(NULL,	"dpll_core_ck",		&dpll_core_ck),
+	CLK(NULL,	"dpll_core_x2_ck",	&dpll_core_x2_ck),
+	CLK(NULL,	"dpll_core_m4_ck",	&dpll_core_m4_ck),
+	CLK(NULL,	"dpll_core_m5_ck",	&dpll_core_m5_ck),
+	CLK(NULL,	"dpll_core_m6_ck",	&dpll_core_m6_ck),
+	CLK(NULL,	"dpll_mpu_ck",		&dpll_mpu_ck),
+	CLK("cpu0",	NULL,			&dpll_mpu_ck),
+	CLK(NULL,	"dpll_mpu_m2_ck",	&dpll_mpu_m2_ck),
+	CLK(NULL,	"dpll_ddr_ck",		&dpll_ddr_ck),
+	CLK(NULL,	"dpll_ddr_m2_ck",	&dpll_ddr_m2_ck),
+	CLK(NULL,	"dpll_ddr_m2_div2_ck",	&dpll_ddr_m2_div2_ck),
+	CLK(NULL,	"dpll_disp_ck",		&dpll_disp_ck),
+	CLK(NULL,	"dpll_disp_m2_ck",	&dpll_disp_m2_ck),
+	CLK(NULL,	"dpll_per_ck",		&dpll_per_ck),
+	CLK(NULL,	"dpll_per_m2_ck",	&dpll_per_m2_ck),
+	CLK(NULL,	"dpll_per_m2_div4_wkupdm_ck",	&dpll_per_m2_div4_wkupdm_ck),
+	CLK(NULL,	"dpll_per_m2_div4_ck",	&dpll_per_m2_div4_ck),
+	CLK(NULL,	"adc_tsc_fck",		&adc_tsc_fck),
+	CLK(NULL,	"cefuse_fck",		&cefuse_fck),
+	CLK(NULL,	"clkdiv32k_ck",		&clkdiv32k_ck),
+	CLK(NULL,	"clkdiv32k_ick",	&clkdiv32k_ick),
+	CLK(NULL,	"dcan0_fck",		&dcan0_fck),
+	CLK("481cc000.d_can",	NULL,		&dcan0_fck),
+	CLK(NULL,	"dcan1_fck",		&dcan1_fck),
+	CLK("481d0000.d_can",	NULL,		&dcan1_fck),
+	CLK(NULL,	"debugss_ick",		&debugss_ick),
+	CLK(NULL,	"pruss_ocp_gclk",	&pruss_ocp_gclk),
+	CLK(NULL,	"mcasp0_fck",		&mcasp0_fck),
+	CLK(NULL,	"mcasp1_fck",		&mcasp1_fck),
+	CLK(NULL,	"mmu_fck",		&mmu_fck),
+	CLK(NULL,	"smartreflex0_fck",	&smartreflex0_fck),
+	CLK(NULL,	"smartreflex1_fck",	&smartreflex1_fck),
+	CLK(NULL,	"timer1_fck",		&timer1_fck),
+	CLK(NULL,	"timer2_fck",		&timer2_fck),
+	CLK(NULL,	"timer3_fck",		&timer3_fck),
+	CLK(NULL,	"timer4_fck",		&timer4_fck),
+	CLK(NULL,	"timer5_fck",		&timer5_fck),
+	CLK(NULL,	"timer6_fck",		&timer6_fck),
+	CLK(NULL,	"timer7_fck",		&timer7_fck),
+	CLK(NULL,	"usbotg_fck",		&usbotg_fck),
+	CLK(NULL,	"ieee5000_fck",		&ieee5000_fck),
+	CLK(NULL,	"wdt1_fck",		&wdt1_fck),
+	CLK(NULL,	"l4_rtc_gclk",		&l4_rtc_gclk),
+	CLK(NULL,	"l3_gclk",		&l3_gclk),
+	CLK(NULL,	"dpll_core_m4_div2_ck",	&dpll_core_m4_div2_ck),
+	CLK(NULL,	"l4hs_gclk",		&l4hs_gclk),
+	CLK(NULL,	"l3s_gclk",		&l3s_gclk),
+	CLK(NULL,	"l4fw_gclk",		&l4fw_gclk),
+	CLK(NULL,	"l4ls_gclk",		&l4ls_gclk),
+	CLK(NULL,	"clk_24mhz",		&clk_24mhz),
+	CLK(NULL,	"sysclk_div_ck",	&sysclk_div_ck),
+	CLK(NULL,	"cpsw_125mhz_gclk",	&cpsw_125mhz_gclk),
+	CLK(NULL,	"cpsw_cpts_rft_clk",	&cpsw_cpts_rft_clk),
+	CLK(NULL,	"gpio0_dbclk_mux_ck",	&gpio0_dbclk_mux_ck),
+	CLK(NULL,	"gpio0_dbclk",		&gpio0_dbclk),
+	CLK(NULL,	"gpio1_dbclk",		&gpio1_dbclk),
+	CLK(NULL,	"gpio2_dbclk",		&gpio2_dbclk),
+	CLK(NULL,	"gpio3_dbclk",		&gpio3_dbclk),
+	CLK(NULL,	"lcd_gclk",		&lcd_gclk),
+	CLK(NULL,	"mmc_clk",		&mmc_clk),
+	CLK(NULL,	"gfx_fclk_clksel_ck",	&gfx_fclk_clksel_ck),
+	CLK(NULL,	"gfx_fck_div_ck",	&gfx_fck_div_ck),
+	CLK(NULL,	"sysclkout_pre_ck",	&sysclkout_pre_ck),
+	CLK(NULL,	"clkout2_div_ck",	&clkout2_div_ck),
+	CLK(NULL,	"timer_32k_ck",		&clkdiv32k_ick),
+	CLK(NULL,	"timer_sys_ck",		&sys_clkin_ck),
 };
 
 
@@ -924,21 +924,10 @@ static const char *enable_init_clks[] = {
 
 int __init am33xx_clk_init(void)
 {
-	struct omap_clk *c;
-	u32 cpu_clkflg;
-
-	if (soc_is_am33xx()) {
+	if (soc_is_am33xx())
 		cpu_mask = RATE_IN_AM33XX;
-		cpu_clkflg = CK_AM33XX;
-	}
-
-	for (c = am33xx_clks; c < am33xx_clks + ARRAY_SIZE(am33xx_clks); c++) {
-		if (c->cpu & cpu_clkflg) {
-			clkdev_add(&c->lk);
-			if (!__clk_init(NULL, c->lk.clk))
-				omap2_init_clk_hw_omap_clocks(c->lk.clk);
-		}
-	}
+
+	omap_clocks_register(am33xx_clks, ARRAY_SIZE(am33xx_clks));
 
 	omap2_clk_disable_autoidle_all();
 
diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap2/cclock3xxx_data.c
index 6ef8758..4398117 100644
--- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -3211,289 +3211,325 @@ static struct clk_hw_omap wdt3_ick_hw = {
 DEFINE_STRUCT_CLK(wdt3_ick, gpio2_ick_parent_names, aes2_ick_ops);
 
 /*
- * clkdev
+ * clocks specific to omap3430es1
+ */
+static struct omap_clk omap3430es1_clks[] = {
+	CLK(NULL,	"gfx_l3_ck",	&gfx_l3_ck),
+	CLK(NULL,	"gfx_l3_fck",	&gfx_l3_fck),
+	CLK(NULL,	"gfx_l3_ick",	&gfx_l3_ick),
+	CLK(NULL,	"gfx_cg1_ck",	&gfx_cg1_ck),
+	CLK(NULL,	"gfx_cg2_ck",	&gfx_cg2_ck),
+	CLK(NULL,	"d2d_26m_fck",	&d2d_26m_fck),
+	CLK(NULL,	"fshostusb_fck", &fshostusb_fck),
+	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck_3430es1),
+	CLK(NULL,	"ssi_sst_fck",	&ssi_sst_fck_3430es1),
+	CLK("musb-omap2430",	"ick",	&hsotgusb_ick_3430es1),
+	CLK(NULL,	"hsotgusb_ick",	&hsotgusb_ick_3430es1),
+	CLK(NULL,	"fac_ick",	&fac_ick),
+	CLK(NULL,	"ssi_ick",	&ssi_ick_3430es1),
+	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick),
+	CLK(NULL,	"dss1_alwon_fck",	&dss1_alwon_fck_3430es1),
+	CLK("omapdss_dss",	"ick",		&dss_ick_3430es1),
+	CLK(NULL,	"dss_ick",		&dss_ick_3430es1),
+};
+
+/*
+ * clocks specific to am35xx
+ */
+static struct omap_clk am35xx_clks[] = {
+	CLK(NULL,	"ipss_ick",	&ipss_ick),
+	CLK(NULL,	"rmii_ck",	&rmii_ck),
+	CLK(NULL,	"pclk_ck",	&pclk_ck),
+	CLK(NULL,	"emac_ick",	&emac_ick),
+	CLK(NULL,	"emac_fck",	&emac_fck),
+	CLK("davinci_emac.0",	NULL,	&emac_ick),
+	CLK("davinci_mdio.0",	NULL,	&emac_fck),
+	CLK("vpfe-capture",	"master",	&vpfe_ick),
+	CLK("vpfe-capture",	"slave",	&vpfe_fck),
+	CLK(NULL,	"hsotgusb_ick",		&hsotgusb_ick_am35xx),
+	CLK(NULL,	"hsotgusb_fck",		&hsotgusb_fck_am35xx),
+	CLK(NULL,	"hecc_ck",	&hecc_ck),
+	CLK(NULL,	"uart4_ick",	&uart4_ick_am35xx),
+	CLK(NULL,	"uart4_fck",	&uart4_fck_am35xx),
+};
+
+/*
+ * clocks specific to omap36xx
+ */
+static struct omap_clk omap36xx_clks[] = {
+	CLK(NULL,	"omap_192m_alwon_fck", &omap_192m_alwon_fck),
+	CLK(NULL,	"uart4_fck",	&uart4_fck),
+};
+
+/*
+ * clocks common to omap36xx omap34xx
+ */
+static struct omap_clk omap34xx_omap36xx_clks[] = {
+	CLK(NULL,	"aes1_ick",	&aes1_ick),
+	CLK("omap_rng",	"ick",		&rng_ick),
+	CLK(NULL,	"sha11_ick",	&sha11_ick),
+	CLK(NULL,	"des1_ick",	&des1_ick),
+	CLK(NULL,	"cam_mclk",	&cam_mclk),
+	CLK(NULL,	"cam_ick",	&cam_ick),
+	CLK(NULL,	"csi2_96m_fck",	&csi2_96m_fck),
+	CLK(NULL,	"security_l3_ick", &security_l3_ick),
+	CLK(NULL,	"pka_ick",	&pka_ick),
+	CLK(NULL,	"icr_ick",	&icr_ick),
+	CLK("omap-aes",	"ick",	&aes2_ick),
+	CLK("omap-sham",	"ick",	&sha12_ick),
+	CLK(NULL,	"des2_ick",	&des2_ick),
+	CLK(NULL,	"mspro_ick",	&mspro_ick),
+	CLK(NULL,	"mailboxes_ick", &mailboxes_ick),
+	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick),
+	CLK(NULL,	"sr1_fck",	&sr1_fck),
+	CLK(NULL,	"sr2_fck",	&sr2_fck),
+	CLK(NULL,	"sr_l4_ick",	&sr_l4_ick),
+	CLK(NULL,	"security_l4_ick2", &security_l4_ick2),
+	CLK(NULL,	"wkup_l4_ick",	&wkup_l4_ick),
+	CLK(NULL,	"dpll2_fck",	&dpll2_fck),
+	CLK(NULL,	"iva2_ck",	&iva2_ck),
+	CLK(NULL,	"modem_fck",	&modem_fck),
+	CLK(NULL,	"sad2d_ick",	&sad2d_ick),
+	CLK(NULL,	"mad2d_ick",	&mad2d_ick),
+	CLK(NULL,	"mspro_fck",	&mspro_fck),
+	CLK(NULL,	"dpll2_ck",	&dpll2_ck),
+	CLK(NULL,	"dpll2_m2_ck",	&dpll2_m2_ck),
+};
+
+/*
+ * clocks common to omap36xx and omap3430es2plus
+ */
+static struct omap_clk omap36xx_omap3430es2plus_clks[] = {
+	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck_3430es2),
+	CLK(NULL,	"ssi_sst_fck",	&ssi_sst_fck_3430es2),
+	CLK("musb-omap2430",	"ick",	&hsotgusb_ick_3430es2),
+	CLK(NULL,	"hsotgusb_ick",	&hsotgusb_ick_3430es2),
+	CLK(NULL,	"ssi_ick",	&ssi_ick_3430es2),
+	CLK(NULL,	"usim_fck",	&usim_fck),
+	CLK(NULL,	"usim_ick",	&usim_ick),
+};
+
+/*
+ * clocks common to am35xx omap36xx and omap3430es2plus
+ */
+static struct omap_clk omap36xx_am35xx_omap3430es2plus_clks[] = {
+	CLK(NULL,	"virt_16_8m_ck", &virt_16_8m_ck),
+	CLK(NULL,	"dpll5_ck",	&dpll5_ck),
+	CLK(NULL,	"dpll5_m2_ck",	&dpll5_m2_ck),
+	CLK(NULL,	"sgx_fck",	&sgx_fck),
+	CLK(NULL,	"sgx_ick",	&sgx_ick),
+	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck),
+	CLK(NULL,	"ts_fck",	&ts_fck),
+	CLK(NULL,	"usbtll_fck",	&usbtll_fck),
+	CLK("usbhs_omap",	"usbtll_fck",	&usbtll_fck),
+	CLK("usbhs_tll",	"usbtll_fck",	&usbtll_fck),
+	CLK(NULL,	"usbtll_ick",	&usbtll_ick),
+	CLK("usbhs_omap",	"usbtll_ick",	&usbtll_ick),
+	CLK("usbhs_tll",	"usbtll_ick",	&usbtll_ick),
+	CLK("omap_hsmmc.2",	"ick",	&mmchs3_ick),
+	CLK(NULL,	"mmchs3_ick",	&mmchs3_ick),
+	CLK(NULL,	"mmchs3_fck",	&mmchs3_fck),
+	CLK(NULL,	"dss1_alwon_fck",	&dss1_alwon_fck_3430es2),
+	CLK("omapdss_dss",	"ick",		&dss_ick_3430es2),
+	CLK(NULL,	"dss_ick",		&dss_ick_3430es2),
+	CLK(NULL,	"usbhost_120m_fck", &usbhost_120m_fck),
+	CLK(NULL,	"usbhost_48m_fck", &usbhost_48m_fck),
+	CLK(NULL,	"usbhost_ick",	&usbhost_ick),
+	CLK("usbhs_omap",	"usbhost_ick",	&usbhost_ick),
+};
+
+/*
+ * common clocks
  */
 static struct omap_clk omap3xxx_clks[] = {
-	CLK(NULL,	"apb_pclk",	&dummy_apb_pclk,	CK_3XXX),
-	CLK(NULL,	"omap_32k_fck",	&omap_32k_fck,	CK_3XXX),
-	CLK(NULL,	"virt_12m_ck",	&virt_12m_ck,	CK_3XXX),
-	CLK(NULL,	"virt_13m_ck",	&virt_13m_ck,	CK_3XXX),
-	CLK(NULL,	"virt_16_8m_ck", &virt_16_8m_ck, CK_3430ES2PLUS | CK_AM35XX  | CK_36XX),
-	CLK(NULL,	"virt_19200000_ck", &virt_19200000_ck, CK_3XXX),
-	CLK(NULL,	"virt_26000000_ck", &virt_26000000_ck, CK_3XXX),
-	CLK(NULL,	"virt_38_4m_ck", &virt_38_4m_ck, CK_3XXX),
-	CLK(NULL,	"osc_sys_ck",	&osc_sys_ck,	CK_3XXX),
-	CLK("twl",	"fck",		&osc_sys_ck,	CK_3XXX),
-	CLK(NULL,	"sys_ck",	&sys_ck,	CK_3XXX),
-	CLK(NULL,	"sys_altclk",	&sys_altclk,	CK_3XXX),
-	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks,	CK_3XXX),
-	CLK(NULL,	"sys_clkout1",	&sys_clkout1,	CK_3XXX),
-	CLK(NULL,	"dpll1_ck",	&dpll1_ck,	CK_3XXX),
-	CLK(NULL,	"dpll1_x2_ck",	&dpll1_x2_ck,	CK_3XXX),
-	CLK(NULL,	"dpll1_x2m2_ck", &dpll1_x2m2_ck, CK_3XXX),
-	CLK(NULL,	"dpll2_ck",	&dpll2_ck,	CK_34XX | CK_36XX),
-	CLK(NULL,	"dpll2_m2_ck",	&dpll2_m2_ck,	CK_34XX | CK_36XX),
-	CLK(NULL,	"dpll3_ck",	&dpll3_ck,	CK_3XXX),
-	CLK(NULL,	"core_ck",	&core_ck,	CK_3XXX),
-	CLK(NULL,	"dpll3_x2_ck",	&dpll3_x2_ck,	CK_3XXX),
-	CLK(NULL,	"dpll3_m2_ck",	&dpll3_m2_ck,	CK_3XXX),
-	CLK(NULL,	"dpll3_m2x2_ck", &dpll3_m2x2_ck, CK_3XXX),
-	CLK(NULL,	"dpll3_m3_ck",	&dpll3_m3_ck,	CK_3XXX),
-	CLK(NULL,	"dpll3_m3x2_ck", &dpll3_m3x2_ck, CK_3XXX),
-	CLK("etb",	"emu_core_alwon_ck", &emu_core_alwon_ck, CK_3XXX),
-	CLK(NULL,	"dpll4_ck",	&dpll4_ck,	CK_3XXX),
-	CLK(NULL,	"dpll4_x2_ck",	&dpll4_x2_ck,	CK_3XXX),
-	CLK(NULL,	"omap_192m_alwon_fck", &omap_192m_alwon_fck, CK_36XX),
-	CLK(NULL,	"omap_96m_alwon_fck", &omap_96m_alwon_fck, CK_3XXX),
-	CLK(NULL,	"omap_96m_fck",	&omap_96m_fck,	CK_3XXX),
-	CLK(NULL,	"cm_96m_fck",	&cm_96m_fck,	CK_3XXX),
-	CLK(NULL,	"omap_54m_fck",	&omap_54m_fck,	CK_3XXX),
-	CLK(NULL,	"omap_48m_fck",	&omap_48m_fck,	CK_3XXX),
-	CLK(NULL,	"omap_12m_fck",	&omap_12m_fck,	CK_3XXX),
-	CLK(NULL,	"dpll4_m2_ck",	&dpll4_m2_ck,	CK_3XXX),
-	CLK(NULL,	"dpll4_m2x2_ck", &dpll4_m2x2_ck, CK_3XXX),
-	CLK(NULL,	"dpll4_m3_ck",	&dpll4_m3_ck,	CK_3XXX),
-	CLK(NULL,	"dpll4_m3x2_ck", &dpll4_m3x2_ck, CK_3XXX),
-	CLK(NULL,	"dpll4_m4_ck",	&dpll4_m4_ck,	CK_3XXX),
-	CLK(NULL,	"dpll4_m4x2_ck", &dpll4_m4x2_ck, CK_3XXX),
-	CLK(NULL,	"dpll4_m5_ck",	&dpll4_m5_ck,	CK_3XXX),
-	CLK(NULL,	"dpll4_m5x2_ck", &dpll4_m5x2_ck, CK_3XXX),
-	CLK(NULL,	"dpll4_m6_ck",	&dpll4_m6_ck,	CK_3XXX),
-	CLK(NULL,	"dpll4_m6x2_ck", &dpll4_m6x2_ck, CK_3XXX),
-	CLK("etb",	"emu_per_alwon_ck", &emu_per_alwon_ck, CK_3XXX),
-	CLK(NULL,	"dpll5_ck",	&dpll5_ck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK(NULL,	"dpll5_m2_ck",	&dpll5_m2_ck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK(NULL,	"clkout2_src_ck", &clkout2_src_ck, CK_3XXX),
-	CLK(NULL,	"sys_clkout2",	&sys_clkout2,	CK_3XXX),
-	CLK(NULL,	"corex2_fck",	&corex2_fck,	CK_3XXX),
-	CLK(NULL,	"dpll1_fck",	&dpll1_fck,	CK_3XXX),
-	CLK(NULL,	"mpu_ck",	&mpu_ck,	CK_3XXX),
-	CLK(NULL,	"arm_fck",	&arm_fck,	CK_3XXX),
-	CLK("etb",	"emu_mpu_alwon_ck", &emu_mpu_alwon_ck, CK_3XXX),
-	CLK(NULL,	"dpll2_fck",	&dpll2_fck,	CK_34XX | CK_36XX),
-	CLK(NULL,	"iva2_ck",	&iva2_ck,	CK_34XX | CK_36XX),
-	CLK(NULL,	"l3_ick",	&l3_ick,	CK_3XXX),
-	CLK(NULL,	"l4_ick",	&l4_ick,	CK_3XXX),
-	CLK(NULL,	"rm_ick",	&rm_ick,	CK_3XXX),
-	CLK(NULL,	"gfx_l3_ck",	&gfx_l3_ck,	CK_3430ES1),
-	CLK(NULL,	"gfx_l3_fck",	&gfx_l3_fck,	CK_3430ES1),
-	CLK(NULL,	"gfx_l3_ick",	&gfx_l3_ick,	CK_3430ES1),
-	CLK(NULL,	"gfx_cg1_ck",	&gfx_cg1_ck,	CK_3430ES1),
-	CLK(NULL,	"gfx_cg2_ck",	&gfx_cg2_ck,	CK_3430ES1),
-	CLK(NULL,	"sgx_fck",	&sgx_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK(NULL,	"sgx_ick",	&sgx_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK(NULL,	"d2d_26m_fck",	&d2d_26m_fck,	CK_3430ES1),
-	CLK(NULL,	"modem_fck",	&modem_fck,	CK_34XX | CK_36XX),
-	CLK(NULL,	"sad2d_ick",	&sad2d_ick,	CK_34XX | CK_36XX),
-	CLK(NULL,	"mad2d_ick",	&mad2d_ick,	CK_34XX | CK_36XX),
-	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_3XXX),
-	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_3XXX),
-	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("usbhs_omap",	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("usbhs_tll",	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK(NULL,	"core_96m_fck",	&core_96m_fck,	CK_3XXX),
-	CLK(NULL,	"mmchs3_fck",	&mmchs3_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK(NULL,	"mmchs2_fck",	&mmchs2_fck,	CK_3XXX),
-	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_34XX | CK_36XX),
-	CLK(NULL,	"mmchs1_fck",	&mmchs1_fck,	CK_3XXX),
-	CLK(NULL,	"i2c3_fck",	&i2c3_fck,	CK_3XXX),
-	CLK(NULL,	"i2c2_fck",	&i2c2_fck,	CK_3XXX),
-	CLK(NULL,	"i2c1_fck",	&i2c1_fck,	CK_3XXX),
-	CLK(NULL,	"mcbsp5_fck",	&mcbsp5_fck,	CK_3XXX),
-	CLK(NULL,	"mcbsp1_fck",	&mcbsp1_fck,	CK_3XXX),
-	CLK(NULL,	"core_48m_fck",	&core_48m_fck,	CK_3XXX),
-	CLK(NULL,	"mcspi4_fck",	&mcspi4_fck,	CK_3XXX),
-	CLK(NULL,	"mcspi3_fck",	&mcspi3_fck,	CK_3XXX),
-	CLK(NULL,	"mcspi2_fck",	&mcspi2_fck,	CK_3XXX),
-	CLK(NULL,	"mcspi1_fck",	&mcspi1_fck,	CK_3XXX),
-	CLK(NULL,	"uart2_fck",	&uart2_fck,	CK_3XXX),
-	CLK(NULL,	"uart1_fck",	&uart1_fck,	CK_3XXX),
-	CLK(NULL,	"fshostusb_fck", &fshostusb_fck, CK_3430ES1),
-	CLK(NULL,	"core_12m_fck",	&core_12m_fck,	CK_3XXX),
-	CLK("omap_hdq.0",	"fck",	&hdq_fck,	CK_3XXX),
-	CLK(NULL,	"hdq_fck",	&hdq_fck,	CK_3XXX),
-	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck_3430es1,	CK_3430ES1),
-	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck_3430es2,	CK_3430ES2PLUS | CK_36XX),
-	CLK(NULL,	"ssi_sst_fck",	&ssi_sst_fck_3430es1,	CK_3430ES1),
-	CLK(NULL,	"ssi_sst_fck",	&ssi_sst_fck_3430es2,	CK_3430ES2PLUS | CK_36XX),
-	CLK(NULL,	"core_l3_ick",	&core_l3_ick,	CK_3XXX),
-	CLK("musb-omap2430",	"ick",	&hsotgusb_ick_3430es1,	CK_3430ES1),
-	CLK("musb-omap2430",	"ick",	&hsotgusb_ick_3430es2,	CK_3430ES2PLUS | CK_36XX),
-	CLK(NULL,	"hsotgusb_ick",	&hsotgusb_ick_3430es1,	CK_3430ES1),
-	CLK(NULL,	"hsotgusb_ick",	&hsotgusb_ick_3430es2,	CK_3430ES2PLUS | CK_36XX),
-	CLK(NULL,	"sdrc_ick",	&sdrc_ick,	CK_3XXX),
-	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_3XXX),
-	CLK(NULL,	"security_l3_ick", &security_l3_ick, CK_34XX | CK_36XX),
-	CLK(NULL,	"pka_ick",	&pka_ick,	CK_34XX | CK_36XX),
-	CLK(NULL,	"core_l4_ick",	&core_l4_ick,	CK_3XXX),
-	CLK(NULL,	"usbtll_ick",	&usbtll_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("usbhs_omap",	"usbtll_ick",	&usbtll_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("usbhs_tll",	"usbtll_ick",	&usbtll_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("omap_hsmmc.2",	"ick",	&mmchs3_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK(NULL,	"mmchs3_ick",	&mmchs3_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK(NULL,	"icr_ick",	&icr_ick,	CK_34XX | CK_36XX),
-	CLK("omap-aes",	"ick",	&aes2_ick,	CK_34XX | CK_36XX),
-	CLK("omap-sham",	"ick",	&sha12_ick,	CK_34XX | CK_36XX),
-	CLK(NULL,	"des2_ick",	&des2_ick,	CK_34XX | CK_36XX),
-	CLK("omap_hsmmc.1",	"ick",	&mmchs2_ick,	CK_3XXX),
-	CLK("omap_hsmmc.0",	"ick",	&mmchs1_ick,	CK_3XXX),
-	CLK(NULL,	"mmchs2_ick",	&mmchs2_ick,	CK_3XXX),
-	CLK(NULL,	"mmchs1_ick",	&mmchs1_ick,	CK_3XXX),
-	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_34XX | CK_36XX),
-	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_3XXX),
-	CLK(NULL,	"hdq_ick",	&hdq_ick,	CK_3XXX),
-	CLK("omap2_mcspi.4", "ick",	&mcspi4_ick,	CK_3XXX),
-	CLK("omap2_mcspi.3", "ick",	&mcspi3_ick,	CK_3XXX),
-	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick,	CK_3XXX),
-	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick,	CK_3XXX),
-	CLK(NULL,	"mcspi4_ick",	&mcspi4_ick,	CK_3XXX),
-	CLK(NULL,	"mcspi3_ick",	&mcspi3_ick,	CK_3XXX),
-	CLK(NULL,	"mcspi2_ick",	&mcspi2_ick,	CK_3XXX),
-	CLK(NULL,	"mcspi1_ick",	&mcspi1_ick,	CK_3XXX),
-	CLK("omap_i2c.3", "ick",	&i2c3_ick,	CK_3XXX),
-	CLK("omap_i2c.2", "ick",	&i2c2_ick,	CK_3XXX),
-	CLK("omap_i2c.1", "ick",	&i2c1_ick,	CK_3XXX),
-	CLK(NULL,	"i2c3_ick",	&i2c3_ick,	CK_3XXX),
-	CLK(NULL,	"i2c2_ick",	&i2c2_ick,	CK_3XXX),
-	CLK(NULL,	"i2c1_ick",	&i2c1_ick,	CK_3XXX),
-	CLK(NULL,	"uart2_ick",	&uart2_ick,	CK_3XXX),
-	CLK(NULL,	"uart1_ick",	&uart1_ick,	CK_3XXX),
-	CLK(NULL,	"gpt11_ick",	&gpt11_ick,	CK_3XXX),
-	CLK(NULL,	"gpt10_ick",	&gpt10_ick,	CK_3XXX),
-	CLK("omap-mcbsp.5", "ick",	&mcbsp5_ick,	CK_3XXX),
-	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_3XXX),
-	CLK(NULL,	"mcbsp5_ick",	&mcbsp5_ick,	CK_3XXX),
-	CLK(NULL,	"mcbsp1_ick",	&mcbsp1_ick,	CK_3XXX),
-	CLK(NULL,	"fac_ick",	&fac_ick,	CK_3430ES1),
-	CLK(NULL,	"mailboxes_ick", &mailboxes_ick, CK_34XX | CK_36XX),
-	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_3XXX),
-	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_34XX | CK_36XX),
-	CLK(NULL,	"ssi_ick",	&ssi_ick_3430es1,	CK_3430ES1),
-	CLK(NULL,	"ssi_ick",	&ssi_ick_3430es2,	CK_3430ES2PLUS | CK_36XX),
-	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick,	CK_3430ES1),
-	CLK(NULL,	"security_l4_ick2", &security_l4_ick2, CK_34XX | CK_36XX),
-	CLK(NULL,	"aes1_ick",	&aes1_ick,	CK_34XX | CK_36XX),
-	CLK("omap_rng",	"ick",		&rng_ick,	CK_34XX | CK_36XX),
-	CLK(NULL,	"sha11_ick",	&sha11_ick,	CK_34XX | CK_36XX),
-	CLK(NULL,	"des1_ick",	&des1_ick,	CK_34XX | CK_36XX),
-	CLK(NULL,	"dss1_alwon_fck",		&dss1_alwon_fck_3430es1, CK_3430ES1),
-	CLK(NULL,	"dss1_alwon_fck",		&dss1_alwon_fck_3430es2, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK(NULL,	"dss_tv_fck",	&dss_tv_fck,	CK_3XXX),
-	CLK(NULL,	"dss_96m_fck",	&dss_96m_fck,	CK_3XXX),
-	CLK(NULL,	"dss2_alwon_fck",	&dss2_alwon_fck, CK_3XXX),
-	CLK("omapdss_dss",	"ick",		&dss_ick_3430es1,	CK_3430ES1),
-	CLK(NULL,	"dss_ick",		&dss_ick_3430es1,	CK_3430ES1),
-	CLK("omapdss_dss",	"ick",		&dss_ick_3430es2,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK(NULL,	"dss_ick",		&dss_ick_3430es2,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK(NULL,	"cam_mclk",	&cam_mclk,	CK_34XX | CK_36XX),
-	CLK(NULL,	"cam_ick",	&cam_ick,	CK_34XX | CK_36XX),
-	CLK(NULL,	"csi2_96m_fck",	&csi2_96m_fck,	CK_34XX | CK_36XX),
-	CLK(NULL,	"usbhost_120m_fck", &usbhost_120m_fck, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK(NULL,	"usbhost_48m_fck", &usbhost_48m_fck, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK(NULL,	"usbhost_ick",	&usbhost_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK("usbhs_omap",	"usbhost_ick",	&usbhost_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
-	CLK(NULL,	"utmi_p1_gfclk",	&dummy_ck,	CK_3XXX),
-	CLK(NULL,	"utmi_p2_gfclk",	&dummy_ck,	CK_3XXX),
-	CLK(NULL,	"xclk60mhsp1_ck",	&dummy_ck,	CK_3XXX),
-	CLK(NULL,	"xclk60mhsp2_ck",	&dummy_ck,	CK_3XXX),
-	CLK(NULL,	"usb_host_hs_utmi_p1_clk",	&dummy_ck,	CK_3XXX),
-	CLK(NULL,	"usb_host_hs_utmi_p2_clk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_omap",	"usb_tll_hs_usb_ch0_clk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_omap",	"usb_tll_hs_usb_ch1_clk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_tll",	"usb_tll_hs_usb_ch0_clk",	&dummy_ck,	CK_3XXX),
-	CLK("usbhs_tll",	"usb_tll_hs_usb_ch1_clk",	&dummy_ck,	CK_3XXX),
-	CLK(NULL,	"init_60m_fclk",	&dummy_ck,	CK_3XXX),
-	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2PLUS | CK_36XX),
-	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_3XXX),
-	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_3XXX),
-	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_3XXX),
-	CLK(NULL,	"wdt2_fck",		&wdt2_fck,	CK_3XXX),
-	CLK(NULL,	"wkup_l4_ick",	&wkup_l4_ick,	CK_34XX | CK_36XX),
-	CLK(NULL,	"usim_ick",	&usim_ick,	CK_3430ES2PLUS | CK_36XX),
-	CLK("omap_wdt",	"ick",		&wdt2_ick,	CK_3XXX),
-	CLK(NULL,	"wdt2_ick",	&wdt2_ick,	CK_3XXX),
-	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_3XXX),
-	CLK(NULL,	"gpio1_ick",	&gpio1_ick,	CK_3XXX),
-	CLK(NULL,	"omap_32ksync_ick", &omap_32ksync_ick, CK_3XXX),
-	CLK(NULL,	"gpt12_ick",	&gpt12_ick,	CK_3XXX),
-	CLK(NULL,	"gpt1_ick",	&gpt1_ick,	CK_3XXX),
-	CLK(NULL,	"per_96m_fck",	&per_96m_fck,	CK_3XXX),
-	CLK(NULL,	"per_48m_fck",	&per_48m_fck,	CK_3XXX),
-	CLK(NULL,	"uart3_fck",	&uart3_fck,	CK_3XXX),
-	CLK(NULL,	"uart4_fck",	&uart4_fck,	CK_36XX),
-	CLK(NULL,	"uart4_fck",	&uart4_fck_am35xx, CK_AM35XX),
-	CLK(NULL,	"gpt2_fck",	&gpt2_fck,	CK_3XXX),
-	CLK(NULL,	"gpt3_fck",	&gpt3_fck,	CK_3XXX),
-	CLK(NULL,	"gpt4_fck",	&gpt4_fck,	CK_3XXX),
-	CLK(NULL,	"gpt5_fck",	&gpt5_fck,	CK_3XXX),
-	CLK(NULL,	"gpt6_fck",	&gpt6_fck,	CK_3XXX),
-	CLK(NULL,	"gpt7_fck",	&gpt7_fck,	CK_3XXX),
-	CLK(NULL,	"gpt8_fck",	&gpt8_fck,	CK_3XXX),
-	CLK(NULL,	"gpt9_fck",	&gpt9_fck,	CK_3XXX),
-	CLK(NULL,	"per_32k_alwon_fck", &per_32k_alwon_fck, CK_3XXX),
-	CLK(NULL,	"gpio6_dbck",	&gpio6_dbck,	CK_3XXX),
-	CLK(NULL,	"gpio5_dbck",	&gpio5_dbck,	CK_3XXX),
-	CLK(NULL,	"gpio4_dbck",	&gpio4_dbck,	CK_3XXX),
-	CLK(NULL,	"gpio3_dbck",	&gpio3_dbck,	CK_3XXX),
-	CLK(NULL,	"gpio2_dbck",	&gpio2_dbck,	CK_3XXX),
-	CLK(NULL,	"wdt3_fck",	&wdt3_fck,	CK_3XXX),
-	CLK(NULL,	"per_l4_ick",	&per_l4_ick,	CK_3XXX),
-	CLK(NULL,	"gpio6_ick",	&gpio6_ick,	CK_3XXX),
-	CLK(NULL,	"gpio5_ick",	&gpio5_ick,	CK_3XXX),
-	CLK(NULL,	"gpio4_ick",	&gpio4_ick,	CK_3XXX),
-	CLK(NULL,	"gpio3_ick",	&gpio3_ick,	CK_3XXX),
-	CLK(NULL,	"gpio2_ick",	&gpio2_ick,	CK_3XXX),
-	CLK(NULL,	"wdt3_ick",	&wdt3_ick,	CK_3XXX),
-	CLK(NULL,	"uart3_ick",	&uart3_ick,	CK_3XXX),
-	CLK(NULL,	"uart4_ick",	&uart4_ick,	CK_36XX),
-	CLK(NULL,	"gpt9_ick",	&gpt9_ick,	CK_3XXX),
-	CLK(NULL,	"gpt8_ick",	&gpt8_ick,	CK_3XXX),
-	CLK(NULL,	"gpt7_ick",	&gpt7_ick,	CK_3XXX),
-	CLK(NULL,	"gpt6_ick",	&gpt6_ick,	CK_3XXX),
-	CLK(NULL,	"gpt5_ick",	&gpt5_ick,	CK_3XXX),
-	CLK(NULL,	"gpt4_ick",	&gpt4_ick,	CK_3XXX),
-	CLK(NULL,	"gpt3_ick",	&gpt3_ick,	CK_3XXX),
-	CLK(NULL,	"gpt2_ick",	&gpt2_ick,	CK_3XXX),
-	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick,	CK_3XXX),
-	CLK("omap-mcbsp.3", "ick",	&mcbsp3_ick,	CK_3XXX),
-	CLK("omap-mcbsp.4", "ick",	&mcbsp4_ick,	CK_3XXX),
-	CLK(NULL,	"mcbsp4_ick",	&mcbsp2_ick,	CK_3XXX),
-	CLK(NULL,	"mcbsp3_ick",	&mcbsp3_ick,	CK_3XXX),
-	CLK(NULL,	"mcbsp2_ick",	&mcbsp4_ick,	CK_3XXX),
-	CLK(NULL,	"mcbsp2_fck",	&mcbsp2_fck,	CK_3XXX),
-	CLK(NULL,	"mcbsp3_fck",	&mcbsp3_fck,	CK_3XXX),
-	CLK(NULL,	"mcbsp4_fck",	&mcbsp4_fck,	CK_3XXX),
-	CLK("etb",	"emu_src_ck",	&emu_src_ck,	CK_3XXX),
-	CLK(NULL,	"emu_src_ck",	&emu_src_ck,	CK_3XXX),
-	CLK(NULL,	"pclk_fck",	&pclk_fck,	CK_3XXX),
-	CLK(NULL,	"pclkx2_fck",	&pclkx2_fck,	CK_3XXX),
-	CLK(NULL,	"atclk_fck",	&atclk_fck,	CK_3XXX),
-	CLK(NULL,	"traceclk_src_fck", &traceclk_src_fck, CK_3XXX),
-	CLK(NULL,	"traceclk_fck",	&traceclk_fck,	CK_3XXX),
-	CLK(NULL,	"sr1_fck",	&sr1_fck,	CK_34XX | CK_36XX),
-	CLK(NULL,	"sr2_fck",	&sr2_fck,	CK_34XX | CK_36XX),
-	CLK(NULL,	"sr_l4_ick",	&sr_l4_ick,	CK_34XX | CK_36XX),
-	CLK(NULL,	"secure_32k_fck", &secure_32k_fck, CK_3XXX),
-	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_3XXX),
-	CLK(NULL,	"wdt1_fck",	&wdt1_fck,	CK_3XXX),
-	CLK(NULL,	"ipss_ick",	&ipss_ick,	CK_AM35XX),
-	CLK(NULL,	"rmii_ck",	&rmii_ck,	CK_AM35XX),
-	CLK(NULL,	"pclk_ck",	&pclk_ck,	CK_AM35XX),
-	CLK(NULL,	"emac_ick",	&emac_ick,	CK_AM35XX),
-	CLK(NULL,	"emac_fck",	&emac_fck,	CK_AM35XX),
-	CLK("davinci_emac.0",	NULL,	&emac_ick,	CK_AM35XX),
-	CLK("davinci_mdio.0",	NULL,	&emac_fck,	CK_AM35XX),
-	CLK("vpfe-capture",	"master",	&vpfe_ick,	CK_AM35XX),
-	CLK("vpfe-capture",	"slave",	&vpfe_fck,	CK_AM35XX),
-	CLK(NULL,	"hsotgusb_ick",		&hsotgusb_ick_am35xx,	CK_AM35XX),
-	CLK(NULL,	"hsotgusb_fck",		&hsotgusb_fck_am35xx,	CK_AM35XX),
-	CLK(NULL,	"hecc_ck",	&hecc_ck,	CK_AM35XX),
-	CLK(NULL,	"uart4_ick",	&uart4_ick_am35xx,	CK_AM35XX),
-	CLK(NULL,	"timer_32k_ck",	&omap_32k_fck,  CK_3XXX),
-	CLK(NULL,	"timer_sys_ck",	&sys_ck,	CK_3XXX),
-	CLK(NULL,	"cpufreq_ck",	&dpll1_ck,	CK_3XXX),
+	CLK(NULL,	"apb_pclk",	&dummy_apb_pclk),
+	CLK(NULL,	"omap_32k_fck",	&omap_32k_fck),
+	CLK(NULL,	"virt_12m_ck",	&virt_12m_ck),
+	CLK(NULL,	"virt_13m_ck",	&virt_13m_ck),
+	CLK(NULL,	"virt_19200000_ck", &virt_19200000_ck),
+	CLK(NULL,	"virt_26000000_ck", &virt_26000000_ck),
+	CLK(NULL,	"virt_38_4m_ck", &virt_38_4m_ck),
+	CLK(NULL,	"osc_sys_ck",	&osc_sys_ck),
+	CLK("twl",	"fck",		&osc_sys_ck),
+	CLK(NULL,	"sys_ck",	&sys_ck),
+	CLK(NULL,	"omap_96m_alwon_fck", &omap_96m_alwon_fck),
+	CLK("etb",	"emu_core_alwon_ck", &emu_core_alwon_ck),
+	CLK(NULL,	"sys_altclk",	&sys_altclk),
+	CLK(NULL,	"mcbsp_clks",	&mcbsp_clks),
+	CLK(NULL,	"sys_clkout1",	&sys_clkout1),
+	CLK(NULL,	"dpll1_ck",	&dpll1_ck),
+	CLK(NULL,	"dpll1_x2_ck",	&dpll1_x2_ck),
+	CLK(NULL,	"dpll1_x2m2_ck", &dpll1_x2m2_ck),
+	CLK(NULL,	"dpll3_ck",	&dpll3_ck),
+	CLK(NULL,	"core_ck",	&core_ck),
+	CLK(NULL,	"dpll3_x2_ck",	&dpll3_x2_ck),
+	CLK(NULL,	"dpll3_m2_ck",	&dpll3_m2_ck),
+	CLK(NULL,	"dpll3_m2x2_ck", &dpll3_m2x2_ck),
+	CLK(NULL,	"dpll3_m3_ck",	&dpll3_m3_ck),
+	CLK(NULL,	"dpll3_m3x2_ck", &dpll3_m3x2_ck),
+	CLK(NULL,	"dpll4_ck",	&dpll4_ck),
+	CLK(NULL,	"dpll4_x2_ck",	&dpll4_x2_ck),
+	CLK(NULL,	"omap_96m_fck",	&omap_96m_fck),
+	CLK(NULL,	"cm_96m_fck",	&cm_96m_fck),
+	CLK(NULL,	"omap_54m_fck",	&omap_54m_fck),
+	CLK(NULL,	"omap_48m_fck",	&omap_48m_fck),
+	CLK(NULL,	"omap_12m_fck",	&omap_12m_fck),
+	CLK(NULL,	"dpll4_m2_ck",	&dpll4_m2_ck),
+	CLK(NULL,	"dpll4_m2x2_ck", &dpll4_m2x2_ck),
+	CLK(NULL,	"dpll4_m3_ck",	&dpll4_m3_ck),
+	CLK(NULL,	"dpll4_m3x2_ck", &dpll4_m3x2_ck),
+	CLK(NULL,	"dpll4_m4_ck",	&dpll4_m4_ck),
+	CLK(NULL,	"dpll4_m4x2_ck", &dpll4_m4x2_ck),
+	CLK(NULL,	"dpll4_m5_ck",	&dpll4_m5_ck),
+	CLK(NULL,	"dpll4_m5x2_ck", &dpll4_m5x2_ck),
+	CLK(NULL,	"dpll4_m6_ck",	&dpll4_m6_ck),
+	CLK(NULL,	"dpll4_m6x2_ck", &dpll4_m6x2_ck),
+	CLK("etb",	"emu_per_alwon_ck", &emu_per_alwon_ck),
+	CLK(NULL,	"clkout2_src_ck", &clkout2_src_ck),
+	CLK(NULL,	"sys_clkout2",	&sys_clkout2),
+	CLK(NULL,	"corex2_fck",	&corex2_fck),
+	CLK(NULL,	"dpll1_fck",	&dpll1_fck),
+	CLK(NULL,	"mpu_ck",	&mpu_ck),
+	CLK(NULL,	"arm_fck",	&arm_fck),
+	CLK("etb",	"emu_mpu_alwon_ck", &emu_mpu_alwon_ck),
+	CLK(NULL,	"l3_ick",	&l3_ick),
+	CLK(NULL,	"l4_ick",	&l4_ick),
+	CLK(NULL,	"rm_ick",	&rm_ick),
+	CLK(NULL,	"gpt10_fck",	&gpt10_fck),
+	CLK(NULL,	"gpt11_fck",	&gpt11_fck),
+	CLK(NULL,	"core_96m_fck",	&core_96m_fck),
+	CLK(NULL,	"mmchs2_fck",	&mmchs2_fck),
+	CLK(NULL,	"mmchs1_fck",	&mmchs1_fck),
+	CLK(NULL,	"i2c3_fck",	&i2c3_fck),
+	CLK(NULL,	"i2c2_fck",	&i2c2_fck),
+	CLK(NULL,	"i2c1_fck",	&i2c1_fck),
+	CLK(NULL,	"mcbsp5_fck",	&mcbsp5_fck),
+	CLK(NULL,	"mcbsp1_fck",	&mcbsp1_fck),
+	CLK(NULL,	"core_48m_fck",	&core_48m_fck),
+	CLK(NULL,	"mcspi4_fck",	&mcspi4_fck),
+	CLK(NULL,	"mcspi3_fck",	&mcspi3_fck),
+	CLK(NULL,	"mcspi2_fck",	&mcspi2_fck),
+	CLK(NULL,	"mcspi1_fck",	&mcspi1_fck),
+	CLK(NULL,	"uart2_fck",	&uart2_fck),
+	CLK(NULL,	"uart1_fck",	&uart1_fck),
+	CLK(NULL,	"core_12m_fck",	&core_12m_fck),
+	CLK("omap_hdq.0",	"fck",	&hdq_fck),
+	CLK(NULL,	"hdq_fck",	&hdq_fck),
+	CLK(NULL,	"core_l3_ick",	&core_l3_ick),
+	CLK(NULL,	"sdrc_ick",	&sdrc_ick),
+	CLK(NULL,	"gpmc_fck",	&gpmc_fck),
+	CLK(NULL,	"core_l4_ick",	&core_l4_ick),
+	CLK("omap_hsmmc.1",	"ick",	&mmchs2_ick),
+	CLK("omap_hsmmc.0",	"ick",	&mmchs1_ick),
+	CLK(NULL,	"mmchs2_ick",	&mmchs2_ick),
+	CLK(NULL,	"mmchs1_ick",	&mmchs1_ick),
+	CLK("omap_hdq.0", "ick",	&hdq_ick),
+	CLK(NULL,	"hdq_ick",	&hdq_ick),
+	CLK("omap2_mcspi.4", "ick",	&mcspi4_ick),
+	CLK("omap2_mcspi.3", "ick",	&mcspi3_ick),
+	CLK("omap2_mcspi.2", "ick",	&mcspi2_ick),
+	CLK("omap2_mcspi.1", "ick",	&mcspi1_ick),
+	CLK(NULL,	"mcspi4_ick",	&mcspi4_ick),
+	CLK(NULL,	"mcspi3_ick",	&mcspi3_ick),
+	CLK(NULL,	"mcspi2_ick",	&mcspi2_ick),
+	CLK(NULL,	"mcspi1_ick",	&mcspi1_ick),
+	CLK("omap_i2c.3", "ick",	&i2c3_ick),
+	CLK("omap_i2c.2", "ick",	&i2c2_ick),
+	CLK("omap_i2c.1", "ick",	&i2c1_ick),
+	CLK(NULL,	"i2c3_ick",	&i2c3_ick),
+	CLK(NULL,	"i2c2_ick",	&i2c2_ick),
+	CLK(NULL,	"i2c1_ick",	&i2c1_ick),
+	CLK(NULL,	"uart2_ick",	&uart2_ick),
+	CLK(NULL,	"uart1_ick",	&uart1_ick),
+	CLK(NULL,	"gpt11_ick",	&gpt11_ick),
+	CLK(NULL,	"gpt10_ick",	&gpt10_ick),
+	CLK("omap-mcbsp.5", "ick",	&mcbsp5_ick),
+	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick),
+	CLK(NULL,	"mcbsp5_ick",	&mcbsp5_ick),
+	CLK(NULL,	"mcbsp1_ick",	&mcbsp1_ick),
+	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick),
+	CLK(NULL,	"dss_tv_fck",	&dss_tv_fck),
+	CLK(NULL,	"dss_96m_fck",	&dss_96m_fck),
+	CLK(NULL,	"dss2_alwon_fck",	&dss2_alwon_fck),
+	CLK(NULL,	"utmi_p1_gfclk",	&dummy_ck),
+	CLK(NULL,	"utmi_p2_gfclk",	&dummy_ck),
+	CLK(NULL,	"xclk60mhsp1_ck",	&dummy_ck),
+	CLK(NULL,	"xclk60mhsp2_ck",	&dummy_ck),
+	CLK(NULL,	"usb_host_hs_utmi_p1_clk",	&dummy_ck),
+	CLK(NULL,	"usb_host_hs_utmi_p2_clk",	&dummy_ck),
+	CLK("usbhs_omap",	"usb_tll_hs_usb_ch0_clk",	&dummy_ck),
+	CLK("usbhs_omap",	"usb_tll_hs_usb_ch1_clk",	&dummy_ck),
+	CLK("usbhs_tll",	"usb_tll_hs_usb_ch0_clk",	&dummy_ck),
+	CLK("usbhs_tll",	"usb_tll_hs_usb_ch1_clk",	&dummy_ck),
+	CLK(NULL,	"init_60m_fclk",	&dummy_ck),
+	CLK(NULL,	"gpt1_fck",	&gpt1_fck),
+	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck),
+	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck),
+	CLK(NULL,	"wdt2_fck",		&wdt2_fck),
+	CLK("omap_wdt",	"ick",		&wdt2_ick),
+	CLK(NULL,	"wdt2_ick",	&wdt2_ick),
+	CLK(NULL,	"wdt1_ick",	&wdt1_ick),
+	CLK(NULL,	"gpio1_ick",	&gpio1_ick),
+	CLK(NULL,	"omap_32ksync_ick", &omap_32ksync_ick),
+	CLK(NULL,	"gpt12_ick",	&gpt12_ick),
+	CLK(NULL,	"gpt1_ick",	&gpt1_ick),
+	CLK(NULL,	"per_96m_fck",	&per_96m_fck),
+	CLK(NULL,	"per_48m_fck",	&per_48m_fck),
+	CLK(NULL,	"uart3_fck",	&uart3_fck),
+	CLK(NULL,	"gpt2_fck",	&gpt2_fck),
+	CLK(NULL,	"gpt3_fck",	&gpt3_fck),
+	CLK(NULL,	"gpt4_fck",	&gpt4_fck),
+	CLK(NULL,	"gpt5_fck",	&gpt5_fck),
+	CLK(NULL,	"gpt6_fck",	&gpt6_fck),
+	CLK(NULL,	"gpt7_fck",	&gpt7_fck),
+	CLK(NULL,	"gpt8_fck",	&gpt8_fck),
+	CLK(NULL,	"gpt9_fck",	&gpt9_fck),
+	CLK(NULL,	"per_32k_alwon_fck", &per_32k_alwon_fck),
+	CLK(NULL,	"gpio6_dbck",	&gpio6_dbck),
+	CLK(NULL,	"gpio5_dbck",	&gpio5_dbck),
+	CLK(NULL,	"gpio4_dbck",	&gpio4_dbck),
+	CLK(NULL,	"gpio3_dbck",	&gpio3_dbck),
+	CLK(NULL,	"gpio2_dbck",	&gpio2_dbck),
+	CLK(NULL,	"wdt3_fck",	&wdt3_fck),
+	CLK(NULL,	"per_l4_ick",	&per_l4_ick),
+	CLK(NULL,	"gpio6_ick",	&gpio6_ick),
+	CLK(NULL,	"gpio5_ick",	&gpio5_ick),
+	CLK(NULL,	"gpio4_ick",	&gpio4_ick),
+	CLK(NULL,	"gpio3_ick",	&gpio3_ick),
+	CLK(NULL,	"gpio2_ick",	&gpio2_ick),
+	CLK(NULL,	"wdt3_ick",	&wdt3_ick),
+	CLK(NULL,	"uart3_ick",	&uart3_ick),
+	CLK(NULL,	"uart4_ick",	&uart4_ick),
+	CLK(NULL,	"gpt9_ick",	&gpt9_ick),
+	CLK(NULL,	"gpt8_ick",	&gpt8_ick),
+	CLK(NULL,	"gpt7_ick",	&gpt7_ick),
+	CLK(NULL,	"gpt6_ick",	&gpt6_ick),
+	CLK(NULL,	"gpt5_ick",	&gpt5_ick),
+	CLK(NULL,	"gpt4_ick",	&gpt4_ick),
+	CLK(NULL,	"gpt3_ick",	&gpt3_ick),
+	CLK(NULL,	"gpt2_ick",	&gpt2_ick),
+	CLK("omap-mcbsp.2", "ick",	&mcbsp2_ick),
+	CLK("omap-mcbsp.3", "ick",	&mcbsp3_ick),
+	CLK("omap-mcbsp.4", "ick",	&mcbsp4_ick),
+	CLK(NULL,	"mcbsp4_ick",	&mcbsp2_ick),
+	CLK(NULL,	"mcbsp3_ick",	&mcbsp3_ick),
+	CLK(NULL,	"mcbsp2_ick",	&mcbsp4_ick),
+	CLK(NULL,	"mcbsp2_fck",	&mcbsp2_fck),
+	CLK(NULL,	"mcbsp3_fck",	&mcbsp3_fck),
+	CLK(NULL,	"mcbsp4_fck",	&mcbsp4_fck),
+	CLK("etb",	"emu_src_ck",	&emu_src_ck),
+	CLK(NULL,	"emu_src_ck",	&emu_src_ck),
+	CLK(NULL,	"pclk_fck",	&pclk_fck),
+	CLK(NULL,	"pclkx2_fck",	&pclkx2_fck),
+	CLK(NULL,	"atclk_fck",	&atclk_fck),
+	CLK(NULL,	"traceclk_src_fck", &traceclk_src_fck),
+	CLK(NULL,	"traceclk_fck",	&traceclk_fck),
+	CLK(NULL,	"secure_32k_fck", &secure_32k_fck),
+	CLK(NULL,	"gpt12_fck",	&gpt12_fck),
+	CLK(NULL,	"wdt1_fck",	&wdt1_fck),
+	CLK(NULL,	"timer_32k_ck",	&omap_32k_fck),
+	CLK(NULL,	"timer_sys_ck",	&sys_ck),
+	CLK(NULL,	"cpufreq_ck",	&dpll1_ck),
 };
 
 static const char *enable_init_clks[] = {
@@ -3504,8 +3540,27 @@ static const char *enable_init_clks[] = {
 
 int __init omap3xxx_clk_init(void)
 {
-	struct omap_clk *c;
-	u32 cpu_clkflg = 0;
+	if (omap3_has_192mhz_clk())
+		omap_96m_alwon_fck = omap_96m_alwon_fck_3630;
+
+	if (cpu_is_omap3630()) {
+		dpll3_m3x2_ck = dpll3_m3x2_ck_3630;
+		dpll4_m2x2_ck = dpll4_m2x2_ck_3630;
+		dpll4_m3x2_ck = dpll4_m3x2_ck_3630;
+		dpll4_m4x2_ck = dpll4_m4x2_ck_3630;
+		dpll4_m5x2_ck = dpll4_m5x2_ck_3630;
+		dpll4_m6x2_ck = dpll4_m6x2_ck_3630;
+	}
+
+	/*
+	 * XXX This type of dynamic rewriting of the clock tree is
+	 * deprecated and should be revised soon.
+	 */
+	if (cpu_is_omap3630())
+		dpll4_dd = dpll4_dd_3630;
+	else
+		dpll4_dd = dpll4_dd_34xx;
+
 
 	/*
 	 * 3505 must be tested before 3517, since 3517 returns true
@@ -3515,13 +3570,20 @@ int __init omap3xxx_clk_init(void)
 	 */
 	if (soc_is_am35xx()) {
 		cpu_mask = RATE_IN_34XX;
-		cpu_clkflg = CK_AM35XX;
+		omap_clocks_register(am35xx_clks, ARRAY_SIZE(am35xx_clks));
+		omap_clocks_register(omap36xx_am35xx_omap3430es2plus_clks,
+				     ARRAY_SIZE(omap36xx_am35xx_omap3430es2plus_clks));
+		omap_clocks_register(omap3xxx_clks, ARRAY_SIZE(omap3xxx_clks));
 	} else if (cpu_is_omap3630()) {
 		cpu_mask = (RATE_IN_34XX | RATE_IN_36XX);
-		cpu_clkflg = CK_36XX;
-	} else if (cpu_is_ti816x()) {
-		cpu_mask = RATE_IN_TI816X;
-		cpu_clkflg = CK_TI816X;
+		omap_clocks_register(omap36xx_clks, ARRAY_SIZE(omap36xx_clks));
+		omap_clocks_register(omap36xx_omap3430es2plus_clks,
+				     ARRAY_SIZE(omap36xx_omap3430es2plus_clks));
+		omap_clocks_register(omap34xx_omap36xx_clks,
+				     ARRAY_SIZE(omap34xx_omap36xx_clks));
+		omap_clocks_register(omap36xx_am35xx_omap3430es2plus_clks,
+				     ARRAY_SIZE(omap36xx_am35xx_omap3430es2plus_clks));
+		omap_clocks_register(omap3xxx_clks, ARRAY_SIZE(omap3xxx_clks));
 	} else if (soc_is_am33xx()) {
 		cpu_mask = RATE_IN_AM33XX;
 	} else if (cpu_is_ti814x()) {
@@ -3529,49 +3591,32 @@ int __init omap3xxx_clk_init(void)
 	} else if (cpu_is_omap34xx()) {
 		if (omap_rev() == OMAP3430_REV_ES1_0) {
 			cpu_mask = RATE_IN_3430ES1;
-			cpu_clkflg = CK_3430ES1;
+			omap_clocks_register(omap3430es1_clks,
+					     ARRAY_SIZE(omap3430es1_clks));
+			omap_clocks_register(omap34xx_omap36xx_clks,
+					     ARRAY_SIZE(omap34xx_omap36xx_clks));
+			omap_clocks_register(omap3xxx_clks,
+					     ARRAY_SIZE(omap3xxx_clks));
 		} else {
 			/*
 			 * Assume that anything that we haven't matched yet
 			 * has 3430ES2-type clocks.
 			 */
 			cpu_mask = RATE_IN_3430ES2PLUS;
-			cpu_clkflg = CK_3430ES2PLUS;
+			omap_clocks_register(omap34xx_omap36xx_clks,
+					     ARRAY_SIZE(omap34xx_omap36xx_clks));
+			omap_clocks_register(omap36xx_omap3430es2plus_clks,
+					     ARRAY_SIZE(omap36xx_omap3430es2plus_clks));
+			omap_clocks_register(omap36xx_am35xx_omap3430es2plus_clks,
+					     ARRAY_SIZE(omap36xx_am35xx_omap3430es2plus_clks));
+			omap_clocks_register(omap3xxx_clks,
+					     ARRAY_SIZE(omap3xxx_clks));
 		}
 	} else {
 		WARN(1, "clock: could not identify OMAP3 variant\n");
 	}
 
-	if (omap3_has_192mhz_clk())
-		omap_96m_alwon_fck = omap_96m_alwon_fck_3630;
-
-	if (cpu_is_omap3630()) {
-		dpll3_m3x2_ck = dpll3_m3x2_ck_3630;
-		dpll4_m2x2_ck = dpll4_m2x2_ck_3630;
-		dpll4_m3x2_ck = dpll4_m3x2_ck_3630;
-		dpll4_m4x2_ck = dpll4_m4x2_ck_3630;
-		dpll4_m5x2_ck = dpll4_m5x2_ck_3630;
-		dpll4_m6x2_ck = dpll4_m6x2_ck_3630;
-	}
-
-	/*
-	 * XXX This type of dynamic rewriting of the clock tree is
-	 * deprecated and should be revised soon.
-	 */
-	if (cpu_is_omap3630())
-		dpll4_dd = dpll4_dd_3630;
-	else
-		dpll4_dd = dpll4_dd_34xx;
-
-	for (c = omap3xxx_clks; c < omap3xxx_clks + ARRAY_SIZE(omap3xxx_clks);
-	     c++)
-		if (c->cpu & cpu_clkflg) {
-			clkdev_add(&c->lk);
-			if (!__clk_init(NULL, c->lk.clk))
-				omap2_init_clk_hw_omap_clocks(c->lk.clk);
-		}
-
-	omap2_clk_disable_autoidle_all();
+		omap2_clk_disable_autoidle_all();
 
 	omap2_clk_enable_init_clocks(enable_init_clks,
 				     ARRAY_SIZE(enable_init_clks));
diff --git a/arch/arm/mach-omap2/cclock44xx_data.c b/arch/arm/mach-omap2/cclock44xx_data.c
index cebe2b3..3126662 100644
--- a/arch/arm/mach-omap2/cclock44xx_data.c
+++ b/arch/arm/mach-omap2/cclock44xx_data.c
@@ -1402,283 +1402,284 @@ DEFINE_CLK_MUX(auxclkreq5_ck, auxclkreq_ck_parents, NULL, 0x0,
 	       0x0, NULL);
 
 /*
- * clkdev
+ * clocks specific to omap4460
  */
+static struct omap_clk omap446x_clks[] = {
+	CLK(NULL,	"div_ts_ck",			&div_ts_ck),
+	CLK(NULL,	"bandgap_ts_fclk",		&bandgap_ts_fclk),
+};
+
+/*
+ * clocks specific to omap4430
+ */
+static struct omap_clk omap443x_clks[] = {
+	CLK(NULL,	"bandgap_fclk",			&bandgap_fclk),
+};
 
+/*
+ * clocks common to omap44xx
+ */
 static struct omap_clk omap44xx_clks[] = {
-	CLK(NULL,	"extalt_clkin_ck",		&extalt_clkin_ck,	CK_443X),
-	CLK(NULL,	"pad_clks_src_ck",		&pad_clks_src_ck,	CK_443X),
-	CLK(NULL,	"pad_clks_ck",			&pad_clks_ck,	CK_443X),
-	CLK(NULL,	"pad_slimbus_core_clks_ck",	&pad_slimbus_core_clks_ck,	CK_443X),
-	CLK(NULL,	"secure_32k_clk_src_ck",	&secure_32k_clk_src_ck,	CK_443X),
-	CLK(NULL,	"slimbus_src_clk",		&slimbus_src_clk,	CK_443X),
-	CLK(NULL,	"slimbus_clk",			&slimbus_clk,	CK_443X),
-	CLK(NULL,	"sys_32k_ck",			&sys_32k_ck,	CK_443X),
-	CLK(NULL,	"virt_12000000_ck",		&virt_12000000_ck,	CK_443X),
-	CLK(NULL,	"virt_13000000_ck",		&virt_13000000_ck,	CK_443X),
-	CLK(NULL,	"virt_16800000_ck",		&virt_16800000_ck,	CK_443X),
-	CLK(NULL,	"virt_19200000_ck",		&virt_19200000_ck,	CK_443X),
-	CLK(NULL,	"virt_26000000_ck",		&virt_26000000_ck,	CK_443X),
-	CLK(NULL,	"virt_27000000_ck",		&virt_27000000_ck,	CK_443X),
-	CLK(NULL,	"virt_38400000_ck",		&virt_38400000_ck,	CK_443X),
-	CLK(NULL,	"sys_clkin_ck",			&sys_clkin_ck,	CK_443X),
-	CLK(NULL,	"tie_low_clock_ck",		&tie_low_clock_ck,	CK_443X),
-	CLK(NULL,	"utmi_phy_clkout_ck",		&utmi_phy_clkout_ck,	CK_443X),
-	CLK(NULL,	"xclk60mhsp1_ck",		&xclk60mhsp1_ck,	CK_443X),
-	CLK(NULL,	"xclk60mhsp2_ck",		&xclk60mhsp2_ck,	CK_443X),
-	CLK(NULL,	"xclk60motg_ck",		&xclk60motg_ck,	CK_443X),
-	CLK(NULL,	"abe_dpll_bypass_clk_mux_ck",	&abe_dpll_bypass_clk_mux_ck,	CK_443X),
-	CLK(NULL,	"abe_dpll_refclk_mux_ck",	&abe_dpll_refclk_mux_ck,	CK_443X),
-	CLK(NULL,	"dpll_abe_ck",			&dpll_abe_ck,	CK_443X),
-	CLK(NULL,	"dpll_abe_x2_ck",		&dpll_abe_x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_abe_m2x2_ck",		&dpll_abe_m2x2_ck,	CK_443X),
-	CLK(NULL,	"abe_24m_fclk",			&abe_24m_fclk,	CK_443X),
-	CLK(NULL,	"abe_clk",			&abe_clk,	CK_443X),
-	CLK(NULL,	"aess_fclk",			&aess_fclk,	CK_443X),
-	CLK(NULL,	"dpll_abe_m3x2_ck",		&dpll_abe_m3x2_ck,	CK_443X),
-	CLK(NULL,	"core_hsd_byp_clk_mux_ck",	&core_hsd_byp_clk_mux_ck,	CK_443X),
-	CLK(NULL,	"dpll_core_ck",			&dpll_core_ck,	CK_443X),
-	CLK(NULL,	"dpll_core_x2_ck",		&dpll_core_x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_core_m6x2_ck",		&dpll_core_m6x2_ck,	CK_443X),
-	CLK(NULL,	"dbgclk_mux_ck",		&dbgclk_mux_ck,	CK_443X),
-	CLK(NULL,	"dpll_core_m2_ck",		&dpll_core_m2_ck,	CK_443X),
-	CLK(NULL,	"ddrphy_ck",			&ddrphy_ck,	CK_443X),
-	CLK(NULL,	"dpll_core_m5x2_ck",		&dpll_core_m5x2_ck,	CK_443X),
-	CLK(NULL,	"div_core_ck",			&div_core_ck,	CK_443X),
-	CLK(NULL,	"div_iva_hs_clk",		&div_iva_hs_clk,	CK_443X),
-	CLK(NULL,	"div_mpu_hs_clk",		&div_mpu_hs_clk,	CK_443X),
-	CLK(NULL,	"dpll_core_m4x2_ck",		&dpll_core_m4x2_ck,	CK_443X),
-	CLK(NULL,	"dll_clk_div_ck",		&dll_clk_div_ck,	CK_443X),
-	CLK(NULL,	"dpll_abe_m2_ck",		&dpll_abe_m2_ck,	CK_443X),
-	CLK(NULL,	"dpll_core_m3x2_ck",		&dpll_core_m3x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_core_m7x2_ck",		&dpll_core_m7x2_ck,	CK_443X),
-	CLK(NULL,	"iva_hsd_byp_clk_mux_ck",	&iva_hsd_byp_clk_mux_ck,	CK_443X),
-	CLK(NULL,	"dpll_iva_ck",			&dpll_iva_ck,	CK_443X),
-	CLK(NULL,	"dpll_iva_x2_ck",		&dpll_iva_x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_iva_m4x2_ck",		&dpll_iva_m4x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_iva_m5x2_ck",		&dpll_iva_m5x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_mpu_ck",			&dpll_mpu_ck,	CK_443X),
-	CLK(NULL,	"dpll_mpu_m2_ck",		&dpll_mpu_m2_ck,	CK_443X),
-	CLK(NULL,	"per_hs_clk_div_ck",		&per_hs_clk_div_ck,	CK_443X),
-	CLK(NULL,	"per_hsd_byp_clk_mux_ck",	&per_hsd_byp_clk_mux_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_ck",			&dpll_per_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_m2_ck",		&dpll_per_m2_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_x2_ck",		&dpll_per_x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_m2x2_ck",		&dpll_per_m2x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_m3x2_ck",		&dpll_per_m3x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_m4x2_ck",		&dpll_per_m4x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_m5x2_ck",		&dpll_per_m5x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_m6x2_ck",		&dpll_per_m6x2_ck,	CK_443X),
-	CLK(NULL,	"dpll_per_m7x2_ck",		&dpll_per_m7x2_ck,	CK_443X),
-	CLK(NULL,	"usb_hs_clk_div_ck",		&usb_hs_clk_div_ck,	CK_443X),
-	CLK(NULL,	"dpll_usb_ck",			&dpll_usb_ck,	CK_443X),
-	CLK(NULL,	"dpll_usb_clkdcoldo_ck",	&dpll_usb_clkdcoldo_ck,	CK_443X),
-	CLK(NULL,	"dpll_usb_m2_ck",		&dpll_usb_m2_ck,	CK_443X),
-	CLK(NULL,	"ducati_clk_mux_ck",		&ducati_clk_mux_ck,	CK_443X),
-	CLK(NULL,	"func_12m_fclk",		&func_12m_fclk,	CK_443X),
-	CLK(NULL,	"func_24m_clk",			&func_24m_clk,	CK_443X),
-	CLK(NULL,	"func_24mc_fclk",		&func_24mc_fclk,	CK_443X),
-	CLK(NULL,	"func_48m_fclk",		&func_48m_fclk,	CK_443X),
-	CLK(NULL,	"func_48mc_fclk",		&func_48mc_fclk,	CK_443X),
-	CLK(NULL,	"func_64m_fclk",		&func_64m_fclk,	CK_443X),
-	CLK(NULL,	"func_96m_fclk",		&func_96m_fclk,	CK_443X),
-	CLK(NULL,	"init_60m_fclk",		&init_60m_fclk,	CK_443X),
-	CLK(NULL,	"l3_div_ck",			&l3_div_ck,	CK_443X),
-	CLK(NULL,	"l4_div_ck",			&l4_div_ck,	CK_443X),
-	CLK(NULL,	"lp_clk_div_ck",		&lp_clk_div_ck,	CK_443X),
-	CLK(NULL,	"l4_wkup_clk_mux_ck",		&l4_wkup_clk_mux_ck,	CK_443X),
-	CLK("smp_twd",	NULL,				&mpu_periphclk,	CK_443X),
-	CLK(NULL,	"ocp_abe_iclk",			&ocp_abe_iclk,	CK_443X),
-	CLK(NULL,	"per_abe_24m_fclk",		&per_abe_24m_fclk,	CK_443X),
-	CLK(NULL,	"per_abe_nc_fclk",		&per_abe_nc_fclk,	CK_443X),
-	CLK(NULL,	"syc_clk_div_ck",		&syc_clk_div_ck,	CK_443X),
-	CLK(NULL,	"aes1_fck",			&aes1_fck,	CK_443X),
-	CLK(NULL,	"aes2_fck",			&aes2_fck,	CK_443X),
-	CLK(NULL,	"bandgap_fclk",			&bandgap_fclk,	CK_443X),
-	CLK(NULL,	"div_ts_ck",			&div_ts_ck,	CK_446X),
-	CLK(NULL,	"bandgap_ts_fclk",		&bandgap_ts_fclk,	CK_446X),
-	CLK(NULL,	"dmic_sync_mux_ck",		&dmic_sync_mux_ck,	CK_443X),
-	CLK(NULL,	"func_dmic_abe_gfclk",			&func_dmic_abe_gfclk,	CK_443X),
-	CLK(NULL,	"dss_sys_clk",			&dss_sys_clk,	CK_443X),
-	CLK(NULL,	"dss_tv_clk",			&dss_tv_clk,	CK_443X),
-	CLK(NULL,	"dss_dss_clk",			&dss_dss_clk,	CK_443X),
-	CLK(NULL,	"dss_48mhz_clk",		&dss_48mhz_clk,	CK_443X),
-	CLK(NULL,	"dss_fck",			&dss_fck,	CK_443X),
-	CLK("omapdss_dss",	"ick",			&dss_fck,	CK_443X),
-	CLK(NULL,	"fdif_fck",			&fdif_fck,	CK_443X),
-	CLK(NULL,	"gpio1_dbclk",			&gpio1_dbclk,	CK_443X),
-	CLK(NULL,	"gpio2_dbclk",			&gpio2_dbclk,	CK_443X),
-	CLK(NULL,	"gpio3_dbclk",			&gpio3_dbclk,	CK_443X),
-	CLK(NULL,	"gpio4_dbclk",			&gpio4_dbclk,	CK_443X),
-	CLK(NULL,	"gpio5_dbclk",			&gpio5_dbclk,	CK_443X),
-	CLK(NULL,	"gpio6_dbclk",			&gpio6_dbclk,	CK_443X),
-	CLK(NULL,	"sgx_clk_mux",			&sgx_clk_mux,	CK_443X),
-	CLK(NULL,	"hsi_fck",			&hsi_fck,	CK_443X),
-	CLK(NULL,	"iss_ctrlclk",			&iss_ctrlclk,	CK_443X),
-	CLK(NULL,	"mcasp_sync_mux_ck",		&mcasp_sync_mux_ck,	CK_443X),
-	CLK(NULL,	"func_mcasp_abe_gfclk",			&func_mcasp_abe_gfclk,	CK_443X),
-	CLK(NULL,	"mcbsp1_sync_mux_ck",		&mcbsp1_sync_mux_ck,	CK_443X),
-	CLK(NULL,	"func_mcbsp1_gfclk",			&func_mcbsp1_gfclk,	CK_443X),
-	CLK(NULL,	"mcbsp2_sync_mux_ck",		&mcbsp2_sync_mux_ck,	CK_443X),
-	CLK(NULL,	"func_mcbsp2_gfclk",			&func_mcbsp2_gfclk,	CK_443X),
-	CLK(NULL,	"mcbsp3_sync_mux_ck",		&mcbsp3_sync_mux_ck,	CK_443X),
-	CLK(NULL,	"func_mcbsp3_gfclk",			&func_mcbsp3_gfclk,	CK_443X),
-	CLK(NULL,	"mcbsp4_sync_mux_ck",		&mcbsp4_sync_mux_ck,	CK_443X),
-	CLK(NULL,	"per_mcbsp4_gfclk",			&per_mcbsp4_gfclk,	CK_443X),
-	CLK(NULL,	"hsmmc1_fclk",			&hsmmc1_fclk,	CK_443X),
-	CLK(NULL,	"hsmmc2_fclk",			&hsmmc2_fclk,	CK_443X),
-	CLK(NULL,	"sha2md5_fck",			&sha2md5_fck,	CK_443X),
-	CLK(NULL,	"slimbus1_fclk_1",		&slimbus1_fclk_1,	CK_443X),
-	CLK(NULL,	"slimbus1_fclk_0",		&slimbus1_fclk_0,	CK_443X),
-	CLK(NULL,	"slimbus1_fclk_2",		&slimbus1_fclk_2,	CK_443X),
-	CLK(NULL,	"slimbus1_slimbus_clk",		&slimbus1_slimbus_clk,	CK_443X),
-	CLK(NULL,	"slimbus2_fclk_1",		&slimbus2_fclk_1,	CK_443X),
-	CLK(NULL,	"slimbus2_fclk_0",		&slimbus2_fclk_0,	CK_443X),
-	CLK(NULL,	"slimbus2_slimbus_clk",		&slimbus2_slimbus_clk,	CK_443X),
-	CLK(NULL,	"smartreflex_core_fck",		&smartreflex_core_fck,	CK_443X),
-	CLK(NULL,	"smartreflex_iva_fck",		&smartreflex_iva_fck,	CK_443X),
-	CLK(NULL,	"smartreflex_mpu_fck",		&smartreflex_mpu_fck,	CK_443X),
-	CLK(NULL,	"dmt1_clk_mux",			&dmt1_clk_mux,	CK_443X),
-	CLK(NULL,	"cm2_dm10_mux",			&cm2_dm10_mux,	CK_443X),
-	CLK(NULL,	"cm2_dm11_mux",			&cm2_dm11_mux,	CK_443X),
-	CLK(NULL,	"cm2_dm2_mux",			&cm2_dm2_mux,	CK_443X),
-	CLK(NULL,	"cm2_dm3_mux",			&cm2_dm3_mux,	CK_443X),
-	CLK(NULL,	"cm2_dm4_mux",			&cm2_dm4_mux,	CK_443X),
-	CLK(NULL,	"timer5_sync_mux",		&timer5_sync_mux,	CK_443X),
-	CLK(NULL,	"timer6_sync_mux",			&timer6_sync_mux,	CK_443X),
-	CLK(NULL,	"timer7_sync_mux",			&timer7_sync_mux,	CK_443X),
-	CLK(NULL,	"timer8_sync_mux",			&timer8_sync_mux,	CK_443X),
-	CLK(NULL,	"cm2_dm9_mux",			&cm2_dm9_mux,	CK_443X),
-	CLK(NULL,	"usb_host_fs_fck",		&usb_host_fs_fck,	CK_443X),
-	CLK("usbhs_omap",	"fs_fck",		&usb_host_fs_fck,	CK_443X),
-	CLK(NULL,	"utmi_p1_gfclk",		&utmi_p1_gfclk,	CK_443X),
-	CLK(NULL,	"usb_host_hs_utmi_p1_clk",	&usb_host_hs_utmi_p1_clk,	CK_443X),
-	CLK(NULL,	"utmi_p2_gfclk",		&utmi_p2_gfclk,	CK_443X),
-	CLK(NULL,	"usb_host_hs_utmi_p2_clk",	&usb_host_hs_utmi_p2_clk,	CK_443X),
-	CLK(NULL,	"usb_host_hs_utmi_p3_clk",	&usb_host_hs_utmi_p3_clk,	CK_443X),
-	CLK(NULL,	"usb_host_hs_hsic480m_p1_clk",	&usb_host_hs_hsic480m_p1_clk,	CK_443X),
-	CLK(NULL,	"usb_host_hs_hsic60m_p1_clk",	&usb_host_hs_hsic60m_p1_clk,	CK_443X),
-	CLK(NULL,	"usb_host_hs_hsic60m_p2_clk",	&usb_host_hs_hsic60m_p2_clk,	CK_443X),
-	CLK(NULL,	"usb_host_hs_hsic480m_p2_clk",	&usb_host_hs_hsic480m_p2_clk,	CK_443X),
-	CLK(NULL,	"usb_host_hs_func48mclk",	&usb_host_hs_func48mclk,	CK_443X),
-	CLK(NULL,	"usb_host_hs_fck",		&usb_host_hs_fck,	CK_443X),
-	CLK("usbhs_omap",	"hs_fck",		&usb_host_hs_fck,	CK_443X),
-	CLK(NULL,	"otg_60m_gfclk",		&otg_60m_gfclk,	CK_443X),
-	CLK(NULL,	"usb_otg_hs_xclk",		&usb_otg_hs_xclk,	CK_443X),
-	CLK(NULL,	"usb_otg_hs_ick",		&usb_otg_hs_ick,	CK_443X),
-	CLK("musb-omap2430",	"ick",			&usb_otg_hs_ick,	CK_443X),
-	CLK(NULL,	"usb_phy_cm_clk32k",		&usb_phy_cm_clk32k,	CK_443X),
-	CLK(NULL,	"usb_tll_hs_usb_ch2_clk",	&usb_tll_hs_usb_ch2_clk,	CK_443X),
-	CLK(NULL,	"usb_tll_hs_usb_ch0_clk",	&usb_tll_hs_usb_ch0_clk,	CK_443X),
-	CLK(NULL,	"usb_tll_hs_usb_ch1_clk",	&usb_tll_hs_usb_ch1_clk,	CK_443X),
-	CLK(NULL,	"usb_tll_hs_ick",		&usb_tll_hs_ick,	CK_443X),
-	CLK("usbhs_omap",	"usbtll_ick",		&usb_tll_hs_ick,	CK_443X),
-	CLK("usbhs_tll",	"usbtll_ick",		&usb_tll_hs_ick,	CK_443X),
-	CLK(NULL,	"usim_ck",			&usim_ck,	CK_443X),
-	CLK(NULL,	"usim_fclk",			&usim_fclk,	CK_443X),
-	CLK(NULL,	"pmd_stm_clock_mux_ck",		&pmd_stm_clock_mux_ck,	CK_443X),
-	CLK(NULL,	"pmd_trace_clk_mux_ck",		&pmd_trace_clk_mux_ck,	CK_443X),
-	CLK(NULL,	"stm_clk_div_ck",		&stm_clk_div_ck,	CK_443X),
-	CLK(NULL,	"trace_clk_div_ck",		&trace_clk_div_ck,	CK_443X),
-	CLK(NULL,	"auxclk0_src_ck",		&auxclk0_src_ck,	CK_443X),
-	CLK(NULL,	"auxclk0_ck",			&auxclk0_ck,	CK_443X),
-	CLK(NULL,	"auxclkreq0_ck",		&auxclkreq0_ck,	CK_443X),
-	CLK(NULL,	"auxclk1_src_ck",		&auxclk1_src_ck,	CK_443X),
-	CLK(NULL,	"auxclk1_ck",			&auxclk1_ck,	CK_443X),
-	CLK(NULL,	"auxclkreq1_ck",		&auxclkreq1_ck,	CK_443X),
-	CLK(NULL,	"auxclk2_src_ck",		&auxclk2_src_ck,	CK_443X),
-	CLK(NULL,	"auxclk2_ck",			&auxclk2_ck,	CK_443X),
-	CLK(NULL,	"auxclkreq2_ck",		&auxclkreq2_ck,	CK_443X),
-	CLK(NULL,	"auxclk3_src_ck",		&auxclk3_src_ck,	CK_443X),
-	CLK(NULL,	"auxclk3_ck",			&auxclk3_ck,	CK_443X),
-	CLK(NULL,	"auxclkreq3_ck",		&auxclkreq3_ck,	CK_443X),
-	CLK(NULL,	"auxclk4_src_ck",		&auxclk4_src_ck,	CK_443X),
-	CLK(NULL,	"auxclk4_ck",			&auxclk4_ck,	CK_443X),
-	CLK(NULL,	"auxclkreq4_ck",		&auxclkreq4_ck,	CK_443X),
-	CLK(NULL,	"auxclk5_src_ck",		&auxclk5_src_ck,	CK_443X),
-	CLK(NULL,	"auxclk5_ck",			&auxclk5_ck,	CK_443X),
-	CLK(NULL,	"auxclkreq5_ck",		&auxclkreq5_ck,	CK_443X),
-	CLK("omap-gpmc",	"fck",			&dummy_ck,	CK_443X),
-	CLK("omap_i2c.1",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap_i2c.2",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap_i2c.3",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap_i2c.4",	"ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"mailboxes_ick",		&dummy_ck,	CK_443X),
-	CLK("omap_hsmmc.0",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap_hsmmc.1",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap_hsmmc.2",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap_hsmmc.3",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap_hsmmc.4",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap-mcbsp.1",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap-mcbsp.2",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap-mcbsp.3",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap-mcbsp.4",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap2_mcspi.1",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap2_mcspi.2",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap2_mcspi.3",	"ick",			&dummy_ck,	CK_443X),
-	CLK("omap2_mcspi.4",	"ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"uart1_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"uart2_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"uart3_ick",			&dummy_ck,	CK_443X),
-	CLK(NULL,	"uart4_ick",			&dummy_ck,	CK_443X),
-	CLK("usbhs_omap",	"usbhost_ick",		&dummy_ck,		CK_443X),
-	CLK("usbhs_omap",	"usbtll_fck",		&dummy_ck,	CK_443X),
-	CLK("usbhs_tll",	"usbtll_fck",		&dummy_ck,	CK_443X),
-	CLK("omap_wdt",	"ick",				&dummy_ck,	CK_443X),
-	CLK(NULL,	"timer_32k_ck",	&sys_32k_ck,	CK_443X),
+	CLK(NULL,	"extalt_clkin_ck",		&extalt_clkin_ck),
+	CLK(NULL,	"pad_clks_src_ck",		&pad_clks_src_ck),
+	CLK(NULL,	"pad_clks_ck",			&pad_clks_ck),
+	CLK(NULL,	"pad_slimbus_core_clks_ck",	&pad_slimbus_core_clks_ck),
+	CLK(NULL,	"secure_32k_clk_src_ck",	&secure_32k_clk_src_ck),
+	CLK(NULL,	"slimbus_src_clk",		&slimbus_src_clk),
+	CLK(NULL,	"slimbus_clk",			&slimbus_clk),
+	CLK(NULL,	"sys_32k_ck",			&sys_32k_ck),
+	CLK(NULL,	"virt_12000000_ck",		&virt_12000000_ck),
+	CLK(NULL,	"virt_13000000_ck",		&virt_13000000_ck),
+	CLK(NULL,	"virt_16800000_ck",		&virt_16800000_ck),
+	CLK(NULL,	"virt_19200000_ck",		&virt_19200000_ck),
+	CLK(NULL,	"virt_26000000_ck",		&virt_26000000_ck),
+	CLK(NULL,	"virt_27000000_ck",		&virt_27000000_ck),
+	CLK(NULL,	"virt_38400000_ck",		&virt_38400000_ck),
+	CLK(NULL,	"sys_clkin_ck",			&sys_clkin_ck),
+	CLK(NULL,	"tie_low_clock_ck",		&tie_low_clock_ck),
+	CLK(NULL,	"utmi_phy_clkout_ck",		&utmi_phy_clkout_ck),
+	CLK(NULL,	"xclk60mhsp1_ck",		&xclk60mhsp1_ck),
+	CLK(NULL,	"xclk60mhsp2_ck",		&xclk60mhsp2_ck),
+	CLK(NULL,	"xclk60motg_ck",		&xclk60motg_ck),
+	CLK(NULL,	"abe_dpll_bypass_clk_mux_ck",	&abe_dpll_bypass_clk_mux_ck),
+	CLK(NULL,	"abe_dpll_refclk_mux_ck",	&abe_dpll_refclk_mux_ck),
+	CLK(NULL,	"dpll_abe_ck",			&dpll_abe_ck),
+	CLK(NULL,	"dpll_abe_x2_ck",		&dpll_abe_x2_ck),
+	CLK(NULL,	"dpll_abe_m2x2_ck",		&dpll_abe_m2x2_ck),
+	CLK(NULL,	"abe_24m_fclk",			&abe_24m_fclk),
+	CLK(NULL,	"abe_clk",			&abe_clk),
+	CLK(NULL,	"aess_fclk",			&aess_fclk),
+	CLK(NULL,	"dpll_abe_m3x2_ck",		&dpll_abe_m3x2_ck),
+	CLK(NULL,	"core_hsd_byp_clk_mux_ck",	&core_hsd_byp_clk_mux_ck),
+	CLK(NULL,	"dpll_core_ck",			&dpll_core_ck),
+	CLK(NULL,	"dpll_core_x2_ck",		&dpll_core_x2_ck),
+	CLK(NULL,	"dpll_core_m6x2_ck",		&dpll_core_m6x2_ck),
+	CLK(NULL,	"dbgclk_mux_ck",		&dbgclk_mux_ck),
+	CLK(NULL,	"dpll_core_m2_ck",		&dpll_core_m2_ck),
+	CLK(NULL,	"ddrphy_ck",			&ddrphy_ck),
+	CLK(NULL,	"dpll_core_m5x2_ck",		&dpll_core_m5x2_ck),
+	CLK(NULL,	"div_core_ck",			&div_core_ck),
+	CLK(NULL,	"div_iva_hs_clk",		&div_iva_hs_clk),
+	CLK(NULL,	"div_mpu_hs_clk",		&div_mpu_hs_clk),
+	CLK(NULL,	"dpll_core_m4x2_ck",		&dpll_core_m4x2_ck),
+	CLK(NULL,	"dll_clk_div_ck",		&dll_clk_div_ck),
+	CLK(NULL,	"dpll_abe_m2_ck",		&dpll_abe_m2_ck),
+	CLK(NULL,	"dpll_core_m3x2_ck",		&dpll_core_m3x2_ck),
+	CLK(NULL,	"dpll_core_m7x2_ck",		&dpll_core_m7x2_ck),
+	CLK(NULL,	"iva_hsd_byp_clk_mux_ck",	&iva_hsd_byp_clk_mux_ck),
+	CLK(NULL,	"dpll_iva_ck",			&dpll_iva_ck),
+	CLK(NULL,	"dpll_iva_x2_ck",		&dpll_iva_x2_ck),
+	CLK(NULL,	"dpll_iva_m4x2_ck",		&dpll_iva_m4x2_ck),
+	CLK(NULL,	"dpll_iva_m5x2_ck",		&dpll_iva_m5x2_ck),
+	CLK(NULL,	"dpll_mpu_ck",			&dpll_mpu_ck),
+	CLK(NULL,	"dpll_mpu_m2_ck",		&dpll_mpu_m2_ck),
+	CLK(NULL,	"per_hs_clk_div_ck",		&per_hs_clk_div_ck),
+	CLK(NULL,	"per_hsd_byp_clk_mux_ck",	&per_hsd_byp_clk_mux_ck),
+	CLK(NULL,	"dpll_per_ck",			&dpll_per_ck),
+	CLK(NULL,	"dpll_per_m2_ck",		&dpll_per_m2_ck),
+	CLK(NULL,	"dpll_per_x2_ck",		&dpll_per_x2_ck),
+	CLK(NULL,	"dpll_per_m2x2_ck",		&dpll_per_m2x2_ck),
+	CLK(NULL,	"dpll_per_m3x2_ck",		&dpll_per_m3x2_ck),
+	CLK(NULL,	"dpll_per_m4x2_ck",		&dpll_per_m4x2_ck),
+	CLK(NULL,	"dpll_per_m5x2_ck",		&dpll_per_m5x2_ck),
+	CLK(NULL,	"dpll_per_m6x2_ck",		&dpll_per_m6x2_ck),
+	CLK(NULL,	"dpll_per_m7x2_ck",		&dpll_per_m7x2_ck),
+	CLK(NULL,	"usb_hs_clk_div_ck",		&usb_hs_clk_div_ck),
+	CLK(NULL,	"dpll_usb_ck",			&dpll_usb_ck),
+	CLK(NULL,	"dpll_usb_clkdcoldo_ck",	&dpll_usb_clkdcoldo_ck),
+	CLK(NULL,	"dpll_usb_m2_ck",		&dpll_usb_m2_ck),
+	CLK(NULL,	"ducati_clk_mux_ck",		&ducati_clk_mux_ck),
+	CLK(NULL,	"func_12m_fclk",		&func_12m_fclk),
+	CLK(NULL,	"func_24m_clk",			&func_24m_clk),
+	CLK(NULL,	"func_24mc_fclk",		&func_24mc_fclk),
+	CLK(NULL,	"func_48m_fclk",		&func_48m_fclk),
+	CLK(NULL,	"func_48mc_fclk",		&func_48mc_fclk),
+	CLK(NULL,	"func_64m_fclk",		&func_64m_fclk),
+	CLK(NULL,	"func_96m_fclk",		&func_96m_fclk),
+	CLK(NULL,	"init_60m_fclk",		&init_60m_fclk),
+	CLK(NULL,	"l3_div_ck",			&l3_div_ck),
+	CLK(NULL,	"l4_div_ck",			&l4_div_ck),
+	CLK(NULL,	"lp_clk_div_ck",		&lp_clk_div_ck),
+	CLK(NULL,	"l4_wkup_clk_mux_ck",		&l4_wkup_clk_mux_ck),
+	CLK("smp_twd",	NULL,				&mpu_periphclk),
+	CLK(NULL,	"ocp_abe_iclk",			&ocp_abe_iclk),
+	CLK(NULL,	"per_abe_24m_fclk",		&per_abe_24m_fclk),
+	CLK(NULL,	"per_abe_nc_fclk",		&per_abe_nc_fclk),
+	CLK(NULL,	"syc_clk_div_ck",		&syc_clk_div_ck),
+	CLK(NULL,	"aes1_fck",			&aes1_fck),
+	CLK(NULL,	"aes2_fck",			&aes2_fck),
+	CLK(NULL,	"dmic_sync_mux_ck",		&dmic_sync_mux_ck),
+	CLK(NULL,	"func_dmic_abe_gfclk",		&func_dmic_abe_gfclk),
+	CLK(NULL,	"dss_sys_clk",			&dss_sys_clk),
+	CLK(NULL,	"dss_tv_clk",			&dss_tv_clk),
+	CLK(NULL,	"dss_dss_clk",			&dss_dss_clk),
+	CLK(NULL,	"dss_48mhz_clk",		&dss_48mhz_clk),
+	CLK(NULL,	"dss_fck",			&dss_fck),
+	CLK("omapdss_dss",	"ick",			&dss_fck),
+	CLK(NULL,	"fdif_fck",			&fdif_fck),
+	CLK(NULL,	"gpio1_dbclk",			&gpio1_dbclk),
+	CLK(NULL,	"gpio2_dbclk",			&gpio2_dbclk),
+	CLK(NULL,	"gpio3_dbclk",			&gpio3_dbclk),
+	CLK(NULL,	"gpio4_dbclk",			&gpio4_dbclk),
+	CLK(NULL,	"gpio5_dbclk",			&gpio5_dbclk),
+	CLK(NULL,	"gpio6_dbclk",			&gpio6_dbclk),
+	CLK(NULL,	"sgx_clk_mux",			&sgx_clk_mux),
+	CLK(NULL,	"hsi_fck",			&hsi_fck),
+	CLK(NULL,	"iss_ctrlclk",			&iss_ctrlclk),
+	CLK(NULL,	"mcasp_sync_mux_ck",		&mcasp_sync_mux_ck),
+	CLK(NULL,	"func_mcasp_abe_gfclk",		&func_mcasp_abe_gfclk),
+	CLK(NULL,	"mcbsp1_sync_mux_ck",		&mcbsp1_sync_mux_ck),
+	CLK(NULL,	"func_mcbsp1_gfclk",		&func_mcbsp1_gfclk),
+	CLK(NULL,	"mcbsp2_sync_mux_ck",		&mcbsp2_sync_mux_ck),
+	CLK(NULL,	"func_mcbsp2_gfclk",		&func_mcbsp2_gfclk),
+	CLK(NULL,	"mcbsp3_sync_mux_ck",		&mcbsp3_sync_mux_ck),
+	CLK(NULL,	"func_mcbsp3_gfclk",		&func_mcbsp3_gfclk),
+	CLK(NULL,	"mcbsp4_sync_mux_ck",		&mcbsp4_sync_mux_ck),
+	CLK(NULL,	"per_mcbsp4_gfclk",		&per_mcbsp4_gfclk),
+	CLK(NULL,	"hsmmc1_fclk",			&hsmmc1_fclk),
+	CLK(NULL,	"hsmmc2_fclk",			&hsmmc2_fclk),
+	CLK(NULL,	"sha2md5_fck",			&sha2md5_fck),
+	CLK(NULL,	"slimbus1_fclk_1",		&slimbus1_fclk_1),
+	CLK(NULL,	"slimbus1_fclk_0",		&slimbus1_fclk_0),
+	CLK(NULL,	"slimbus1_fclk_2",		&slimbus1_fclk_2),
+	CLK(NULL,	"slimbus1_slimbus_clk",		&slimbus1_slimbus_clk),
+	CLK(NULL,	"slimbus2_fclk_1",		&slimbus2_fclk_1),
+	CLK(NULL,	"slimbus2_fclk_0",		&slimbus2_fclk_0),
+	CLK(NULL,	"slimbus2_slimbus_clk",		&slimbus2_slimbus_clk),
+	CLK(NULL,	"smartreflex_core_fck",		&smartreflex_core_fck),
+	CLK(NULL,	"smartreflex_iva_fck",		&smartreflex_iva_fck),
+	CLK(NULL,	"smartreflex_mpu_fck",		&smartreflex_mpu_fck),
+	CLK(NULL,	"dmt1_clk_mux",			&dmt1_clk_mux),
+	CLK(NULL,	"cm2_dm10_mux",			&cm2_dm10_mux),
+	CLK(NULL,	"cm2_dm11_mux",			&cm2_dm11_mux),
+	CLK(NULL,	"cm2_dm2_mux",			&cm2_dm2_mux),
+	CLK(NULL,	"cm2_dm3_mux",			&cm2_dm3_mux),
+	CLK(NULL,	"cm2_dm4_mux",			&cm2_dm4_mux),
+	CLK(NULL,	"timer5_sync_mux",		&timer5_sync_mux),
+	CLK(NULL,	"timer6_sync_mux",		&timer6_sync_mux),
+	CLK(NULL,	"timer7_sync_mux",		&timer7_sync_mux),
+	CLK(NULL,	"timer8_sync_mux",		&timer8_sync_mux),
+	CLK(NULL,	"cm2_dm9_mux",			&cm2_dm9_mux),
+	CLK(NULL,	"usb_host_fs_fck",		&usb_host_fs_fck),
+	CLK("usbhs_omap",	"fs_fck",		&usb_host_fs_fck),
+	CLK(NULL,	"utmi_p1_gfclk",		&utmi_p1_gfclk),
+	CLK(NULL,	"usb_host_hs_utmi_p1_clk",	&usb_host_hs_utmi_p1_clk),
+	CLK(NULL,	"utmi_p2_gfclk",		&utmi_p2_gfclk),
+	CLK(NULL,	"usb_host_hs_utmi_p2_clk",	&usb_host_hs_utmi_p2_clk),
+	CLK(NULL,	"usb_host_hs_utmi_p3_clk",	&usb_host_hs_utmi_p3_clk),
+	CLK(NULL,	"usb_host_hs_hsic480m_p1_clk",	&usb_host_hs_hsic480m_p1_clk),
+	CLK(NULL,	"usb_host_hs_hsic60m_p1_clk",	&usb_host_hs_hsic60m_p1_clk),
+	CLK(NULL,	"usb_host_hs_hsic60m_p2_clk",	&usb_host_hs_hsic60m_p2_clk),
+	CLK(NULL,	"usb_host_hs_hsic480m_p2_clk",	&usb_host_hs_hsic480m_p2_clk),
+	CLK(NULL,	"usb_host_hs_func48mclk",	&usb_host_hs_func48mclk),
+	CLK(NULL,	"usb_host_hs_fck",		&usb_host_hs_fck),
+	CLK("usbhs_omap",	"hs_fck",		&usb_host_hs_fck),
+	CLK(NULL,	"otg_60m_gfclk",		&otg_60m_gfclk),
+	CLK(NULL,	"usb_otg_hs_xclk",		&usb_otg_hs_xclk),
+	CLK(NULL,	"usb_otg_hs_ick",		&usb_otg_hs_ick),
+	CLK("musb-omap2430",	"ick",			&usb_otg_hs_ick),
+	CLK(NULL,	"usb_phy_cm_clk32k",		&usb_phy_cm_clk32k),
+	CLK(NULL,	"usb_tll_hs_usb_ch2_clk",	&usb_tll_hs_usb_ch2_clk),
+	CLK(NULL,	"usb_tll_hs_usb_ch0_clk",	&usb_tll_hs_usb_ch0_clk),
+	CLK(NULL,	"usb_tll_hs_usb_ch1_clk",	&usb_tll_hs_usb_ch1_clk),
+	CLK(NULL,	"usb_tll_hs_ick",		&usb_tll_hs_ick),
+	CLK("usbhs_omap",	"usbtll_ick",		&usb_tll_hs_ick),
+	CLK("usbhs_tll",	"usbtll_ick",		&usb_tll_hs_ick),
+	CLK(NULL,	"usim_ck",			&usim_ck),
+	CLK(NULL,	"usim_fclk",			&usim_fclk),
+	CLK(NULL,	"pmd_stm_clock_mux_ck",		&pmd_stm_clock_mux_ck),
+	CLK(NULL,	"pmd_trace_clk_mux_ck",		&pmd_trace_clk_mux_ck),
+	CLK(NULL,	"stm_clk_div_ck",		&stm_clk_div_ck),
+	CLK(NULL,	"trace_clk_div_ck",		&trace_clk_div_ck),
+	CLK(NULL,	"auxclk0_src_ck",		&auxclk0_src_ck),
+	CLK(NULL,	"auxclk0_ck",			&auxclk0_ck),
+	CLK(NULL,	"auxclkreq0_ck",		&auxclkreq0_ck),
+	CLK(NULL,	"auxclk1_src_ck",		&auxclk1_src_ck),
+	CLK(NULL,	"auxclk1_ck",			&auxclk1_ck),
+	CLK(NULL,	"auxclkreq1_ck",		&auxclkreq1_ck),
+	CLK(NULL,	"auxclk2_src_ck",		&auxclk2_src_ck),
+	CLK(NULL,	"auxclk2_ck",			&auxclk2_ck),
+	CLK(NULL,	"auxclkreq2_ck",		&auxclkreq2_ck),
+	CLK(NULL,	"auxclk3_src_ck",		&auxclk3_src_ck),
+	CLK(NULL,	"auxclk3_ck",			&auxclk3_ck),
+	CLK(NULL,	"auxclkreq3_ck",		&auxclkreq3_ck),
+	CLK(NULL,	"auxclk4_src_ck",		&auxclk4_src_ck),
+	CLK(NULL,	"auxclk4_ck",			&auxclk4_ck),
+	CLK(NULL,	"auxclkreq4_ck",		&auxclkreq4_ck),
+	CLK(NULL,	"auxclk5_src_ck",		&auxclk5_src_ck),
+	CLK(NULL,	"auxclk5_ck",			&auxclk5_ck),
+	CLK(NULL,	"auxclkreq5_ck",		&auxclkreq5_ck),
+	CLK("omap-gpmc",	"fck",			&dummy_ck),
+	CLK("omap_i2c.1",	"ick",			&dummy_ck),
+	CLK("omap_i2c.2",	"ick",			&dummy_ck),
+	CLK("omap_i2c.3",	"ick",			&dummy_ck),
+	CLK("omap_i2c.4",	"ick",			&dummy_ck),
+	CLK(NULL,	"mailboxes_ick",		&dummy_ck),
+	CLK("omap_hsmmc.0",	"ick",			&dummy_ck),
+	CLK("omap_hsmmc.1",	"ick",			&dummy_ck),
+	CLK("omap_hsmmc.2",	"ick",			&dummy_ck),
+	CLK("omap_hsmmc.3",	"ick",			&dummy_ck),
+	CLK("omap_hsmmc.4",	"ick",			&dummy_ck),
+	CLK("omap-mcbsp.1",	"ick",			&dummy_ck),
+	CLK("omap-mcbsp.2",	"ick",			&dummy_ck),
+	CLK("omap-mcbsp.3",	"ick",			&dummy_ck),
+	CLK("omap-mcbsp.4",	"ick",			&dummy_ck),
+	CLK("omap2_mcspi.1",	"ick",			&dummy_ck),
+	CLK("omap2_mcspi.2",	"ick",			&dummy_ck),
+	CLK("omap2_mcspi.3",	"ick",			&dummy_ck),
+	CLK("omap2_mcspi.4",	"ick",			&dummy_ck),
+	CLK(NULL,	"uart1_ick",			&dummy_ck),
+	CLK(NULL,	"uart2_ick",			&dummy_ck),
+	CLK(NULL,	"uart3_ick",			&dummy_ck),
+	CLK(NULL,	"uart4_ick",			&dummy_ck),
+	CLK("usbhs_omap",	"usbhost_ick",		&dummy_ck),
+	CLK("usbhs_omap",	"usbtll_fck",		&dummy_ck),
+	CLK("usbhs_tll",	"usbtll_fck",		&dummy_ck),
+	CLK("omap_wdt",	"ick",				&dummy_ck),
+	CLK(NULL,	"timer_32k_ck",	&sys_32k_ck),
 	/* TODO: Remove "omap_timer.X" aliases once DT migration is complete */
-	CLK("omap_timer.1",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("omap_timer.2",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("omap_timer.3",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("omap_timer.4",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("omap_timer.9",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("omap_timer.10",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("omap_timer.11",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("omap_timer.5",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK("omap_timer.6",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK("omap_timer.7",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK("omap_timer.8",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK("4a318000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("48032000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("48034000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("48036000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("4803e000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("48086000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("48088000.timer",	"timer_sys_ck",	&sys_clkin_ck,	CK_443X),
-	CLK("40138000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK("4013a000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK("4013c000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK("4013e000.timer",	"timer_sys_ck",	&syc_clk_div_ck,	CK_443X),
-	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck,	CK_443X),
+	CLK("omap_timer.1",	"timer_sys_ck",	&sys_clkin_ck),
+	CLK("omap_timer.2",	"timer_sys_ck",	&sys_clkin_ck),
+	CLK("omap_timer.3",	"timer_sys_ck",	&sys_clkin_ck),
+	CLK("omap_timer.4",	"timer_sys_ck",	&sys_clkin_ck),
+	CLK("omap_timer.9",	"timer_sys_ck",	&sys_clkin_ck),
+	CLK("omap_timer.10",	"timer_sys_ck",	&sys_clkin_ck),
+	CLK("omap_timer.11",	"timer_sys_ck",	&sys_clkin_ck),
+	CLK("omap_timer.5",	"timer_sys_ck",	&syc_clk_div_ck),
+	CLK("omap_timer.6",	"timer_sys_ck",	&syc_clk_div_ck),
+	CLK("omap_timer.7",	"timer_sys_ck",	&syc_clk_div_ck),
+	CLK("omap_timer.8",	"timer_sys_ck",	&syc_clk_div_ck),
+	CLK("4a318000.timer",	"timer_sys_ck",	&sys_clkin_ck),
+	CLK("48032000.timer",	"timer_sys_ck",	&sys_clkin_ck),
+	CLK("48034000.timer",	"timer_sys_ck",	&sys_clkin_ck),
+	CLK("48036000.timer",	"timer_sys_ck",	&sys_clkin_ck),
+	CLK("4803e000.timer",	"timer_sys_ck",	&sys_clkin_ck),
+	CLK("48086000.timer",	"timer_sys_ck",	&sys_clkin_ck),
+	CLK("48088000.timer",	"timer_sys_ck",	&sys_clkin_ck),
+	CLK("40138000.timer",	"timer_sys_ck",	&syc_clk_div_ck),
+	CLK("4013a000.timer",	"timer_sys_ck",	&syc_clk_div_ck),
+	CLK("4013c000.timer",	"timer_sys_ck",	&syc_clk_div_ck),
+	CLK("4013e000.timer",	"timer_sys_ck",	&syc_clk_div_ck),
+	CLK(NULL,	"cpufreq_ck",	&dpll_mpu_ck),
 };
 
 int __init omap4xxx_clk_init(void)
 {
-	u32 cpu_clkflg;
-	struct omap_clk *c;
 	int rc;
 
 	if (cpu_is_omap443x()) {
 		cpu_mask = RATE_IN_4430;
-		cpu_clkflg = CK_443X;
+		omap_clocks_register(omap443x_clks, ARRAY_SIZE(omap443x_clks));
 	} else if (cpu_is_omap446x() || cpu_is_omap447x()) {
 		cpu_mask = RATE_IN_4460 | RATE_IN_4430;
-		cpu_clkflg = CK_446X | CK_443X;
-
+		omap_clocks_register(omap446x_clks, ARRAY_SIZE(omap446x_clks));
 		if (cpu_is_omap447x())
 			pr_warn("WARNING: OMAP4470 clock data incomplete!\n");
 	} else {
 		return 0;
 	}
 
-	for (c = omap44xx_clks; c < omap44xx_clks + ARRAY_SIZE(omap44xx_clks);
-									c++) {
-		if (c->cpu & cpu_clkflg) {
-			clkdev_add(&c->lk);
-			if (!__clk_init(NULL, c->lk.clk))
-				omap2_init_clk_hw_omap_clocks(c->lk.clk);
-		}
-	}
+	omap_clocks_register(omap44xx_clks, ARRAY_SIZE(omap44xx_clks));
 
 	omap2_clk_disable_autoidle_all();
 
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index e4ec3a6..8474c7d 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -23,7 +23,7 @@
 #include <linux/clk-provider.h>
 #include <linux/io.h>
 #include <linux/bitops.h>
-
+#include <linux/clk-private.h>
 #include <asm/cpu.h>
 
 
@@ -569,6 +569,21 @@ const struct clk_hw_omap_ops clkhwops_wait = {
 };
 
 /**
+ * omap_clocks_register - register an array of omap_clk
+ * @ocs: pointer to an array of omap_clk to register
+ */
+void __init omap_clocks_register(struct omap_clk oclks[], int cnt)
+{
+	struct omap_clk *c;
+
+	for (c = oclks; c < oclks + cnt; c++) {
+		clkdev_add(&c->lk);
+		if (!__clk_init(NULL, c->lk.clk))
+			omap2_init_clk_hw_omap_clocks(c->lk.clk);
+	}
+}
+
+/**
  * omap2_clk_switch_mpurate_at_boot - switch ARM MPU rate by boot-time argument
  * @mpurate_ck_name: clk name of the clock to change rate
  *
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index b402048..bb49be4 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -27,9 +27,8 @@ struct omap_clk {
 	struct clk_lookup		lk;
 };
 
-#define CLK(dev, con, ck, cp)		\
+#define CLK(dev, con, ck)		\
 	{				\
-		 .cpu = cp,		\
 		.lk = {			\
 			.dev_id = dev,	\
 			.con_id = con,	\
@@ -37,22 +36,6 @@ struct omap_clk {
 		},			\
 	}
 
-/* Platform flags for the clkdev-OMAP integration code */
-#define CK_242X		(1 << 0)
-#define CK_243X		(1 << 1)	/* 243x, 253x */
-#define CK_3430ES1	(1 << 2)	/* 34xxES1 only */
-#define CK_3430ES2PLUS	(1 << 3)	/* 34xxES2, ES3, non-Sitara 35xx only */
-#define CK_AM35XX	(1 << 4)	/* Sitara AM35xx */
-#define CK_36XX		(1 << 5)	/* 36xx/37xx-specific clocks */
-#define CK_443X		(1 << 6)
-#define CK_TI816X	(1 << 7)
-#define CK_446X		(1 << 8)
-#define CK_AM33XX	(1 << 9)	/* AM33xx specific clocks */
-
-
-#define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
-#define CK_3XXX		(CK_34XX | CK_AM35XX | CK_36XX)
-
 struct clockdomain;
 #define to_clk_hw_omap(_hw) container_of(_hw, struct clk_hw_omap, hw)
 
@@ -469,4 +452,5 @@ extern int am33xx_clk_init(void);
 extern int omap2_clkops_enable_clkdm(struct clk_hw *hw);
 extern void omap2_clkops_disable_clkdm(struct clk_hw *hw);
 
+extern void omap_clocks_register(struct omap_clk *oclks, int cnt);
 #endif
-- 
1.7.10.4


