From: "Mark A. Greer" <mgreer@animalcreek.com>
Subject: [PATCH 07/12] arm: omap3: am35x: Set proper powerdomain states
Date: Wed, 11 Apr 2012 12:05:42 -0700
Message-ID: <1334171147-7517-8-git-send-email-mgreer@animalcreek.com>
References: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail20.dotsterhost.com ([66.11.232.73]:50162 "EHLO
	mail20.dotsterhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761126Ab2DKTsP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Apr 2012 15:48:15 -0400
In-Reply-To: <1334171147-7517-1-git-send-email-mgreer@animalcreek.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@ti.com, paul@pwsan.com, "Mark A. Greer" <mgreer@animalcreek.com>

From: "Mark A. Greer" <mgreer@animalcreek.com>

The am35x family of SoCs only support PWRSTS_ON
and PWRSTS_INACTIVE states so create a new set
of powerdomain structures that ensure that only
the ON and INACTIVE states are entered.

Signed-off-by: Mark A. Greer <mgreer@animalcreek.com>
---
 arch/arm/mach-omap2/powerdomain.h           |    1 +
 arch/arm/mach-omap2/powerdomains3xxx_data.c |  134 ++++++++++++++++++++++++---
 2 files changed, 123 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index 0d72a8a..561cb27 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -43,6 +43,7 @@
 #define PWRSTS_OFF_ON		(PWRSTS_OFF | PWRSTS_ON)
 #define PWRSTS_OFF_RET		(PWRSTS_OFF | PWRSTS_RET)
 #define PWRSTS_RET_ON		(PWRSTS_RET | PWRSTS_ON)
+#define PWRSTS_INACTIVE_ON	(PWRSTS_INACTIVE | PWRSTS_ON)
 #define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | PWRSTS_ON)
 
 
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index b7ea468..fae6dea 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -71,6 +71,22 @@ static struct powerdomain mpu_3xxx_pwrdm = {
 	.voltdm           = { .name = "mpu_iva" },
 };
 
+static struct powerdomain mpu_am35x_pwrdm = {
+	.name		  = "mpu_pwrdm",
+	.prcm_offs	  = MPU_MOD,
+	.pwrsts		  = PWRSTS_INACTIVE_ON,
+	.pwrsts_logic_ret = PWRSTS_INACTIVE,
+	.flags		  = PWRDM_HAS_MPU_QUIRK,
+	.banks		  = 1,
+	.pwrsts_mem_ret	  = {
+		[0] = PWRSTS_INACTIVE,
+	},
+	.pwrsts_mem_on	  = {
+		[0] = PWRSTS_INACTIVE_ON,
+	},
+	.voltdm           = { .name = "mpu_iva" },
+};
+
 /*
  * The USBTLL Save-and-Restore mechanism is broken on
  * 3430s up to ES3.0 and 3630ES1.0. Hence this feature
@@ -120,6 +136,23 @@ static struct powerdomain core_3xxx_es3_1_pwrdm = {
 	.voltdm           = { .name = "core" },
 };
 
+static struct powerdomain core_am35x_pwrdm = {
+	.name		  = "core_pwrdm",
+	.prcm_offs	  = CORE_MOD,
+	.pwrsts		  = PWRSTS_INACTIVE_ON,
+	.pwrsts_logic_ret = PWRSTS_INACTIVE,
+	.banks		  = 2,
+	.pwrsts_mem_ret	  = {
+		[0] = PWRSTS_INACTIVE,	 /* MEM1RETSTATE */
+		[1] = PWRSTS_INACTIVE,	 /* MEM2RETSTATE */
+	},
+	.pwrsts_mem_on	  = {
+		[0] = PWRSTS_INACTIVE_ON, /* MEM1ONSTATE */
+		[1] = PWRSTS_INACTIVE_ON, /* MEM2ONSTATE */
+	},
+	.voltdm           = { .name = "core" },
+};
+
 static struct powerdomain dss_pwrdm = {
 	.name		  = "dss_pwrdm",
 	.prcm_offs	  = OMAP3430_DSS_MOD,
@@ -135,6 +168,21 @@ static struct powerdomain dss_pwrdm = {
 	.voltdm           = { .name = "core" },
 };
 
+static struct powerdomain dss_am35x_pwrdm = {
+	.name		  = "dss_pwrdm",
+	.prcm_offs	  = OMAP3430_DSS_MOD,
+	.pwrsts		  = PWRSTS_INACTIVE_ON,
+	.pwrsts_logic_ret = PWRSTS_INACTIVE,
+	.banks		  = 1,
+	.pwrsts_mem_ret	  = {
+		[0] = PWRSTS_INACTIVE, /* MEMRETSTATE */
+	},
+	.pwrsts_mem_on	  = {
+		[0] = PWRSTS_ON,  /* MEMONSTATE */
+	},
+	.voltdm           = { .name = "core" },
+};
+
 /*
  * Although the 34XX TRM Rev K Table 4-371 notes that retention is a
  * possible SGX powerstate, the SGX device itself does not support
@@ -156,6 +204,21 @@ static struct powerdomain sgx_pwrdm = {
 	.voltdm           = { .name = "core" },
 };
 
+static struct powerdomain sgx_am35x_pwrdm = {
+	.name		  = "sgx_pwrdm",
+	.prcm_offs	  = OMAP3430ES2_SGX_MOD,
+	.pwrsts		  = PWRSTS_INACTIVE_ON,
+	.pwrsts_logic_ret = PWRSTS_INACTIVE,
+	.banks		  = 1,
+	.pwrsts_mem_ret	  = {
+		[0] = PWRSTS_INACTIVE, /* MEMRETSTATE */
+	},
+	.pwrsts_mem_on	  = {
+		[0] = PWRSTS_ON,  /* MEMONSTATE */
+	},
+	.voltdm           = { .name = "core" },
+};
+
 static struct powerdomain cam_pwrdm = {
 	.name		  = "cam_pwrdm",
 	.prcm_offs	  = OMAP3430_CAM_MOD,
@@ -186,6 +249,21 @@ static struct powerdomain per_pwrdm = {
 	.voltdm           = { .name = "core" },
 };
 
+static struct powerdomain per_am35x_pwrdm = {
+	.name		  = "per_pwrdm",
+	.prcm_offs	  = OMAP3430_PER_MOD,
+	.pwrsts		  = PWRSTS_INACTIVE_ON,
+	.pwrsts_logic_ret = PWRSTS_INACTIVE,
+	.banks		  = 1,
+	.pwrsts_mem_ret	  = {
+		[0] = PWRSTS_INACTIVE, /* MEMRETSTATE */
+	},
+	.pwrsts_mem_on	  = {
+		[0] = PWRSTS_ON,  /* MEMONSTATE */
+	},
+	.voltdm           = { .name = "core" },
+};
+
 static struct powerdomain emu_pwrdm = {
 	.name		= "emu_pwrdm",
 	.prcm_offs	= OMAP3430_EMU_MOD,
@@ -200,6 +278,14 @@ static struct powerdomain neon_pwrdm = {
 	.voltdm           = { .name = "mpu_iva" },
 };
 
+static struct powerdomain neon_am35x_pwrdm = {
+	.name		  = "neon_pwrdm",
+	.prcm_offs	  = OMAP3430_NEON_MOD,
+	.pwrsts		  = PWRSTS_INACTIVE_ON,
+	.pwrsts_logic_ret = PWRSTS_INACTIVE,
+	.voltdm           = { .name = "mpu_iva" },
+};
+
 static struct powerdomain usbhost_pwrdm = {
 	.name		  = "usbhost_pwrdm",
 	.prcm_offs	  = OMAP3430ES2_USBHOST_MOD,
@@ -293,6 +379,22 @@ static struct powerdomain *powerdomains_omap3430es3_1plus[] __initdata = {
 	NULL
 };
 
+static struct powerdomain *powerdomains_am35x[] __initdata = {
+	&wkup_omap2_pwrdm,
+	&mpu_am35x_pwrdm,
+	&neon_am35x_pwrdm,
+	&core_am35x_pwrdm,
+	&sgx_am35x_pwrdm,
+	&dss_am35x_pwrdm,
+	&per_am35x_pwrdm,
+	&emu_pwrdm,
+	&dpll1_pwrdm,
+	&dpll3_pwrdm,
+	&dpll4_pwrdm,
+	&dpll5_pwrdm,
+	NULL
+};
+
 void __init omap3xxx_powerdomains_init(void)
 {
 	unsigned int rev;
@@ -301,21 +403,29 @@ void __init omap3xxx_powerdomains_init(void)
 		return;
 
 	pwrdm_register_platform_funcs(&omap3_pwrdm_operations);
-	pwrdm_register_pwrdms(powerdomains_omap3430_common);
 
 	rev = omap_rev();
 
-	if (rev == OMAP3430_REV_ES1_0)
-		pwrdm_register_pwrdms(powerdomains_omap3430es1);
-	else if (rev == OMAP3430_REV_ES2_0 || rev == OMAP3430_REV_ES2_1 ||
-		 rev == OMAP3430_REV_ES3_0 || rev == OMAP3630_REV_ES1_0)
-		pwrdm_register_pwrdms(powerdomains_omap3430es2_es3_0);
-	else if (rev == OMAP3430_REV_ES3_1 || rev == OMAP3430_REV_ES3_1_2 ||
-		 rev == OMAP3517_REV_ES1_0 || rev == OMAP3517_REV_ES1_1 ||
-		 rev == OMAP3630_REV_ES1_1 || rev == OMAP3630_REV_ES1_2)
-		pwrdm_register_pwrdms(powerdomains_omap3430es3_1plus);
-	else
-		WARN(1, "OMAP3 powerdomain init: unknown chip type\n");
+	if (rev == OMAP3517_REV_ES1_0 || rev == OMAP3517_REV_ES1_1)
+		pwrdm_register_pwrdms(powerdomains_am35x);
+	else {
+		pwrdm_register_pwrdms(powerdomains_omap3430_common);
+
+		if (rev == OMAP3430_REV_ES1_0)
+			pwrdm_register_pwrdms(powerdomains_omap3430es1);
+		else if (rev == OMAP3430_REV_ES2_0 ||
+			 rev == OMAP3430_REV_ES2_1 ||
+			 rev == OMAP3430_REV_ES3_0 ||
+			 rev == OMAP3630_REV_ES1_0)
+			pwrdm_register_pwrdms(powerdomains_omap3430es2_es3_0);
+		else if (rev == OMAP3430_REV_ES3_1 ||
+			 rev == OMAP3430_REV_ES3_1_2 ||
+			 rev == OMAP3630_REV_ES1_1 ||
+			 rev == OMAP3630_REV_ES1_2)
+			pwrdm_register_pwrdms(powerdomains_omap3430es3_1plus);
+		else
+			WARN(1, "OMAP3 powerdomain init: unknown chip type\n");
+	}
 
 	pwrdm_complete_init();
 }
-- 
1.7.9.4

