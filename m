From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v3 03/10] input: tps65218-pwrbutton: Add platform_device_id table
Date: Tue, 28 Jun 2016 11:36:13 +0530
Message-ID: <1467093980-11458-4-git-send-email-j-keerthy@ti.com>
References: <1467093980-11458-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467093980-11458-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com, linus.walleij@linaro.org, gnurou@gmail.com, lee.jones@linaro.org, broonie@kernel.org, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

platform_device_id table is needed for adding the tps65218-pwrbutton
module to the mfd_cell array.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/input/misc/tps65218-pwrbutton.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/misc/tps65218-pwrbutton.c b/drivers/input/misc/tps65218-pwrbutton.c
index 2bba8de..a0cb7d2 100644
--- a/drivers/input/misc/tps65218-pwrbutton.c
+++ b/drivers/input/misc/tps65218-pwrbutton.c
@@ -113,12 +113,19 @@ static const struct of_device_id of_tps65218_pwr_match[] = {
 };
 MODULE_DEVICE_TABLE(of, of_tps65218_pwr_match);
 
+static const struct platform_device_id tps65218_pwrbtn_id_table[] = {
+	{ "tps65218-pwrbutton", },
+	{ /* sentinel */ }
+}
+MODULE_DEVICE_TABLE(platform, tps65218_pwrbtn_id_table);
+
 static struct platform_driver tps65218_pwron_driver = {
 	.probe	= tps65218_pwron_probe,
 	.driver	= {
 		.name	= "tps65218_pwrbutton",
 		.of_match_table = of_tps65218_pwr_match,
 	},
+	.id_table = tps65218_pwrbtn_id_table,
 };
 module_platform_driver(tps65218_pwron_driver);
 
-- 
1.9.1
