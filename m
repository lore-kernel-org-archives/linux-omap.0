From: jean.pihet@newoldbits.com
Subject: [PATCH 12/15] OMAP4: powerdomain data: add wake-up latency figures
Date: Thu, 11 Aug 2011 17:06:49 +0200
Message-ID: <1313075212-8366-13-git-send-email-j-pihet@ti.com>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46608 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752419Ab1HKPH4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Aug 2011 11:07:56 -0400
Received: by mail-wy0-f174.google.com with SMTP id 24so1487550wyg.19
        for <linux-omap@vger.kernel.org>; Thu, 11 Aug 2011 08:07:55 -0700 (PDT)
In-Reply-To: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.ke
Cc: Vishwanath BS <vishwanath.bs@ti.com>, Jean Pihet <j-pihet@ti.com>

From: Vishwanath BS <vishwanath.bs@ti.com>

This patch adds wake up latency numbers for OMAP4. Note that these are
preliminary numbers and need to be relooked.

Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>

The INACTIVE state is added as unsupported.

Tested on OMAP4 Pandaboard in RET/OFF using wake-up latency constraints on
MPU, CORE and PER.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/powerdomains44xx_data.c |   84 +++++++++++++++++++++++++++
 1 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index 247e794..c3f8dd4 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -54,6 +54,13 @@ static struct powerdomain core_44xx_pwrdm = {
 		[4] = PWRSTS_ON,	/* ducati_unicache */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_OSWR] = 600,
+		[PWRDM_FUNC_PWRST_CSWR] = 300,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* gfx_44xx_pwrdm: 3D accelerator power domain */
@@ -71,6 +78,13 @@ static struct powerdomain gfx_44xx_pwrdm = {
 		[0] = PWRSTS_ON,	/* gfx_mem */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* abe_44xx_pwrdm: Audio back end power domain */
@@ -91,6 +105,13 @@ static struct powerdomain abe_44xx_pwrdm = {
 		[1] = PWRSTS_ON,	/* periphmem */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = 600,
+		[PWRDM_FUNC_PWRST_CSWR] = 300,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* dss_44xx_pwrdm: Display subsystem power domain */
@@ -109,6 +130,13 @@ static struct powerdomain dss_44xx_pwrdm = {
 		[0] = PWRSTS_ON,	/* dss_mem */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 300,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* tesla_44xx_pwrdm: Tesla processor power domain */
@@ -131,6 +159,13 @@ static struct powerdomain tesla_44xx_pwrdm = {
 		[2] = PWRSTS_ON,	/* tesla_l2 */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = 600,
+		[PWRDM_FUNC_PWRST_CSWR] = 300,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* wkup_44xx_pwrdm: Wake-up power domain */
@@ -164,6 +199,13 @@ static struct powerdomain cpu0_44xx_pwrdm = {
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* cpu0_l1 */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = 600,
+		[PWRDM_FUNC_PWRST_CSWR] = 300,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* cpu1_44xx_pwrdm: MPU1 processor and Neon coprocessor power domain */
@@ -181,6 +223,13 @@ static struct powerdomain cpu1_44xx_pwrdm = {
 	.pwrsts_mem_on	= {
 		[0] = PWRSTS_ON,	/* cpu1_l1 */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = 600,
+		[PWRDM_FUNC_PWRST_CSWR] = 300,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* emu_44xx_pwrdm: Emulation power domain */
@@ -218,6 +267,13 @@ static struct powerdomain mpu_44xx_pwrdm = {
 		[1] = PWRSTS_ON,	/* mpu_l2 */
 		[2] = PWRSTS_ON,	/* mpu_ram */
 	},
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = 600,
+		[PWRDM_FUNC_PWRST_CSWR] = 300,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* ivahd_44xx_pwrdm: IVA-HD power domain */
@@ -242,6 +298,13 @@ static struct powerdomain ivahd_44xx_pwrdm = {
 		[3] = PWRSTS_ON,	/* tcm2_mem */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = 300,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* cam_44xx_pwrdm: Camera subsystem power domain */
@@ -259,6 +322,13 @@ static struct powerdomain cam_44xx_pwrdm = {
 		[0] = PWRSTS_ON,	/* cam_mem */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_CSWR] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* l3init_44xx_pwrdm: L3 initators pheripherals power domain  */
@@ -277,6 +347,13 @@ static struct powerdomain l3init_44xx_pwrdm = {
 		[0] = PWRSTS_ON,	/* l3init_bank1 */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = 1000,
+		[PWRDM_FUNC_PWRST_OSWR] = 600,
+		[PWRDM_FUNC_PWRST_CSWR] = 300,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /* l4per_44xx_pwrdm: Target peripherals power domain */
@@ -297,6 +374,13 @@ static struct powerdomain l4per_44xx_pwrdm = {
 		[1] = PWRSTS_ON,	/* retained_bank */
 	},
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
+	.wakeup_lat = {
+		[PWRDM_FUNC_PWRST_OFF] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_OSWR] = 600,
+		[PWRDM_FUNC_PWRST_CSWR] = 300,
+		[PWRDM_FUNC_PWRST_INACTIVE] = UNSUP_STATE,
+		[PWRDM_FUNC_PWRST_ON] = 0,
+	},
 };
 
 /*
-- 
1.7.2.5

