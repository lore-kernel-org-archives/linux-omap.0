From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH] arm: omap2+: hwmod: Add qspi data for am437x.
Date: Mon, 14 Oct 2013 23:32:22 +0530
Message-ID: <1381773742-3931-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, paul@pwsan.com
Cc: afzal@ti.com, linux@arm.linux.org.uk, tony@atomide.com, nsekhar@ti.com, balbi@ti.com, Sourav Poddar <sourav.poddar@ti.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Add hwmod data for qspi for AM437x.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
This was tested on AM437x EPOS EVM with Afzal's v6 of AM43x PRCM
basic support and tero's DT clock series.
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c |   34 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prcm43xx.h             |    1 +
 2 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
index 6500d43..0a5f7a7 100644
--- a/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_43xx_data.c
@@ -316,6 +316,32 @@ static struct omap_hwmod am43xx_gpio5_hwmod = {
 	.dev_attr	= &gpio_dev_attr,
 };
 
+static struct omap_hwmod_class_sysconfig am43xx_qspi_sysc = {
+	.sysc_offs      = 0x0010,
+	.sysc_flags     = SYSC_HAS_SIDLEMODE,
+	.idlemodes      = (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+				SIDLE_SMART_WKUP),
+	.sysc_fields    = &omap_hwmod_sysc_type2,
+};
+
+static struct omap_hwmod_class am43xx_qspi_hwmod_class = {
+	.name   = "qspi",
+	.sysc   = &am43xx_qspi_sysc,
+};
+
+static struct omap_hwmod am43xx_qspi_hwmod = {
+	.name           = "qspi",
+	.class          = &am43xx_qspi_hwmod_class,
+	.clkdm_name     = "l3s_clkdm",
+	.main_clk       = "l3s_gclk",
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = AM43XX_CM_PER_QSPI_CLKCTRL_OFFSET,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+};
+
 /* Interfaces */
 static struct omap_hwmod_ocp_if am43xx_l3_main__l4_hs = {
 	.master		= &am33xx_l3_main_hwmod,
@@ -520,6 +546,13 @@ static struct omap_hwmod_ocp_if am43xx_l4_ls__gpio5 = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+static struct omap_hwmod_ocp_if am43xx_l3_s__qspi = {
+	.master         = &am33xx_l3_s_hwmod,
+	.slave          = &am43xx_qspi_hwmod,
+	.clk            = "l3s_gclk",
+	.user           = OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am33xx_l4_wkup__synctimer,
 	&am43xx_l4_ls__timer8,
@@ -559,6 +592,7 @@ static struct omap_hwmod_ocp_if *am43xx_hwmod_ocp_ifs[] __initdata = {
 	&am43xx_l4_wkup__i2c1,
 	&am43xx_l4_wkup__gpio0,
 	&am43xx_l4_wkup__wd_timer1,
+	&am43xx_l3_s__qspi,
 	&am33xx_l4_per__dcan0,
 	&am33xx_l4_per__dcan1,
 	&am33xx_l4_per__gpio1,
diff --git a/arch/arm/mach-omap2/prcm43xx.h b/arch/arm/mach-omap2/prcm43xx.h
index f0636ec..976191a 100644
--- a/arch/arm/mach-omap2/prcm43xx.h
+++ b/arch/arm/mach-omap2/prcm43xx.h
@@ -106,6 +106,7 @@
 #define AM43XX_CM_WKUP_L4WKUP_CLKCTRL_OFFSET		0x0220
 #define AM43XX_CM_RTC_RTC_CLKCTRL_OFFSET		0x0020
 #define AM43XX_CM_PER_MMC2_CLKCTRL_OFFSET		0x0248
+#define AM43XX_CM_PER_QSPI_CLKCTRL_OFFSET               0x0258
 #define AM43XX_CM_PER_GPMC_CLKCTRL_OFFSET		0x0220
 #define AM43XX_CM_PER_MCASP0_CLKCTRL_OFFSET		0x0238
 #define AM43XX_CM_PER_MCASP1_CLKCTRL_OFFSET		0x0240
-- 
1.7.1
