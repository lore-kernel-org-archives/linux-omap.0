From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 1/2] AM35x: Add missing GPIO mux config for EHCI port
Date: Mon, 22 Feb 2010 15:51:12 +0530
Message-ID: <1266834073-7670-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55445 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592Ab0BVKVS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Feb 2010 05:21:18 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1MALFIX004620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 22 Feb 2010 04:21:17 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>

Adding GPIO mux config used for PHY reset of EHCI port on base board.
We get below failure message without this patch,

"hub 1-0:1.0: unable to enumerate USB device on port 1"

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index af99faf..c78a4d0 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -232,6 +232,9 @@ static void __init am3517_evm_init(void)
 				ARRAY_SIZE(am3517_evm_devices));
 
 	omap_serial_init();
+
+	/* Configure GPIO for EHCI port */
+	omap_mux_init_gpio(57, OMAP_PIN_OUTPUT);
 	usb_ehci_init(&ehci_pdata);
 	/* DSS */
 	am3517_evm_display_init();
-- 
1.6.2.4

