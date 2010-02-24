From: Sergio Aguirre <saaguirre@ti.com>
Subject: [PATCH] omap2/3/4: serial: Don't init UART4 for 3630 still
Date: Wed, 24 Feb 2010 03:02:24 -0600
Message-ID: <1267002144-21944-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50265 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755664Ab0BXJCV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Feb 2010 04:02:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Vikram Pandita <vikram.pandita@ti.com>, Moiz Sonasath <m-sonasath@ti.com>, Sergio Aguirre <saaguirre@ti.com>

The patch named:
  "omap2/3/4: Fix mach-omap2/serial.c for multiboot"

Which added UART4 init also for 36xx based boards, broke zoom3
booting.

In theory, for zoom3 case, we should have UART4 + external debugboard
UART running with no issues. But unless the real issue is fixed,
this patch is crucial for Zoom3 booting.

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/serial.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index b79bc89..c4a810b 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -764,7 +764,7 @@ void __init omap_serial_init(void)
 {
 	int i, nr_ports;
 
-	if (!(cpu_is_omap3630() || cpu_is_omap4430()))
+	if (!cpu_is_omap4430())
 		nr_ports = 3;
 	else
 		nr_ports = ARRAY_SIZE(omap_uart);
-- 
1.6.3.3

