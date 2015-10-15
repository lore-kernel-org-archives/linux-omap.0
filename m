From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH] twl4030_charger: add missing iio dependency
Date: Thu, 15 Oct 2015 11:11:07 +0200
Message-ID: <1444900267-31937-1-git-send-email-sre@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, Marek Belisko <marek@goldelico.com>, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

This driver fails to link without CONFIG_IIO, since
there are no stubs for the iio_channels functions.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/power/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 9e68853217ca..cb0ae666dc68 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -313,7 +313,7 @@ config CHARGER_MAX8903
 
 config CHARGER_TWL4030
 	tristate "OMAP TWL4030 BCI charger driver"
-	depends on TWL4030_CORE
+	depends on IIO && TWL4030_CORE
 	help
 	  Say Y here to enable support for TWL4030 Battery Charge Interface.
 
-- 
2.6.1

