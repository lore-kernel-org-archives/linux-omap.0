From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 09/12] OMAP3: clock: clarify usage of struct clksel_rate.flags
	and struct omap_clk.cpu
Date: Mon, 13 Dec 2010 23:34:52 -0700
Message-ID: <20101214063451.21555.48485.stgit@twilight.localdomain>
References: <20101214063308.21555.76050.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50289 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720Ab0LNGf1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Dec 2010 01:35:27 -0500
In-Reply-To: <20101214063308.21555.76050.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Clarify the usage of the struct omap_clk.cpu flags (e.g., CK_*) to use
bits only for individual SoC variants (e.g., CK_3430ES1, CK_3505,
etc.).  Superset flags, such as CK_3XXX or CK_AM35XX, are now defined
as disjunctions of individual SoC variant flags.  This simplifies the
definition and use of these flags.  struct omap_clk record definitions
can now simply specify the bitmask of actual SoCs that the records are
valid for.  The clock init code can simply set a single CPU type mask
bit for the SoC that is currently in use, and test against that,
rather than needing to set some combination of flags.

Similarly, clarify the use of struct clksel_rate.flags.  The bit
allocated for RATE_IN_3XXX has been reassigned, and RATE_IN_3XXX has
been defined as a disjunction of the 34xx and 36xx rate flags.  The
advantages are the same as the above.

Clarify the usage of struct omap_clk.cpu flags such as CK_34XX to only
apply to the SoCs that they name, e.g., OMAP34xx chips.  The previous
practice caused significantly different SoCs, such as OMAP36xx, to be
included in CK_34XX.  In my opinion, this is much more intuitive.

Similarly, clarify the use of struct clksel_rate.flags, such that
RATE_IN_3430ES2PLUS now only applies to 34xx chips with ES level >= 2
- it does not apply to OMAP36xx.

...

At some point, it probably makes sense to collapse the CK_* and
RATE_IN_* flags together into a single bitfield, and possibly use the
existing CHIP_IS_OMAP* flags for platform detection.

...

This all seems to work fine on OMAP34xx and OMAP36xx Beagle.  Not sure
if it works on Sitara or the TI816X, unfortunately I don't have any
here to test with.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock3xxx_data.c          |  216 ++++++++++++-------------
 arch/arm/plat-omap/include/plat/clkdev_omap.h |   20 +-
 arch/arm/plat-omap/include/plat/clock.h       |   11 +
 3 files changed, 125 insertions(+), 122 deletions(-)

diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 94cbae3..84e43d3 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -120,7 +120,7 @@ static const struct clksel_rate osc_sys_13m_rates[] = {
 };
 
 static const struct clksel_rate osc_sys_16_8m_rates[] = {
-	{ .div = 1, .val = 5, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 1, .val = 5, .flags = RATE_IN_3430ES2PLUS_36XX },
 	{ .div = 0 }
 };
 
@@ -452,35 +452,35 @@ static struct clk dpll3_x2_ck = {
 static const struct clksel_rate div31_dpll3_rates[] = {
 	{ .div = 1, .val = 1, .flags = RATE_IN_3XXX },
 	{ .div = 2, .val = 2, .flags = RATE_IN_3XXX },
-	{ .div = 3, .val = 3, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 4, .val = 4, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 5, .val = 5, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 6, .val = 6, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 7, .val = 7, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 8, .val = 8, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 9, .val = 9, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 10, .val = 10, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 11, .val = 11, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 12, .val = 12, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 13, .val = 13, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 14, .val = 14, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 15, .val = 15, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 16, .val = 16, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 17, .val = 17, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 18, .val = 18, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 19, .val = 19, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 20, .val = 20, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 21, .val = 21, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 22, .val = 22, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 23, .val = 23, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 24, .val = 24, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 25, .val = 25, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 26, .val = 26, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 27, .val = 27, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 28, .val = 28, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 29, .val = 29, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 30, .val = 30, .flags = RATE_IN_3430ES2PLUS },
-	{ .div = 31, .val = 31, .flags = RATE_IN_3430ES2PLUS },
+	{ .div = 3, .val = 3, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 5, .val = 5, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 6, .val = 6, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 7, .val = 7, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 8, .val = 8, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 9, .val = 9, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 10, .val = 10, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 11, .val = 11, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 12, .val = 12, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 13, .val = 13, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 14, .val = 14, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 15, .val = 15, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 16, .val = 16, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 17, .val = 17, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 18, .val = 18, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 19, .val = 19, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 20, .val = 20, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 21, .val = 21, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 22, .val = 22, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 23, .val = 23, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 24, .val = 24, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 25, .val = 25, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 26, .val = 26, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 27, .val = 27, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 28, .val = 28, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 29, .val = 29, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 30, .val = 30, .flags = RATE_IN_3430ES2PLUS_36XX },
+	{ .div = 31, .val = 31, .flags = RATE_IN_3430ES2PLUS_36XX },
 	{ .div = 0 },
 };
 
@@ -3203,7 +3203,7 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"omap_32k_fck",	&omap_32k_fck,	CK_3XXX),
 	CLK(NULL,	"virt_12m_ck",	&virt_12m_ck,	CK_3XXX),
 	CLK(NULL,	"virt_13m_ck",	&virt_13m_ck,	CK_3XXX),
-	CLK(NULL,	"virt_16_8m_ck", &virt_16_8m_ck, CK_3430ES2 | CK_AM35XX),
+	CLK(NULL,	"virt_16_8m_ck", &virt_16_8m_ck, CK_3430ES2PLUS | CK_AM35XX  | CK_36XX),
 	CLK(NULL,	"virt_19_2m_ck", &virt_19_2m_ck, CK_3XXX),
 	CLK(NULL,	"virt_26m_ck",	&virt_26m_ck,	CK_3XXX),
 	CLK(NULL,	"virt_38_4m_ck", &virt_38_4m_ck, CK_3XXX),
@@ -3220,8 +3220,8 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"dpll1_ck",	&dpll1_ck,	CK_3XXX),
 	CLK(NULL,	"dpll1_x2_ck",	&dpll1_x2_ck,	CK_3XXX),
 	CLK(NULL,	"dpll1_x2m2_ck", &dpll1_x2m2_ck, CK_3XXX),
-	CLK(NULL,	"dpll2_ck",	&dpll2_ck,	CK_343X),
-	CLK(NULL,	"dpll2_m2_ck",	&dpll2_m2_ck,	CK_343X),
+	CLK(NULL,	"dpll2_ck",	&dpll2_ck,	CK_34XX | CK_36XX),
+	CLK(NULL,	"dpll2_m2_ck",	&dpll2_m2_ck,	CK_34XX | CK_36XX),
 	CLK(NULL,	"dpll3_ck",	&dpll3_ck,	CK_3XXX),
 	CLK(NULL,	"core_ck",	&core_ck,	CK_3XXX),
 	CLK(NULL,	"dpll3_x2_ck",	&dpll3_x2_ck,	CK_3XXX),
@@ -3250,8 +3250,8 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"dpll4_m6_ck",	&dpll4_m6_ck,	CK_3XXX),
 	CLK(NULL,	"dpll4_m6x2_ck", &dpll4_m6x2_ck, CK_3XXX),
 	CLK("etb",	"emu_per_alwon_ck", &emu_per_alwon_ck, CK_3XXX),
-	CLK(NULL,	"dpll5_ck",	&dpll5_ck,	CK_3430ES2 | CK_AM35XX),
-	CLK(NULL,	"dpll5_m2_ck",	&dpll5_m2_ck,	CK_3430ES2 | CK_AM35XX),
+	CLK(NULL,	"dpll5_ck",	&dpll5_ck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK(NULL,	"dpll5_m2_ck",	&dpll5_m2_ck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK(NULL,	"clkout2_src_ck", &clkout2_src_ck, CK_3XXX),
 	CLK(NULL,	"sys_clkout2",	&sys_clkout2,	CK_3XXX),
 	CLK(NULL,	"corex2_fck",	&corex2_fck,	CK_3XXX),
@@ -3259,8 +3259,8 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"mpu_ck",	&mpu_ck,	CK_3XXX),
 	CLK(NULL,	"arm_fck",	&arm_fck,	CK_3XXX),
 	CLK("etb",	"emu_mpu_alwon_ck", &emu_mpu_alwon_ck, CK_3XXX),
-	CLK(NULL,	"dpll2_fck",	&dpll2_fck,	CK_343X),
-	CLK(NULL,	"iva2_ck",	&iva2_ck,	CK_343X),
+	CLK(NULL,	"dpll2_fck",	&dpll2_fck,	CK_34XX | CK_36XX),
+	CLK(NULL,	"iva2_ck",	&iva2_ck,	CK_34XX | CK_36XX),
 	CLK(NULL,	"l3_ick",	&l3_ick,	CK_3XXX),
 	CLK(NULL,	"l4_ick",	&l4_ick,	CK_3XXX),
 	CLK(NULL,	"rm_ick",	&rm_ick,	CK_3XXX),
@@ -3269,24 +3269,24 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"gfx_l3_ick",	&gfx_l3_ick,	CK_3430ES1),
 	CLK(NULL,	"gfx_cg1_ck",	&gfx_cg1_ck,	CK_3430ES1),
 	CLK(NULL,	"gfx_cg2_ck",	&gfx_cg2_ck,	CK_3430ES1),
-	CLK(NULL,	"sgx_fck",	&sgx_fck,	CK_3430ES2 | CK_3517),
-	CLK(NULL,	"sgx_ick",	&sgx_ick,	CK_3430ES2 | CK_3517),
+	CLK(NULL,	"sgx_fck",	&sgx_fck,	CK_3430ES2PLUS | CK_3517 | CK_36XX),
+	CLK(NULL,	"sgx_ick",	&sgx_ick,	CK_3430ES2PLUS | CK_3517 | CK_36XX),
 	CLK(NULL,	"d2d_26m_fck",	&d2d_26m_fck,	CK_3430ES1),
-	CLK(NULL,	"modem_fck",	&modem_fck,	CK_343X),
-	CLK(NULL,	"sad2d_ick",	&sad2d_ick,	CK_343X),
-	CLK(NULL,	"mad2d_ick",	&mad2d_ick,	CK_343X),
+	CLK(NULL,	"modem_fck",	&modem_fck,	CK_34XX | CK_36XX),
+	CLK(NULL,	"sad2d_ick",	&sad2d_ick,	CK_34XX | CK_36XX),
+	CLK(NULL,	"mad2d_ick",	&mad2d_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"gpt10_fck",	&gpt10_fck,	CK_3XXX),
 	CLK(NULL,	"gpt11_fck",	&gpt11_fck,	CK_3XXX),
-	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck,	CK_3430ES2 | CK_AM35XX),
-	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2 | CK_AM35XX),
-	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2 | CK_AM35XX),
-	CLK("ehci-omap.0",	"usbtll_fck",	&usbtll_fck,	CK_3430ES2 | CK_AM35XX),
+	CLK(NULL,	"cpefuse_fck",	&cpefuse_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK(NULL,	"ts_fck",	&ts_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK(NULL,	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK("ehci-omap.0",	"usbtll_fck",	&usbtll_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK("omap-mcbsp.1",	"prcm_fck",	&core_96m_fck,	CK_3XXX),
 	CLK("omap-mcbsp.5",	"prcm_fck",	&core_96m_fck,	CK_3XXX),
 	CLK(NULL,	"core_96m_fck",	&core_96m_fck,	CK_3XXX),
-	CLK("mmci-omap-hs.2",	"fck",	&mmchs3_fck,	CK_3430ES2 | CK_AM35XX),
+	CLK("mmci-omap-hs.2",	"fck",	&mmchs3_fck,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK("mmci-omap-hs.1",	"fck",	&mmchs2_fck,	CK_3XXX),
-	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_343X),
+	CLK(NULL,	"mspro_fck",	&mspro_fck,	CK_34XX | CK_36XX),
 	CLK("mmci-omap-hs.0",	"fck",	&mmchs1_fck,	CK_3XXX),
 	CLK("i2c_omap.3", "fck",	&i2c3_fck,	CK_3XXX),
 	CLK("i2c_omap.2", "fck",	&i2c2_fck,	CK_3XXX),
@@ -3304,27 +3304,27 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"core_12m_fck",	&core_12m_fck,	CK_3XXX),
 	CLK("omap_hdq.0", "fck",	&hdq_fck,	CK_3XXX),
 	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck_3430es1,	CK_3430ES1),
-	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck_3430es2,	CK_3430ES2),
+	CLK(NULL,	"ssi_ssr_fck",	&ssi_ssr_fck_3430es2,	CK_3430ES2PLUS | CK_36XX),
 	CLK(NULL,	"ssi_sst_fck",	&ssi_sst_fck_3430es1,	CK_3430ES1),
-	CLK(NULL,	"ssi_sst_fck",	&ssi_sst_fck_3430es2,	CK_3430ES2),
+	CLK(NULL,	"ssi_sst_fck",	&ssi_sst_fck_3430es2,	CK_3430ES2PLUS | CK_36XX),
 	CLK(NULL,	"core_l3_ick",	&core_l3_ick,	CK_3XXX),
 	CLK("musb-omap2430",	"ick",	&hsotgusb_ick_3430es1,	CK_3430ES1),
-	CLK("musb-omap2430",	"ick",	&hsotgusb_ick_3430es2,	CK_3430ES2),
+	CLK("musb-omap2430",	"ick",	&hsotgusb_ick_3430es2,	CK_3430ES2PLUS | CK_36XX),
 	CLK(NULL,	"sdrc_ick",	&sdrc_ick,	CK_3XXX),
 	CLK(NULL,	"gpmc_fck",	&gpmc_fck,	CK_3XXX),
-	CLK(NULL,	"security_l3_ick", &security_l3_ick, CK_343X),
-	CLK(NULL,	"pka_ick",	&pka_ick,	CK_343X),
+	CLK(NULL,	"security_l3_ick", &security_l3_ick, CK_34XX | CK_36XX),
+	CLK(NULL,	"pka_ick",	&pka_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"core_l4_ick",	&core_l4_ick,	CK_3XXX),
-	CLK(NULL,	"usbtll_ick",	&usbtll_ick,	CK_3430ES2 | CK_AM35XX),
-	CLK("ehci-omap.0",	"usbtll_ick",	&usbtll_ick,	CK_3430ES2 | CK_AM35XX),
-	CLK("mmci-omap-hs.2",	"ick",	&mmchs3_ick,	CK_3430ES2 | CK_AM35XX),
-	CLK(NULL,	"icr_ick",	&icr_ick,	CK_343X),
-	CLK("omap-aes",	"ick",	&aes2_ick,	CK_343X),
-	CLK("omap-sham",	"ick",	&sha12_ick,	CK_343X),
-	CLK(NULL,	"des2_ick",	&des2_ick,	CK_343X),
+	CLK(NULL,	"usbtll_ick",	&usbtll_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK("ehci-omap.0",	"usbtll_ick",	&usbtll_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK("mmci-omap-hs.2",	"ick",	&mmchs3_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK(NULL,	"icr_ick",	&icr_ick,	CK_34XX | CK_36XX),
+	CLK("omap-aes",	"ick",	&aes2_ick,	CK_34XX | CK_36XX),
+	CLK("omap-sham",	"ick",	&sha12_ick,	CK_34XX | CK_36XX),
+	CLK(NULL,	"des2_ick",	&des2_ick,	CK_34XX | CK_36XX),
 	CLK("mmci-omap-hs.1",	"ick",	&mmchs2_ick,	CK_3XXX),
 	CLK("mmci-omap-hs.0",	"ick",	&mmchs1_ick,	CK_3XXX),
-	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_343X),
+	CLK(NULL,	"mspro_ick",	&mspro_ick,	CK_34XX | CK_36XX),
 	CLK("omap_hdq.0", "ick",	&hdq_ick,	CK_3XXX),
 	CLK("omap2_mcspi.4", "ick",	&mcspi4_ick,	CK_3XXX),
 	CLK("omap2_mcspi.3", "ick",	&mcspi3_ick,	CK_3XXX),
@@ -3340,40 +3340,40 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK("omap-mcbsp.5", "ick",	&mcbsp5_ick,	CK_3XXX),
 	CLK("omap-mcbsp.1", "ick",	&mcbsp1_ick,	CK_3XXX),
 	CLK(NULL,	"fac_ick",	&fac_ick,	CK_3430ES1),
-	CLK(NULL,	"mailboxes_ick", &mailboxes_ick, CK_343X),
+	CLK(NULL,	"mailboxes_ick", &mailboxes_ick, CK_34XX | CK_36XX),
 	CLK(NULL,	"omapctrl_ick",	&omapctrl_ick,	CK_3XXX),
-	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_343X),
+	CLK(NULL,	"ssi_l4_ick",	&ssi_l4_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"ssi_ick",	&ssi_ick_3430es1,	CK_3430ES1),
-	CLK(NULL,	"ssi_ick",	&ssi_ick_3430es2,	CK_3430ES2),
+	CLK(NULL,	"ssi_ick",	&ssi_ick_3430es2,	CK_3430ES2PLUS | CK_36XX),
 	CLK(NULL,	"usb_l4_ick",	&usb_l4_ick,	CK_3430ES1),
-	CLK(NULL,	"security_l4_ick2", &security_l4_ick2, CK_343X),
-	CLK(NULL,	"aes1_ick",	&aes1_ick,	CK_343X),
-	CLK("omap_rng",	"ick",		&rng_ick,	CK_343X),
-	CLK(NULL,	"sha11_ick",	&sha11_ick,	CK_343X),
-	CLK(NULL,	"des1_ick",	&des1_ick,	CK_343X),
+	CLK(NULL,	"security_l4_ick2", &security_l4_ick2, CK_34XX | CK_36XX),
+	CLK(NULL,	"aes1_ick",	&aes1_ick,	CK_34XX | CK_36XX),
+	CLK("omap_rng",	"ick",		&rng_ick,	CK_34XX | CK_36XX),
+	CLK(NULL,	"sha11_ick",	&sha11_ick,	CK_34XX | CK_36XX),
+	CLK(NULL,	"des1_ick",	&des1_ick,	CK_34XX | CK_36XX),
 	CLK("omapdss",	"dss1_fck",	&dss1_alwon_fck_3430es1, CK_3430ES1),
-	CLK("omapdss",	"dss1_fck",	&dss1_alwon_fck_3430es2, CK_3430ES2 | CK_AM35XX),
+	CLK("omapdss",	"dss1_fck",	&dss1_alwon_fck_3430es2, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
 	CLK("omapdss",	"tv_fck",	&dss_tv_fck,	CK_3XXX),
 	CLK("omapdss",	"video_fck",	&dss_96m_fck,	CK_3XXX),
 	CLK("omapdss",	"dss2_fck",	&dss2_alwon_fck, CK_3XXX),
 	CLK("omapdss",	"ick",		&dss_ick_3430es1,	CK_3430ES1),
-	CLK("omapdss",	"ick",		&dss_ick_3430es2,	CK_3430ES2 | CK_AM35XX),
-	CLK(NULL,	"cam_mclk",	&cam_mclk,	CK_343X),
-	CLK(NULL,	"cam_ick",	&cam_ick,	CK_343X),
-	CLK(NULL,	"csi2_96m_fck",	&csi2_96m_fck,	CK_343X),
-	CLK(NULL,	"usbhost_120m_fck", &usbhost_120m_fck, CK_3430ES2 | CK_AM35XX),
-	CLK("ehci-omap.0",	"hs_fck", &usbhost_120m_fck, CK_3430ES2 | CK_AM35XX),
-	CLK(NULL,	"usbhost_48m_fck", &usbhost_48m_fck, CK_3430ES2 | CK_AM35XX),
-	CLK("ehci-omap.0",	"fs_fck", &usbhost_48m_fck, CK_3430ES2 | CK_AM35XX),
-	CLK(NULL,	"usbhost_ick",	&usbhost_ick,	CK_3430ES2 | CK_AM35XX),
-	CLK("ehci-omap.0",	"usbhost_ick",	&usbhost_ick,	CK_3430ES2 | CK_AM35XX),
-	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2),
+	CLK("omapdss",	"ick",		&dss_ick_3430es2,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK(NULL,	"cam_mclk",	&cam_mclk,	CK_34XX | CK_36XX),
+	CLK(NULL,	"cam_ick",	&cam_ick,	CK_34XX | CK_36XX),
+	CLK(NULL,	"csi2_96m_fck",	&csi2_96m_fck,	CK_34XX | CK_36XX),
+	CLK(NULL,	"usbhost_120m_fck", &usbhost_120m_fck, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK("ehci-omap.0",	"hs_fck", &usbhost_120m_fck, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK(NULL,	"usbhost_48m_fck", &usbhost_48m_fck, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK("ehci-omap.0",	"fs_fck", &usbhost_48m_fck, CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK(NULL,	"usbhost_ick",	&usbhost_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK("ehci-omap.0",	"usbhost_ick",	&usbhost_ick,	CK_3430ES2PLUS | CK_AM35XX | CK_36XX),
+	CLK(NULL,	"usim_fck",	&usim_fck,	CK_3430ES2PLUS | CK_36XX),
 	CLK(NULL,	"gpt1_fck",	&gpt1_fck,	CK_3XXX),
 	CLK(NULL,	"wkup_32k_fck",	&wkup_32k_fck,	CK_3XXX),
 	CLK(NULL,	"gpio1_dbck",	&gpio1_dbck,	CK_3XXX),
 	CLK("omap_wdt",	"fck",		&wdt2_fck,	CK_3XXX),
-	CLK(NULL,	"wkup_l4_ick",	&wkup_l4_ick,	CK_343X),
-	CLK(NULL,	"usim_ick",	&usim_ick,	CK_3430ES2),
+	CLK(NULL,	"wkup_l4_ick",	&wkup_l4_ick,	CK_34XX | CK_36XX),
+	CLK(NULL,	"usim_ick",	&usim_ick,	CK_3430ES2PLUS | CK_36XX),
 	CLK("omap_wdt",	"ick",		&wdt2_ick,	CK_3XXX),
 	CLK(NULL,	"wdt1_ick",	&wdt1_ick,	CK_3XXX),
 	CLK(NULL,	"gpio1_ick",	&gpio1_ick,	CK_3XXX),
@@ -3431,9 +3431,9 @@ static struct omap_clk omap3xxx_clks[] = {
 	CLK(NULL,	"atclk_fck",	&atclk_fck,	CK_3XXX),
 	CLK(NULL,	"traceclk_src_fck", &traceclk_src_fck, CK_3XXX),
 	CLK(NULL,	"traceclk_fck",	&traceclk_fck,	CK_3XXX),
-	CLK(NULL,	"sr1_fck",	&sr1_fck,	CK_343X),
-	CLK(NULL,	"sr2_fck",	&sr2_fck,	CK_343X),
-	CLK(NULL,	"sr_l4_ick",	&sr_l4_ick,	CK_343X),
+	CLK(NULL,	"sr1_fck",	&sr1_fck,	CK_34XX | CK_36XX),
+	CLK(NULL,	"sr2_fck",	&sr2_fck,	CK_34XX | CK_36XX),
+	CLK(NULL,	"sr_l4_ick",	&sr_l4_ick,	CK_34XX | CK_36XX),
 	CLK(NULL,	"secure_32k_fck", &secure_32k_fck, CK_3XXX),
 	CLK(NULL,	"gpt12_fck",	&gpt12_fck,	CK_3XXX),
 	CLK(NULL,	"wdt1_fck",	&wdt1_fck,	CK_3XXX),
@@ -3454,38 +3454,37 @@ static struct omap_clk omap3xxx_clks[] = {
 int __init omap3xxx_clk_init(void)
 {
 	struct omap_clk *c;
-	u32 cpu_clkflg = CK_3XXX;
+	u32 cpu_clkflg = 0;
 
 	if (cpu_is_omap3517()) {
-		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
-		cpu_clkflg |= CK_3517;
+		cpu_mask = RATE_IN_34XX;
+		cpu_clkflg = CK_3517;
 	} else if (cpu_is_omap3505()) {
-		cpu_mask = RATE_IN_3XXX | RATE_IN_3430ES2PLUS;
-		cpu_clkflg |= CK_3505;
+		cpu_mask = RATE_IN_34XX;
+		cpu_clkflg = CK_3505;
+	} else if (cpu_is_omap3630()) {
+		cpu_mask = (RATE_IN_34XX | RATE_IN_36XX);
+		cpu_clkflg = CK_36XX;
 	} else if (cpu_is_omap34xx()) {
-		cpu_mask = RATE_IN_3XXX;
-		cpu_clkflg |= CK_343X;
-
-		/*
-		 * Update this if there are further clock changes between ES2
-		 * and production parts
-		 */
 		if (omap_rev() == OMAP3430_REV_ES1_0) {
-			/* No 3430ES1-only rates exist, so no RATE_IN_3430ES1 */
-			cpu_clkflg |= CK_3430ES1;
+			cpu_mask = RATE_IN_3430ES1;
+			cpu_clkflg = CK_3430ES1;
 		} else {
-			cpu_mask |= RATE_IN_3430ES2PLUS;
-			cpu_clkflg |= CK_3430ES2;
+			/*
+			 * Assume that anything that we haven't matched yet
+			 * has 3430ES2-type clocks.
+			 */
+			cpu_mask = RATE_IN_3430ES2PLUS;
+			cpu_clkflg = CK_3430ES2PLUS;
 		}
+	} else {
+		WARN(1, "clock: could not identify OMAP3 variant\n");
 	}
 
 	if (omap3_has_192mhz_clk())
 		omap_96m_alwon_fck = omap_96m_alwon_fck_3630;
 
 	if (cpu_is_omap3630()) {
-		cpu_mask |= RATE_IN_36XX;
-		cpu_clkflg |= CK_36XX;
-
 		/*
 		 * XXX This type of dynamic rewriting of the clock tree is
 		 * deprecated and should be revised soon.
@@ -3532,10 +3531,9 @@ int __init omap3xxx_clk_init(void)
 
 	recalculate_root_clocks();
 
-	printk(KERN_INFO "Clocking rate (Crystal/Core/MPU): "
-	       "%ld.%01ld/%ld/%ld MHz\n",
-	       (osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 100000) % 10,
-	       (core_ck.rate / 1000000), (arm_fck.rate / 1000000));
+	pr_info("Clocking rate (Crystal/Core/MPU): %ld.%01ld/%ld/%ld MHz\n",
+		(osc_sys_ck.rate / 1000000), (osc_sys_ck.rate / 100000) % 10,
+		(core_ck.rate / 1000000), (arm_fck.rate / 1000000));
 
 	/*
 	 * Only enable those clocks we will need, let the drivers
diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-omap/include/plat/clkdev_omap.h
index bb937f3..b19774c 100644
--- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -31,18 +31,18 @@ struct omap_clk {
 #define CK_1510		(1 << 2)
 #define CK_16XX		(1 << 3)	/* 16xx, 17xx, 5912 */
 #define CK_242X		(1 << 4)
-#define CK_243X		(1 << 5)
-#define CK_3XXX		(1 << 6)	/* OMAP3 + AM3 common clocks*/
-#define CK_343X		(1 << 7)	/* OMAP34xx common clocks */
-#define CK_3430ES1	(1 << 8)	/* 34xxES1 only */
-#define CK_3430ES2	(1 << 9)	/* 34xxES2, ES3, non-Sitara 35xx only */
-#define CK_3505		(1 << 10)
-#define CK_3517		(1 << 11)
-#define CK_36XX		(1 << 12)	/* OMAP36xx/37xx-specific clocks */
-#define CK_443X		(1 << 13)
+#define CK_243X		(1 << 5)	/* 243x, 253x */
+#define CK_3430ES1	(1 << 6)	/* 34xxES1 only */
+#define CK_3430ES2PLUS	(1 << 7)	/* 34xxES2, ES3, non-Sitara 35xx only */
+#define CK_3505		(1 << 8)
+#define CK_3517		(1 << 9)
+#define CK_36XX		(1 << 10)	/* 36xx/37xx-specific clocks */
+#define CK_443X		(1 << 11)
 
-#define CK_AM35XX	(CK_3505 | CK_3517)	/* all Sitara AM35xx */
 
+#define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
+#define CK_AM35XX	(CK_3505 | CK_3517)	/* all Sitara AM35xx */
+#define CK_3XXX		(CK_34XX | CK_AM35XX | CK_36XX)
 
 
 #endif
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index fef4696..6e22315 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -49,13 +49,18 @@ struct clkops {
 /* struct clksel_rate.flags possibilities */
 #define RATE_IN_242X		(1 << 0)
 #define RATE_IN_243X		(1 << 1)
-#define RATE_IN_3XXX		(1 << 2)	/* rates common to all OMAP3 */
-#define RATE_IN_3430ES2		(1 << 3)	/* 3430ES2 rates only */
+#define RATE_IN_3430ES1		(1 << 2)	/* 3430ES1 rates only */
+#define RATE_IN_3430ES2PLUS	(1 << 3)	/* 3430 ES >= 2 rates only */
 #define RATE_IN_36XX		(1 << 4)
 #define RATE_IN_4430		(1 << 5)
 
 #define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
-#define RATE_IN_3430ES2PLUS	(RATE_IN_3430ES2 | RATE_IN_36XX)
+#define RATE_IN_34XX		(RATE_IN_3430ES1 | RATE_IN_3430ES2PLUS)
+#define RATE_IN_3XXX		(RATE_IN_34XX | RATE_IN_36XX)
+
+/* RATE_IN_3430ES2PLUS_36XX includes 34xx/35xx with ES >=2, and all 36xx/37xx */
+#define RATE_IN_3430ES2PLUS_36XX	(RATE_IN_3430ES2PLUS | RATE_IN_36XX)
+
 
 /**
  * struct clksel_rate - register bitfield values corresponding to clk divisors


