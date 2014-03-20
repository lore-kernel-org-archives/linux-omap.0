From: Pekon Gupta <pekon@ti.com>
Subject: [PATCH v8 4/4] mtd: devices: elm: update DRIVER_NAME as "omap-elm"
Date: Thu, 20 Mar 2014 18:43:08 +0530
Message-ID: <1395321188-4123-5-git-send-email-pekon@ti.com>
References: <1395321188-4123-1-git-send-email-pekon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56712 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757532AbaCTNNi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 20 Mar 2014 09:13:38 -0400
In-Reply-To: <1395321188-4123-1-git-send-email-pekon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Stefan Roese <sr@denx.de>, Pekon Gupta <pekon@ti.com>

use "omap-elm" as DRIVER_NAME

Signed-off-by: Pekon Gupta <pekon@ti.com>
---
 drivers/mtd/devices/elm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/elm.c b/drivers/mtd/devices/elm.c
index 26df41f..1fd4a0f 100644
--- a/drivers/mtd/devices/elm.c
+++ b/drivers/mtd/devices/elm.c
@@ -15,6 +15,8 @@
  *
  */
 
+#define DRIVER_NAME	"omap-elm"
+
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
@@ -520,7 +522,7 @@ MODULE_DEVICE_TABLE(of, elm_of_match);
 
 static struct platform_driver elm_driver = {
 	.driver	= {
-		.name	= "elm",
+		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(elm_of_match),
 		.pm	= &elm_pm_ops,
-- 
1.8.5.1.163.gd7aced9

