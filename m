From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH] i2c: busses: remove superfluous comment
Date: Fri, 17 May 2013 11:53:23 +0200
Message-ID: <1368784416-15306-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34657 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753529Ab3EQJwQ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 17 May 2013 05:52:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, davinci-linux-open-source@linux.davincidsp.com, linux-omap@vger.kernel.org

The comment already got copy&pasted around and is not really useful.
Remove it.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/i2c/busses/i2c-davinci.c            |    1 -
 drivers/i2c/busses/i2c-designware-platdrv.c |    1 -
 drivers/i2c/busses/i2c-omap.c               |    1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index cf20e06..2daa253 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -646,7 +646,6 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	struct resource *mem, *irq;
 	int r;
 
-	/* NOTE: driver uses the static register mapping */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
 		dev_err(&pdev->dev, "no mem resource?\n");
diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 35b70a1..da53d64 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -87,7 +87,6 @@ static int dw_i2c_probe(struct platform_device *pdev)
 	struct resource *mem;
 	int irq, r;
 
-	/* NOTE: driver uses the static register mapping */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
 		dev_err(&pdev->dev, "no mem resource?\n");
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index e02f9e3..b241ae6 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1084,7 +1084,6 @@ omap_i2c_probe(struct platform_device *pdev)
 	u32 rev;
 	u16 minor, major, scheme;
 
-	/* NOTE: driver uses the static register mapping */
 	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!mem) {
 		dev_err(&pdev->dev, "no mem resource?\n");
-- 
1.7.10.4

