From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 1/4] ARM: OMAP2+: dm81xx: Add clkdm and hwmod for SATA
Date: Tue, 14 Mar 2017 12:14:12 +0100
Message-ID: <1489490055-2318-2-git-send-email-bgolaszewski@baylibre.com>
References: <1489490055-2318-1-git-send-email-bgolaszewski@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1489490055-2318-1-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Neil Armstrong <narmstrong@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Patrick Titiano <ptitiano@baylibre.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-omap@vger.kernel.org

From: Kevin Hilman <khilman@baylibre.com>

Add the SATA clockdomain (part of CM_DEFAULT) and a hwmod for the SATA
block on dm81xx.

Tested on DM8168 EVM.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
[Bartosz: removed an unused define]
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-omap2/clockdomains81xx_data.c | 10 +++++++++
 arch/arm/mach-omap2/cm81xx.h                |  1 +
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c  | 34 +++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

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
index 3a0ccf0..5d73a10 100644
--- a/arch/arm/mach-omap2/cm81xx.h
+++ b/arch/arm/mach-omap2/cm81xx.h
@@ -57,5 +57,6 @@
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
