From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 1/2] OMAP: features: export symbol omap3_features
Date: Thu, 23 Sep 2010 22:41:04 -0500
Message-ID: <1285299665-21639-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34175 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753491Ab0IXDuh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Sep 2010 23:50:37 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Nishanth Menon <nm@ti.com>, Paul Walmsley <paul@pwsan.com>, Sanjeev Premi <premi@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

From: Kevin Hilman <khilman@deeprootsystems.com>

Since omap3_features is a global variable, only code
built-in the kernel can make use of it and thus use
omap_has ##feat functions; exporting this as a kernel
symbol makes modules able to use feature detection
framework too.

Thread: http://marc.info/?l=linux-omap&m=128528822902211&w=2

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
CC: Tony Lindgren <tony@atomide.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: Nishanth Menon <nm@ti.com>
CC: Paul Walmsley <paul@pwsan.com>
CC: Sanjeev Premi <premi@ti.com>
CC: linux-omap@vger.kernel.org
CC: linux-arm-kernel@lists.infradead.org
---
 arch/arm/mach-omap2/id.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 9a879f9..a8c6d19 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -31,6 +31,7 @@ static struct omap_chip_id omap_chip;
 static unsigned int omap_revision;
 
 u32 omap3_features;
+EXPORT_SYMBOL(omap3_features);
 
 unsigned int omap_rev(void)
 {
-- 
1.7.1

