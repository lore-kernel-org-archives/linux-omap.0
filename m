From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 2/3] OMAP: i2c: Change device name: i2c_omap -> omap_i2c
Date: Mon, 6 Dec 2010 11:41:32 +0100
Message-ID: <1291632093-18799-3-git-send-email-b-cousson@ti.com>
References: <1291632093-18799-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33263 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200Ab0LFKmK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Dec 2010 05:42:10 -0500
In-Reply-To: <1291632093-18799-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>, Ben Dooks <ben-i2c@fluff.org>

The convention for omap device naming is omap_XXX.

Rename the device and driver name in order to stick
to this naming convention.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
c: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Ben Dooks <ben-i2c@fluff.org>
---
 arch/arm/plat-omap/i2c.c      |    2 +-
 drivers/i2c/busses/i2c-omap.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/i2c.c b/arch/arm/plat-omap/i2c.c
index a5bff9c..0a271ad 100644
--- a/arch/arm/plat-omap/i2c.c
+++ b/arch/arm/plat-omap/i2c.c
@@ -40,7 +40,7 @@
 #define OMAP_I2C_SIZE		0x3f
 #define OMAP1_I2C_BASE		0xfffb3800
 
-static const char name[] = "i2c_omap";
+static const char name[] = "omap_i2c";
 
 #define I2C_RESOURCE_BUILDER(base, irq)			\
 	{						\
diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
index 760b8be..9d09083 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1139,7 +1139,7 @@ static struct platform_driver omap_i2c_driver = {
 	.probe		= omap_i2c_probe,
 	.remove		= omap_i2c_remove,
 	.driver		= {
-		.name	= "i2c_omap",
+		.name	= "omap_i2c",
 		.owner	= THIS_MODULE,
 	},
 };
@@ -1161,4 +1161,4 @@ module_exit(omap_i2c_exit_driver);
 MODULE_AUTHOR("MontaVista Software, Inc. (and others)");
 MODULE_DESCRIPTION("TI OMAP I2C bus adapter");
 MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:i2c_omap");
+MODULE_ALIAS("platform:omap_i2c");
-- 
1.7.0.4

