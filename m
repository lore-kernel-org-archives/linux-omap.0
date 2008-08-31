From: Felipe Balbi <me@felipebalbi.com>
Subject: [PATCH 2/2] input: touchscreen: Fix typo on Kconfig
Date: Mon,  1 Sep 2008 00:56:57 +0300
Message-ID: <1220219817-22651-2-git-send-email-me@felipebalbi.com>
References: <1220219817-22651-1-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:43738 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235AbYHaV5Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 Aug 2008 17:57:25 -0400
In-Reply-To: <1220219817-22651-1-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/input/touchscreen/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index f32361f..98e37fc 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -220,7 +220,7 @@ config TOUCHSCREEN_ATMEL_TSADCC
 config TOUCHSCREEN_TSC2005
 	tristate "TSC2005 touchscreen support"
 	help
-	  Say Y here for if you are using the touchscreen features of TSC2301.
+	  Say Y here for if you are using the touchscreen features of TSC2005.
 
 config TOUCHSCREEN_TSC2102
 	tristate "TSC 2102 based touchscreens"
-- 
1.6.0.1.157.g7df43

