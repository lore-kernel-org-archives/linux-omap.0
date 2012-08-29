From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 2/2] arm: omap: sram: skip the first 16K on OMAP3 HS
Date: Wed, 29 Aug 2012 18:24:31 +0300
Message-ID: <1346253871-5761-2-git-send-email-aaro.koskinen@iki.fi>
References: <1346253871-5761-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:47085 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456Ab2H2PYd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Aug 2012 11:24:33 -0400
In-Reply-To: <1346253871-5761-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, santosh.shilimkar@ti.com

In some OMAP3 HS devices (at least Nokia N9 and N950), the public SRAM
seems to conflict with secure portition of SRAM. When booting the 3.6-rc3
kernel (and also earlier) on these devices, the kernel gets tainted with
tons of the following warnings:

	[    6.894348] In-band Error seen by MPU  at address 0
	[...]
	[    6.894378] WARNING: at arch/arm/mach-omap2/omap_l3_smx.c:162

Fix this by skipping the first 16K of the public SRAM. (Note that the
mapping could not be changed, as it resulted in secure monitor call
failure in save_secure_sram().)

This will leave 12K SRAM available that should be still sufficient. The
patch has been boot tested with vanilla 3.6-rc3 on N900, N950 and N9.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/arm/plat-omap/sram.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 85c23db..024f3b0 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -68,6 +68,7 @@
 
 static unsigned long omap_sram_start;
 static void __iomem *omap_sram_base;
+static unsigned long omap_sram_skip;
 static unsigned long omap_sram_size;
 static void __iomem *omap_sram_ceil;
 
@@ -106,6 +107,7 @@ static int is_sram_locked(void)
  */
 static void __init omap_detect_sram(void)
 {
+	omap_sram_skip = SRAM_BOOTLOADER_SZ;
 	if (cpu_class_is_omap2()) {
 		if (is_sram_locked()) {
 			if (cpu_is_omap34xx()) {
@@ -113,6 +115,7 @@ static void __init omap_detect_sram(void)
 				if ((omap_type() == OMAP2_DEVICE_TYPE_EMU) ||
 				    (omap_type() == OMAP2_DEVICE_TYPE_SEC)) {
 					omap_sram_size = 0x7000; /* 28K */
+					omap_sram_skip += SZ_16K;
 				} else {
 					omap_sram_size = 0x8000; /* 32K */
 				}
@@ -205,8 +208,8 @@ static void __init omap_map_sram(void)
 	 * Looks like we need to preserve some bootloader code at the
 	 * beginning of SRAM for jumping to flash for reboot to work...
 	 */
-	memset_io(omap_sram_base + SRAM_BOOTLOADER_SZ, 0,
-		  omap_sram_size - SRAM_BOOTLOADER_SZ);
+	memset_io(omap_sram_base + omap_sram_skip, 0,
+		  omap_sram_size - omap_sram_skip);
 }
 
 /*
@@ -220,7 +223,7 @@ void *omap_sram_push_address(unsigned long size)
 {
 	unsigned long available, new_ceil = (unsigned long)omap_sram_ceil;
 
-	available = omap_sram_ceil - (omap_sram_base + SRAM_BOOTLOADER_SZ);
+	available = omap_sram_ceil - (omap_sram_base + omap_sram_skip);
 
 	if (size > available) {
 		pr_err("Not enough space in SRAM\n");
-- 
1.7.2.5

