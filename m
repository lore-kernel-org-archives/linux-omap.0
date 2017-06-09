From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 2/3] ARM: OMAP4: hwmod data: add aes
Date: Sat, 10 Jun 2017 01:12:05 +0200
Message-ID: <20170609231206.19798-3-sre@kernel.org>
References: <20170609231206.19798-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170609231206.19798-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Joel Fernandes <joelf@ti.com>
List-Id: linux-omap@vger.kernel.org

This fixes the following error during kernel boot:

platform 4b501000.aes: Cannot lookup hwmod 'aes'

Unfortunately the AES module is only documented partly
in the OMAP4430 TRM. I found an old patch from Joel,
which I took over and updated for currently mainline.

Signed-off-by: Joel Fernandes <joelf@ti.com>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 41 ++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 94f09c720f29..18feb49e813b 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -953,6 +953,46 @@ static struct omap_hwmod omap44xx_emif2_hwmod = {
 };
 
 /*
+    Crypto modules AES0/1 belong to:
+	PD_L4_PER power domain
+	CD_L4_SEC clock domain
+	On the L3, the AES modules are mapped to
+	L3_CLK2: Peripherals and multimedia sub clock domain
+*/
+static struct omap_hwmod_class_sysconfig omap44xx_aes1_sysc = {
+	.rev_offs	= 0x80,
+	.sysc_offs	= 0x84,
+	.syss_offs	= 0x88,
+	.sysc_flags	= SYSS_HAS_RESET_STATUS,
+};
+
+static struct omap_hwmod_class omap44xx_aes1_hwmod_class = {
+	.name		= "aes1",
+	.sysc		= &omap44xx_aes1_sysc,
+};
+
+static struct omap_hwmod omap44xx_aes1_hwmod = {
+	.name		= "aes",
+	.class		= &omap44xx_aes1_hwmod_class,
+	.clkdm_name	= "l4_secure_clkdm",
+	.main_clk	= "aes1_fck",
+	.prcm		= {
+		.omap4	= {
+			.context_offs	= OMAP4_RM_L4SEC_AES1_CONTEXT_OFFSET,
+			.clkctrl_offs	= OMAP4_CM_L4SEC_AES1_CLKCTRL_OFFSET,
+			.modulemode	= MODULEMODE_SWCTRL,
+		},
+	},
+};
+
+static struct omap_hwmod_ocp_if omap44xx_l3_main_2__aes1 = {
+	.master		= &omap44xx_l4_per_hwmod,
+	.slave		= &omap44xx_aes1_hwmod,
+	.clk		= "l4_div_ck",
+	.user		= OCP_USER_MPU | OCP_USER_SDMA,
+};
+
+/*
  * 'fdif' class
  * face detection hw accelerator module
  */
@@ -4793,6 +4833,7 @@ static struct omap_hwmod_ocp_if *omap44xx_hwmod_ocp_ifs[] __initdata = {
 	&omap44xx_l4_abe__wd_timer3_dma,
 	&omap44xx_mpu__emif1,
 	&omap44xx_mpu__emif2,
+	&omap44xx_l3_main_2__aes1,
 	NULL,
 };
 
-- 
2.11.0
