From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] OMAP: I2C: Fix omap_register_i2c_bus() return value on success
Date: Wed,  2 Nov 2011 12:54:03 +0100
Message-ID: <1320234843-29115-1-git-send-email-laurent.pinchart@ideasonboard.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:60439 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753808Ab1KBLyG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Nov 2011 07:54:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com

Commit 4d17aeb1c5b2375769446d13012a98e6d265ec13 ("OMAP: I2C: split
device registration and convert OMAP2+ to omap_device") makes
omap2_i2c_add_bus() return a pointer to an omap_device instead on
success instead of 0.

This breaks the omap_register_i2c_bus() ABI and results in the igep0020
board code detecting an I2C bus registration error when there is none.

Fix the problem by using PTR_RET() instead of PTR_ERR() in
omap2_i2c_add_bus().

Reported-by: Alexander Kinzer <a.kinzer@plusoptix.de>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/plat-omap/i2c.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index 3341ca4..443c319 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -165,7 +165,7 @@ static inline int omap2_i2c_add_bus(int bus_id)
 			omap_i2c_latency, ARRAY_SIZE(omap_i2c_latency), 0);
 	WARN(IS_ERR(od), "Could not build omap_device for %s\n", name);
 
-	return PTR_ERR(od);
+	return PTR_RET(od);
 }
 #else
 static inline int omap2_i2c_add_bus(int bus_id)
-- 
Regards,

Laurent Pinchart

