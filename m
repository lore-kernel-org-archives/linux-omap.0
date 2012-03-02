From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 03/12] mfd: twl-core: Remove references already defined in header file
Date: Fri, 2 Mar 2012 17:50:15 +0100
Message-ID: <1330707024-23730-4-git-send-email-b-cousson@ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59558 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985Ab2CBQvO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Mar 2012 11:51:14 -0500
In-Reply-To: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sameo@linux.intel.com, tony@atomide.com, grant.likely@secretlab.ca
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

The twl-core exported functions are already declared in twl-core.h

Include the header file instead or re-declaring the functions.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Acked-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mfd/twl-core.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index e612678..d0f08b0 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -45,6 +45,8 @@
 #include <linux/i2c.h>
 #include <linux/i2c/twl.h>
 
+#include "twl-core.h"
+
 /*
  * The TWL4030 "Triton 2" is one of a family of a multi-function "Power
  * Management and System Companion Device" chips originally designed for
@@ -1150,11 +1152,6 @@ static void clocks_init(struct device *dev,
 
 /*----------------------------------------------------------------------*/
 
-int twl4030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end);
-int twl4030_exit_irq(void);
-int twl4030_init_chip_irq(const char *chip);
-int twl6030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end);
-int twl6030_exit_irq(void);
 
 static int twl_remove(struct i2c_client *client)
 {
-- 
1.7.0.4

