From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC v3][PATCH 2/6] omap2/3/4: serial: Remove condition for getting uart4_phys
Date: Sat, 27 Feb 2010 14:46:07 -0600
Message-ID: <1267303571-3674-3-git-send-email-saaguirre@ti.com>
References: <1267303571-3674-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56353 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030838Ab0B0Up7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 27 Feb 2010 15:45:59 -0500
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1RKjwPM009629
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Sat, 27 Feb 2010 14:45:58 -0600
In-Reply-To: <1267303571-3674-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sergio Aguirre <saaguirre@ti.com>

This check is invalid, since we haven't filled the
omap_revision var at this point.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/serial.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index 128bfae..605422e 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -115,7 +115,6 @@ static struct plat_serial8250_port serial_platform_data2[] = {
 	}
 };
 
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 static struct plat_serial8250_port serial_platform_data3[] = {
 	{
 		.irq		= 70,
@@ -128,23 +127,12 @@ static struct plat_serial8250_port serial_platform_data3[] = {
 	}
 };
 
-static inline void omap2_set_globals_uart4(struct omap_globals *omap2_globals)
-{
-	serial_platform_data3[0].mapbase = omap2_globals->uart4_phys;
-}
-#else
-static inline void omap2_set_globals_uart4(struct omap_globals *omap2_globals)
-{
-}
-#endif
-
 void __init omap2_set_globals_uart(struct omap_globals *omap2_globals)
 {
 	serial_platform_data0[0].mapbase = omap2_globals->uart1_phys;
 	serial_platform_data1[0].mapbase = omap2_globals->uart2_phys;
 	serial_platform_data2[0].mapbase = omap2_globals->uart3_phys;
-	if (cpu_is_omap3630() || cpu_is_omap44xx())
-		omap2_set_globals_uart4(omap2_globals);
+	serial_platform_data3[0].mapbase = omap2_globals->uart4_phys;
 }
 
 static inline unsigned int __serial_read_reg(struct uart_port *up,
-- 
1.6.3.3

