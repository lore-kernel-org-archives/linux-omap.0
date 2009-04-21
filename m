From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH] OMAP: Remove IRQ hardcoding from serial.c
Date: Tue, 21 Apr 2009 17:35:27 +0530
Message-ID: <1240315527-16064-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51902 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753459AbZDUMFg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Apr 2009 08:05:36 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n3LC5UpG025388
	for <linux-omap@vger.kernel.org>; Tue, 21 Apr 2009 07:05:36 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>

This patch removes hardcoding done for UART IRQ lines
from serial.c file.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/serial.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 4dcf39c..f7a3090 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -29,7 +29,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	{
 		.membase	= IO_ADDRESS(OMAP_UART1_BASE),
 		.mapbase	= OMAP_UART1_BASE,
-		.irq		= 72,
+		.irq		= INT_24XX_UART1_IRQ,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
@@ -37,7 +37,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	}, {
 		.membase	= IO_ADDRESS(OMAP_UART2_BASE),
 		.mapbase	= OMAP_UART2_BASE,
-		.irq		= 73,
+		.irq		= INT_24XX_UART2_IRQ,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
@@ -45,7 +45,7 @@ static struct plat_serial8250_port serial_platform_data[] = {
 	}, {
 		.membase	= IO_ADDRESS(OMAP_UART3_BASE),
 		.mapbase	= OMAP_UART3_BASE,
-		.irq		= 74,
+		.irq		= INT_24XX_UART3_IRQ,
 		.flags		= UPF_BOOT_AUTOCONF,
 		.iotype		= UPIO_MEM,
 		.regshift	= 2,
-- 
1.5.4.7

