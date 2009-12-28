From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 5/8] arm: omap: musb: ioremap only what's ours
Date: Mon, 28 Dec 2009 13:09:47 +0200
Message-ID: <1261998590-6639-6-git-send-email-felipe.balbi@nokia.com>
References: <1261998590-6639-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:61535 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751088AbZL1LLo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Dec 2009 06:11:44 -0500
In-Reply-To: <1261998590-6639-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

omap3430 TRM says the OTG address space is 4k, not 8k.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/usb-musb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 12b0d24..d12e311 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -92,7 +92,7 @@ void __init usb_musb_init(void)
 		musb_resources[0].start = OMAP243X_HS_BASE;
 	else
 		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
-	musb_resources[0].end = musb_resources[0].start + SZ_8K - 1;
+	musb_resources[0].end = musb_resources[0].start + SZ_4K - 1;
 
 	/*
 	 * REVISIT: This line can be removed once all the platforms using
-- 
1.6.6.rc0

