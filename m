From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 10/19] OMAP3: powerdomain data: add voltage domains
Date: Wed, 23 Mar 2011 17:00:24 -0700
Message-ID: <1300924833-26745-11-git-send-email-khilman@ti.com>
References: <1300924833-26745-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:47813 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933110Ab1CXAAb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 20:00:31 -0400
Received: by mail-iw0-f174.google.com with SMTP id 34so11864276iwn.33
        for <linux-omap@vger.kernel.org>; Wed, 23 Mar 2011 17:00:30 -0700 (PDT)
In-Reply-To: <1300924833-26745-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

Add voltage domain name to indicate which voltagedomain each
powerdomain is in.  A missing voltage domain name means that that
powerdomain is not in one of the currently scalable voltage domains.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |    2 ++
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |   16 ++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
index 4210c33..45aa4b7 100644
--- a/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c
@@ -70,6 +70,7 @@ struct powerdomain gfx_omap2_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_ON,  /* MEMONSTATE */
 	},
+	.voltdm           = { .name = "core" },
 };
 
 struct powerdomain wkup_omap2_pwrdm = {
@@ -77,4 +78,5 @@ struct powerdomain wkup_omap2_pwrdm = {
 	.prcm_offs	= WKUP_MOD,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
 	.pwrsts		= PWRSTS_ON,
+	.voltdm         = { .name = "wkup" },
 };
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index 9c9c113..09bdfcf 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -52,6 +52,7 @@ static struct powerdomain iva2_pwrdm = {
 		[2] = PWRSTS_OFF_ON,
 		[3] = PWRSTS_ON,
 	},
+	.voltdm           = { .name = "mpu_iva" },
 };
 
 static struct powerdomain mpu_3xxx_pwrdm = {
@@ -68,6 +69,7 @@ static struct powerdomain mpu_3xxx_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_OFF_ON,
 	},
+	.voltdm           = { .name = "mpu_iva" },
 };
 
 /*
@@ -98,6 +100,7 @@ static struct powerdomain core_3xxx_pre_es3_1_pwrdm = {
 		[0] = PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
 		[1] = PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
 	},
+	.voltdm           = { .name = "core" },
 };
 
 static struct powerdomain core_3xxx_es3_1_pwrdm = {
@@ -121,6 +124,7 @@ static struct powerdomain core_3xxx_es3_1_pwrdm = {
 		[0] = PWRSTS_OFF_RET_ON, /* MEM1ONSTATE */
 		[1] = PWRSTS_OFF_RET_ON, /* MEM2ONSTATE */
 	},
+	.voltdm           = { .name = "core" },
 };
 
 static struct powerdomain dss_pwrdm = {
@@ -136,6 +140,7 @@ static struct powerdomain dss_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_ON,  /* MEMONSTATE */
 	},
+	.voltdm           = { .name = "core" },
 };
 
 /*
@@ -157,6 +162,7 @@ static struct powerdomain sgx_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_ON,  /* MEMONSTATE */
 	},
+	.voltdm           = { .name = "core" },
 };
 
 static struct powerdomain cam_pwrdm = {
@@ -172,6 +178,7 @@ static struct powerdomain cam_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_ON,  /* MEMONSTATE */
 	},
+	.voltdm           = { .name = "core" },
 };
 
 static struct powerdomain per_pwrdm = {
@@ -187,12 +194,14 @@ static struct powerdomain per_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_ON,  /* MEMONSTATE */
 	},
+	.voltdm           = { .name = "core" },
 };
 
 static struct powerdomain emu_pwrdm = {
 	.name		= "emu_pwrdm",
 	.prcm_offs	= OMAP3430_EMU_MOD,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.voltdm           = { .name = "core" },
 };
 
 static struct powerdomain neon_pwrdm = {
@@ -201,6 +210,7 @@ static struct powerdomain neon_pwrdm = {
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_RET,
+	.voltdm           = { .name = "mpu_iva" },
 };
 
 static struct powerdomain usbhost_pwrdm = {
@@ -223,36 +233,42 @@ static struct powerdomain usbhost_pwrdm = {
 	.pwrsts_mem_on	  = {
 		[0] = PWRSTS_ON,  /* MEMONSTATE */
 	},
+	.voltdm           = { .name = "core" },
 };
 
 static struct powerdomain dpll1_pwrdm = {
 	.name		= "dpll1_pwrdm",
 	.prcm_offs	= MPU_MOD,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.voltdm           = { .name = "mpu_iva" },
 };
 
 static struct powerdomain dpll2_pwrdm = {
 	.name		= "dpll2_pwrdm",
 	.prcm_offs	= OMAP3430_IVA2_MOD,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.voltdm           = { .name = "mpu_iva" },
 };
 
 static struct powerdomain dpll3_pwrdm = {
 	.name		= "dpll3_pwrdm",
 	.prcm_offs	= PLL_MOD,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.voltdm           = { .name = "core" },
 };
 
 static struct powerdomain dpll4_pwrdm = {
 	.name		= "dpll4_pwrdm",
 	.prcm_offs	= PLL_MOD,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
+	.voltdm           = { .name = "core" },
 };
 
 static struct powerdomain dpll5_pwrdm = {
 	.name		= "dpll5_pwrdm",
 	.prcm_offs	= PLL_MOD,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
+	.voltdm           = { .name = "core" },
 };
 
 /* As powerdomains are added or removed above, this list must also be changed */
-- 
1.7.4

