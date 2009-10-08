From: "Reddy, Teerth" <teerth@ti.com>
Subject: [PATCH]ZOOM2: Initialization of SDRC params on Zoom2
Date: Thu, 8 Oct 2009 13:56:02 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030A3D05E3@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:37064 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278AbZJHI0n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Oct 2009 04:26:43 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n988Q4Cr031975
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 8 Oct 2009 03:26:06 -0500
Received: from dbde71.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n988Q3ZK006058
	for <linux-omap@vger.kernel.org>; Thu, 8 Oct 2009 13:56:03 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

From: Teerth Reddy <teerth@ti.com>

This patch initializes the correct SDRC settings required 
for DVFS on Zoom2.

Signed-off-by: Teerth Reddy <teerth@ti.com>
---
 arch/arm/mach-omap2/board-zoom2.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/board-zoom2.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/board-zoom2.c
+++ linux-omap-2.6/arch/arm/mach-omap2/board-zoom2.c
@@ -25,6 +25,7 @@
 #include <mach/keypad.h>
 
 #include "mmc-twl4030.h"
+#include "sdram-micron-mt46h32m32lf-6.h"
 
 /* Zoom2 has Qwerty keyboard*/
 static int board_keymap[] = {
@@ -213,7 +214,8 @@ static void __init omap_zoom2_init_irq(v
 {
 	omap_board_config = zoom2_config;
 	omap_board_config_size = ARRAY_SIZE(zoom2_config);
-	omap2_init_common_hw(NULL, NULL);
+	omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
+				 mt46h32m32lf6_sdrc_params);
 	omap_init_irq();
 	omap_gpio_init();
 }
