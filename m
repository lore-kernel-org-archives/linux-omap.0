From: Manjunatha GK <manjugk@ti.com>
Subject: [PATCH] OMAP: Zoom3: Fix Zoom3 booting issue
Date: Tue,  2 Mar 2010 19:05:55 +0530
Message-ID: <1267536955-31268-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36089 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753019Ab0CBNRk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Mar 2010 08:17:40 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Manjunatha GK <manjugk@ti.com>, Tony Lindgren <tony@atomide.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Govindraj R <govindraj.raja@ti.com>

The commit id "5550bc33a1a9002976022cc794fe8c52ad9a0021" seems to be broken
zoom3 boot which adds support for UART4 on OMAP4 and OMAP3630.

But, it looks like OMAP3630 UART4 interface and functional clock nodes needs
to be added for omap3630. Thus limiting no. of UART's for 3630 to 3 to prevent
boot up issues until clock nodes are added for UART4 on OMAP3630.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Manjunatha GK <manjugk@ti.com>
Signed-off-by: Govindraj R <govindraj.raja@ti.com>
---
 arch/arm/mach-omap2/serial.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index b79bc89..ac22a4e 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -764,7 +764,12 @@ void __init omap_serial_init(void)
 {
 	int i, nr_ports;
 
-	if (!(cpu_is_omap3630() || cpu_is_omap4430()))
+	/* Limit no.of UART ports to three for OMAP3630 since
+	 * clock nodes are yet to be updated for 3630 UART4.
+	 * TODO: update clock nodes for 3630 UART4 and then enable
+	 * check for !(cpu_is_omap3630())
+	 */
+	if (!cpu_is_omap4430())
 		nr_ports = 3;
 	else
 		nr_ports = ARRAY_SIZE(omap_uart);
-- 
1.6.0.4

