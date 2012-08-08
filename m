From: Matthias Kaehlcke <matthias@kaehlcke.net>
Subject: [PATCH] mfd: Fix allocation size of tps65217 platform data
Date: Wed, 8 Aug 2012 23:00:51 +0200
Message-ID: <20120808210051.GD30282@darwin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:51816 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759277Ab2HHVBn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 17:01:43 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

tps65217_parse_dt() allocates a struct tps65217_board for each regulator
specified in the device tree. the structure itself provides arrays for
the pointers to the regulator init data and the regulator device tree node,
so only one instance of it is needed

This patch is based on the mfd tree

Signed-off-by: Matthias Kaehlcke <matthias@kaehlcke.net>
---
 drivers/mfd/tps65217.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/tps65217.c b/drivers/mfd/tps65217.c
index 61c097a..cf908ac 100644
--- a/drivers/mfd/tps65217.c
+++ b/drivers/mfd/tps65217.c
@@ -162,7 +162,7 @@ static struct tps65217_board *tps65217_parse_dt(struct i2c_client *client)
 		return NULL;
 
 	count = ret;
-	pdata = devm_kzalloc(&client->dev, count * sizeof(*pdata), GFP_KERNEL);
+	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return NULL;
 
-- 
1.7.10

