From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 4/8] ti814evm: Add support for musb interface
Date: Tue, 11 Oct 2011 16:56:05 +0530
Message-ID: <1318332369-9732-5-git-send-email-ajay.gupta@ti.com>
References: <1318332369-9732-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56040 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670Ab1JKL0P (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Oct 2011 07:26:15 -0400
In-Reply-To: <1318332369-9732-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, balbi@ti.com, Ravi Babu <ravibabu@ti.com>, Ajay Kumar Gupta <ajay.gupta@ti.com>

From: Ravi Babu <ravibabu@ti.com>

Adding musb support in ti814 EVM board file.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Ravi Babu <ravibabu@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/board-ti8148evm.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-ti8148evm.c b/arch/arm/mach-omap2/board-ti8148evm.c
index 5f0280e..03c85dd 100644
--- a/arch/arm/mach-omap2/board-ti8148evm.c
+++ b/arch/arm/mach-omap2/board-ti8148evm.c
@@ -23,6 +23,14 @@
 #include <plat/irqs.h>
 #include <plat/board.h>
 #include <plat/common.h>
+#include <plat/usb.h>
+
+static struct omap_musb_board_data musb_board_data = {
+	.set_phy_power	= ti81xx_musb_phy_power,
+	.interface_type	= MUSB_INTERFACE_ULPI,
+	.mode           = MUSB_OTG,
+	.power		= 500,
+};
 
 static struct omap_board_config_kernel ti8148_evm_config[] __initdata = {
 };
@@ -38,6 +46,7 @@ static void __init ti8148_evm_init(void)
 	omap_sdrc_init(NULL, NULL);
 	omap_board_config = ti8148_evm_config;
 	omap_board_config_size = ARRAY_SIZE(ti8148_evm_config);
+	usb_musb_init(&musb_board_data);
 }
 
 static void __init ti8148_evm_map_io(void)
-- 
1.6.2.4

