From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] mfd: twl6040: Remove wrong and unneeded "platform:twl6040"
 modalias
Date: Mon, 30 Mar 2015 16:12:55 +0800
Message-ID: <1427703175.30616.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:33730 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbbC3IM7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Mar 2015 04:12:59 -0400
Received: by pdnc3 with SMTP id c3so168454195pdn.0
        for <linux-omap@vger.kernel.org>; Mon, 30 Mar 2015 01:12:59 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is a I2C driver, so it's wrong to use platform prefix for the
modalias. We have all needed i2c aliases coming form MODULE_DEVICE_TABLE,
so let's remove the wrong and unneeded "platform:twl6040" modalias.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mfd/twl6040.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/twl6040.c b/drivers/mfd/twl6040.c
index f71ee3d..c5265c1 100644
--- a/drivers/mfd/twl6040.c
+++ b/drivers/mfd/twl6040.c
@@ -814,4 +814,3 @@ MODULE_DESCRIPTION("TWL6040 MFD");
 MODULE_AUTHOR("Misael Lopez Cruz <misael.lopez@ti.com>");
 MODULE_AUTHOR("Jorge Eduardo Candelaria <jorge.candelaria@ti.com>");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:twl6040");
-- 
1.9.1



