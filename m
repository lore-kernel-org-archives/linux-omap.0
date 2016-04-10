From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v5 4/6] ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS
Date: Sun, 10 Apr 2016 18:57:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1604101845460.11457@utopia.booyaka.com>
References: <1457400224-24797-1-git-send-email-fcooper@ti.com> <1457400224-24797-5-git-send-email-fcooper@ti.com> <alpine.DEB.2.02.1603080644580.4974@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1603080644580.4974@utopia.booyaka.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>, vigneshr@ti.com
Cc: thierry.reding@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, bcousson@baylibre.com, tony@atomide.com, linux@arm.linux.org.uk, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Vignesh, Franklin,

On Tue, 8 Mar 2016, Paul Walmsley wrote:

> On Mon, 7 Mar 2016, Franklin S Cooper Jr wrote:
> 
> > From: Vignesh R <vigneshr@ti.com>
> > 
> > Add hwmod entries for the PWMSS on DRA7.
> > 
> > Set l4_root_clk_div as the main_clk of PWMSS. It is fixed-factored clock
> > equal to L4PER2_L3_GICLK/2(l3_iclk_div/2).
> > 
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> > [fcooper@ti.com: Do not add eQEP, ePWM and eCAP hwmod entries]
> > Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> 
> Thanks, queued for v4.7.

I took a closer look at this while preparing to merge it and it adds a 
bunch of sparse warnings:

> arch/arm/mach-omap2/omap_hwmod_7xx_data.c:3104:26: warning: symbol 'dra7xx_l4_per2__epwmss0' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_7xx_data.c:3111:26: warning: symbol 'dra7xx_l4_per2__epwmss1' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_7xx_data.c:3118:26: warning: symbol 'dra7xx_l4_per2__epwmss2' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_7xx_data.c:395:25: warning: symbol 'dra7xx_epwmss_hwmod_class' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_7xx_data.c:401:19: warning: symbol 'dra7xx_epwmss0_hwmod' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_7xx_data.c:416:19: warning: symbol 'dra7xx_epwmss1_hwmod' was not declared. Should it be static?
> arch/arm/mach-omap2/omap_hwmod_7xx_data.c:431:19: warning: symbol 'dra7xx_epwmss2_hwmod' was not declared. Should it be static?

It's also missing the one-line comments above each OCP interface record, 
e.g.

/* l4_per1 -> gpio6 */

and a few other hwmod comments.  I've added those too.

By courtesy, I've fixed these issues for this patch.  But in the future, 
please check your patches before sending to make sure that they don't add 
new sparse warnings. If you need help running sparse, let us know (or 
Nishanth can probably help you out; I think he's got some scripts that 
test patch sets for common pre-submission problems).  And please try to 
align with the comment style of the rest of the hwmod files.


- Paul

From: Vignesh R <vigneshr@ti.com>
Date: Sun, 10 Apr 2016 11:54:24 -0600
Subject: [PATCH] ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS

Add hwmod entries for the PWMSS on DRA7.

Set l4_root_clk_div as the main_clk of PWMSS. It is fixed-factored clock
equal to L4PER2_L3_GICLK/2(l3_iclk_div/2).

Signed-off-by: Vignesh R <vigneshr@ti.com>
[fcooper@ti.com: Do not add eQEP, ePWM and eCAP hwmod entries]
Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
[paul@pwsan.com: fixed sparse warnings; added missing comments]
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 89 +++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 7610f3ef28b7..2f15cf13e0d7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -383,6 +383,68 @@ static struct omap_hwmod dra7xx_dcan2_hwmod = {
 	},
 };
 
+/* pwmss  */
+static struct omap_hwmod_class_sysconfig dra7xx_epwmss_sysc = {
+	.rev_offs	= 0x0,
+	.sysc_offs	= 0x4,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET,
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
+	.sysc_fields	= &omap_hwmod_sysc_type2,
+};
+
+/*
+ * epwmss class
+ */
+static struct omap_hwmod_class dra7xx_epwmss_hwmod_class = {
+	.name		= "epwmss",
+	.sysc		= &dra7xx_epwmss_sysc,
+};
+
+/* epwmss0 */
+static struct omap_hwmod dra7xx_epwmss0_hwmod = {
+	.name		= "epwmss0",
+	.class		= &dra7xx_epwmss_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "l4_root_clk_div",
+	.prcm		= {
+		.omap4	= {
+			.modulemode	= MODULEMODE_SWCTRL,
+			.clkctrl_offs	= DRA7XX_CM_L4PER2_PWMSS1_CLKCTRL_OFFSET,
+			.context_offs	= DRA7XX_RM_L4PER2_PWMSS1_CONTEXT_OFFSET,
+		},
+	},
+};
+
+/* epwmss1 */
+static struct omap_hwmod dra7xx_epwmss1_hwmod = {
+	.name		= "epwmss1",
+	.class		= &dra7xx_epwmss_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "l4_root_clk_div",
+	.prcm		= {
+		.omap4	= {
+			.modulemode	= MODULEMODE_SWCTRL,
+			.clkctrl_offs	= DRA7XX_CM_L4PER2_PWMSS2_CLKCTRL_OFFSET,
+			.context_offs	= DRA7XX_RM_L4PER2_PWMSS2_CONTEXT_OFFSET,
+		},
+	},
+};
+
+/* epwmss2 */
+static struct omap_hwmod dra7xx_epwmss2_hwmod = {
+	.name		= "epwmss2",
+	.class		= &dra7xx_epwmss_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "l4_root_clk_div",
+	.prcm		= {
+		.omap4	= {
+			.modulemode	= MODULEMODE_SWCTRL,
+			.clkctrl_offs	= DRA7XX_CM_L4PER2_PWMSS3_CLKCTRL_OFFSET,
+			.context_offs	= DRA7XX_RM_L4PER2_PWMSS3_CONTEXT_OFFSET,
+		},
+	},
+};
+
 /*
  * 'dma' class
  *
@@ -3693,6 +3755,30 @@ static struct omap_hwmod_ocp_if dra7xx_l4_wkup__wd_timer2 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/* l4_per2 -> epwmss0 */
+static struct omap_hwmod_ocp_if dra7xx_l4_per2__epwmss0 = {
+	.master		= &dra7xx_l4_per2_hwmod,
+	.slave		= &dra7xx_epwmss0_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU,
+};
+
+/* l4_per2 -> epwmss1 */
+static struct omap_hwmod_ocp_if dra7xx_l4_per2__epwmss1 = {
+	.master		= &dra7xx_l4_per2_hwmod,
+	.slave		= &dra7xx_epwmss1_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU,
+};
+
+/* l4_per2 -> epwmss2 */
+static struct omap_hwmod_ocp_if dra7xx_l4_per2__epwmss2 = {
+	.master		= &dra7xx_l4_per2_hwmod,
+	.slave		= &dra7xx_epwmss2_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU,
+};
+
 static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l3_main_1__dmm,
 	&dra7xx_l3_main_2__l3_instr,
@@ -3814,6 +3900,9 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l3_main_1__vcp2,
 	&dra7xx_l4_per2__vcp2,
 	&dra7xx_l4_wkup__wd_timer2,
+	&dra7xx_l4_per2__epwmss0,
+	&dra7xx_l4_per2__epwmss1,
+	&dra7xx_l4_per2__epwmss2,
 	NULL,
 };
 
-- 
2.8.0.rc3
