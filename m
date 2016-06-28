From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v4 4/6] gpio: tps65218-gpio: Add platform_device_id table
Date: Tue, 28 Jun 2016 14:52:07 +0530
Message-ID: <1467105729-28249-5-git-send-email-j-keerthy@ti.com>
References: <1467105729-28249-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467105729-28249-1-git-send-email-j-keerthy@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dmitry.torokhov@gmail.com, linus.walleij@linaro.org, gnurou@gmail.com, lee.jones@linaro.org, broonie@kernel.org, tony@atomide.com
Cc: devicetree@vger.kernel.org, j-keerthy@ti.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

platform_device_id table is needed for adding the tps65218-gpio
module to the mfd_cell array.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v4:

  * Retained the compatible strings in order to interrogate the DT in the
    normal way.

 drivers/gpio/gpio-tps65218.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpio/gpio-tps65218.c b/drivers/gpio/gpio-tps65218.c
index 0f9d9bd..0961f3a 100644
--- a/drivers/gpio/gpio-tps65218.c
+++ b/drivers/gpio/gpio-tps65218.c
@@ -231,6 +231,12 @@ static const struct of_device_id tps65218_dt_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tps65218_dt_match);
 
+static const struct platform_device_id tps65218_gpio_id_table[] = {
+	{ "tps65218-gpio", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, tps65218_gpio_id_table);
+
 static struct platform_driver tps65218_gpio_driver = {
 	.driver = {
 		.name = "tps65218-gpio",
@@ -238,6 +244,7 @@ static struct platform_driver tps65218_gpio_driver = {
 	},
 	.probe = tps65218_gpio_probe,
 	.remove = tps65218_gpio_remove,
+	.id_table = tps65218_gpio_id_table,
 };
 
 module_platform_driver(tps65218_gpio_driver);
-- 
1.9.1
