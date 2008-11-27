From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 1/3] OMAP3: PM: Add wake-up bit defintiions for CONTROL_PADCONF_X
Date: Wed, 26 Nov 2008 16:29:58 -0800
Message-ID: <1227745800-5894-2-git-send-email-khilman@deeprootsystems.com>
References: <1227745800-5894-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:54056 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752572AbYK0AaH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Nov 2008 19:30:07 -0500
Received: by qw-out-2122.google.com with SMTP id 3so200752qwe.37
        for <linux-omap@vger.kernel.org>; Wed, 26 Nov 2008 16:30:06 -0800 (PST)
In-Reply-To: <1227745800-5894-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/include/mach/control.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index b51f7fd..745bc4c 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -213,6 +213,10 @@
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
1.6.0.3

