From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 06/13] OMAP3: PM: Fix secure save size for OMAP3
Date: Thu, 18 Nov 2010 19:54:51 -0600
Message-ID: <1290131698-6194-7-git-send-email-nm@ti.com>
References: <1290131698-6194-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:55452 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757095Ab0KSBzC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Nov 2010 20:55:02 -0500
In-Reply-To: <1290131698-6194-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin <khilman@deeprootsystems.com>, Jean Pihet <jean.pihet@newoldbits.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Tony <tony@atomide.com>

Use TI recommended save_secure_ram size for OMAP3 using TI official
OMAP3 PPA. Note: custom platforms may have different save sizes.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/pm34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index b20ecf5..bbb1a40 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -56,7 +56,7 @@
 
 /* Secure ram save size - store the defaults */
 static struct omap3_secure_copy_data secure_copy_data = {
-	.size = 0x803F,
+	.size = 0xF040,			/* 60k + 64 byte header */
 	.save_every_cycle = false,	/* explicit for readability */
 };
 
-- 
1.6.3.3

