From: "Philip, Avinash" <avinashphilip-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5 06/12] ARM: AM33XX: clk: Add clock node for EHRPWM TBCLK
Date: Tue, 27 Nov 2012 14:18:11 +0530
Message-ID: <1354006097-25895-7-git-send-email-avinashphilip@ti.com>
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

EHRPWM module requires explicit clock gating of TBCLK from control
module. Hence add TBCLK clock node in clock tree for EHRPWM modules.

Signed-off-by: Philip, Avinash <avinashphilip-l0cyMroinI0@public.gmane.org>
---
Changes since v4:
	- Add dev_id field in clcok tree for TBCLK to remove support
	  for optional HWMOD clock support for EHRPWM.

 arch/arm/mach-omap2/clock33xx_data.c |   37 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/control.h        |    8 +++++++
 2 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/clock33xx_data.c b/arch/arm/mach-omap2/clock33xx_data.c
index 1a45d6b..d08cd9a 100644
--- a/arch/arm/mach-omap2/clock33xx_data.c
+++ b/arch/arm/mach-omap2/clock33xx_data.c
@@ -996,6 +996,40 @@ static struct clk wdt1_fck = {
 };
 
 /*
+ * PWMSS Time based module clock node. This node is
+ * requred to enable clock gating for EHRPWM TBCLK.
+ */
+static struct clk ehrpwm0_tbclk = {
+	.name		= "ehrpwm0_tbclk",
+	.clkdm_name	= "l4ls_clkdm",
+	.enable_reg	= AM33XX_CTRL_REGADDR(AM33XX_PWMSS_TBCLK_CLKCTRL),
+	.enable_bit	= AM33XX_PWMSS0_TBCLKEN_SHIFT,
+	.ops		= &clkops_omap2_dflt,
+	.parent		= &l4ls_gclk,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk ehrpwm1_tbclk = {
+	.name		= "ehrpwm1_tbclk",
+	.clkdm_name	= "l4ls_clkdm",
+	.enable_reg	= AM33XX_CTRL_REGADDR(AM33XX_PWMSS_TBCLK_CLKCTRL),
+	.enable_bit	= AM33XX_PWMSS1_TBCLKEN_SHIFT,
+	.ops		= &clkops_omap2_dflt,
+	.parent		= &l4ls_gclk,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk ehrpwm2_tbclk = {
+	.name		= "ehrpwm2_tbclk",
+	.clkdm_name	= "l4ls_clkdm",
+	.enable_reg	= AM33XX_CTRL_REGADDR(AM33XX_PWMSS_TBCLK_CLKCTRL),
+	.enable_bit	= AM33XX_PWMSS2_TBCLKEN_SHIFT,
+	.ops		= &clkops_omap2_dflt,
+	.parent		= &l4ls_gclk,
+	.recalc		= &followparent_recalc,
+};
+
+/*
  * clkdev
  */
 static struct omap_clk am33xx_clks[] = {
@@ -1075,6 +1109,9 @@ static struct omap_clk am33xx_clks[] = {
 	CLK(NULL,	"clkout2_ck",		&clkout2_ck,	CK_AM33XX),
 	CLK(NULL,	"timer_32k_ck",		&clkdiv32k_ick,	CK_AM33XX),
 	CLK(NULL,	"timer_sys_ck",		&sys_clkin_ck,	CK_AM33XX),
+	CLK("48300200.ehrpwm",	"tbclk",	&ehrpwm0_tbclk,	CK_AM33XX),
+	CLK("48302200.ehrpwm",	"tbclk",	&ehrpwm1_tbclk,	CK_AM33XX),
+	CLK("48304200.ehrpwm",	"tbclk",	&ehrpwm2_tbclk,	CK_AM33XX),
 };
 
 int __init am33xx_clk_init(void)
diff --git a/arch/arm/mach-omap2/control.h b/arch/arm/mach-omap2/control.h
index a89e825..c0e34e6 100644
--- a/arch/arm/mach-omap2/control.h
+++ b/arch/arm/mach-omap2/control.h
@@ -357,6 +357,14 @@
 #define AM33XX_CONTROL_STATUS_SYSBOOT1_WIDTH		0x2
 #define AM33XX_CONTROL_STATUS_SYSBOOT1_MASK		(0x3 << 22)
 
+/* AM33XX PWMSS Control register */
+#define AM33XX_PWMSS_TBCLK_CLKCTRL			0x664
+
+/* AM33XX  PWMSS Control bitfields */
+#define AM33XX_PWMSS0_TBCLKEN_SHIFT			0
+#define AM33XX_PWMSS1_TBCLKEN_SHIFT			1
+#define AM33XX_PWMSS2_TBCLKEN_SHIFT			2
+
 /* CONTROL OMAP STATUS register to identify OMAP3 features */
 #define OMAP3_CONTROL_OMAP_STATUS	0x044c
 
-- 
1.7.0.4
