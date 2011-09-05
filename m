From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP2430: hwmod: musb: add missing terminator to
 omap2430_usbhsotg_addrs[]
Date: Sun, 4 Sep 2011 20:18:51 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1109042017350.9056@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:59350 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab1IECSw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 4 Sep 2011 22:18:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Add a missing array terminator to omap2430_usbhsotg_addrs[].  Without
this terminator, the omap_hwmod resource building code runs off the
end of the array, resulting in at least this error -- if not worse
behavior:

[    0.578002] musb-omap2430: failed to claim resource 4
[    0.583465] omap_device: musb-omap2430: build failed (-16)
[    0.589294] Could not build omap_device for musb-omap2430 usb_otg_hs

This should have been part of commit
78183f3fdf76f422431a81852468be01b36db325 ("omap_hwmod: use a null
structure record to terminate omap_hwmod_addr_space arrays") but was
evidently missed.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
index 16743c7..408193d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -192,6 +192,7 @@ static struct omap_hwmod_addr_space omap2430_usbhsotg_addrs[] = {
 		.pa_end		= OMAP243X_HS_BASE + SZ_4K - 1,
 		.flags		= ADDR_TYPE_RT
 	},
+	{ }
 };
 
 /*  l4_core ->usbhsotg  interface */
-- 
1.7.5.4

