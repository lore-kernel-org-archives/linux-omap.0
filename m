From: Sergio Aguirre <saaguirre@ti.com>
Subject: [PATCH 3/7] omap2/3/4: serial: Remove condition for getting uart4_phys
Date: Mon, 15 Mar 2010 18:04:08 -0500
Message-ID: <1268694252-21985-4-git-send-email-saaguirre@ti.com>
References: <1268694252-21985-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57774 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937081Ab0COXCd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Mar 2010 19:02:33 -0400
In-Reply-To: <1268694252-21985-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Sergio Aguirre <saaguirre@ti.com>

This check is invalid, since we haven't filled the
omap_revision var at this point.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/serial.c |   14 +-------------
 1 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index a55e6ae..3771254 100644
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

