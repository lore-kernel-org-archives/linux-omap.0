From: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Subject: [Patch v4 4/6] ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS
Date: Mon,  7 Mar 2016 14:39:45 -0600
Message-ID: <1457383187-17166-5-git-send-email-fcooper@ti.com>
References: <1457383187-17166-1-git-send-email-fcooper@ti.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457383187-17166-1-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: vigneshr-l0cyMroinI0@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>

Add hwmod entries for the PWMSS on DRA7.

Set l4_root_clk_div as the main_clk of PWMSS. It is fixed-factored clock
equal to L4PER2_L3_GICLK/2(l3_iclk_div/2).

Signed-off-by: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
[fcooper-l0cyMroinI0@public.gmane.org: Do not add eQEP, ePWM and eCAP hwmod entries]
Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
---
Version 4 changes:
Do not include eQEP, ePWM and eCAP hwmod entries.

 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 83 +++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 848356e..f8f5aa2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -383,6 +383,65 @@ static struct omap_hwmod dra7xx_dcan2_hwmod = {
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
+struct omap_hwmod_class dra7xx_epwmss_hwmod_class = {
+	.name		= "epwmss",
+	.sysc		= &dra7xx_epwmss_sysc,
+};
+
+/* epwmss0 */
+struct omap_hwmod dra7xx_epwmss0_hwmod = {
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
+struct omap_hwmod dra7xx_epwmss1_hwmod = {
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
+struct omap_hwmod dra7xx_epwmss2_hwmod = {
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
@@ -2676,6 +2735,27 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per1__gpio6 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+struct omap_hwmod_ocp_if dra7xx_l4_per2__epwmss0 = {
+	.master		= &dra7xx_l4_per2_hwmod,
+	.slave		= &dra7xx_epwmss0_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if dra7xx_l4_per2__epwmss1 = {
+	.master		= &dra7xx_l4_per2_hwmod,
+	.slave		= &dra7xx_epwmss1_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if dra7xx_l4_per2__epwmss2 = {
+	.master		= &dra7xx_l4_per2_hwmod,
+	.slave		= &dra7xx_epwmss2_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU,
+};
+
 /* l4_per1 -> gpio7 */
 static struct omap_hwmod_ocp_if dra7xx_l4_per1__gpio7 = {
 	.master		= &dra7xx_l4_per1_hwmod,
@@ -3452,6 +3532,9 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l3_main_1__vcp2,
 	&dra7xx_l4_per2__vcp2,
 	&dra7xx_l4_wkup__wd_timer2,
+	&dra7xx_l4_per2__epwmss0,
+	&dra7xx_l4_per2__epwmss1,
+	&dra7xx_l4_per2__epwmss2,
 	NULL,
 };
 
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
