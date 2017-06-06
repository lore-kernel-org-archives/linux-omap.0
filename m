From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 3/5] mfd: tps65217: Add a dependency on OF
Date: Tue, 6 Jun 2017 20:15:38 +0530
Message-ID: <1496760340-27959-4-git-send-email-j-keerthy@ti.com>
References: <1496760340-27959-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1496760340-27959-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, milo.kim@ti.com, lee.jones@linaro.org
Cc: j-keerthy@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Currently the driver boots only via device tree hence add a
dependency on OF.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/mfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 75b59f1..2d1425d 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1297,7 +1297,7 @@ config MFD_TPS65090
 
 config MFD_TPS65217
 	tristate "TI TPS65217 Power Management / White LED chips"
-	depends on I2C
+	depends on I2C && OF
 	select MFD_CORE
 	select REGMAP_I2C
 	select IRQ_DOMAIN
-- 
1.9.1
