From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 02/13] mfd: menelaus: switch over to module_i2c_driver
Date: Wed, 27 Nov 2013 13:06:46 -0600
Message-ID: <1385579217-20127-3-git-send-email-balbi@ti.com>
References: <1385579217-20127-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1385579217-20127-1-git-send-email-balbi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: sameo@linux.intel.com
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, lee.jones@linaro.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

just a macro to remove some boilerplate code,
no functional changes.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/mfd/menelaus.c | 23 +----------------------
 1 file changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/mfd/menelaus.c b/drivers/mfd/menelaus.c
index 975ff9e..8bd97ca 100644
--- a/drivers/mfd/menelaus.c
+++ b/drivers/mfd/menelaus.c
@@ -1287,29 +1287,8 @@ static struct i2c_driver menelaus_i2c_driver = {
 	.id_table	= menelaus_id,
 };
 
-static int __init menelaus_init(void)
-{
-	int res;
-
-	res = i2c_add_driver(&menelaus_i2c_driver);
-	if (res < 0) {
-		pr_err(DRIVER_NAME ": driver registration failed\n");
-		return res;
-	}
-
-	return 0;
-}
-
-static void __exit menelaus_exit(void)
-{
-	i2c_del_driver(&menelaus_i2c_driver);
-
-	/* FIXME: Shutdown menelaus parts that can be shut down */
-}
+module_i2c_driver(menelaus_i2c_driver);
 
 MODULE_AUTHOR("Texas Instruments, Inc. (and others)");
 MODULE_DESCRIPTION("I2C interface for Menelaus.");
 MODULE_LICENSE("GPL");
-
-module_init(menelaus_init);
-module_exit(menelaus_exit);
-- 
1.8.4.GIT
