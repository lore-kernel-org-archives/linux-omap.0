From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 1/4] ARM: OMAP2+: dm81xx: Add clkdm and hwmod for SATA
Date: Mon, 13 Mar 2017 17:43:16 +0100
Message-ID: <1489423399-3824-2-git-send-email-bgolaszewski@baylibre.com>
References: <1489423399-3824-1-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1489423399-3824-1-git-send-email-bgolaszewski@baylibre.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Neil Armstrong <narmstrong@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: devicetree@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Kevin Hilman <khilman@baylibre.com>

Add the SATA clockdomain (part of CM_DEFAULT) and a hwmod for the SATA
block on dm81xx.

Tested on DM8168 EVM.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-omap2/clockdomains81xx_data.c | 10 +++++++++
 arch/arm/mach-omap2/cm81xx.h                |  2 ++
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c  | 34 +++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/arch/arm/mach-omap2/clockdomains81xx_data.c b/arch/arm/mach-omap2/clockdomains81xx_data.c
index 3b5fb05..65fbd13 100644
--- a/arch/arm/mach-omap2/clockdomains81xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains81xx_data.c
@@ -91,6 +91,14 @@ static struct clockdomain default_l3_slow_81xx_clkdm = {
 	.flags		= CLKDM_CAN_SWSUP,
 };
 
+static struct clockdomain default_sata_81xx_clkdm = {
+	.name		= "default_clkdm",
+	.pwrdm		= { .name = "default_pwrdm" },
+	.cm_inst	= TI81XX_CM_DEFAULT_MOD,
+	.clkdm_offs	= TI816X_CM_DEFAULT_SATA_CLKDM,
+	.flags		= CLKDM_CAN_SWSUP,
+};
+
 /* 816x only */
 
 static struct clockdomain alwon_mpu_816x_clkdm = {
@@ -173,6 +181,7 @@ static struct clockdomain *clockdomains_ti814x[] __initdata = {
 	&mmu_81xx_clkdm,
 	&mmu_cfg_81xx_clkdm,
 	&default_l3_slow_81xx_clkdm,
+	&default_sata_81xx_clkdm,
 	NULL,
 };
 
@@ -200,6 +209,7 @@ static struct clockdomain *clockdomains_ti816x[] __initdata = {
 	&default_ducati_816x_clkdm,
 	&default_pci_816x_clkdm,
 	&default_l3_slow_81xx_clkdm,
+	&default_sata_81xx_clkdm,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/cm81xx.h b/arch/arm/mach-omap2/cm81xx.h
index 3a0ccf0..44ca275 100644
--- a/arch/arm/mach-omap2/cm81xx.h
+++ b/arch/arm/mach-omap2/cm81xx.h
@@ -35,6 +35,7 @@
 #define TI81XX_CM_MMU_CLKDM			0x000C
 #define TI81XX_CM_MMUCFG_CLKDM			0x0010
 #define TI81XX_CM_ALWON_MPU_CLKDM		0x001C
+#define TI81XX_CM_ALWON_SYSCLK5_CLKDM		0x0024
 #define TI81XX_CM_ALWON_L3_FAST_CLKDM		0x0030
 
 /* ACTIVE */
@@ -57,5 +58,6 @@
 #define TI816X_CM_DEFAULT_PCI_CLKDM		0x0010
 #define TI816X_CM_DEFAULT_L3_SLOW_CLKDM		0x0014
 #define TI816X_CM_DEFAULT_DUCATI_CLKDM		0x0018
+#define TI816X_CM_DEFAULT_SATA_CLKDM		0x0060
 
 #endif
diff --git a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
index b82b77c..310afe4 100644
--- a/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_81xx_data.c
@@ -106,6 +106,7 @@
  */
 #define DM81XX_CM_DEFAULT_OFFSET	0x500
 #define DM81XX_CM_DEFAULT_USB_CLKCTRL	(0x558 - DM81XX_CM_DEFAULT_OFFSET)
+#define DM81XX_CM_DEFAULT_SATA_CLKCTRL	(0x560 - DM81XX_CM_DEFAULT_OFFSET)
 
 /* L3 Interconnect entries clocked at 125, 250 and 500MHz */
 static struct omap_hwmod dm81xx_alwon_l3_slow_hwmod = {
@@ -973,6 +974,38 @@ static struct omap_hwmod_ocp_if dm816x_l4_hs__emac1 = {
 	.user		= OCP_USER_MPU,
 };
 
+static struct omap_hwmod_class_sysconfig dm81xx_sata_sysc = {
+	.sysc_offs	= 0x1100,
+	.sysc_flags	= SYSC_HAS_SIDLEMODE,
+	.idlemodes	= SIDLE_FORCE,
+	.sysc_fields	= &omap_hwmod_sysc_type3,
+};
+
+static struct omap_hwmod_class dm81xx_sata_hwmod_class = {
+	.name	= "sata",
+	.sysc	= &dm81xx_sata_sysc,
+};
+
+static struct omap_hwmod dm81xx_sata_hwmod = {
+	.name		= "sata",
+	.clkdm_name	= "default_sata_clkdm",
+	.flags		= HWMOD_NO_IDLEST,
+	.prcm = {
+		.omap4 = {
+			.clkctrl_offs = DM81XX_CM_DEFAULT_SATA_CLKCTRL,
+			.modulemode   = MODULEMODE_SWCTRL,
+		},
+	},
+	.class		= &dm81xx_sata_hwmod_class,
+};
+
+static struct omap_hwmod_ocp_if dm81xx_l4_hs__sata = {
+	.master		= &dm81xx_l4_hs_hwmod,
+	.slave		= &dm81xx_sata_hwmod,
+	.clk		= "sysclk5_ck",
+	.user		= OCP_USER_MPU,
+};
+
 static struct omap_hwmod_class_sysconfig dm81xx_mmc_sysc = {
 	.rev_offs	= 0x0,
 	.sysc_offs	= 0x110,
@@ -1474,6 +1507,7 @@ static struct omap_hwmod_ocp_if *dm816x_hwmod_ocp_ifs[] __initdata = {
 	&dm81xx_l4_hs__emac0,
 	&dm81xx_emac0__mdio,
 	&dm816x_l4_hs__emac1,
+	&dm81xx_l4_hs__sata,
 	&dm81xx_alwon_l3_fast__tpcc,
 	&dm81xx_alwon_l3_fast__tptc0,
 	&dm81xx_alwon_l3_fast__tptc1,
-- 
2.9.3
