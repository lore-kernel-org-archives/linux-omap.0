From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/5] ARM: OMAP2+: Fix access to reserved smartreflex registers
 for dra7
Date: Tue, 29 Aug 2017 10:03:31 -0700
Message-ID: <20170829170335.11536-2-tony@atomide.com>
References: <20170829170335.11536-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170829170335.11536-1-tony@atomide.com>
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
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

The TRM has marked dra7 SmartReflex as reserved and we should not
touch those registers as pointed out by Nishanth Menon <nm@ti.com>.
So let's remove these registers.

If it later on turns out that these registers are needed for
some reason, the struct omap_hwmod_addr_space needs be mapped in
the device tree instead.

Cc: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 106 ------------------------------
 1 file changed, 106 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
--- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
@@ -20,7 +20,6 @@
 #include <linux/io.h>
 #include <linux/platform_data/gpio-omap.h>
 #include <linux/platform_data/hsmmc-omap.h>
-#include <linux/power/smartreflex.h>
 #include <linux/i2c-omap.h>
 
 #include <linux/omap-dma.h>
@@ -2054,73 +2053,6 @@ static struct omap_hwmod dra7xx_sata_hwmod = {
 	},
 };
 
-/*
- * 'smartreflex' class
- *
- */
-
-/* The IP is not compliant to type1 / type2 scheme */
-static struct omap_hwmod_sysc_fields omap_hwmod_sysc_type_smartreflex = {
-	.sidle_shift	= 24,
-	.enwkup_shift	= 26,
-};
-
-static struct omap_hwmod_class_sysconfig dra7xx_smartreflex_sysc = {
-	.sysc_offs	= 0x0038,
-	.sysc_flags	= (SYSC_HAS_ENAWAKEUP | SYSC_HAS_SIDLEMODE),
-	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   SIDLE_SMART_WKUP),
-	.sysc_fields	= &omap_hwmod_sysc_type_smartreflex,
-};
-
-static struct omap_hwmod_class dra7xx_smartreflex_hwmod_class = {
-	.name	= "smartreflex",
-	.sysc	= &dra7xx_smartreflex_sysc,
-	.rev	= 2,
-};
-
-/* smartreflex_core */
-/* smartreflex_core dev_attr */
-static struct omap_smartreflex_dev_attr smartreflex_core_dev_attr = {
-	.sensor_voltdm_name	= "core",
-};
-
-static struct omap_hwmod dra7xx_smartreflex_core_hwmod = {
-	.name		= "smartreflex_core",
-	.class		= &dra7xx_smartreflex_hwmod_class,
-	.clkdm_name	= "coreaon_clkdm",
-	.main_clk	= "wkupaon_iclk_mux",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_COREAON_SMARTREFLEX_CORE_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_COREAON_SMARTREFLEX_CORE_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-	.dev_attr	= &smartreflex_core_dev_attr,
-};
-
-/* smartreflex_mpu */
-/* smartreflex_mpu dev_attr */
-static struct omap_smartreflex_dev_attr smartreflex_mpu_dev_attr = {
-	.sensor_voltdm_name	= "mpu",
-};
-
-static struct omap_hwmod dra7xx_smartreflex_mpu_hwmod = {
-	.name		= "smartreflex_mpu",
-	.class		= &dra7xx_smartreflex_hwmod_class,
-	.clkdm_name	= "coreaon_clkdm",
-	.main_clk	= "wkupaon_iclk_mux",
-	.prcm = {
-		.omap4 = {
-			.clkctrl_offs = DRA7XX_CM_COREAON_SMARTREFLEX_MPU_CLKCTRL_OFFSET,
-			.context_offs = DRA7XX_RM_COREAON_SMARTREFLEX_MPU_CONTEXT_OFFSET,
-			.modulemode   = MODULEMODE_SWCTRL,
-		},
-	},
-	.dev_attr	= &smartreflex_mpu_dev_attr,
-};
-
 /*
  * 'spinlock' class
  *
@@ -3569,42 +3501,6 @@ static struct omap_hwmod_ocp_if dra7xx_l4_cfg__sata = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
-static struct omap_hwmod_addr_space dra7xx_smartreflex_core_addrs[] = {
-	{
-		.pa_start	= 0x4a0dd000,
-		.pa_end		= 0x4a0dd07f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-/* l4_cfg -> smartreflex_core */
-static struct omap_hwmod_ocp_if dra7xx_l4_cfg__smartreflex_core = {
-	.master		= &dra7xx_l4_cfg_hwmod,
-	.slave		= &dra7xx_smartreflex_core_hwmod,
-	.clk		= "l4_root_clk_div",
-	.addr		= dra7xx_smartreflex_core_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
-static struct omap_hwmod_addr_space dra7xx_smartreflex_mpu_addrs[] = {
-	{
-		.pa_start	= 0x4a0d9000,
-		.pa_end		= 0x4a0d907f,
-		.flags		= ADDR_TYPE_RT
-	},
-	{ }
-};
-
-/* l4_cfg -> smartreflex_mpu */
-static struct omap_hwmod_ocp_if dra7xx_l4_cfg__smartreflex_mpu = {
-	.master		= &dra7xx_l4_cfg_hwmod,
-	.slave		= &dra7xx_smartreflex_mpu_hwmod,
-	.clk		= "l4_root_clk_div",
-	.addr		= dra7xx_smartreflex_mpu_addrs,
-	.user		= OCP_USER_MPU | OCP_USER_SDMA,
-};
-
 /* l4_cfg -> spinlock */
 static struct omap_hwmod_ocp_if dra7xx_l4_cfg__spinlock = {
 	.master		= &dra7xx_l4_cfg_hwmod,
@@ -4019,8 +3915,6 @@ static struct omap_hwmod_ocp_if *dra7xx_hwmod_ocp_ifs[] __initdata = {
 	&dra7xx_l4_cfg__pciess2,
 	&dra7xx_l3_main_1__qspi,
 	&dra7xx_l4_cfg__sata,
-	&dra7xx_l4_cfg__smartreflex_core,
-	&dra7xx_l4_cfg__smartreflex_mpu,
 	&dra7xx_l4_cfg__spinlock,
 	&dra7xx_l4_wkup__timer1,
 	&dra7xx_l4_per1__timer2,
-- 
2.14.1
