From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 2/2] ARM: OMAP2+: CM: make cm_ll_data structures as const
Date: Mon,  6 Nov 2017 14:15:40 +0100
Message-ID: <1509974140-10860-3-git-send-email-bhumirks@gmail.com>
References: <1509974140-10860-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1509974140-10860-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, tony@atomide.com, linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-omap@vger.kernel.org

Make these const as they are only getting passed to the functions
cm_register and cm_unregister having the arguments as const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 arch/arm/mach-omap2/cm2xxx.c     | 2 +-
 arch/arm/mach-omap2/cm33xx.c     | 2 +-
 arch/arm/mach-omap2/cm3xxx.c     | 2 +-
 arch/arm/mach-omap2/cminst44xx.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index cd90b4c..d5b87f4 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -385,7 +385,7 @@ void omap2xxx_cm_set_mod_dividers(u32 mpu, u32 dsp, u32 gfx, u32 core, u32 mdm)
  *
  */
 
-static struct cm_ll_data omap2xxx_cm_ll_data = {
+static const struct cm_ll_data omap2xxx_cm_ll_data = {
 	.split_idlest_reg	= &omap2xxx_cm_split_idlest_reg,
 	.wait_module_ready	= &omap2xxx_cm_wait_module_ready,
 };
diff --git a/arch/arm/mach-omap2/cm33xx.c b/arch/arm/mach-omap2/cm33xx.c
index a9e08d8..0c9750f 100644
--- a/arch/arm/mach-omap2/cm33xx.c
+++ b/arch/arm/mach-omap2/cm33xx.c
@@ -342,7 +342,7 @@ struct clkdm_ops am33xx_clkdm_operations = {
 	.clkdm_clk_disable	= am33xx_clkdm_clk_disable,
 };
 
-static struct cm_ll_data am33xx_cm_ll_data = {
+static const struct cm_ll_data am33xx_cm_ll_data = {
 	.wait_module_ready	= &am33xx_cm_wait_module_ready,
 	.wait_module_idle	= &am33xx_cm_wait_module_idle,
 	.module_enable		= &am33xx_cm_module_enable,
diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index 961bc47..ec580fd 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -662,7 +662,7 @@ void omap3_cm_save_scratchpad_contents(u32 *ptr)
  *
  */
 
-static struct cm_ll_data omap3xxx_cm_ll_data = {
+static const struct cm_ll_data omap3xxx_cm_ll_data = {
 	.split_idlest_reg	= &omap3xxx_cm_split_idlest_reg,
 	.wait_module_ready	= &omap3xxx_cm_wait_module_ready,
 };
diff --git a/arch/arm/mach-omap2/cminst44xx.c b/arch/arm/mach-omap2/cminst44xx.c
index 8774e98..2e2274f 100644
--- a/arch/arm/mach-omap2/cminst44xx.c
+++ b/arch/arm/mach-omap2/cminst44xx.c
@@ -512,7 +512,7 @@ struct clkdm_ops am43xx_clkdm_operations = {
 	.clkdm_xlate_address	= omap4_clkdm_xlate_address,
 };
 
-static struct cm_ll_data omap4xxx_cm_ll_data = {
+static const struct cm_ll_data omap4xxx_cm_ll_data = {
 	.wait_module_ready	= &omap4_cminst_wait_module_ready,
 	.wait_module_idle	= &omap4_cminst_wait_module_idle,
 	.module_enable		= &omap4_cminst_module_enable,
-- 
1.9.1
