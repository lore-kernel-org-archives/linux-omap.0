From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] i2c: omap: highspeed only over 1000mhz
Date: Mon, 20 Oct 2008 13:26:59 +0300
Message-ID: <20081020102659.GA31599@gandalf.research.nokia.com>
References: <1224277795-17143-1-git-send-email-felipe.balbi@nokia.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:35914 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbYJTK2A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 20 Oct 2008 06:28:00 -0400
Content-Disposition: inline
In-Reply-To: <1224277795-17143-1-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Tony Lindgren <tony@atomide.com>

up to 1000khz it's Fast Mode+, not highspeed.

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

-- 
balbi
