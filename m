From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH RFC 1/2] watchdog : omap_wdt : Implement WDIOC_GETBOOTSTATUS for omap3+
Date: Mon, 23 Jan 2012 16:43:07 +0530
Message-ID: <1327317188-14782-2-git-send-email-shubhrajyoti@ti.com>
References: <1327317188-14782-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60344 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752499Ab2AWLNU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jan 2012 06:13:20 -0500
In-Reply-To: <1327317188-14782-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-watchdog@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>

This patch intends to implement the WDIOC_GETBOOTSTATUS ioctl
for the omap3 and omap4.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/watchdog/omap_wdt.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/watchdog/omap_wdt.c b/drivers/watchdog/omap_wdt.c
index 4b33e3f..5395a4c 100644
--- a/drivers/watchdog/omap_wdt.c
+++ b/drivers/watchdog/omap_wdt.c
@@ -229,7 +229,7 @@ static long omap_wdt_ioctl(struct file *file, unsigned int cmd,
 		if (cpu_is_omap16xx())
 			return put_user(__raw_readw(ARM_SYSST),
 					(int __user *)arg);
-		if (cpu_is_omap24xx())
+		if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx())
 			return put_user(omap_prcm_get_reset_sources(),
 					(int __user *)arg);
 		return put_user(0, (int __user *)arg);
-- 
1.7.1

