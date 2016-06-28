From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH v6 3/6] input: tps65218-pwrbutton: Add platform_device_id table
Date: Tue, 28 Jun 2016 18:00:51 +0530
Message-ID: <1467117054-12943-4-git-send-email-j-keerthy@ti.com>
References: <1467117054-12943-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467117054-12943-1-git-send-email-j-keerthy@ti.com>
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

platform_device_id table is needed for adding the tps65218-pwrbutton
module to the mfd_cell array.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v4:

  * Added the missing ';' for struct platform_device_id.

 drivers/input/misc/tps65218-pwrbutton.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/misc/tps65218-pwrbutton.c b/drivers/input/misc/tps65218-pwrbutton.c
index 2bba8de..33d141a 100644
--- a/drivers/input/misc/tps65218-pwrbutton.c
+++ b/drivers/input/misc/tps65218-pwrbutton.c
@@ -113,12 +113,19 @@ static const struct of_device_id of_tps65218_pwr_match[] = {
 };
 MODULE_DEVICE_TABLE(of, of_tps65218_pwr_match);
 
+static const struct platform_device_id tps65218_pwrbtn_id_table[] = {
+	{ "tps65218-pwrbutton", },
+	{ /* sentinel */ }
+};
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
