From: Anuj Aggarwal <anuj.aggarwal@ti.com>
Subject: [PATCH 2/4] AM3517: MMC: Modifying board-evm file to add mmc_init
Date: Mon, 23 Nov 2009 23:55:20 +0530
Message-ID: <1259000722-32222-2-git-send-email-anuj.aggarwal@ti.com>
References: <1259000722-32222-1-git-send-email-anuj.aggarwal@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52151 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbZKWSZT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Nov 2009 13:25:19 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nANIPNOi013051
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 23 Nov 2009 12:25:25 -0600
In-Reply-To: <1259000722-32222-1-git-send-email-anuj.aggarwal@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anuj Aggarwal <anuj.aggarwal@ti.com>

Modifying the board-evm file for AM3517 and adding the mmc_init
function in it.

Signed-off-by: Anuj Aggarwal <anuj.aggarwal@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 415a13d..30f8b00 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -30,6 +30,7 @@
 #include <plat/common.h>
 #include <plat/usb.h>
 
+#include "mmc-am3517evm.h"
 /*
  * Board initialization
  */
@@ -60,6 +61,24 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
 	.reset_gpio_port[2]  = -EINVAL
 };
 
+static struct am3517_hsmmc_info mmc[] = {
+	{
+		.mmc		= 1,
+		.wires		= 4,
+		/* TODO: Need to change */
+		.gpio_cd	= 127,
+		.gpio_wp	= 126,
+	},
+	{
+		.mmc		= 2,
+		.wires		= 4,
+		/* TODO: Need to change */
+		.gpio_cd	= 128,
+		.gpio_wp	= 129,
+	},
+	{}	/* Terminator */
+};
+
 static void __init am3517_evm_init(void)
 {
 	platform_add_devices(am3517_evm_devices,
@@ -67,6 +86,9 @@ static void __init am3517_evm_init(void)
 
 	omap_serial_init();
 	usb_ehci_init(&ehci_pdata);
+
+	/* MMC init function */
+	am3517_mmc_init(mmc);
 }
 
 static void __init am3517_evm_map_io(void)
-- 
1.6.2.4

