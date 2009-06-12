From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH 2/2] OMAP: Zoom2: Fix file system loading issue
Date: Thu, 11 Jun 2009 19:49:57 -0500
Message-ID: <1244767797-22860-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60168 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754998AbZFLAvg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Jun 2009 20:51:36 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n5C0pYkH028733
	for <linux-omap@vger.kernel.org>; Thu, 11 Jun 2009 19:51:39 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vikram Pandita <vikram.pandita@ti.com>

IRQ for 8250 driver is not working on zoom2 as IRQ HIGH level
setting is requried

This setting was not possible in 8250 driver

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
---
 arch/arm/mach-omap2/board-zoom-debugboard.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom-debugboard.c b/arch/arm/mach-omap2/board-zoom-debugboard.c
index bac5c43..a8c45dc 100644
--- a/arch/arm/mach-omap2/board-zoom-debugboard.c
+++ b/arch/arm/mach-omap2/board-zoom-debugboard.c
@@ -83,7 +83,8 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	{
 		.mapbase	= 0x10000000,
 		.irq		= OMAP_GPIO_IRQ(102),
-		.flags		= UPF_BOOT_AUTOCONF|UPF_IOREMAP|UPF_SHARE_IRQ,
+		.flags		= UPF_BOOT_AUTOCONF|UPF_IOREMAP|UPF_SHARE_IRQ|
+					UPF_IRQ_TRIG_HIGH,
 		.iotype		= UPIO_MEM,
 		.regshift	= 1,
 		.uartclk	= QUART_CLK,
-- 
1.6.0.3.613.g9f8f13

