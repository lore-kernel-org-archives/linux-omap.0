From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH RESEND] OMAP: beagle: Set USB Host Port 1 to OMAP_USBHS_PORT_MODE_UNUSED
Date: Tue, 19 Jun 2012 09:22:49 -0500
Message-ID: <1340115769-16902-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from db3ehsobe005.messaging.microsoft.com ([213.199.154.143]:45770
	"EHLO db3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751452Ab2FSOZb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jun 2012 10:25:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, balbi@ti.com, Brian Austin <brian.austin@cirrus.com>

The beagleboard USB Host Port that is used is Port 2. The platform driver sets MODE_PHY for port 1 causing pin muxing to override the pins on the expansion
connector P17 when using board_mux[]. Since USBHS Port 1 is not connected remove the case for muxing the USB Port1 pins by default.

Patch is based off of 3.5-rc2 from ASoC for-next branch

Tested with BeagleBoard xM revC and checked the userguides for Beagle xM and revC to be sure USB Port2 is what is used.

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 79c6909..75eb88a 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -435,7 +435,7 @@ static struct platform_device *omap3_beagle_devices[] __initdata = {
 
 static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
 
-	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
+	.port_mode[0] = OMAP_USBHS_PORT_MODE_UNUSED,
 	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
 	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
 
-- 
1.7.10.4


