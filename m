From: Hema HK <hemahk@ti.com>
Subject: [PATCH 4/5 v2] usb: musb: OMAP4430: Power down the PHY during board init
Date: Fri, 25 Feb 2011 18:54:05 +0530
Message-ID: <1298640246-21181-5-git-send-email-hemahk@ti.com>
References: <1298640246-21181-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52094 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932182Ab1BYNYf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 08:24:35 -0500
In-Reply-To: <1298640246-21181-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

Powerdown the internal PHY during board init for OMAP44xx.
So that when musb is disabled core transition to retention/off
is not blocked.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/usb-musb.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index a9d4d14..516711d 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -161,6 +161,10 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
 	dev->dma_mask = &musb_dmamask;
 	dev->coherent_dma_mask = musb_dmamask;
 	put_device(dev);
+
+	if (cpu_is_omap44xx())
+		omap4430_phy_init(dev);
+
 }
 
 #else
-- 
1.7.0.4

