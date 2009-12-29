From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 2/2] arm: omap: gpmc: avoid section definitions on headers
Date: Tue, 29 Dec 2009 03:05:08 +0200
Message-ID: <1262048708-25033-2-git-send-email-felipe.balbi@nokia.com>
References: <1262048708-25033-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:51612 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752252AbZL2BFV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Dec 2009 20:05:21 -0500
In-Reply-To: <1262048708-25033-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, Felipe Balbi <felipe.balbi@nokia.com>

trivial patch, no functional changes.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/plat-omap/include/plat/gpmc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/gpmc.h b/arch/arm/plat-omap/include/plat/gpmc.h
index e081338..3f3609a 100644
--- a/arch/arm/plat-omap/include/plat/gpmc.h
+++ b/arch/arm/plat-omap/include/plat/gpmc.h
@@ -110,6 +110,6 @@ extern void gpmc_prefetch_reset(void);
 extern int gpmc_prefetch_status(void);
 extern void omap3_gpmc_save_context(void);
 extern void omap3_gpmc_restore_context(void);
-extern void __init gpmc_init(void);
+extern void gpmc_init(void);
 
 #endif
-- 
1.6.6.35.g1d85d

