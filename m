From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 2/4] rtc: omap: Adopt driver to support probe deferral
Date: Thu, 25 Sep 2014 15:02:07 +0530
Message-ID: <1411637529-18289-3-git-send-email-lokeshvutla@ti.com>
References: <1411637529-18289-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1411637529-18289-1-git-send-email-lokeshvutla@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: rtc-linux@googlegroups.com, a.zummo@towertech.it
Cc: devicetree@vger.kernel.org, tony@atomide.com, j-keerthy@ti.com, nsekhar@ti.com, balbi@ti.com, t-kristo@ti.com, lokeshvutla@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

module_platform_driver_probe() prevents driver from requesting probe deferral.
So using module_platform_drive() to support probe deferral.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since V1:
	- New patch, seperated from patch 4/4.
 drivers/rtc/rtc-omap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index 4e90b50..93c5424 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -397,7 +397,7 @@ static const struct of_device_id omap_rtc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, omap_rtc_of_match);
 
-static int __init omap_rtc_probe(struct platform_device *pdev)
+static int omap_rtc_probe(struct platform_device *pdev)
 {
 	struct resource		*res;
 	struct rtc_omap_dev	*rtc_omap;
@@ -601,6 +601,7 @@ static void omap_rtc_shutdown(struct platform_device *pdev)
 }
 
 static struct platform_driver omap_rtc_driver = {
+	.probe		= omap_rtc_probe,
 	.remove		= __exit_p(omap_rtc_remove),
 	.shutdown	= omap_rtc_shutdown,
 	.driver		= {
@@ -612,7 +613,7 @@ static struct platform_driver omap_rtc_driver = {
 	.id_table	= omap_rtc_devtype,
 };
 
-module_platform_driver_probe(omap_rtc_driver, omap_rtc_probe);
+module_platform_driver(omap_rtc_driver);
 
 MODULE_ALIAS("platform:omap_rtc");
 MODULE_AUTHOR("George G. Davis (and others)");
-- 
1.9.1
