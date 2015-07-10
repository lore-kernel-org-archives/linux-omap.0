From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 09/12] memory: omap-gpmc: use module_platform_driver()
Date: Fri, 10 Jul 2015 15:23:36 +0300
Message-ID: <1436531019-18088-10-git-send-email-rogerq@ti.com>
References: <1436531019-18088-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1436531019-18088-1-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: tony@atomide.com, dwmw2@infradead.org, computersforpeace@gmail.com, bcousson@baylibre.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, ezequiel@vanguardiasur.com.ar, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Stop registering driver at postcore and do it
the standard way.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/memory/omap-gpmc.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 995e9b8..f19edc2 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -1914,19 +1914,7 @@ static struct platform_driver gpmc_driver = {
 	},
 };
 
-static __init int gpmc_init(void)
-{
-	return platform_driver_register(&gpmc_driver);
-}
-
-static __exit void gpmc_exit(void)
-{
-	platform_driver_unregister(&gpmc_driver);
-
-}
-
-postcore_initcall(gpmc_init);
-module_exit(gpmc_exit);
+module_platform_driver(gpmc_driver);
 
 static struct omap3_gpmc_regs gpmc_context;
 
-- 
2.1.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
