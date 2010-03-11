From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC part1/2 merge v4][PATCH 03/11] omap2/3/4: serial: Remove condition for getting uart4_phys
Date: Wed, 10 Mar 2010 18:14:16 -0600
Message-ID: <1268266464-15702-4-git-send-email-saaguirre@ti.com>
References: <1268266464-15702-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35594 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932920Ab0CKANU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Mar 2010 19:13:20 -0500
In-Reply-To: <1268266464-15702-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Vikram Pandita <vikram.pandita@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <me@felipebalbi.com>, Sergio Aguirre <saaguirre@ti.com>

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

