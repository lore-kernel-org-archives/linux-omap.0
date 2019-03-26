From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] ARM: OMAP2+: Drop uart platform data for dra7
Date: Tue, 26 Mar 2019 11:35:35 -0700
Message-ID: <20190326183535.20798-5-tony@atomide.com>
References: <20190326183535.20798-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190326183535.20798-1-tony@atomide.com>
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
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

We can now drop legacy platform data one interconnect target module at
a time in favor of the device tree based data that has been added earlier.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 272 ----------------------
 1 file changed, 272 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -1954,188 +1954,6 @@ static struct omap_hwmod dra7xx_timer16_hwmod = {
 	},
 };
 
-/*
- * 'uart' class
- *
- */
-
-static struct omap_hwmod_class_sysconfig dra7xx_uart_sysc = {
-	.rev_offs	= 0x0050,
-	.sysc_offs	= 0x0054,
-	.syss_offs	= 0x0058,
-	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_ENAWAKEUP |
-			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
-			   SYSS_HAS_RESET_STATUS),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   SIDLE_SMART_WKUP),
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-static struct omap_hwmod_class dra7xx_uart_hwmod_class = {
-	.name	= "uart",
-	.sysc	= &dra7xx_uart_sysc,
-};
-
-/* uart1 */
-static struct omap_hwmod dra7xx_uart1_hwmod = {
-	.name		= "uart1",
-	.class		= &dra7xx_uart_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "uart1_gfclk_mux",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT | DEBUG_OMAP2UART1_FLAGS,
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_UART1_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L4PER_UART1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* uart2 */
-static struct omap_hwmod dra7xx_uart2_hwmod = {
-	.name		= "uart2",
-	.class		= &dra7xx_uart_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "uart2_gfclk_mux",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_UART2_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L4PER_UART2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* uart3 */
-static struct omap_hwmod dra7xx_uart3_hwmod = {
-	.name		= "uart3",
-	.class		= &dra7xx_uart_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "uart3_gfclk_mux",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT | DEBUG_OMAP4UART3_FLAGS,
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_UART3_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L4PER_UART3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* uart4 */
-static struct omap_hwmod dra7xx_uart4_hwmod = {
-	.name		= "uart4",
-	.class		= &dra7xx_uart_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "uart4_gfclk_mux",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT | DEBUG_OMAP4UART4_FLAGS,
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_UART4_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L4PER_UART4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* uart5 */
-static struct omap_hwmod dra7xx_uart5_hwmod = {
-	.name		= "uart5",
-	.class		= &dra7xx_uart_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.main_clk	= "uart5_gfclk_mux",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER_UART5_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L4PER_UART5_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* uart6 */
-static struct omap_hwmod dra7xx_uart6_hwmod = {
-	.name		= "uart6",
-	.class		= &dra7xx_uart_hwmod_class,
-	.clkdm_name	= "ipu_clkdm",
-	.main_clk	= "uart6_gfclk_mux",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_IPU_UART6_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_IPU_UART6_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* uart7 */
-static struct omap_hwmod dra7xx_uart7_hwmod = {
-	.name		= "uart7",
-	.class		= &dra7xx_uart_hwmod_class,
-	.clkdm_name	= "l4per2_clkdm",
-	.main_clk	= "uart7_gfclk_mux",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER2_UART7_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L4PER2_UART7_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* uart8 */
-static struct omap_hwmod dra7xx_uart8_hwmod = {
-	.name		= "uart8",
-	.class		= &dra7xx_uart_hwmod_class,
-	.clkdm_name	= "l4per2_clkdm",
-	.main_clk	= "uart8_gfclk_mux",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER2_UART8_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L4PER2_UART8_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* uart9 */
-static struct omap_hwmod dra7xx_uart9_hwmod = {
-	.name		= "uart9",
-	.class		= &dra7xx_uart_hwmod_class,
-	.clkdm_name	= "l4per2_clkdm",
-	.main_clk	= "uart9_gfclk_mux",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_L4PER2_UART9_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_L4PER2_UART9_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* uart10 */
-static struct omap_hwmod dra7xx_uart10_hwmod = {
-	.name		= "uart10",
-	.class		= &dra7xx_uart_hwmod_class,
-	.clkdm_name	= "wkupaon_clkdm",
-	.main_clk	= "uart10_gfclk_mux",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_WKUPAON_UART10_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_WKUPAON_UART10_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
 /* DES (the 'P' (public) device) */
 static struct omap_hwmod_class_sysconfig dra7xx_des_sysc = {
 	.rev_offs	= 0x0030,
@@ -3076,62 +2894,6 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per3__timer16 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_per1 -> uart1 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__uart1 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_uart1_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per1 -> uart2 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__uart2 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_uart2_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per1 -> uart3 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__uart3 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_uart3_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per1 -> uart4 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__uart4 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_uart4_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per1 -> uart5 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__uart5 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_uart5_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per1 -> uart6 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per1__uart6 = {
-	.master		= &dra7xx_l4_per1_hwmod,
-	.slave		= &dra7xx_uart6_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per2 -> uart7 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per2__uart7 = {
-	.master		= &dra7xx_l4_per2_hwmod,
-	.slave		= &dra7xx_uart7_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_per1 -> des */
 static struct omap_hwmod_ocp_if dra7xx_l4_per1__des = {
 	.master		= &dra7xx_l4_per1_hwmod,
@@ -3140,30 +2902,6 @@ static struct omap_hwmod_ocp_if dra7xx_l4_per1__des = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_per2 -> uart8 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per2__uart8 = {
-	.master		= &dra7xx_l4_per2_hwmod,
-	.slave		= &dra7xx_uart8_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per2 -> uart9 */
-static struct omap_hwmod_ocp_if dra7xx_l4_per2__uart9 = {
-	.master		= &dra7xx_l4_per2_hwmod,
-	.slave		= &dra7xx_uart9_hwmod,
-	.clk		= "l3_iclk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_wkup -> uart10 */
-static struct omap_hwmod_ocp_if dra7xx_l4_wkup__uart10 = {
-	.master		= &dra7xx_l4_wkup_hwmod,
-	.slave		= &dra7xx_uart10_hwmod,
-	.clk		= "wkupaon_iclk_mux",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_per1 -> rng */
 static struct omap_hwmod_ocp_if dra7xx_l4_per1__rng = {
 	.master         = &dra7xx_l4_per1_hwmod,
@@ -3355,16 +3093,6 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_per3__timer14,
 	&dra7xx_l4_per3__timer15,
 	&dra7xx_l4_per3__timer16,
-	&dra7xx_l4_per1__uart1,
-	&dra7xx_l4_per1__uart2,
-	&dra7xx_l4_per1__uart3,
-	&dra7xx_l4_per1__uart4,
-	&dra7xx_l4_per1__uart5,
-	&dra7xx_l4_per1__uart6,
-	&dra7xx_l4_per2__uart7,
-	&dra7xx_l4_per2__uart8,
-	&dra7xx_l4_per2__uart9,
-	&dra7xx_l4_wkup__uart10,
 	&dra7xx_l4_per1__des,
 	&dra7xx_l4_per3__usb_otg_ss1,
 	&dra7xx_l4_per3__usb_otg_ss2,
-- 
2.21.0
