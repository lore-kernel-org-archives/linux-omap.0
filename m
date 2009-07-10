From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 3/8] ehci: correct EHCI init parameters on OMAP3EVM
Date: Fri, 10 Jul 2009 14:47:09 +0530
Message-ID: <1247217434-6309-3-git-send-email-ajay.gupta@ti.com>
References: <1247217434-6309-1-git-send-email-ajay.gupta@ti.com>
 <1247217434-6309-2-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47204 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbZGJJRb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Jul 2009 05:17:31 -0400
In-Reply-To: <1247217434-6309-2-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Multimedia Daughter card on OMAP3EVM uses port2 as EHCI port.
Other ports (port1 and port3)are not used.

GPIO135 has been used as EHCI phy reset pin so the mux config
is also setup.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
Resubmitting with padconfig part in platform files.

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

