From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 3/9] ehci: correct EHCI init parameters on OMAP3EVM
Date: Thu,  6 Aug 2009 17:37:34 +0530
Message-ID: <1249560460-16306-3-git-send-email-ajay.gupta@ti.com>
References: <1249560460-16306-1-git-send-email-ajay.gupta@ti.com>
 <1249560460-16306-2-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46478 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755260AbZHFMJH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Aug 2009 08:09:07 -0400
In-Reply-To: <1249560460-16306-2-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, david-b@pacbell.net, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Multimedia Daughter card on OMAP3EVM uses port2 as EHCI port.
Other ports (port1 and port3)are not used.

GPIO135 has been used as EHCI phy reset pin so the mux config
is also setup.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 595beac..b497979 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -308,7 +308,9 @@ static void __init omap3_evm_init(void)
 
 	omap_serial_init();
 	usb_musb_init();
-	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
+	/* Setup EHCI phy reset padconfig */
+	omap_cfg_reg(AF4_34XX_GPIO135_OUT);
+	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, false, true, -EINVAL, 135);
 	ads7846_dev_init();
 }
 
-- 
1.6.2.4

