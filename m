From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/7] ARM: OMAP2+: Add mmc hwmod entries for dm814x
Date: Thu,  3 Dec 2015 17:25:31 -0800
Message-ID: <1449192335-10137-4-git-send-email-tony@atomide.com>
References: <1449192335-10137-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449192335-10137-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>, Delio Brignoli <dbrignoli@audioscience.com>, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Let's add mmc entries for dm814x. To do that, we need to rename some
entries to be common for 81xx.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c | 93 ++++++++++++++++++++++++++----
 1 file changed, 83 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index 1b96cdf..6ee5ba5 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -912,7 +912,7 @@ static struct omap_hwmod_ocp_if dm816x_l4_hs__emac1 = {
 	.user		= OCP_USER_MPU,
 };
 
-static struct omap_hwmod_class_sysconfig dm816x_mmc_sysc = {
+static struct omap_hwmod_class_sysconfig dm81xx_mmc_sysc = {
 	.rev_offs	= 0x0,
 	.sysc_offs	= 0x110,
 	.syss_offs	= 0x114,
@@ -923,24 +923,94 @@ static struct omap_hwmod_class_sysconfig dm816x_mmc_sysc = {
 	.sysc_fields	= &omap_hwmod_sysc_type1,
 };
 
-static struct omap_hwmod_class dm816x_mmc_class = {
+static struct omap_hwmod_class dm81xx_mmc_class = {
 	.name = "mmc",
-	.sysc = &dm816x_mmc_sysc,
+	.sysc = &dm81xx_mmc_sysc,
 };
 
-static struct omap_hwmod_opt_clk dm816x_mmc1_opt_clks[] = {
+static struct omap_hwmod_opt_clk dm81xx_mmc_opt_clks[] = {
 	{ .role = "dbck", .clk = "sysclk18_ck", },
 };
 
-static struct omap_hsmmc_dev_attr mmc1_dev_attr = {
-	.flags = OMAP_HSMMC_SUPPORTS_DUAL_VOLT,
+static struct omap_hsmmc_dev_attr mmc_dev_attr = {
+};
+
+static struct omap_hwmod dm814x_mmc1_hwmod = {
+	.name		= "mmc1",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.opt_clks	= dm81xx_mmc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dm81xx_mmc_opt_clks),
+	.main_clk	= "sysclk8_ck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM814X_CM_ALWON_MMCHS_0_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.dev_attr	= &mmc_dev_attr,
+	.class		= &dm81xx_mmc_class,
+};
+
+static struct omap_hwmod_ocp_if dm814x_l4_ls__mmc1 = {
+	.master		= &dm81xx_l4_ls_hwmod,
+	.slave		= &dm814x_mmc1_hwmod,
+	.clk		= "sysclk6_ck",
+	.user		= OCP_USER_MPU,
+	.flags		= OMAP_FIREWALL_L4
+};
+
+static struct omap_hwmod dm814x_mmc2_hwmod = {
+	.name		= "mmc2",
+	.clkdm_name	= "alwon_l3s_clkdm",
+	.opt_clks	= dm81xx_mmc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dm81xx_mmc_opt_clks),
+	.main_clk	= "sysclk8_ck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM814X_CM_ALWON_MMCHS_1_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.dev_attr	= &mmc_dev_attr,
+	.class		= &dm81xx_mmc_class,
+};
+
+static struct omap_hwmod_ocp_if dm814x_l4_ls__mmc2 = {
+	.master		= &dm81xx_l4_ls_hwmod,
+	.slave		= &dm814x_mmc2_hwmod,
+	.clk		= "sysclk6_ck",
+	.user		= OCP_USER_MPU,
+	.flags		= OMAP_FIREWALL_L4
+};
+
+static struct omap_hwmod dm814x_mmc3_hwmod = {
+	.name		= "mmc3",
+	.clkdm_name	= "alwon_l3_med_clkdm",
+	.opt_clks	= dm81xx_mmc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dm81xx_mmc_opt_clks),
+	.main_clk	= "sysclk8_ck",
+	.prcm		= {
+		.omap4 = {
+			.clkctrl_offs = DM814X_CM_ALWON_MMCHS_2_CLKCTRL,
+			.modulemode = MODULEMODE_SWCTRL,
+		},
+	},
+	.dev_attr	= &mmc_dev_attr,
+	.class		= &dm81xx_mmc_class,
+};
+
+static struct omap_hwmod_ocp_if dm814x_alwon_l3_med__mmc3 = {
+	.master		= &dm81xx_alwon_l3_med_hwmod,
+	.slave		= &dm814x_mmc3_hwmod,
+	.clk		= "sysclk4_ck",
+	.user		= OCP_USER_MPU,
 };
 
 static struct omap_hwmod dm816x_mmc1_hwmod = {
 	.name		= "mmc1",
 	.clkdm_name	= "alwon_l3s_clkdm",
-	.opt_clks	= dm816x_mmc1_opt_clks,
-	.opt_clks_cnt	= ARRAY_SIZE(dm816x_mmc1_opt_clks),
+	.opt_clks	= dm81xx_mmc_opt_clks,
+	.opt_clks_cnt	= ARRAY_SIZE(dm81xx_mmc_opt_clks),
 	.main_clk	= "sysclk10_ck",
 	.prcm		= {
 		.omap4 = {
@@ -948,8 +1018,8 @@ static struct omap_hwmod dm816x_mmc1_hwmod = {
 			.modulemode = MODULEMODE_SWCTRL,
 		},
 	},
-	.dev_attr	= &mmc1_dev_attr,
-	.class		= &dm816x_mmc_class,
+	.dev_attr	= &mmc_dev_attr,
+	.class		= &dm81xx_mmc_class,
 };
 
 static struct omap_hwmod_ocp_if dm816x_l4_ls__mmc1 = {
@@ -1252,6 +1322,8 @@ static struct omap_hwmod_ocp_if *dm814x_hwmod_ocp_ifs[] __initdata = {
 	&dm81xx_l4_ls__gpio2,
 	&dm81xx_l4_ls__elm,
 	&dm81xx_l4_ls__mcspi1,
+	&dm814x_l4_ls__mmc1,
+	&dm814x_l4_ls__mmc2,
 	&dm81xx_alwon_l3_fast__tpcc,
 	&dm81xx_alwon_l3_fast__tptc0,
 	&dm81xx_alwon_l3_fast__tptc1,
@@ -1265,6 +1337,7 @@ static struct omap_hwmod_ocp_if *dm814x_hwmod_ocp_ifs[] __initdata = {
 	&dm814x_l4_ls__timer2,
 	&dm814x_l4_hs__cpgmac0,
 	&dm814x_cpgmac0__mdio,
+	&dm814x_alwon_l3_med__mmc3,
 	NULL,
 };
 
-- 
2.6.2
