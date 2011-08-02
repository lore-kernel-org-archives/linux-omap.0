From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] ARM: platform_device: pdev_archdata: add omap_device pointer
Date: Mon,  1 Aug 2011 18:14:52 -0700
Message-ID: <1312247692-13727-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:40716 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752907Ab1HBBOY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Aug 2011 21:14:24 -0400
Received: by mail-pz0-f48.google.com with SMTP id 32so13817254pzk.35
        for <linux-omap@vger.kernel.org>; Mon, 01 Aug 2011 18:14:23 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>

Add omap_device pointer to the ARM-specific arch data in the
platform_device.  This will be used to attach OMAP-specific
device-data to the platform device with device lifetime.

Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Applies to v3.0

 arch/arm/include/asm/device.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index 9f390ce..b5c9f5b 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -12,7 +12,12 @@ struct dev_archdata {
 #endif
 };
 
+struct omap_device;
+
 struct pdev_archdata {
+#ifdef CONFIG_ARCH_OMAP
+	struct omap_device *od;
+#endif
 };
 
 #endif
-- 
1.7.6

