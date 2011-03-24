From: Hema HK <hemahk@ti.com>
Subject: [PATCH 2/2 v2] usb: otg: OMAP4430: Powerdown the internal PHY when USB is disabled
Date: Thu, 24 Mar 2011 17:09:03 +0530
Message-ID: <1300966743-10993-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39895 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754938Ab1CXLjJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Mar 2011 07:39:09 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>

Powerdown the internal UTMI PHY when USB is not enabled. This will
allow the OMAP core domain to transition to retention and offmode.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/usb-musb.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 35559f7..500d9db 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -169,5 +169,7 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
 #else
 void __init usb_musb_init(struct omap_musb_board_data *board_data)
 {
+	if (cpu_is_omap44xx())
+		omap4430_phy_init(NULL);
 }
 #endif /* CONFIG_USB_MUSB_SOC */
-- 
1.7.0.4

