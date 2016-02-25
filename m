From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH v3 2/5] ARM: OMAP2+: DRA7: Add hwmod entries for PWMSS
Date: Thu, 25 Feb 2016 16:36:33 -0600
Message-ID: <1456439796-28546-3-git-send-email-fcooper@ti.com>
References: <1456439796-28546-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1456439796-28546-1-git-send-email-fcooper@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: paul@pwsan.com, t-kristo@ti.com, tony@atomide.com, vigneshr@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Vignesh R <vigneshr@ti.com>

Add hwmod entries for the PWMSS on DRA7.

Set l4_root_clk_div as the main_clk of PWMSS. It is fixed-factored clock
equal to L4PER2_L3_GICLK/2(l3_iclk_div/2).
As per AM57x TRM SPRUHZ6[1], October 2014, Section 29.1.3 Table 29-4,
clock source to PWMSS is L4PER2_L3_GICLK. But it is actually
L4PER2_L3_GICLK/2. The TRM does not show the division by 2.

[1] www.ti.com/lit/ug/spruhz6/spruhz6.pdf

Signed-off-by: Vignesh R <vigneshr@ti.com>
---
Version 3 changes:
Switch from SYSC_HAS_RESET_STATUS to SYSC_HAS_SOFTRESET which is the
correct bitfield for that register.

 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 239 ++++++++++++++++++++++++++++++
 1 file changed, 239 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
index 848356e..4b2d68b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -383,6 +383,149 @@ static struct omap_hwmod dra7xx_dcan2_hwmod = {
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
+static struct omap_hwmod_class dra7xx_ecap_hwmod_class = {
+	.name		= "ecap",
+};
+
+static struct omap_hwmod_class dra7xx_eqep_hwmod_class = {
+	.name		= "eqep",
+};
+
+struct omap_hwmod_class dra7xx_ehrpwm_hwmod_class = {
+	.name		= "ehrpwm",
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
+/* ecap0 */
+struct omap_hwmod dra7xx_ecap0_hwmod = {
+	.name		= "ecap0",
+	.class		= &dra7xx_ecap_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "l4_root_clk_div",
+};
+
+/* eqep0 */
+struct omap_hwmod dra7xx_eqep0_hwmod = {
+	.name		= "eqep0",
+	.class		= &dra7xx_eqep_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "l4_root_clk_div",
+};
+
+/* ehrpwm0 */
+struct omap_hwmod dra7xx_ehrpwm0_hwmod = {
+	.name		= "ehrpwm0",
+	.class		= &dra7xx_ehrpwm_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "l4_root_clk_div",
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
+/* ecap1 */
+struct omap_hwmod dra7xx_ecap1_hwmod = {
+	.name		= "ecap1",
+	.class		= &dra7xx_ecap_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "l4_root_clk_div",
+};
+
+/* eqep1 */
+struct omap_hwmod dra7xx_eqep1_hwmod = {
+	.name		= "eqep1",
+	.class		= &dra7xx_eqep_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "l4_root_clk_div",
+};
+
+/* ehrpwm1 */
+struct omap_hwmod dra7xx_ehrpwm1_hwmod = {
+	.name		= "ehrpwm1",
+	.class		= &dra7xx_ehrpwm_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "l4_root_clk_div",
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
+/* ecap2 */
+struct omap_hwmod dra7xx_ecap2_hwmod = {
+	.name		= "ecap2",
+	.class		= &dra7xx_ecap_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "l4_root_clk_div",
+};
+
+/* eqep2 */
+struct omap_hwmod dra7xx_eqep2_hwmod = {
+	.name		= "eqep2",
+	.class		= &dra7xx_eqep_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "l4_root_clk_div",
+};
+
+/* ehrpwm2 */
+struct omap_hwmod dra7xx_ehrpwm2_hwmod = {
+	.name		= "ehrpwm2",
+	.class		= &dra7xx_ehrpwm_hwmod_class,
+	.clkdm_name	= "l4per2_clkdm",
+	.main_clk	= "l4_root_clk_div",
+};
+
 /*
  * 'dma' class
  *
@@ -2676,6 +2819,90 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per1__gpio6 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+struct omap_hwmod_ocp_if dra7xx_l4_per2__epwmss0 = {
+	.master		= &dra7xx_l4_per2_hwmod,
+	.slave		= &dra7xx_epwmss0_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if dra7xx_epwmss0__ecap0 = {
+	.master		= &dra7xx_epwmss0_hwmod,
+	.slave		= &dra7xx_ecap0_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if dra7xx_epwmss0__eqep0 = {
+	.master		= &dra7xx_epwmss0_hwmod,
+	.slave		= &dra7xx_eqep0_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if dra7xx_epwmss0__ehrpwm0 = {
+	.master		= &dra7xx_epwmss0_hwmod,
+	.slave		= &dra7xx_ehrpwm0_hwmod,
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
+struct omap_hwmod_ocp_if dra7xx_epwmss1__ecap1 = {
+	.master		= &dra7xx_epwmss1_hwmod,
+	.slave		= &dra7xx_ecap1_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if dra7xx_epwmss1__eqep1 = {
+	.master		= &dra7xx_epwmss1_hwmod,
+	.slave		= &dra7xx_eqep1_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if dra7xx_epwmss1__ehrpwm1 = {
+	.master		= &dra7xx_epwmss1_hwmod,
+	.slave		= &dra7xx_ehrpwm1_hwmod,
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
+struct omap_hwmod_ocp_if dra7xx_epwmss2__ecap2 = {
+	.master		= &dra7xx_epwmss2_hwmod,
+	.slave		= &dra7xx_ecap2_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if dra7xx_epwmss2__eqep2 = {
+	.master		= &dra7xx_epwmss2_hwmod,
+	.slave		= &dra7xx_eqep2_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU,
+};
+
+struct omap_hwmod_ocp_if dra7xx_epwmss2__ehrpwm2 = {
+	.master		= &dra7xx_epwmss2_hwmod,
+	.slave		= &dra7xx_ehrpwm2_hwmod,
+	.clk		= "l4_root_clk_div",
+	.user		= OCP_USER_MPU,
+};
+
 /* l4_per1 -> gpio7 */
 static struct omap_hwmod_ocp_if dra7xx_l4_per1__gpio7 = {
 	.master		= &dra7xx_l4_per1_hwmod,
@@ -3452,6 +3679,18 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l3_main_1__vcp2,
 	&dra7xx_l4_per2__vcp2,
 	&dra7xx_l4_wkup__wd_timer2,
+	&dra7xx_l4_per2__epwmss0,
+	&dra7xx_epwmss0__ecap0,
+	&dra7xx_epwmss0__eqep0,
+	&dra7xx_epwmss0__ehrpwm0,
+	&dra7xx_l4_per2__epwmss1,
+	&dra7xx_epwmss1__ecap1,
+	&dra7xx_epwmss1__eqep1,
+	&dra7xx_epwmss1__ehrpwm1,
+	&dra7xx_l4_per2__epwmss2,
+	&dra7xx_epwmss2__ecap2,
+	&dra7xx_epwmss2__eqep2,
+	&dra7xx_epwmss2__ehrpwm2,
 	NULL,
 };
 
-- 
2.7.0
