From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v6 4/4] regulator: lp873x: Change the MFD config option as per latest naming
Date: Mon, 8 Aug 2016 11:16:58 +0530
Message-ID: <1470635218-15951-5-git-send-email-j-keerthy@ti.com>
References: <1470635218-15951-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1470635218-15951-1-git-send-email-j-keerthy@ti.com>
Sender: linux-gpio-owner@vger.kernel.org
To: broonie@kernel.org, lee.jones@linaro.org, tony@atomide.com
Cc: j-keerthy@ti.com, linus.walleij@linaro.org, gnurou@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org
List-Id: linux-omap@vger.kernel.org

Change the MFD config option as per latest naming

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/regulator/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 6c88e31..97dc4cc 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -323,7 +323,7 @@ config REGULATOR_LP872X
 
 config REGULATOR_LP873X
 	tristate "TI LP873X Power regulators"
-	depends on MFD_LP873X && OF
+	depends on MFD_TI_LP873X && OF
 	help
 	  This driver supports LP873X voltage regulator chips. LP873X
 	  provides two step-down converters and two general-purpose LDO
-- 
1.9.1

