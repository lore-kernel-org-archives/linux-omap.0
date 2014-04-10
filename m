From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/11] ARM: OMAP2+: Enable CPUidle in omap2plus_defconfig
Date: Thu, 10 Apr 2014 16:47:17 -0700
Message-ID: <1397173639-29587-10-git-send-email-tony@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49169 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758902AbaDJXrd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Apr 2014 19:47:33 -0400
In-Reply-To: <1397173639-29587-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@linaro.org>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>

Enable CPUidle so it's easier for maintainers to notice
if some future code changes cause regressions.

Cc: Kevin Hilman <khilman@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/configs/omap2plus_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 3a0b53d..9da475a 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -21,6 +21,8 @@ CONFIG_MODULE_SRCVERSION_ALL=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_MULTI_V6=y
+CONFIG_POWER_AVS_OMAP=y
+CONFIG_POWER_AVS_OMAP_CLASS3=y
 CONFIG_OMAP_RESET_CLOCKS=y
 CONFIG_OMAP_MUX_DEBUG=y
 CONFIG_ARCH_OMAP2=y
@@ -41,6 +43,7 @@ CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="root=/dev/mmcblk0p2 rootwait console=ttyO2,115200"
 CONFIG_KEXEC=y
 CONFIG_FPE_NWFPE=y
+CONFIG_CPU_IDLE=y
 CONFIG_BINFMT_MISC=y
 CONFIG_PM_DEBUG=y
 CONFIG_NET=y
@@ -158,11 +161,14 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_TWL4030=y
 CONFIG_W1=y
 CONFIG_POWER_SUPPLY=y
+CONFIG_POWER_AVS=y
 CONFIG_SENSORS_LM75=m
 CONFIG_THERMAL=y
 CONFIG_THERMAL_GOV_FAIR_SHARE=y
 CONFIG_THERMAL_GOV_USER_SPACE=y
+CONFIG_CPU_THERMAL=y
 CONFIG_TI_SOC_THERMAL=y
+CONFIG_TI_THERMAL=y
 CONFIG_OMAP4_THERMAL=y
 CONFIG_OMAP5_THERMAL=y
 CONFIG_DRA752_THERMAL=y
@@ -175,6 +181,7 @@ CONFIG_MFD_TPS65910=y
 CONFIG_TWL6040_CORE=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_REGULATOR_PALMAS=y
+CONFIG_REGULATOR_TI_ABB=y
 CONFIG_REGULATOR_TPS65023=y
 CONFIG_REGULATOR_TPS6507X=y
 CONFIG_REGULATOR_TPS65217=y
-- 
1.8.1.1

