From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] ARM: multi_v7: Add OMAP with ramdisk config bits
Date: Wed, 12 Jun 2013 17:08:02 -0400
Message-ID: <1371071282-14750-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49977 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755695Ab3FLVIb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Jun 2013 17:08:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Sricharan R <r.sricharan@ti.com>

Add ramdisk fileystem related options which lets OMAP5 and Keystone
SOCs to boot till shell with multi_v7_config.

Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>

Signed-off-by: Sricharan R <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
The ARCH_SIRF related fix is already in arm-soc as pointed by Olof on
IRC. So just sending the defconfig bits only. I didn't sync the
multi_v7_config with usual method since it was adding some unnecessary
delta to the $subject patch.

 arch/arm/configs/multi_v7_defconfig |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2e67a27..efd12f4 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1,11 +1,14 @@
 CONFIG_EXPERIMENTAL=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_ARMADA_370=y
 CONFIG_ARCH_SIRF=y
 CONFIG_MACH_ARMADA_XP=y
 CONFIG_ARCH_HIGHBANK=y
+CONFIG_ARCH_OMAP2PLUS=y
+CONFIG_SOC_OMAP5=y
 CONFIG_ARCH_SOCFPGA=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_WM8850=y
@@ -25,6 +28,9 @@ CONFIG_ARM_APPENDED_DTB=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_NET=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_SATA_HIGHBANK=y
@@ -38,6 +44,8 @@ CONFIG_SERIO_AMBAKMI=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_DW=y
+CONFIG_SERIAL_OMAP=y
+CONFIG_SERIAL_OMAP_CONSOLE=y
 CONFIG_KEYBOARD_SPEAR=y
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
@@ -81,3 +89,4 @@ CONFIG_DMADEVICES=y
 CONFIG_PL330_DMA=y
 CONFIG_SIRF_DMA=y
 CONFIG_DW_DMAC=y
+CONFIG_EXT2_FS=y
-- 
1.7.9.5

