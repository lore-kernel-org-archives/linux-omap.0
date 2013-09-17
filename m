From: Russ Dill <Russ.Dill@ti.com>
Subject: [RFC PATCH 10/11] ARM: OMAP2+: AM33XX: Add PIE support for AM33XX
Date: Tue, 17 Sep 2013 05:43:36 -0700
Message-ID: <1379421817-15759-11-git-send-email-Russ.Dill@ti.com>
References: <1379421817-15759-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:44971 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752953Ab3IQMoO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Sep 2013 08:44:14 -0400
In-Reply-To: <1379421817-15759-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>, mans@mansr.com, Shawn Guo <shawn.guo@linaro.org>, Dave Martin <Dave.Martin@arm.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>

This enables CONFIG_PIE for omap2plus_defconfig and adds
an am33xx PIE section group. This is necessary for am33xx
suspend/resume code as it is written in C.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 arch/arm/kernel/pie.lds.S            | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 5d4c9b8..f342f85 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -102,6 +102,7 @@ CONFIG_SENSORS_TSL2550=m
 CONFIG_SENSORS_LIS3_I2C=m
 CONFIG_BMP085_I2C=m
 CONFIG_SRAM=y
+CONFIG_PIE=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_MULTI_LUN=y
diff --git a/arch/arm/kernel/pie.lds.S b/arch/arm/kernel/pie.lds.S
index 4fd5ac5..92fba61 100644
--- a/arch/arm/kernel/pie.lds.S
+++ b/arch/arm/kernel/pie.lds.S
@@ -23,6 +23,7 @@ SECTIONS
 
 	PIE_OVERLAY_START
 	OVERLAY : NOCROSSREFS {
+		PIE_OVERLAY_SECTION(am33xx)
 	}
 	PIE_OVERLAY_SEND
 
-- 
1.8.3.2

