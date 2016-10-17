From: Keerthy <j-keerthy@ti.com>
Subject: [RESEND PATCH v8 3/5] input: tps65218-pwrbutton: Add platform_device_id table
Date: Mon, 17 Oct 2016 21:29:36 +0530
Message-ID: <1476719978-16332-4-git-send-email-j-keerthy@ti.com>
References: <1476719978-16332-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1476719978-16332-1-git-send-email-j-keerthy@ti.com>
Sender: linux-input-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, tony@atomide.com, dmitry.torokhov@gmail.com, linus.walleij@linaro.org, broonie@kernel.org, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

platform_device_id table is needed for adding the tps65218-pwrbutton
module to the mfd_cell array.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/tps65218-pwrbutton.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/misc/tps65218-pwrbutton.c b/drivers/input/misc/tps65218-pwrbutton.c
index 3273217..cc74a41 100644
--- a/drivers/input/misc/tps65218-pwrbutton.c
+++ b/drivers/input/misc/tps65218-pwrbutton.c
@@ -150,12 +150,20 @@ static int tps6521x_pb_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct platform_device_id tps6521x_pwrbtn_id_table[] = {
+	{ "tps65218-pwrbutton", },
+	{ "tps65217-pwrbutton", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, tps6521x_pwrbtn_id_table);
+
 static struct platform_driver tps6521x_pb_driver = {
 	.probe	= tps6521x_pb_probe,
 	.driver	= {
 		.name	= "tps6521x_pwrbutton",
 		.of_match_table = of_tps6521x_pb_match,
 	},
+	.id_table = tps6521x_pwrbtn_id_table,
 };
 module_platform_driver(tps6521x_pb_driver);
 
-- 
1.9.1

