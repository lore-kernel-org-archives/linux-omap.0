From: Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: [PATCH 3/3] i2c: OMAP fix driver initialization message
Date: Wed, 19 Sep 2012 19:07:21 +0300
Message-ID: <1348070841-23354-4-git-send-email-panto@antoniou-consulting.com>
References: <1348070841-23354-1-git-send-email-panto@antoniou-consulting.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from li42-95.members.linode.com ([209.123.162.95]:56259 "EHLO
	li42-95.members.linode.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753276Ab2IRSMK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Sep 2012 14:12:10 -0400
In-Reply-To: <1348070841-23354-1-git-send-email-panto@antoniou-consulting.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Porter <mporter@ti.com>, Koen Kooi <koen@dominion.thruhere.net>, Shubhrajyoti D <shubhrajyoti@ti.com>, Tony Lindgren <tony@atomide.com>, Pantelis Antoniou <panto@antoniou-consulting.com>

The message spit out when the i2c-omap driver load is printing
the platform device's id as a bus number. However when booting
from OF id is -1, which is not so nice.

Fix it by printing the adapter number.

[    0.210467] omap_i2c 44e0b000.i2c: bus -1 rev2.4.0 at 400 kHz
	vs
[    0.210467] omap_i2c 44e0b000.i2c: bus 0 rev2.4.0 at 400 kHz

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
---
 drivers/i2c/busses/i2c-omap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index f722478..87bb705 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1178,9 +1178,6 @@ omap_i2c_probe(struct platform_device *pdev)
 		goto err_unuse_clocks;
 	}
 
-	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", pdev->id,
-		 dev->dtrev, dev->rev >> 4, dev->rev & 0xf, dev->speed);
-
 	adap = &dev->adapter;
 	i2c_set_adapdata(adap, dev);
 	adap->owner = THIS_MODULE;
@@ -1204,6 +1201,9 @@ omap_i2c_probe(struct platform_device *pdev)
 	if (IS_ERR(pinctrl))
 		dev_warn(dev->dev, "pins are not configured from the driver\n");
 
+	dev_info(dev->dev, "bus %d rev%d.%d.%d at %d kHz\n", adap->nr,
+		 dev->dtrev, dev->rev >> 4, dev->rev & 0xf, dev->speed);
+
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
 
-- 
1.7.12

