From: Kyle Manna <kyle@kylemanna.com>
Subject: [PATCH v2 3/4] mfd: twl4030-madc: check for NULL pointer
Date: Thu, 11 Aug 2011 22:33:14 -0500
Message-ID: <1313119995-15382-4-git-send-email-kyle@kylemanna.com>
References: <CANOLnOPB=wFMPwqGbu9ufh__iM7TquUx3-o95R=gyJcae+gENg@mail.gmail.com>
 <1313119995-15382-1-git-send-email-kyle@kylemanna.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caiajhbdcbef.dreamhost.com ([208.97.132.145]:58504 "EHLO
	homiemail-a63.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751307Ab1HLDeB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Aug 2011 23:34:01 -0400
In-Reply-To: <1313119995-15382-1-git-send-email-kyle@kylemanna.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Samuel Ortiz <sameo@linux.intel.com>
Cc: Keerthy <j-keerthy@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kyle Manna <kyle@kylemanna.com>

If the twl4030-madc device wasn't registered, and another device, such
as twl4030-madc-hwmon, calls twl4030_madc_conversion() a NULL pointer is
dereferenced.

Signed-off-by: Kyle Manna <kyle@kylemanna.com>
---
 drivers/mfd/twl4030-madc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/twl4030-madc.c b/drivers/mfd/twl4030-madc.c
index 99dd611..834f824 100644
--- a/drivers/mfd/twl4030-madc.c
+++ b/drivers/mfd/twl4030-madc.c
@@ -510,8 +510,9 @@ int twl4030_madc_conversion(struct twl4030_madc_request *req)
 	u8 ch_msb, ch_lsb;
 	int ret;
 
-	if (!req)
+	if (!req || !twl4030_madc)
 		return -EINVAL;
+
 	mutex_lock(&twl4030_madc->lock);
 	if (req->method < TWL4030_MADC_RT || req->method > TWL4030_MADC_SW2) {
 		ret = -EINVAL;
-- 
1.7.4.1

