From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH] arm: omap: fix build for 2430sdp
Date: Sat, 30 Aug 2008 19:11:48 +0300
Message-ID: <1220112708-26556-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:40124 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238AbYH3QMD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 30 Aug 2008 12:12:03 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Missing include file broke compilation for 2430sdp.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 64e76e8..94e202d 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -20,6 +20,7 @@
 #include <linux/mtd/partitions.h>
 #include <linux/delay.h>
 #include <linux/input.h>
+#include <linux/i2c/twl4030.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
-- 
1.6.0.1.141.g445ca

