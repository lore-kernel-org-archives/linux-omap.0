From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [RFC 3/9] ARM: OMAP2+: AM335X: Add a constant PRCM_PARITION for the pwrdomains
Date: Tue, 2 Jul 2013 16:58:12 +0530
Message-ID: <1372764498-32503-4-git-send-email-vaibhav.bedia@ti.com>
References: <1372764498-32503-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33017 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799Ab3GBL3K (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jul 2013 07:29:10 -0400
In-Reply-To: <1372764498-32503-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tony@atomide.com, paul@pwsan.com, rnayak@ti.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

OMAP4 style PRM, CM APIs expect the pwrdomains to specify a
prcm_partition. Introduce a PRCM_PARTITION for the AM335x
pwrdomains so that we can eventually consolidate the code.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/mach-omap2/powerdomains33xx_data.c | 6 ++++++
 arch/arm/mach-omap2/prm33xx.h               | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/mach-omap2/powerdomains33xx_data.c b/arch/arm/mach-omap2/powerdomains33xx_data.c
index 869adb8..646e912 100644
--- a/arch/arm/mach-omap2/powerdomains33xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains33xx_data.c
@@ -24,6 +24,7 @@
 static struct powerdomain gfx_33xx_pwrdm = {
 	.name			= "gfx_pwrdm",
 	.voltdm			= { .name = "core" },
+	.prcm_partition		= AM33XX_PRM_PARTITION,
 	.prcm_offs		= AM33XX_PRM_GFX_MOD,
 	.pwrstctrl_offs		= AM33XX_PM_GFX_PWRSTCTRL_OFFSET,
 	.pwrstst_offs		= AM33XX_PM_GFX_PWRSTST_OFFSET,
@@ -55,6 +56,7 @@ static struct powerdomain gfx_33xx_pwrdm = {
 static struct powerdomain rtc_33xx_pwrdm = {
 	.name			= "rtc_pwrdm",
 	.voltdm			= { .name = "rtc" },
+	.prcm_partition		= AM33XX_PRM_PARTITION,
 	.prcm_offs		= AM33XX_PRM_RTC_MOD,
 	.pwrstctrl_offs		= AM33XX_PM_RTC_PWRSTCTRL_OFFSET,
 	.pwrstst_offs		= AM33XX_PM_RTC_PWRSTST_OFFSET,
@@ -65,6 +67,7 @@ static struct powerdomain rtc_33xx_pwrdm = {
 static struct powerdomain wkup_33xx_pwrdm = {
 	.name			= "wkup_pwrdm",
 	.voltdm			= { .name = "core" },
+	.prcm_partition		= AM33XX_PRM_PARTITION,
 	.prcm_offs		= AM33XX_PRM_WKUP_MOD,
 	.pwrstctrl_offs		= AM33XX_PM_WKUP_PWRSTCTRL_OFFSET,
 	.pwrstst_offs		= AM33XX_PM_WKUP_PWRSTST_OFFSET,
@@ -75,6 +78,7 @@ static struct powerdomain wkup_33xx_pwrdm = {
 static struct powerdomain per_33xx_pwrdm = {
 	.name			= "per_pwrdm",
 	.voltdm			= { .name = "core" },
+	.prcm_partition		= AM33XX_PRM_PARTITION,
 	.prcm_offs		= AM33XX_PRM_PER_MOD,
 	.pwrstctrl_offs		= AM33XX_PM_PER_PWRSTCTRL_OFFSET,
 	.pwrstst_offs		= AM33XX_PM_PER_PWRSTST_OFFSET,
@@ -118,6 +122,7 @@ static struct powerdomain per_33xx_pwrdm = {
 static struct powerdomain mpu_33xx_pwrdm = {
 	.name			= "mpu_pwrdm",
 	.voltdm			= { .name = "mpu" },
+	.prcm_partition		= AM33XX_PRM_PARTITION,
 	.prcm_offs		= AM33XX_PRM_MPU_MOD,
 	.pwrstctrl_offs		= AM33XX_PM_MPU_PWRSTCTRL_OFFSET,
 	.pwrstst_offs		= AM33XX_PM_MPU_PWRSTST_OFFSET,
@@ -161,6 +166,7 @@ static struct powerdomain mpu_33xx_pwrdm = {
 static struct powerdomain cefuse_33xx_pwrdm = {
 	.name		= "cefuse_pwrdm",
 	.voltdm		= { .name = "core" },
+	.prcm_partition	= AM33XX_PRM_PARTITION,
 	.prcm_offs	= AM33XX_PRM_CEFUSE_MOD,
 	.pwrstctrl_offs	= AM33XX_PM_CEFUSE_PWRSTCTRL_OFFSET,
 	.pwrstst_offs	= AM33XX_PM_CEFUSE_PWRSTST_OFFSET,
diff --git a/arch/arm/mach-omap2/prm33xx.h b/arch/arm/mach-omap2/prm33xx.h
index 9b9918d..c82b22b2 100644
--- a/arch/arm/mach-omap2/prm33xx.h
+++ b/arch/arm/mach-omap2/prm33xx.h
@@ -24,6 +24,7 @@
 #define AM33XX_PRM_REGADDR(inst, reg)                         \
 	AM33XX_L4_WK_IO_ADDRESS(AM33XX_PRM_BASE + (inst) + (reg))
 
+#define AM33XX_PRM_PARTITION	1
 
 /* PRM instances */
 #define AM33XX_PRM_OCP_SOCKET_MOD	0x0B00
-- 
1.8.1

