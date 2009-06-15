From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP3: drop SmartReflex base addresses mistakenly added by EHCI patch
Date: Mon, 15 Jun 2009 10:12:12 -0700
Message-ID: <1245085932-9996-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:44145 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758617AbZFORMN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Jun 2009 13:12:13 -0400
Received: by pxi27 with SMTP id 27so351355pxi.33
        for <linux-omap@vger.kernel.org>; Mon, 15 Jun 2009 10:12:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Kevin Hilman <khilman@ti.deeprootsystems.com>

Drop them for now.  They will be re-added with the SmartReflex
patches coming from the PM branch, and will use the
L4_34XX_BASE + <offset> approach.

Signed-off-by: Kevin Hilman <khilman@ti.deeprootsystems.com>
---
 arch/arm/plat-omap/include/mach/omap34xx.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/omap34xx.h b/arch/arm/plat-omap/include/mach/omap34xx.h
index 4655707..6a58f3d 100644
--- a/arch/arm/plat-omap/include/mach/omap34xx.h
+++ b/arch/arm/plat-omap/include/mach/omap34xx.h
@@ -78,8 +78,6 @@
 #define OMAP34XX_UHH_CONFIG_BASE	(L4_34XX_BASE + 0x64000)
 #define OMAP34XX_OHCI_BASE	(L4_34XX_BASE + 0x64400)
 #define OMAP34XX_EHCI_BASE	(L4_34XX_BASE + 0x64800)
-#define OMAP34XX_SR1_BASE	0x480C9000
-#define OMAP34XX_SR2_BASE	0x480CB000
 
 #define OMAP34XX_MAILBOX_BASE		(L4_34XX_BASE + 0x94000)
 
-- 
1.6.2.2

