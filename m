From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v2 3/8] ARM: OMAP2+: omap2plus_defconfig: Enable lis3lv02d accelerometer
Date: Fri, 14 Dec 2012 11:02:59 +0530
Message-ID: <1355463184-16283-4-git-send-email-anilkumar@ti.com>
References: <1355463184-16283-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33514 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751107Ab2LNFdg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Dec 2012 00:33:36 -0500
In-Reply-To: <1355463184-16283-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, AnilKumar Ch <anilkumar@ti.com>

AM335X-EVM and AM335X-EVMSK devices have lis331dlh accelerometer, one
has to manually enable this support to use accelerometer. So this patch
enables lis3lv02d driver in omap2plus_defconfig.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 27bf465..417a320 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -81,6 +81,8 @@ CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
+CONFIG_SENSORS_LIS3LV02D=y
+CONFIG_SENSORS_LIS3_I2C=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_MULTI_LUN=y
-- 
1.7.9.5

