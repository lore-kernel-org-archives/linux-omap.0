From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 4/4] ARM: OMAP2+: Drop uart platform data for omap5
Date: Tue, 26 Mar 2019 11:30:54 -0700
Message-ID: <20190326183054.7598-5-tony@atomide.com>
References: <20190326183054.7598-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190326183054.7598-1-tony@atomide.com>
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
 arch/arm/mach-omap2/omap_hwmod_54xx_data.c | 172 ---------------------
 1 file changed, 172 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_54xx_data.c
@@ -1243,124 +1243,6 @@ static struct omap_hwmod omap54xx_timer11_hwmod = {
 	},
 };
 
-/*
- * 'uart' class
- * universal asynchronous receiver/transmitter (uart)
- */
-
-static struct omap_hwmod_class_sysconfig omap54xx_uart_sysc = {
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
-static struct omap_hwmod_class omap54xx_uart_hwmod_class = {
-	.name	= "uart",
-	.sysc	= &omap54xx_uart_sysc,
-};
-
-/* uart1 */
-static struct omap_hwmod omap54xx_uart1_hwmod = {
-	.name		= "uart1",
-	.class		= &omap54xx_uart_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "func_48m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_UART1_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L4PER_UART1_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* uart2 */
-static struct omap_hwmod omap54xx_uart2_hwmod = {
-	.name		= "uart2",
-	.class		= &omap54xx_uart_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "func_48m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_UART2_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L4PER_UART2_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* uart3 */
-static struct omap_hwmod omap54xx_uart3_hwmod = {
-	.name		= "uart3",
-	.class		= &omap54xx_uart_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= DEBUG_OMAP4UART3_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "func_48m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_UART3_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L4PER_UART3_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* uart4 */
-static struct omap_hwmod omap54xx_uart4_hwmod = {
-	.name		= "uart4",
-	.class		= &omap54xx_uart_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= DEBUG_OMAP4UART4_FLAGS | HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "func_48m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_UART4_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L4PER_UART4_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* uart5 */
-static struct omap_hwmod omap54xx_uart5_hwmod = {
-	.name		= "uart5",
-	.class		= &omap54xx_uart_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "func_48m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_UART5_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L4PER_UART5_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-/* uart6 */
-static struct omap_hwmod omap54xx_uart6_hwmod = {
-	.name		= "uart6",
-	.class		= &omap54xx_uart_hwmod_class,
-	.clkdm_name	= "l4per_clkdm",
-	.flags		= HWMOD_SWSUP_SIDLE_ACT,
-	.main_clk	= "func_48m_fclk",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP54XX_CM_L4PER_UART6_CLKCTRL_OFFSET,
-			.context_offs = OMAP54XX_RM_L4PER_UART6_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-};
-
 /*
  * 'usb_host_hs' class
  * high-speed multi-port usb host controller
@@ -2052,54 +1934,6 @@ static struct omap_hwmod_ocp_if omap54xx_l4_per__timer11 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_per -> uart1 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__uart1 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_uart1_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> uart2 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__uart2 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_uart2_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> uart3 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__uart3 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_uart3_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> uart4 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__uart4 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_uart4_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> uart5 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__uart5 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_uart5_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-/* l4_per -> uart6 */
-static struct omap_hwmod_ocp_if omap54xx_l4_per__uart6 = {
-	.master		= &omap54xx_l4_per_hwmod,
-	.slave		= &omap54xx_uart6_hwmod,
-	.clk		= "l4_root_clk_div",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_cfg -> usb_host_hs */
 static struct omap_hwmod_ocp_if omap54xx_l4_cfg__usb_host_hs = {
 	.master		= &omap54xx_l4_cfg_hwmod,
@@ -2186,12 +2020,6 @@ static struct omap_hwmod_ocp_if *omap54xx_hwmod_ocp_ifs[] __initdata = {
 	&omap54xx_l4_per__timer9,
 	&omap54xx_l4_per__timer10,
 	&omap54xx_l4_per__timer11,
-	&omap54xx_l4_per__uart1,
-	&omap54xx_l4_per__uart2,
-	&omap54xx_l4_per__uart3,
-	&omap54xx_l4_per__uart4,
-	&omap54xx_l4_per__uart5,
-	&omap54xx_l4_per__uart6,
 	&omap54xx_l4_cfg__usb_host_hs,
 	&omap54xx_l4_cfg__usb_tll_hs,
 	&omap54xx_l4_cfg__usb_otg_ss,
-- 
2.21.0
