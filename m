From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] i2c: omap: highspeed only over 1000mhz
Date: Sat, 18 Oct 2008 00:09:55 +0300
Message-ID: <1224277795-17143-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:46172 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769AbYJQVKk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Oct 2008 17:10:40 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Ben Dooks <ben-linux@fluff.org>, Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

up to 1000mhz it's Fast Mode+, not highspeed.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index a999606..53d6244 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -296,7 +296,7 @@ static int omap_i2c_init(struct omap_i2c_dev *dev)
 		psc = psc - 1;
 
 		/* If configured for High Speed */
-		if (dev->speed > 400) {
+		if (dev->speed > 1000) {
 			/* For first phase of HS mode */
 			fsscll = internal_clk / (400 * 2) - 6;
 			fssclh = internal_clk / (400 * 2) - 6;
-- 
1.6.0.2.307.gc427

