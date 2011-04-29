From: srinath@mistralsolutions.com
Subject: [PATCH 1/2] AM35xx-Craneboard: USB EHCI: Fix USB ECHI PHY reset
Date: Fri, 29 Apr 2011 17:11:00 +0530
Message-ID: <1304077261-17811-1-git-send-email-srinath@mistralsolutions.com>
References: <[PATCH]>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50979 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab1D2MZO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 29 Apr 2011 08:25:14 -0400
In-Reply-To: <[PATCH]>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jdk@ti.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, nm@ti.com, nagendra@mistralsolutions.com, umeshk@mistralsolutions.com, Srinath <srinath@mistralsolutions.com>

From: Srinath <srinath@mistralsolutions.com>

This patch fixes the EHCI PHY reset issue found on CraneBoard.

Signed-off-by: Srinath <srinath@mistralsolutions.com>
---
 arch/arm/mach-omap2/board-am3517crane.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index a890d24..05867b5 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -60,7 +60,7 @@ static struct usbhs_omap_board_data usbhs_bdata __initdata = {
 	.port_mode[1] = OMAP_USBHS_PORT_MODE_UNUSED,
 	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
 
-	.phy_reset  = true,
+	.phy_reset  = false,
 	.reset_gpio_port[0]  = GPIO_USB_NRESET,
 	.reset_gpio_port[1]  = -EINVAL,
 	.reset_gpio_port[2]  = -EINVAL
-- 
1.7.1.226.g770c5

