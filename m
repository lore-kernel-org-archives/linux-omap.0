From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 05/25] OMAP4: Use WARN_ON() instead of BUG_ON() with graceful exit
Date: Sun, 4 Sep 2011 19:24:06 +0530
Message-ID: <1315144466-9395-6-git-send-email-santosh.shilimkar@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38010 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754463Ab1IDNzl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 4 Sep 2011 09:55:41 -0400
In-Reply-To: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, khilman@ti.com, rnayak@ti.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

OMAP4 L2X0 initialisation code uses BUG_ON() for the ioremap()
failure scenarios.

Use WARN_ON() instead and allow graceful function exits.

This was suggsted by Kevin Hilman <khilman@ti.com> during
OMAP4 PM code review.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap4-common.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 4791370..4904025 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -121,7 +121,8 @@ static int __init omap_l2_cache_init(void)
 
 	/* Static mapping, never released */
 	l2cache_base = ioremap(OMAP44XX_L2CACHE_BASE, SZ_4K);
-	BUG_ON(!l2cache_base);
+	if (WARN_ON(!l2cache_base))
+		return -ENODEV;
 
 	/*
 	 * 16-way associativity, parity disabled
-- 
1.7.4.1

