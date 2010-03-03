From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC part1/2 merge][PATCH 02/10] omap2/3/4: serial: Remove condition for getting uart4_phys
Date: Wed,  3 Mar 2010 08:18:37 -0600
Message-ID: <1267625925-22616-3-git-send-email-saaguirre@ti.com>
References: <1267625925-22616-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41980 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293Ab0CCOSe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Mar 2010 09:18:34 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o23EIY13025028
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 3 Mar 2010 08:18:34 -0600
In-Reply-To: <1267625925-22616-1-git-send-email-saaguirre@ti.com>
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
index 1ca4330..351ba62 100644
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

