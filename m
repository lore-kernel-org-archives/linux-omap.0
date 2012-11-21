From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 3/7] ARM: OMAP2+: omap2plus_defconfig: Enable tsl2550 ambient light sensor
Date: Wed, 21 Nov 2012 12:29:19 +0530
Message-ID: <1353481163-29462-4-git-send-email-anilkumar@ti.com>
References: <1353481163-29462-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42856 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638Ab2KUG7k (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 21 Nov 2012 01:59:40 -0500
In-Reply-To: <1353481163-29462-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, AnilKumar Ch <anilkumar@ti.com>

AM335x-evm device have tsl2550 ambient light sensor, one has to
manually enable this support to use light sensor. So this patch
enables tsl2550 driver in omap2plus_defconfig.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index c69c08d..cf08365 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -84,6 +84,7 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=16384
 CONFIG_SENSORS_LIS3LV02D=y
+CONFIG_SENSORS_TSL2550=y
 CONFIG_SENSORS_LIS3_I2C=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
-- 
1.7.9.5

