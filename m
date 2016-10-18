From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 7/7] ARM: AMx3xx: hwmod: Add data for RNG
Date: Tue, 18 Oct 2016 10:55:27 +0300
Message-ID: <1476777327-700-8-git-send-email-t-kristo@ti.com>
References: <1476777327-700-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1476777327-700-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Lokesh Vutla <lokeshvutla@ti.com>

Hardware random number generator is present in both AM33xx and AM43xx
SoC's. So moving the hwmod data to common data.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |  2 ++
 .../omap_hwmod_33xx_43xx_interconnect_data.c       |  8 +++++
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 29 ++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         | 35 ----------------------
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  1 +
 arch/arm/mach-omap2/prcm43xx.h                     |  1 +
 6 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
index d3e61d1..434bd1a 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_common_data.h
@@ -68,6 +68,7 @@
 extern struct omap_hwmod_ocp_if am33xx_l3_main__ocmc;
 extern struct omap_hwmod_ocp_if am33xx_l3_main__sha0;
 extern struct omap_hwmod_ocp_if am33xx_l3_main__aes0;
+extern struct omap_hwmod_ocp_if am33xx_l4_per__rng;
 
 extern struct omap_hwmod am33xx_l3_main_hwmod;
 extern struct omap_hwmod am33xx_l3_s_hwmod;
@@ -80,6 +81,7 @@
 extern struct omap_hwmod am33xx_prcm_hwmod;
 extern struct omap_hwmod am33xx_aes0_hwmod;
 extern struct omap_hwmod am33xx_sha0_hwmod;
+extern struct omap_hwmod am33xx_rng_hwmod;
 extern struct omap_hwmod am33xx_ocmcram_hwmod;
 extern struct omap_hwmod am33xx_smartreflex0_hwmod;
 extern struct omap_hwmod am33xx_smartreflex1_hwmod;
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
index 10dff2f..8236e5c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_interconnect_data.c
@@ -547,3 +547,11 @@ struct omap_hwmod_ocp_if am33xx_l3_main__aes0 = {
 	.addr		= am33xx_aes0_addrs,
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
+
+/* l4 per -> rng */
+struct omap_hwmod_ocp_if am33xx_l4_per__rng = {
+	.master		= &am33xx_l4_ls_hwmod,
+	.slave		= &am33xx_rng_hwmod,
+	.clk		= "rng_fck",
+	.user		= OCP_USER_MPU,
+};
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
index e2d84aa..de06a1d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c
@@ -268,6 +268,33 @@ struct omap_hwmod am33xx_sha0_hwmod = {
 	},
 };
 
+/* rng */
+static struct omap_hwmod_class_sysconfig am33xx_rng_sysc = {
+	.rev_offs	= 0x1fe0,
+	.sysc_offs	= 0x1fe4,
+	.sysc_flags	= SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDLEMODE,
+	.idlemodes	= SIDLE_FORCE | SIDLE_NO,
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class am33xx_rng_hwmod_class = {
+	.name		= "rng",
+	.sysc		= &am33xx_rng_sysc,
+};
+
+struct omap_hwmod am33xx_rng_hwmod = {
+	.name		= "rng",
+	.class		= &am33xx_rng_hwmod_class,
+	.clkdm_name	= "l4ls_clkdm",
+	.flags		= HWMOD_SWSUP_SIDLE,
+	.main_clk	= "rng_fck",
+	.prcm		= {
+		.omap4	= {
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
 /* ocmcram */
 static struct omap_hwmod_class am33xx_ocmcram_hwmod_class = {
 	.name = "ocmcram",
@@ -1315,6 +1342,7 @@ static void omap_hwmod_am33xx_clkctrl(void)
 	CLKCTRL(am33xx_ocmcram_hwmod , AM33XX_CM_PER_OCMCRAM_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_sha0_hwmod , AM33XX_CM_PER_SHA0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_aes0_hwmod , AM33XX_CM_PER_AES0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_rng_hwmod, AM33XX_CM_PER_RNG_CLKCTRL_OFFSET);
 }
 
 static void omap_hwmod_am33xx_rst(void)
@@ -1388,6 +1416,7 @@ static void omap_hwmod_am43xx_clkctrl(void)
 	CLKCTRL(am33xx_ocmcram_hwmod , AM43XX_CM_PER_OCMCRAM_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_sha0_hwmod , AM43XX_CM_PER_SHA0_CLKCTRL_OFFSET);
 	CLKCTRL(am33xx_aes0_hwmod , AM43XX_CM_PER_AES0_CLKCTRL_OFFSET);
+	CLKCTRL(am33xx_rng_hwmod, AM43XX_CM_PER_RNG_CLKCTRL_OFFSET);
 }
 
 static void omap_hwmod_am43xx_rst(void)
diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index e1c2025..6dc51a7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -503,41 +503,6 @@
 	.flags		= OCPIF_SWSUP_IDLE,
 };
 
-/* rng */
-static struct omap_hwmod_class_sysconfig am33xx_rng_sysc = {
-	.rev_offs	= 0x1fe0,
-	.sysc_offs	= 0x1fe4,
-	.sysc_flags	= SYSC_HAS_AUTOIDLE | SYSC_HAS_SIDLEMODE,
-	.idlemodes	= SIDLE_FORCE | SIDLE_NO,
-	.sysc_fields	= &omap_hwmod_sysc_type1,
-};
-
-static struct omap_hwmod_class am33xx_rng_hwmod_class = {
-	.name		= "rng",
-	.sysc		= &am33xx_rng_sysc,
-};
-
-static struct omap_hwmod am33xx_rng_hwmod = {
-	.name		= "rng",
-	.class		= &am33xx_rng_hwmod_class,
-	.clkdm_name	= "l4ls_clkdm",
-	.flags		= HWMOD_SWSUP_SIDLE,
-	.main_clk	= "rng_fck",
-	.prcm		= {
-		.omap4	= {
-			.clkctrl_offs	= AM33XX_CM_PER_RNG_CLKCTRL_OFFSET,
-			.modulemode	= MODULEMODE_SWCTRL,
-		},
-	},
-};
-
-static struct omap_hwmod_ocp_if am33xx_l4_per__rng = {
-	.master		= &am33xx_l4_ls_hwmod,
-	.slave		= &am33xx_rng_hwmod,
-	.clk		= "rng_fck",
-	.user		= OCP_USER_MPU,
-};
-
 static struct omap_hwmod_ocp_if *am33xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l3_main__emif,
 	&am33xx_mpu__l3_main,
diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index 3f7dac0..afbce1f 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -949,6 +949,7 @@
 	&am33xx_l4_per__i2c2,
 	&am33xx_l4_per__i2c3,
 	&am33xx_l4_per__mailbox,
+	&am33xx_l4_per__rng,
 	&am33xx_l4_ls__mcasp0,
 	&am33xx_l4_ls__mcasp1,
 	&am33xx_l4_ls__mmc0,
diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
index 4169685..e2ad14e 100644
--- a/arch/arm/mach-omap2/prcm43xx.h
+++ b/arch/arm/mach-omap2/prcm43xx.h
@@ -92,6 +92,7 @@
 #define AM43XX_CM_PER_MAILBOX0_CLKCTRL_OFFSET		0x04b8
 #define AM43XX_CM_PER_MMC0_CLKCTRL_OFFSET		0x04c0
 #define AM43XX_CM_PER_MMC1_CLKCTRL_OFFSET		0x04c8
+#define AM43XX_CM_PER_RNG_CLKCTRL_OFFSET		0x04e0
 #define AM43XX_CM_PER_SPI0_CLKCTRL_OFFSET		0x0500
 #define AM43XX_CM_PER_SPI1_CLKCTRL_OFFSET		0x0508
 #define AM43XX_CM_PER_SPINLOCK_CLKCTRL_OFFSET		0x0528
-- 
1.9.1
