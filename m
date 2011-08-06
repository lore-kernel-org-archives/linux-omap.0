From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 8/9] ARM: platform_device: pdev_archdata: add omap_device pointer
Date: Fri,  5 Aug 2011 17:19:24 -0700
Message-ID: <1312589965-19416-9-git-send-email-khilman@ti.com>
References: <1312589965-19416-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:58594 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932339Ab1HFATl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 20:19:41 -0400
Received: by mail-iy0-f172.google.com with SMTP id 7so3758762iye.3
        for <linux-omap@vger.kernel.org>; Fri, 05 Aug 2011 17:19:40 -0700 (PDT)
In-Reply-To: <1312589965-19416-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>
Cc: linux-arm-kernel@lists.infradead.org

Add omap_device pointer to the ARM-specific arch data in the
platform_device.  This will be used to attach OMAP-specific
device-data to the platform device with device lifetime.

Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Grant Likely <grant.likely@secretlab.ca>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
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

