From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH v3 3/7] ARM: OMAP2+: omap2plus_defconfig: Add tsl2550 support
Date: Wed, 2 Jan 2013 15:57:27 +0530
Message-ID: <1357122451-7577-4-git-send-email-anilkumar@ti.com>
References: <1357122451-7577-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38071 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752623Ab3ABK15 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Jan 2013 05:27:57 -0500
In-Reply-To: <1357122451-7577-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, AnilKumar Ch <anilkumar@ti.com>

AM335x-evm device have tsl2550 ambient light sensor, one has to
manually enable this support to use light sensor. So this patch
enables tsl2550 driver as module in omap2plus_defconfig.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 8fd208a..cd1cd51 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -84,6 +84,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
 CONFIG_SENSORS_LIS3LV02D=m
+CONFIG_SENSORS_TSL2550=m
 CONFIG_SENSORS_LIS3_I2C=m
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
-- 
1.7.9.5

