From: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: [RFCv2 1/3] ARM: OMAP2+: hwmod-data: Add SSI information
Date: Sun, 15 Sep 2013 22:44:14 +0200
Message-ID: <1379277856-24571-2-git-send-email-sre@debian.org>
References: <1379277856-24571-1-git-send-email-sre@debian.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1379277856-24571-1-git-send-email-sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Carlos Chinea <cch.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, =?UTF-8?q?=27Beno=C3=AEt=20Cousson=27?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch adds Synchronous Serial Interface (SSI) hwmod support for
OMAP34xx SoCs.

Signed-off-by: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 48 ++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 0c3a427..9e56fab 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -3693,6 +3693,53 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_core__aes = {
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 
+/*
+ * 'ssi' class
+ * synchronous serial interface (multichannel and full-duplex serial if)
+ */
+
+static struct omap_hwmod_class_sysconfig omap34xx_ssi_sysc = {
+	.rev_offs	= 0x0000,
+	.sysc_offs	= 0x0010,
+	.syss_offs	= 0x0014,
+	.sysc_flags	= (SYSC_HAS_AUTOIDLE | SYSC_HAS_EMUFREE |
+			   SYSC_HAS_MIDLEMODE | SYSC_HAS_SIDLEMODE |
+			   SYSC_HAS_SOFTRESET | SYSS_HAS_RESET_STATUS),
+	.idlemodes	= (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
+			   SIDLE_SMART_WKUP | MSTANDBY_FORCE | MSTANDBY_NO |
+			   MSTANDBY_SMART | MSTANDBY_SMART_WKUP),
+	.sysc_fields	= &omap_hwmod_sysc_type1,
+};
+
+static struct omap_hwmod_class omap34xx_ssi_hwmod_class = {
+	.name	= "ssi",
+	.sysc	= &omap34xx_ssi_sysc,
+};
+
+static struct omap_hwmod omap34xx_ssi_hwmod = {
+	.name		= "ssi",
+	.class		= &omap34xx_ssi_hwmod_class,
+	.clkdm_name	= "core_l4_clkdm",
+	.main_clk	= "ssi_ssr_fck",
+	.prcm		= {
+		.omap2 = {
+			.prcm_reg_id		= 1,
+			.module_bit		= OMAP3430_EN_SSI_SHIFT,
+			.module_offs		= CORE_MOD,
+			.idlest_reg_id		= 1,
+			.idlest_idle_bit	= OMAP3430ES2_ST_SSI_IDLE_SHIFT,
+		},
+	},
+};
+
+/* L4 CORE -> SSI */
+static struct omap_hwmod_ocp_if omap34xx_l4_core__ssi = {
+	.master		= &omap3xxx_l4_core_hwmod,
+	.slave		= &omap34xx_ssi_hwmod,
+	.clk		= "ssi_ick",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
 static struct omap_hwmod_ocp_if *omap3xxx_hwmod_ocp_ifs[] __initdata = {
 	&omap3xxx_l3_main__l4_core,
 	&omap3xxx_l3_main__l4_per,
@@ -3818,6 +3865,7 @@ static struct omap_hwmod_ocp_if *omap34xx_hwmod_ocp_ifs[] __initdata = {
 #ifdef CONFIG_OMAP_IOMMU_IVA2
 	&omap3xxx_l3_main__mmu_iva,
 #endif
+	&omap34xx_l4_core__ssi,
 	NULL
 };
 
-- 
1.8.4.rc3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
