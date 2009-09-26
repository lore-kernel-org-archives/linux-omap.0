From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: OMAP4430 build broken on latest mainline/linux-omap head
Date: Sat, 26 Sep 2009 13:39:12 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02BADABC8A@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41243 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbZIZIJ2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 26 Sep 2009 04:09:28 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Tony,
OMAP4430 board build is breaking on the latest mainline head because of couple of issues.
1. The serial.c merge conflict issue below wasn't fixed correctly :(
Related link:
http://article.gmane.org/gmane.linux.ports.arm.omap/23341

2. Pauls below series breaks build as well. 
[PATCH 00/13] OMAP PM, clock,	and SDRC updates for the 2.6.32 merge window


Paul,
Can you fix the same please? I don't have the correct " cm-regbits-4xxx.h" file to generate the patch. 

***************************************************
CC      arch/arm/mach-omap2/control.o
  CC      arch/arm/mach-omap2/mux.o
  CC      arch/arm/mach-omap2/devices.o
  CC      arch/arm/mach-omap2/serial.o
  CC      arch/arm/mach-omap2/gpmc.o
  CC      arch/arm/mach-omap2/timer-gp.o
  CC      arch/arm/mach-omap2/omap-smp.o
  AS      arch/arm/mach-omap2/omap-headsmp.o
  CC      arch/arm/mach-omap2/timer-mpu.o
  CC      arch/arm/mach-omap2/cm4xxx.o
arch/arm/mach-omap2/cm4xxx.c:25:29: error: cm-regbits-4xxx.h: No such file or directory
arch/arm/mach-omap2/cm4xxx.c: In function 'omap4_cm_wait_idlest_ready':
arch/arm/mach-omap2/cm4xxx.c:61: error: implicit declaration of function 'omap4_cm_read_mod_reg'
arch/arm/mach-omap2/cm4xxx.c:62: error: 'OMAP4_CM_CLKCTRL_DREG' undeclared (first use in this function)
arch/arm/mach-omap2/cm4xxx.c:62: error: (Each undeclared identifier is reported only once
arch/arm/mach-omap2/cm4xxx.c:62: error: for each function it appears in.)
make[1]: *** [arch/arm/mach-omap2/cm4xxx.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

*****************************************************


Tony,
Patch regarding one 1. is below.

>From 3abd16f9b81dc55a2d894175d4a75f5a40c0fdd5 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Sat, 26 Sep 2009 13:07:39 +0530
Subject: [PATCH] ARM: OMAP4: Fix build break because of merge conflict

On the latest mainline head 2.6.31 (commit:6d7f18f6), OMAP4430 board
build is broken. This was mainly because of merge conflict which wasn't
resolved correctly.

The related patch and issue was discussed here.
http://article.gmane.org/gmane.linux.ports.arm.omap/23341

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/serial.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 3a529c7..54dfeb5 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -109,16 +109,6 @@ static struct plat_serial8250_port serial_platform_data2[] = {
 		.regshift	= 2,
 		.uartclk	= OMAP24XX_BASE_BAUD * 16,
 	}, {
-#ifdef CONFIG_ARCH_OMAP4
-		.membase	= IO_ADDRESS(OMAP_UART4_BASE),
-		.mapbase	= OMAP_UART4_BASE,
-		.irq		= 70,
-		.flags		= UPF_BOOT_AUTOCONF,
-		.iotype		= UPIO_MEM,
-		.regshift	= 2,
-		.uartclk	= OMAP24XX_BASE_BAUD * 16,
-	}, {
-#endif
 		.flags		= 0
 	}
 };
@@ -126,7 +116,7 @@ static struct plat_serial8250_port serial_platform_data2[] = {
 #ifdef CONFIG_ARCH_OMAP4
 static struct plat_serial8250_port serial_platform_data3[] = {
 	{
-		.membase	= IO_ADDRESS(OMAP_UART4_BASE),
+		.membase	= OMAP2_IO_ADDRESS(OMAP_UART4_BASE),
 		.mapbase	= OMAP_UART4_BASE,
 		.irq		= 70,
 		.flags		= UPF_BOOT_AUTOCONF,
@@ -579,7 +569,7 @@ static struct omap_uart_state omap_uart[OMAP_MAX_NR_PORTS] = {
 	{
 		.pdev = {
 			.name			= "serial8250",
-			.id			= 3
+			.id			= 3,
 			.dev			= {
 				.platform_data	= serial_platform_data3,
 			},
-- 
1.5.4.7

Thanks !!

Regards,
Santosh

