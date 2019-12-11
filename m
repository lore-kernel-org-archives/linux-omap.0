From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 14/16] ARM: OMAP2+: Drop legacy platform data for omap4 elm
Date: Wed, 11 Dec 2019 09:20:12 -0800
Message-ID: <20191211172014.35201-15-tony@atomide.com>
References: <20191211172014.35201-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191211172014.35201-1-tony@atomide.com>
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
Cc: Vignesh R <vigneshr@ti.com>, Keerthy <j-keerthy@ti.com>, Jyri Sarha <jsarha@ti.com>, "Andrew F. Davis" <afd@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>, Franklin S Cooper Jr <fcooper@ti.com>, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

We can now probe devices with ti-sysc interconnect driver and dts
data. Let's drop the related platform data and custom ti,hwmods
dts property.

As we're just dropping data, and the early platform data init
is based on the custom ti,hwmods property, we want to drop both
the platform data and ti,hwmods property in a single patch.

Cc: Franklin S Cooper Jr <fcooper@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Cc: Roger Quadros <rogerq@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-l4.dtsi            |  1 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 42 ----------------------
 2 files changed, 43 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-l4.dtsi b/arch/arm/boot/dts/omap4-l4.dtsi
--- a/arch/arm/boot/dts/omap4-l4.dtsi
+++ b/arch/arm/boot/dts/omap4-l4.dtsi
@@ -1908,7 +1908,6 @@ target-module@76000 {			/* 0x48076000, ap 39 38.0 */
 
 		target-module@78000 {			/* 0x48078000, ap 41 1a.0 */
 			compatible = "ti,sysc-omap2", "ti,sysc";
-			ti,hwmods = "elm";
 			reg = <0x78000 0x4>,
 			      <0x78010 0x4>,
 			      <0x78014 0x4>;
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -707,39 +707,6 @@ static struct omap_hwmod omap44xx_dss_venc_hwmod = {
 };
 
 
-/*
- * 'elm' class
- * bch error location module
- */
-
-static struct omap_hwmod_class_sysconfig omap44xx_elm_sysc = {
-	.rev_offs	= 0x0000,
-	.sysc_offs	= 0x0010,
-	.syss_offs	= 0x0014,
-	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
-			   SYSC_HAS_SIDLEMODE | SYSC_HAS_SOFTRESET |
-			   SYSS_HAS_RESET_STATUS),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-static struct omap_hwmod_class omap44xx_elm_hwmod_class = {
-	.name	= "elm",
-	.sysc	= &omap44xx_elm_sysc,
-};
-
-/* elm */
-static struct omap_hwmod omap44xx_elm_hwmod = {
-	.name		= "elm",
-	.class		= &omap44xx_elm_hwmod_class,
-	.clkdm_name	= "l4_per_clkdm",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4PER_ELM_CLKCTRL_OFFSET,
-			.context_offs = OMAP4_RM_L4PER_ELM_CONTEXT_OFFSET,
-		},
-	},
-};
 
 /*
  * 'emif' class
@@ -2130,14 +2097,6 @@ static struct omap_hwmod_ocp_if omap44xx_l4_per__dss_venc = {
 	.user		= OCP_USER_MPU,
 };
 
-/* l4_per -> elm */
-static struct omap_hwmod_ocp_if omap44xx_l4_per__elm = {
-	.master		= &omap44xx_l4_per_hwmod,
-	.slave		= &omap44xx_elm_hwmod,
-	.clk		= "l4_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_cfg -> fdif */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__fdif = {
 	.master		= &omap44xx_l4_cfg_hwmod,
@@ -2419,7 +2378,6 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_per__dss_rfbi,
 	&omap44xx_l3_main_2__dss_venc,
 	&omap44xx_l4_per__dss_venc,
-	&omap44xx_l4_per__elm,
 	&omap44xx_l4_cfg__fdif,
 	&omap44xx_l3_main_2__gpmc,
 	&omap44xx_l4_cfg__hsi,
-- 
2.24.1
