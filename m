From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/6] AM35x: Add missing GPIO mux config for EHCI port
Date: Thu, 25 Feb 2010 15:03:11 -0800
Message-ID: <20100225230311.26233.97139.stgit@baageli.muru.com>
References: <20100225230116.26233.65157.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65102 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934451Ab0BYXCI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Feb 2010 18:02:08 -0500
In-Reply-To: <20100225230116.26233.65157.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Ajay Kumar Gupta <ajay.gupta@ti.com>, linux-omap@vger.kernel.org

From: Ajay Kumar Gupta <ajay.gupta@ti.com>

Adding GPIO mux config used for PHY reset of EHCI port on base board.
We get below failure message without this patch,

"hub 1-0:1.0: unable to enumerate USB device on port 1"

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-am3517evm.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index e6b8967..aee0a02 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -301,6 +301,9 @@ static void __init am3517_evm_init(void)
 				ARRAY_SIZE(am3517_evm_devices));
 
 	omap_serial_init();
+
+	/* Configure GPIO for EHCI port */
+	omap_mux_init_gpio(57, OMAP_PIN_OUTPUT);
 	usb_ehci_init(&ehci_pdata);
 	/* DSS */
 	am3517_evm_display_init();

