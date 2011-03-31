From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 11/17] OMAP4: powerdomain data: add voltage domains
Date: Wed, 30 Mar 2011 17:16:14 -0700
Message-ID: <1301530580-12046-12-git-send-email-khilman@ti.com>
References: <1301530580-12046-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:51828 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933119Ab1CaAQa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Mar 2011 20:16:30 -0400
Received: by yih10 with SMTP id 10so1513950yih.25
        for <linux-omap@vger.kernel.org>; Wed, 30 Mar 2011 17:16:27 -0700 (PDT)
In-Reply-To: <1301530580-12046-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

From: Benoit Cousson <b-cousson@ti.com>

Add voltage domain name to indicate which voltagedomain each
powerdomain is in.

The fixed voltage domain like ldo_wakeup for emu and wkup power
domain is added too.

Update the TI copyright date to 2011.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
[khilman@ti.com]: renamed wakeup domain: s/ldo_wakeup/wakeup/
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/powerdomains44xx_data.c   |   18 +++++++++++++++++-
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    5 +++++
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index c4222c7..af91554 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -1,7 +1,7 @@
 /*
  * OMAP4 Power domains framework
  *
- * Copyright (C) 2009-2010 Texas Instruments, Inc.
+ * Copyright (C) 2009-2011 Texas Instruments, Inc.
  * Copyright (C) 2009-2011 Nokia Corporation
  *
  * Abhijit Pagare (abhijitpagare@ti.com)
@@ -33,6 +33,7 @@
 /* core_44xx_pwrdm: CORE power domain */
 static struct powerdomain core_44xx_pwrdm = {
 	.name		  = "core_pwrdm",
+	.voltdm		  = { .name = "core" },
 	.prcm_offs	  = OMAP4430_PRM_CORE_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -59,6 +60,7 @@ static struct powerdomain core_44xx_pwrdm = {
 /* gfx_44xx_pwrdm: 3D accelerator power domain */
 static struct powerdomain gfx_44xx_pwrdm = {
 	.name		  = "gfx_pwrdm",
+	.voltdm		  = { .name = "core" },
 	.prcm_offs	  = OMAP4430_PRM_GFX_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -76,6 +78,7 @@ static struct powerdomain gfx_44xx_pwrdm = {
 /* abe_44xx_pwrdm: Audio back end power domain */
 static struct powerdomain abe_44xx_pwrdm = {
 	.name		  = "abe_pwrdm",
+	.voltdm		  = { .name = "iva" },
 	.prcm_offs	  = OMAP4430_PRM_ABE_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -96,6 +99,7 @@ static struct powerdomain abe_44xx_pwrdm = {
 /* dss_44xx_pwrdm: Display subsystem power domain */
 static struct powerdomain dss_44xx_pwrdm = {
 	.name		  = "dss_pwrdm",
+	.voltdm		  = { .name = "core" },
 	.prcm_offs	  = OMAP4430_PRM_DSS_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -114,6 +118,7 @@ static struct powerdomain dss_44xx_pwrdm = {
 /* tesla_44xx_pwrdm: Tesla processor power domain */
 static struct powerdomain tesla_44xx_pwrdm = {
 	.name		  = "tesla_pwrdm",
+	.voltdm		  = { .name = "iva" },
 	.prcm_offs	  = OMAP4430_PRM_TESLA_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -136,6 +141,7 @@ static struct powerdomain tesla_44xx_pwrdm = {
 /* wkup_44xx_pwrdm: Wake-up power domain */
 static struct powerdomain wkup_44xx_pwrdm = {
 	.name		  = "wkup_pwrdm",
+	.voltdm		  = { .name = "wakeup" },
 	.prcm_offs	  = OMAP4430_PRM_WKUP_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -152,6 +158,7 @@ static struct powerdomain wkup_44xx_pwrdm = {
 /* cpu0_44xx_pwrdm: MPU0 processor and Neon coprocessor power domain */
 static struct powerdomain cpu0_44xx_pwrdm = {
 	.name		  = "cpu0_pwrdm",
+	.voltdm		  = { .name = "mpu" },
 	.prcm_offs	  = OMAP4430_PRCM_MPU_CPU0_INST,
 	.prcm_partition	  = OMAP4430_PRCM_MPU_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -169,6 +176,7 @@ static struct powerdomain cpu0_44xx_pwrdm = {
 /* cpu1_44xx_pwrdm: MPU1 processor and Neon coprocessor power domain */
 static struct powerdomain cpu1_44xx_pwrdm = {
 	.name		  = "cpu1_pwrdm",
+	.voltdm		  = { .name = "mpu" },
 	.prcm_offs	  = OMAP4430_PRCM_MPU_CPU1_INST,
 	.prcm_partition	  = OMAP4430_PRCM_MPU_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -186,6 +194,7 @@ static struct powerdomain cpu1_44xx_pwrdm = {
 /* emu_44xx_pwrdm: Emulation power domain */
 static struct powerdomain emu_44xx_pwrdm = {
 	.name		  = "emu_pwrdm",
+	.voltdm		  = { .name = "wakeup" },
 	.prcm_offs	  = OMAP4430_PRM_EMU_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -202,6 +211,7 @@ static struct powerdomain emu_44xx_pwrdm = {
 /* mpu_44xx_pwrdm: Modena processor and the Neon coprocessor power domain */
 static struct powerdomain mpu_44xx_pwrdm = {
 	.name		  = "mpu_pwrdm",
+	.voltdm		  = { .name = "mpu" },
 	.prcm_offs	  = OMAP4430_PRM_MPU_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -223,6 +233,7 @@ static struct powerdomain mpu_44xx_pwrdm = {
 /* ivahd_44xx_pwrdm: IVA-HD power domain */
 static struct powerdomain ivahd_44xx_pwrdm = {
 	.name		  = "ivahd_pwrdm",
+	.voltdm		  = { .name = "iva" },
 	.prcm_offs	  = OMAP4430_PRM_IVAHD_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -247,6 +258,7 @@ static struct powerdomain ivahd_44xx_pwrdm = {
 /* cam_44xx_pwrdm: Camera subsystem power domain */
 static struct powerdomain cam_44xx_pwrdm = {
 	.name		  = "cam_pwrdm",
+	.voltdm		  = { .name = "core" },
 	.prcm_offs	  = OMAP4430_PRM_CAM_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -264,6 +276,7 @@ static struct powerdomain cam_44xx_pwrdm = {
 /* l3init_44xx_pwrdm: L3 initators pheripherals power domain  */
 static struct powerdomain l3init_44xx_pwrdm = {
 	.name		  = "l3init_pwrdm",
+	.voltdm		  = { .name = "core" },
 	.prcm_offs	  = OMAP4430_PRM_L3INIT_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -282,6 +295,7 @@ static struct powerdomain l3init_44xx_pwrdm = {
 /* l4per_44xx_pwrdm: Target peripherals power domain */
 static struct powerdomain l4per_44xx_pwrdm = {
 	.name		  = "l4per_pwrdm",
+	.voltdm		  = { .name = "core" },
 	.prcm_offs	  = OMAP4430_PRM_L4PER_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -305,6 +319,7 @@ static struct powerdomain l4per_44xx_pwrdm = {
  */
 static struct powerdomain always_on_core_44xx_pwrdm = {
 	.name		  = "always_on_core_pwrdm",
+	.voltdm		  = { .name = "core" },
 	.prcm_offs	  = OMAP4430_PRM_ALWAYS_ON_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
@@ -314,6 +329,7 @@ static struct powerdomain always_on_core_44xx_pwrdm = {
 /* cefuse_44xx_pwrdm: Customer efuse controller power domain */
 static struct powerdomain cefuse_44xx_pwrdm = {
 	.name		  = "cefuse_pwrdm",
+	.voltdm		  = { .name = "core" },
 	.prcm_offs	  = OMAP4430_PRM_CEFUSE_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm/mach-omap2/voltagedomains44xx_data.c
index 95e1ce5..9a17b5e 100644
--- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
+++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
@@ -86,10 +86,15 @@ static struct voltagedomain omap4_voltdm_core = {
 	.vdd = &omap4_vdd_core_info,
 };
 
+static struct voltagedomain omap4_voltdm_wkup = {
+	.name = "wakeup",
+};
+
 static struct voltagedomain *voltagedomains_omap4[] __initdata = {
 	&omap4_voltdm_mpu,
 	&omap4_voltdm_iva,
 	&omap4_voltdm_core,
+	&omap4_voltdm_wkup,
 	NULL,
 };
 
-- 
1.7.4

