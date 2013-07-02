From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [RFC 5/9] ARM: OMAP4: Add offsets for pwrstctrl and pwrstst
Date: Tue, 2 Jul 2013 16:58:14 +0530
Message-ID: <1372764498-32503-6-git-send-email-vaibhav.bedia@ti.com>
References: <1372764498-32503-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36367 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602Ab3GBL3U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jul 2013 07:29:20 -0400
In-Reply-To: <1372764498-32503-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, rnayak@ti.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

OMAP4 powerdomains have a consistent register layout
and so far the pwrstctrl and pwrstst offsets were
hardcoded in the lowlevel APIs.

AM335x powerdomains don't have a consistent register
layout and hence the offsets used in the lowlevel APIs
need to be removed. As part of the AM335x work two additional
fields pwrstctrl_offs and pwrstst_offs were introduced in
the pwrdomain data structure. To enable consolidation of
AM335x and OMAP4 lowlevel APIs add in the appropriate
offsets to the OMAP4 pwrdomains.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/powerdomains44xx_data.c | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index 704664c..ed53787 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -36,6 +36,8 @@ static struct powerdomain core_44xx_pwrdm = {
 	.voltdm		  = { .name = "core" },
 	.prcm_offs	  = OMAP4430_PRM_CORE_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
+	.pwrstctrl_offs	  = OMAP4_PM_PWSTCTRL,
+	.pwrstst_offs	  = OMAP4_PM_PWSTST,
 	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 5,
@@ -62,6 +64,8 @@ static struct powerdomain gfx_44xx_pwrdm = {
 	.voltdm		  = { .name = "core" },
 	.prcm_offs	  = OMAP4430_PRM_GFX_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
+	.pwrstctrl_offs	  = OMAP4_PM_PWSTCTRL,
+	.pwrstst_offs	  = OMAP4_PM_PWSTST,
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
@@ -79,6 +83,8 @@ static struct powerdomain abe_44xx_pwrdm = {
 	.voltdm		  = { .name = "iva" },
 	.prcm_offs	  = OMAP4430_PRM_ABE_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
+	.pwrstctrl_offs	  = OMAP4_PM_PWSTCTRL,
+	.pwrstst_offs	  = OMAP4_PM_PWSTST,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 2,
@@ -99,6 +105,8 @@ static struct powerdomain dss_44xx_pwrdm = {
 	.voltdm		  = { .name = "core" },
 	.prcm_offs	  = OMAP4430_PRM_DSS_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
+	.pwrstctrl_offs	  = OMAP4_PM_PWSTCTRL,
+	.pwrstst_offs	  = OMAP4_PM_PWSTST,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 1,
@@ -117,6 +125,8 @@ static struct powerdomain tesla_44xx_pwrdm = {
 	.voltdm		  = { .name = "iva" },
 	.prcm_offs	  = OMAP4430_PRM_TESLA_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
+	.pwrstctrl_offs	  = OMAP4_PM_PWSTCTRL,
+	.pwrstst_offs	  = OMAP4_PM_PWSTST,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 3,
@@ -139,6 +149,8 @@ static struct powerdomain wkup_44xx_pwrdm = {
 	.voltdm		  = { .name = "wakeup" },
 	.prcm_offs	  = OMAP4430_PRM_WKUP_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
+	.pwrstctrl_offs	  = OMAP4_PM_PWSTCTRL,
+	.pwrstst_offs	  = OMAP4_PM_PWSTST,
 	.pwrsts		  = PWRSTS_ON,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
@@ -155,6 +167,8 @@ static struct powerdomain cpu0_44xx_pwrdm = {
 	.voltdm		  = { .name = "mpu" },
 	.prcm_offs	  = OMAP4430_PRCM_MPU_CPU0_INST,
 	.prcm_partition	  = OMAP4430_PRCM_MPU_PARTITION,
+	.pwrstctrl_offs	  = OMAP4_PM_PWSTCTRL,
+	.pwrstst_offs	  = OMAP4_PM_PWSTST,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
@@ -172,6 +186,8 @@ static struct powerdomain cpu1_44xx_pwrdm = {
 	.voltdm		  = { .name = "mpu" },
 	.prcm_offs	  = OMAP4430_PRCM_MPU_CPU1_INST,
 	.prcm_partition	  = OMAP4430_PRCM_MPU_PARTITION,
+	.pwrstctrl_offs	  = OMAP4_PM_PWSTCTRL,
+	.pwrstst_offs	  = OMAP4_PM_PWSTST,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
@@ -189,6 +205,8 @@ static struct powerdomain emu_44xx_pwrdm = {
 	.voltdm		  = { .name = "wakeup" },
 	.prcm_offs	  = OMAP4430_PRM_EMU_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
+	.pwrstctrl_offs	  = OMAP4_PM_PWSTCTRL,
+	.pwrstst_offs	  = OMAP4_PM_PWSTST,
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
@@ -205,6 +223,8 @@ static struct powerdomain mpu_44xx_pwrdm = {
 	.voltdm		  = { .name = "mpu" },
 	.prcm_offs	  = OMAP4430_PRM_MPU_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
+	.pwrstctrl_offs	  = OMAP4_PM_PWSTCTRL,
+	.pwrstst_offs	  = OMAP4_PM_PWSTST,
 	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 3,
@@ -226,6 +246,8 @@ static struct powerdomain ivahd_44xx_pwrdm = {
 	.voltdm		  = { .name = "iva" },
 	.prcm_offs	  = OMAP4430_PRM_IVAHD_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
+	.pwrstctrl_offs	  = OMAP4_PM_PWSTCTRL,
+	.pwrstst_offs	  = OMAP4_PM_PWSTST,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF,
 	.banks		  = 4,
@@ -250,6 +272,8 @@ static struct powerdomain cam_44xx_pwrdm = {
 	.voltdm		  = { .name = "core" },
 	.prcm_offs	  = OMAP4430_PRM_CAM_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
+	.pwrstctrl_offs	  = OMAP4_PM_PWSTCTRL,
+	.pwrstst_offs	  = OMAP4_PM_PWSTST,
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
@@ -267,6 +291,8 @@ static struct powerdomain l3init_44xx_pwrdm = {
 	.voltdm		  = { .name = "core" },
 	.prcm_offs	  = OMAP4430_PRM_L3INIT_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
+	.pwrstctrl_offs	  = OMAP4_PM_PWSTCTRL,
+	.pwrstst_offs	  = OMAP4_PM_PWSTST,
 	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 1,
@@ -285,6 +311,8 @@ static struct powerdomain l4per_44xx_pwrdm = {
 	.voltdm		  = { .name = "core" },
 	.prcm_offs	  = OMAP4430_PRM_L4PER_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
+	.pwrstctrl_offs	  = OMAP4_PM_PWSTCTRL,
+	.pwrstst_offs	  = OMAP4_PM_PWSTST,
 	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 2,
@@ -308,6 +336,8 @@ static struct powerdomain always_on_core_44xx_pwrdm = {
 	.voltdm		  = { .name = "core" },
 	.prcm_offs	  = OMAP4430_PRM_ALWAYS_ON_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
+	.pwrstctrl_offs	  = OMAP4_PM_PWSTCTRL,
+	.pwrstst_offs	  = OMAP4_PM_PWSTST,
 	.pwrsts		  = PWRSTS_ON,
 };
 
@@ -317,6 +347,8 @@ static struct powerdomain cefuse_44xx_pwrdm = {
 	.voltdm		  = { .name = "core" },
 	.prcm_offs	  = OMAP4430_PRM_CEFUSE_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
+	.pwrstctrl_offs	  = OMAP4_PM_PWSTCTRL,
+	.pwrstst_offs	  = OMAP4_PM_PWSTST,
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
-- 
1.8.1

