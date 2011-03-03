From: Andy Green <andy@warmcat.com>
Subject: [PATCH 4/4] OMAP3 and 4 I2C use cpu type consistently for new
 register availability
Date: Thu, 03 Mar 2011 13:50:44 +0000
Message-ID: <20110303135044.30648.27273.stgit@otae.warmcat.com>
References: <20110303134744.30648.91218.stgit@otae.warmcat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:51839 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758226Ab1CCNur (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Mar 2011 08:50:47 -0500
Received: by mail-ww0-f44.google.com with SMTP id 22so1364688wwb.1
        for <linux-omap@vger.kernel.org>; Thu, 03 Mar 2011 05:50:46 -0800 (PST)
In-Reply-To: <20110303134744.30648.91218.stgit@otae.warmcat.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: patches@linaro.org, Andy Green <andy.green@linaro.org>

The driver makes the choice about which register layout to
use based on cpu, however it then tries to use the probed
peripheral unit version register to decide whether to access
registers that only exist in the 4430 unit.

Unfortunately, the unit with the smaller register map on the
OMAP3530 has the same peripheral unit version number, leading
the OMAP3530 to dereference the register map beyond the bounds
of its array, and then to access a 'random' register offset taken
from whatever happens to be sitting beyond the register map
array, as reported here

https://bugs.launchpad.net/linux-linaro/+bug/645324

This patch makes both the choice of register map and the decision
to use a register only present in the larger map both do so based
on cpu type, which correctly reflects register availability.

Cc: patches@linaro.org
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 drivers/i2c/busses/i2c-omap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index e09c62d..c82e1bb5 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -309,7 +309,7 @@ static void omap_i2c_idle(struct omap_i2c_dev *dev)
 	pdata = pdev->dev.platform_data;
 
 	dev->iestate = omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
-	if (dev->rev >= OMAP_I2C_REV_ON_4430)
+	if (cpu_is_omap44xx())
 		omap_i2c_write_reg(dev, OMAP_I2C_OMAP4430_IRQENABLE_CLR, 1);
 	else
 		omap_i2c_write_reg(dev, OMAP_I2C_IE_REG, 0);

