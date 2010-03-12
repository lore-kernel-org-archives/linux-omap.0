From: Sergio Aguirre <saaguirre@ti.com>
Subject: [PATCH 3/7] omap2/3/4: serial: Remove condition for getting uart4_phys
Date: Fri, 12 Mar 2010 14:00:05 -0600
Message-ID: <1268424009-18974-4-git-send-email-saaguirre@ti.com>
References: <1268424009-18974-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55081 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758432Ab0CLT6x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 12 Mar 2010 14:58:53 -0500
In-Reply-To: <1268424009-18974-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <me@felipebalbi.com>, Sergio Aguirre <saaguirre@ti.com>

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

