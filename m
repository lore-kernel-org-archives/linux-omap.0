From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 05/13] OMAP3: PM: Add wake-up bit defintiions for CONTROL_PADCONF_X
Date: Wed, 20 May 2009 16:19:28 -0700
Message-ID: <1242861576-13008-6-git-send-email-khilman@deeprootsystems.com>
References: <1242861576-13008-1-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-2-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-3-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-4-git-send-email-khilman@deeprootsystems.com>
 <1242861576-13008-5-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:58343 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757169AbZETXTv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 May 2009 19:19:51 -0400
Received: by mail-pz0-f177.google.com with SMTP id 7so340423pzk.33
        for <linux-omap@vger.kernel.org>; Wed, 20 May 2009 16:19:53 -0700 (PDT)
In-Reply-To: <1242861576-13008-5-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/include/mach/control.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index d38697b..a9f05e5 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -194,6 +194,10 @@
 #define OMAP3_IVA2_BOOTMOD_MASK		(0xf << 0)
 #define OMAP3_IVA2_BOOTMOD_IDLE		(0x1 << 0)
 
+/* CONTROL_PADCONF_X bits */
+#define OMAP3_PADCONF_WAKEUPEVENT0	(1 << 15)
+#define OMAP3_PADCONF_WAKEUPENABLE0	(1 << 14)
+
 #ifndef __ASSEMBLY__
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 extern void __iomem *omap_ctrl_base_get(void);
-- 
1.6.2.2

