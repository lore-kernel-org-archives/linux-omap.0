From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/16] ARM: OMAP2+: Drop legacy platform data for omap4
 spinlock
Date: Wed, 11 Dec 2019 09:20:02 -0800
Message-ID: <20191211172014.35201-5-tony@atomide.com>
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

Cc: Suman Anna <s-anna@ti.com>
Cc: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-l4.dtsi            |  1 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 43 ----------------------
 2 files changed, 44 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-l4.dtsi b/arch/arm/boot/dts/omap4-l4.dtsi
--- a/arch/arm/boot/dts/omap4-l4.dtsi
+++ b/arch/arm/boot/dts/omap4-l4.dtsi
@@ -613,7 +613,6 @@ mbox_dsp: mbox_dsp {
 
 		target-module@76000 {			/* 0x4a0f6000, ap 29 3a.0 */
 			compatible = "ti,sysc-omap2", "ti,sysc";
-			ti,hwmods = "spinlock";
 			reg = <0x76000 0x4>,
 			      <0x76010 0x4>,
 			      <0x76014 0x4>;
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1490,40 +1490,6 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 	.dev_attr	= &smartreflex_mpu_dev_attr,
 };
 
-/*
- * 'spinlock' class
- * spinlock provides hardware assistance for synchronizing the processes
- * running on multiple processors
- */
-
-static struct omap_hwmod_class_sysconfig omap44xx_spinlock_sysc = {
-	.rev_offs	= 0x0000,
-	.sysc_offs	= 0x0010,
-	.syss_offs	= 0x0014,
-	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_CLOCKACTIVITY |
-			   SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE |
-			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART),
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-static struct omap_hwmod_class omap44xx_spinlock_hwmod_class = {
-	.name	= "spinlock",
-	.sysc	= &omap44xx_spinlock_sysc,
-};
-
-/* spinlock */
-static struct omap_hwmod omap44xx_spinlock_hwmod = {
-	.name		= "spinlock",
-	.class		= &omap44xx_spinlock_hwmod_class,
-	.clkdm_name	= "l4_cfg_clkdm",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = OMAP4_CM_L4CFG_HW_SEM_CLKCTRL_OFFSET,
-			.context_offs = OMAP4_RM_L4CFG_HW_SEM_CONTEXT_OFFSET,
-		},
-	},
-};
 
 /*
  * 'timer' class
@@ -2348,14 +2314,6 @@ static struct omap_hwmod_ocp_if omap44xx_l4_cfg__smartreflex_mpu = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-/* l4_cfg -> spinlock */
-static struct omap_hwmod_ocp_if omap44xx_l4_cfg__spinlock = {
-	.master		= &omap44xx_l4_cfg_hwmod,
-	.slave		= &omap44xx_spinlock_hwmod,
-	.clk		= "l4_div_ck",
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_wkup -> timer1 */
 static struct omap_hwmod_ocp_if omap44xx_l4_wkup__timer1 = {
 	.master		= &omap44xx_l4_wkup_hwmod,
@@ -2486,7 +2444,6 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_cfg__smartreflex_core,
 	&omap44xx_l4_cfg__smartreflex_iva,
 	&omap44xx_l4_cfg__smartreflex_mpu,
-	&omap44xx_l4_cfg__spinlock,
 	&omap44xx_l4_wkup__timer1,
 	/* &omap44xx_l4_cfg__usb_host_fs, */
 	&omap44xx_l4_cfg__usb_host_hs,
-- 
2.24.1
