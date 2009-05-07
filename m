From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH] OMAP: RX51: Add log partition
Date: Thu, 07 May 2009 09:53:49 +0300
Message-ID: <4A02857D.4000301@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:20547 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757900AbZEGGw5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 02:52:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap Mailing List <linux-omap@vger.kernel.org>

>From 22d5b418dd2535f326d7f3ee5661db8159b9845d Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Thu, 7 May 2009 09:45:32 +0300
Subject: [PATCH] OMAP: RX51: Add log partition

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 arch/arm/configs/rx51_defconfig              |    2 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c |    5 +++++
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/rx51_defconfig b/arch/arm/configs/rx51_defconfig
index 2672a70..7ee4b6a 100644
--- a/arch/arm/configs/rx51_defconfig
+++ b/arch/arm/configs/rx51_defconfig
@@ -288,7 +288,7 @@ CONFIG_ALIGNMENT_TRAP=y
 #
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="init=/sbin/preinit ubi.mtd=4 root=ubi0:rootfs rootfstype=ubifs rw console=ttyMTD5"
+CONFIG_CMDLINE="init=/sbin/preinit ubi.mtd=rootfs root=ubi0:rootfs rootfstype=ubifs rootflags=bulk_read,no_chk_data_crc rw console=ttyMTD,log console=tty0"
 # CONFIG_XIP_KERNEL is not set
 # CONFIG_KEXEC is not set
 
diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 55e8568..4d10f5c 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -494,6 +494,11 @@ static struct mtd_partition onenand_partitions[] = {
 		.size           = 0x60000,
 	},
 	{
+		.name           = "log",
+		.offset         = MTDPART_OFS_APPEND,
+		.size           = 0x40000,
+	},
+	{
 		.name           = "kernel",
 		.offset         = MTDPART_OFS_APPEND,
 		.size           = 0x200000,
-- 
1.5.6.3

