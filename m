From: Kevin Hilman <khilman@ti.com>
Subject: [RFC/PATCH 5/7] ARM: OMAP: clock: remove unused CK_3505 flag
Date: Wed,  4 Jan 2012 17:16:44 -0800
Message-ID: <1325726206-11199-6-git-send-email-khilman@ti.com>
References: <1325726206-11199-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:48128 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757459Ab2AEBRC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Jan 2012 20:17:02 -0500
Received: by yenl2 with SMTP id l2so7938yen.8
        for <linux-omap@vger.kernel.org>; Wed, 04 Jan 2012 17:17:01 -0800 (PST)
In-Reply-To: <1325726206-11199-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Vaibhav Hiremath <hvaibhav@ti.com>

This flag is no longer used since clock init all AM35x devices
is now the same.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/clkdev_omap.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-omap/include/plat/clkdev_omap.h
index b299b8d..45afa4d 100644
--- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -34,7 +34,6 @@ struct omap_clk {
 #define CK_243X		(1 << 5)	/* 243x, 253x */
 #define CK_3430ES1	(1 << 6)	/* 34xxES1 only */
 #define CK_3430ES2PLUS	(1 << 7)	/* 34xxES2, ES3, non-Sitara 35xx only */
-#define CK_3505		(1 << 8)
 #define CK_3517		(1 << 9)
 #define CK_36XX		(1 << 10)	/* 36xx/37xx-specific clocks */
 #define CK_443X		(1 << 11)
@@ -44,7 +43,7 @@ struct omap_clk {
 
 
 #define CK_34XX		(CK_3430ES1 | CK_3430ES2PLUS)
-#define CK_AM35XX	(CK_3505 | CK_3517)	/* all Sitara AM35xx */
+#define CK_AM35XX	CK_3517		/* all Sitara AM35xx */
 #define CK_3XXX		(CK_34XX | CK_AM35XX | CK_36XX)
 
 
-- 
1.7.8.2

