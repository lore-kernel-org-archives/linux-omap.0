From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 6/7] ARM: AM43xx: hwmod: Add data for DES
Date: Tue, 18 Oct 2016 10:55:26 +0300
Message-ID: <1476777327-700-7-git-send-email-t-kristo@ti.com>
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

AM43xx SoC contains DES crypto hardware accelerator. Add hwmod data for
this IP so that it can be utilized by crypto frameworks.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c | 33 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |  1 +
 2 files changed, 34 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index 61f2f30..3f7dac0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -442,6 +442,31 @@
 	},
 };
 
+static struct omap_hwmod_class_sysconfig am43xx_des_sysc = {
+	.rev_offs	= 0x30,
+	.sysc_offs	= 0x34,
+	.syss_offs	= 0x38,
+	.sysc_flags	= SYSS_HAS_RESET_STATUS,
+};
+
+static struct omap_hwmod_class am43xx_des_hwmod_class = {
+	.name		= "des",
+	.sysc		= &am43xx_des_sysc,
+};
+
+static struct omap_hwmod am43xx_des_hwmod = {
+	.name		= "des",
+	.class		= &am43xx_des_hwmod_class,
+	.clkdm_name	= "l3_clkdm",
+	.main_clk	= "l3_gclk",
+	.prcm		= {
+		.omap4	= {
+			.clkctrl_offs	= AM43XX_CM_PER_DES_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
 /* dss */
 
 static struct omap_hwmod am43xx_dss_core_hwmod = {
@@ -870,6 +895,13 @@
 	.user           = OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_ocp_if am43xx_l3_main__des = {
+	.master		= &am33xx_l3_main_hwmod,
+	.slave		= &am43xx_des_hwmod,
+	.clk		= "l3_gclk",
+	.user		= OCP_USER_MPU,
+};
+
 static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_wkup__synctimer,
 	&am43xx_l4_ls__timer8,
@@ -950,6 +982,7 @@
 	&am33xx_cpgmac0__mdio,
 	&am33xx_l3_main__sha0,
 	&am33xx_l3_main__aes0,
+	&am43xx_l3_main__des,
 	&am43xx_l4_ls__ocp2scp0,
 	&am43xx_l4_ls__ocp2scp1,
 	&am43xx_l3_s__usbotgss0,
diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
index babb5db..4169685 100644
--- a/arch/arm/mach-omap2/prcm43xx.h
+++ b/arch/arm/mach-omap2/prcm43xx.h
@@ -133,6 +133,7 @@
 #define AM43XX_CM_PER_OCMCRAM_CLKCTRL_OFFSET		0x0050
 #define AM43XX_CM_PER_SHA0_CLKCTRL_OFFSET		0x0058
 #define AM43XX_CM_PER_AES0_CLKCTRL_OFFSET		0x0028
+#define AM43XX_CM_PER_DES_CLKCTRL_OFFSET		0x0030
 #define AM43XX_CM_PER_TIMER8_CLKCTRL_OFFSET		0x0560
 #define AM43XX_CM_PER_TIMER9_CLKCTRL_OFFSET		0x0568
 #define AM43XX_CM_PER_TIMER10_CLKCTRL_OFFSET		0x0570
-- 
1.9.1
