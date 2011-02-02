From: Sourav Poddar <sourav.poddar@ti.com>
Subject: [PATCH 2/2] Input: ads7846 - configure pendown gpio as input
Date: Wed,  2 Feb 2011 21:00:46 +0530
Message-ID: <1296660646-28168-1-git-send-email-sourav.poddar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42072 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754026Ab1BBPaw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Feb 2011 10:30:52 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>

The ads7846 driver requests a gpio to detect pendown events,
but does not configure its direction. Configure this gpio
as an input after requesting it.

Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
---
 drivers/input/touchscreen/ads7846.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 036f245..c001ce5 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -962,6 +962,7 @@ static int __devinit ads7846_setup_pendown(struct spi_device *spi, struct ads784
 		return err;
 	}
 
+	gpio_direction_input(pdata->gpio_pendown);
 	ts->gpio_pendown = pdata->gpio_pendown;
 
 	return 0;
-- 
1.7.0.4

