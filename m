From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [PATCH] usb: omap: fix the warning unused variable 'status'
Date: Tue,  5 Oct 2010 02:50:13 +0530
Message-ID: <1286227213-16182-1-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52530 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089Ab0JEJSx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Oct 2010 05:18:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: gadiyar@ti.com, nskamat@ti.com, balbi@ti.com, Keshava Munegowda <keshava_mgowda@ti.com>

This patch fix the follwing warning when compiling usb code 
for OMAP defconfigs.
arch/arm/mach-omap2/board-omap4panda.c:277: warning: unused variable 'status'

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-2.6/arch/arm/mach-omap2/board-omap4panda.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-omap4panda.c
+++ linux-2.6/arch/arm/mach-omap2/board-omap4panda.c
@@ -274,8 +274,6 @@ static int __init omap4_panda_i2c_init(v
 }
 static void __init omap4_panda_init(void)
 {
-	int status;
-
 	omap4_panda_i2c_init();
 	omap_serial_init();
 	omap4_twl6030_hsmmc_init(mmc);
