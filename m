From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5 02/12] ARM: OMAP: AM33xx hwmod: Corrects PWM subsystem
 HWMOD entries
Date: Tue, 27 Nov 2012 14:18:07 +0530
Message-ID: <1354006097-25895-3-git-send-email-avinashphilip@ti.com>
References: <1354006097-25895-1-git-send-email-avinashphilip@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1354006097-25895-1-git-send-email-avinashphilip-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, "Philip,
 Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>, vaibhav.bedia-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

EQEP entry is HWMOD entry is not present in HWMOD entry. Also address
ranges specified for EACP & EHRPWM is not correct & HWMOD flags of
ADDR_TYPE_RT is added to PWM subsystem register address space. This
patch
1. Corrects register address mapping for ECAP & EHRPWM
2. Removes  HWMOD flags in PWM submodule register address space.
3. Adds EQEP HWMOD entries.

Signed-off-by: Philip, Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>
---
Changes since v4:
	- Split the HWMOD patches to handle correction of PWMi
	  subsystem correction.

 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |  158 +++++++++++++++++++++++++---
 1 files changed, 145 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 59d5c1c..9ed0bcf 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -769,7 +769,7 @@ static struct omap_hwmod am33xx_elm_hwmod = {
 };
 
 /*
- * 'epwmss' class: ecap0,1,2,  ehrpwm0,1,2
+ * 'epwmss' class: ehrpwm0,1,2 eqep0,1,2 ecap0,1,2
  */
 static struct omap_hwmod_class_sysconfig am33xx_epwmss_sysc = {
 	.rev_offs	= 0x0,
@@ -849,6 +849,66 @@ static struct omap_hwmod am33xx_ehrpwm2_hwmod = {
 	},
 };
 
+/* eqep0 */
+static struct omap_hwmod_irq_info am33xx_eqep0_irqs[] = {
+	{ .irq = 79 + OMAP_INTC_START, },
+	{ .irq = -1 },
+};
+
+static struct omap_hwmod am33xx_eqep0_hwmod = {
+	.name		= "eqep0",
+	.class		= &am33xx_epwmss_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.mpu_irqs	= am33xx_eqep0_irqs,
+	.main_clk	= "l4ls_gclk",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= AM33XX_CM_PER_EPWMSS0_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/* eqep1 */
+static struct omap_hwmod_irq_info am33xx_eqep1_irqs[] = {
+	{ .irq = 88 + OMAP_INTC_START, },
+	{ .irq = -1 },
+};
+
+static struct omap_hwmod am33xx_eqep1_hwmod = {
+	.name		= "eqep1",
+	.class		= &am33xx_epwmss_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.mpu_irqs	= am33xx_eqep1_irqs,
+	.main_clk	= "l4ls_gclk",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= AM33XX_CM_PER_EPWMSS1_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+/* eqep2 */
+static struct omap_hwmod_irq_info am33xx_eqep2_irqs[] = {
+	{ .irq = 89 + OMAP_INTC_START, },
+	{ .irq = -1 },
+};
+
+static struct omap_hwmod am33xx_eqep2_hwmod = {
+	.name		= "eqep2",
+	.class		= &am33xx_epwmss_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.mpu_irqs	= am33xx_eqep2_irqs,
+	.main_clk	= "l4ls_gclk",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= AM33XX_CM_PER_EPWMSS2_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
 /* ecap0 */
 static struct omap_hwmod_irq_info am33xx_ecap0_irqs[] = {
 	{ .irq = 31 + OMAP_INTC_START, },
@@ -2530,8 +2590,7 @@ static struct omap_hwmod_addr_space am33xx_ehrpwm0_addr_space[] = {
 	},
 	{
 		.pa_start	= 0x48300200,
-		.pa_end		= 0x48300200 + SZ_256 - 1,
-		.flags		= ADDR_TYPE_RT
+		.pa_end		= 0x48300200 + SZ_128 - 1,
 	},
 	{ }
 };
@@ -2556,8 +2615,7 @@ static struct omap_hwmod_addr_space am33xx_ehrpwm1_addr_space[] = {
 	},
 	{
 		.pa_start	= 0x48302200,
-		.pa_end		= 0x48302200 + SZ_256 - 1,
-		.flags		= ADDR_TYPE_RT
+		.pa_end		= 0x48302200 + SZ_128 - 1,
 	},
 	{ }
 };
@@ -2582,8 +2640,7 @@ static struct omap_hwmod_addr_space am33xx_ehrpwm2_addr_space[] = {
 	},
 	{
 		.pa_start	= 0x48304200,
-		.pa_end		= 0x48304200 + SZ_256 - 1,
-		.flags		= ADDR_TYPE_RT
+		.pa_end		= 0x48304200 + SZ_128 - 1,
 	},
 	{ }
 };
@@ -2600,6 +2657,81 @@ static struct omap_hwmod_ocp_if am33xx_l4_ls__ehrpwm2 = {
  * Splitting the resources to handle access of PWMSS config space
  * and module specific part independently
  */
+static struct omap_hwmod_addr_space am33xx_eqep0_addr_space[] = {
+	{
+		.pa_start	= 0x48300000,
+		.pa_end		= 0x48300000 + SZ_16 - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+	{
+		.pa_start	= 0x48300180,
+		.pa_end		= 0x48300180 + SZ_128 - 1,
+	},
+	{ }
+};
+
+static struct omap_hwmod_ocp_if am33xx_l4_ls__eqep0 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_eqep0_hwmod,
+	.clk		= "l4ls_gclk",
+	.addr		= am33xx_eqep0_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+/*
+ * Splitting the resources to handle access of PWMSS config space
+ * and module specific part independently
+ */
+static struct omap_hwmod_addr_space am33xx_eqep1_addr_space[] = {
+	{
+		.pa_start	= 0x48302000,
+		.pa_end		= 0x48302000 + SZ_16 - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+	{
+		.pa_start	= 0x48302180,
+		.pa_end		= 0x48302180 + SZ_128 - 1,
+	},
+	{ }
+};
+
+static struct omap_hwmod_ocp_if am33xx_l4_ls__eqep1 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_eqep1_hwmod,
+	.clk		= "l4ls_gclk",
+	.addr		= am33xx_eqep1_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+/*
+ * Splitting the resources to handle access of PWMSS config space
+ * and module specific part independently
+ */
+static struct omap_hwmod_addr_space am33xx_eqep2_addr_space[] = {
+	{
+		.pa_start	= 0x48304000,
+		.pa_end		= 0x48304000 + SZ_16 - 1,
+		.flags		= ADDR_TYPE_RT
+	},
+	{
+		.pa_start	= 0x48304180,
+		.pa_end		= 0x48304180 + SZ_128 - 1,
+	},
+	{ }
+};
+
+static struct omap_hwmod_ocp_if am33xx_l4_ls__eqep2 = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_eqep2_hwmod,
+	.clk		= "l4ls_gclk",
+	.addr		= am33xx_eqep2_addr_space,
+	.user		= OCP_USER_MPU,
+};
+
+/*
+ * Splitting the resources to handle access of PWMSS config space
+ * and module specific part independently
+ */
 static struct omap_hwmod_addr_space am33xx_ecap0_addr_space[] = {
 	{
 		.pa_start	= 0x48300000,
@@ -2608,8 +2740,7 @@ static struct omap_hwmod_addr_space am33xx_ecap0_addr_space[] = {
 	},
 	{
 		.pa_start	= 0x48300100,
-		.pa_end		= 0x48300100 + SZ_256 - 1,
-		.flags		= ADDR_TYPE_RT
+		.pa_end		= 0x48300100 + SZ_128 - 1,
 	},
 	{ }
 };
@@ -2634,8 +2765,7 @@ static struct omap_hwmod_addr_space am33xx_ecap1_addr_space[] = {
 	},
 	{
 		.pa_start	= 0x48302100,
-		.pa_end		= 0x48302100 + SZ_256 - 1,
-		.flags		= ADDR_TYPE_RT
+		.pa_end		= 0x48302100 + SZ_128 - 1,
 	},
 	{ }
 };
@@ -2660,8 +2790,7 @@ static struct omap_hwmod_addr_space am33xx_ecap2_addr_space[] = {
 	},
 	{
 		.pa_start	= 0x48304100,
-		.pa_end		= 0x48304100 + SZ_256 - 1,
-		.flags		= ADDR_TYPE_RT
+		.pa_end		= 0x48304100 + SZ_128 - 1,
 	},
 	{ }
 };
@@ -3359,6 +3488,9 @@ static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_ls__ehrpwm0,
 	&am33xx_l4_ls__ehrpwm1,
 	&am33xx_l4_ls__ehrpwm2,
+	&am33xx_l4_ls__eqep0,
+	&am33xx_l4_ls__eqep1,
+	&am33xx_l4_ls__eqep2,
 	&am33xx_l4_ls__ecap0,
 	&am33xx_l4_ls__ecap1,
 	&am33xx_l4_ls__ecap2,
-- 
1.7.0.4
