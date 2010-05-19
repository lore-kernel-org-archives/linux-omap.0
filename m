From: felipe.balbi@nokia.com
Subject: [PATCH 3/3] arm: omap: musb: do not issue SOFTRESET on omap3630
Date: Wed, 19 May 2010 12:40:18 +0300
Message-ID: <1274262018-32631-3-git-send-email-felipe.balbi@nokia.com>
References: <1274262018-32631-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:30537 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752671Ab0ESJmc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 05:42:32 -0400
In-Reply-To: <1274262018-32631-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Errata ID i445 says we SOFTRESET doesn't work properly
on omap3630, so let's avoid issuing that here.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/usb-musb.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index de3e768..97dae0d 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -54,6 +54,10 @@ void __init usb_musb_pm_init(void)
 	if (!cpu_is_omap34xx())
 		return;
 
+	/* Errata ID i445 fix : Do not use SOFTRESET with OMAP3630 */
+	if (cpu_is_omap3630())
+		return;
+
 	otg_base = ioremap(OMAP34XX_HSUSB_OTG_BASE, SZ_4K);
 	if (WARN_ON(!otg_base))
 		return;
-- 
1.7.1

