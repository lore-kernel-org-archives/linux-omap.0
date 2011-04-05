From: Alexander Holler <holler@ahsoftware.de>
Subject: [PATCH] arm: omap3: beagle: Ensure msecure is mux'd to be able to set the RTC
Date: Tue,  5 Apr 2011 15:40:08 +0200
Message-ID: <1302010808-3065-1-git-send-email-holler@ahsoftware.de>
References: <4D9AEB76.2060509@ahsoftware.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:49395 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310Ab1DENla (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Apr 2011 09:41:30 -0400
In-Reply-To: <4D9AEB76.2060509@ahsoftware.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org, Alexander Holler <holler@ahsoftware.de>

Without msecure beeing high it isn't possible to set (or start)
the RTC.

Tested with a BeagleBoard C4.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 46d814a..ebe3a7e 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -628,6 +628,9 @@ static void __init omap3_beagle_init(void)
 	usb_ehci_init(&ehci_pdata);
 	omap3beagle_flash_init();
 
+	/* Ensure msecure is mux'd to be able to set the RTC. */
+	omap_mux_init_signal("sys_drm_msecure", OMAP_PIN_OFF_OUTPUT_HIGH);
+
 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
 	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
-- 
1.7.3.4

