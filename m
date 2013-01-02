From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v3 2/7] ARM: OMAP2+: omap2plus_defconfig: Add lis3lv02d support
Date: Wed, 2 Jan 2013 15:57:26 +0530
Message-ID: <1357122451-7577-3-git-send-email-anilkumar@ti.com>
References: <1357122451-7577-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38070 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752327Ab3ABK15 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Jan 2013 05:27:57 -0500
In-Reply-To: <1357122451-7577-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, AnilKumar Ch <anilkumar@ti.com>

AM335X-EVM and AM335X-EVMSK devices have lis331dlh accelerometer, one
has to manually enable this support to use accelerometer. So this patch
enables lis3lv02d driver as moudle in omap2plus_defconfig.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index ee6e060..8fd208a 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -83,6 +83,8 @@ CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
+CONFIG_SENSORS_LIS3LV02D=m
+CONFIG_SENSORS_LIS3_I2C=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_MULTI_LUN=y
-- 
1.7.9.5

