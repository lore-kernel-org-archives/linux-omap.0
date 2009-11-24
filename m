From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH] rtc: make rtc-omap wakeup capable
Date: Tue, 24 Nov 2009 18:48:40 +0530
Message-ID: <1259068720-26113-1-git-send-email-nsekhar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42947 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932541AbZKXNSu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Nov 2009 08:18:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rtc-linux@googlegroups.com
Cc: a.zummo@towertech.it, Davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>

The rtc-omap driver currently hardcodes the RTC to be
not capable of wakeup events. On the DA850/OMAP-L138
SoC, the RTC is a wake up source from its "deep sleep"
mode.

Let platform data set the wakeup capability flag instead.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Applies to latest of Linus's tree.

 drivers/rtc/rtc-omap.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 0587d53..ac9d55b 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -400,16 +400,11 @@ static int __init omap_rtc_probe(struct platform_device *pdev)
 
 	/* BOARD-SPECIFIC CUSTOMIZATION CAN GO HERE:
 	 *
-	 *  - Boards wired so that RTC_WAKE_INT does something, and muxed
-	 *    right (W13_1610_RTC_WAKE_INT is the default after chip reset),
-	 *    should initialize the device wakeup flag appropriately.
-	 *
 	 *  - Boards wired so RTC_ON_nOFF is used as the reset signal,
 	 *    rather than nPWRON_RESET, should forcibly enable split
 	 *    power mode.  (Some chip errata report that RTC_CTRL_SPLIT
 	 *    is write-only, and always reads as zero...)
 	 */
-	device_init_wakeup(&pdev->dev, 0);
 
 	if (new_ctrl & (u8) OMAP_RTC_CTRL_SPLIT)
 		pr_info("%s: split power mode\n", pdev->name);
-- 
1.6.2.4

