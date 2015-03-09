From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH] mfd: menelaus: rmove incorrect __exit markups
Date: Mon, 9 Mar 2015 10:49:36 -0700
Message-ID: <20150309174936.GA22662@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:46587 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753931AbbCIRtl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Mar 2015 13:49:41 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

Even if bus is not hot-pluggable, the devices can be unbound from the
driver via sysfs, so we should not be using __exit annotations on
remove() methods. The only exception is drivers registered with
platform_driver_probe() which specifically disables sysfs bind/unbind
attributes.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/mfd/menelaus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index 9f01aef..5269ff2 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -1259,7 +1259,7 @@ fail:
 	return err;
 }
 
-static int __exit menelaus_remove(struct i2c_client *client)
+static int menelaus_remove(struct i2c_client *client)
 {
 	struct menelaus_chip	*menelaus = i2c_get_clientdata(client);
 
@@ -1280,7 +1280,7 @@ static struct i2c_driver menelaus_i2c_driver = {
 		.name		= DRIVER_NAME,
 	},
 	.probe		= menelaus_probe,
-	.remove		= __exit_p(menelaus_remove),
+	.remove		= menelaus_remove,
 	.id_table	= menelaus_id,
 };
 
-- 
2.2.0.rc0.207.ga3a616c


-- 
Dmitry
