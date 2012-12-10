From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 8/9] memory: emif: fix timings initialization issue
Date: Mon, 10 Dec 2012 12:39:17 +0530
Message-ID: <1355123358-5273-9-git-send-email-lokeshvutla@ti.com>
References: <1355123358-5273-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50095 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab2LJHJb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Dec 2012 02:09:31 -0500
In-Reply-To: <1355123358-5273-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, gregkh@linuxfoundation.org, b-cousson@ti.com, lokeshvutla@ti.com, Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com>

From: Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com>

The issue was that only the first timings table was added to the
emif platform data at the emif driver registration. All other
timings tables was filled with zeros. Now all emif timings table
are added to the platform data.

Signed-off-by: Oleksandr Dmytryshyn <oleksandr.dmytryshyn@ti.com>
---
 drivers/memory/emif.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 32ce601..70f6e0f 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -1462,7 +1462,7 @@ static struct emif_data *__init_or_module get_device_details(
 	if (pd->timings) {
 		temp = devm_kzalloc(dev, size, GFP_KERNEL);
 		if (temp) {
-			memcpy(temp, pd->timings, sizeof(*pd->timings));
+			memcpy(temp, pd->timings, size);
 			pd->timings = temp;
 		} else {
 			dev_warn(dev, "%s:%d: allocation error\n", __func__,
-- 
1.7.9.5

