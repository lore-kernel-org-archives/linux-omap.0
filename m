From: Laurent Navet <laurent.navet@gmail.com>
Subject: [PATCH 10/10] gpio: gpio-tps65910.c: fix checkpatch error
Date: Wed, 20 Mar 2013 13:16:04 +0100
Message-ID: <1363781764-17330-11-git-send-email-laurent.navet@gmail.com>
References: <1363781764-17330-1-git-send-email-laurent.navet@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:61027 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab3CTMKz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Mar 2013 08:10:55 -0400
In-Reply-To: <1363781764-17330-1-git-send-email-laurent.navet@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, linus.walleij@linaro.org
Cc: santosh.shilimkar@ti.com, khilman@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Laurent Navet <laurent.navet@gmail.com>

Fix :
 gpio/gpio-tps65910.c:136: ERROR: space required before the open parenthesis '('

Signed-off-by: Laurent Navet <laurent.navet@gmail.com>
---
 drivers/gpio/gpio-tps65910.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-tps65910.c b/drivers/gpio/gpio-tps65910.c
index 5083825..0614621 100644
--- a/drivers/gpio/gpio-tps65910.c
+++ b/drivers/gpio/gpio-tps65910.c
@@ -133,7 +133,7 @@ static int tps65910_gpio_probe(struct platform_device *pdev)
 	tps65910_gpio->gpio_chip.owner = THIS_MODULE;
 	tps65910_gpio->gpio_chip.label = tps65910->i2c_client->name;
 
-	switch(tps65910_chip_id(tps65910)) {
+	switch (tps65910_chip_id(tps65910)) {
 	case TPS65910:
 		tps65910_gpio->gpio_chip.ngpio = TPS65910_NUM_GPIO;
 		break;
-- 
1.7.10.4

