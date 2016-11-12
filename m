From: Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/3] rtc: rtc-twl: make driver DT only
Date: Sat, 12 Nov 2016 12:07:25 +0200
Message-ID: <1478945246-32056-3-git-send-email-Nicolae_Rosia@mentor.com>
References: <1478945246-32056-1-git-send-email-Nicolae_Rosia@mentor.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <rtc-linux+bncBAABB7GTTPAQKGQEFHFANZQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <1478945246-32056-1-git-send-email-Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Since there are no platform based users and all users
of this code are TI OMAP-based which is DT only, it makes
sense to remove unused code.

Signed-off-by: Nicolae Rosia <Nicolae_Rosia-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
---
 drivers/rtc/Kconfig   |  1 +
 drivers/rtc/rtc-twl.c | 10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index e859d14..2189216 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -481,6 +481,7 @@ config RTC_DRV_TWL92330
 config RTC_DRV_TWL4030
 	tristate "TI TWL4030/TWL5030/TWL6030/TPS659x0"
 	depends on TWL4030_CORE
+	depends on OF
 	help
 	  If you say yes here you get support for the RTC on the
 	  TWL4030/TWL5030/TWL6030 family chips, used mostly with OMAP3 platforms.
diff --git a/drivers/rtc/rtc-twl.c b/drivers/rtc/rtc-twl.c
index 0a1700a0..3d76322 100644
--- a/drivers/rtc/rtc-twl.c
+++ b/drivers/rtc/rtc-twl.c
@@ -492,10 +492,16 @@ static const struct rtc_class_ops twl_rtc_ops = {
 static int twl_rtc_probe(struct platform_device *pdev)
 {
 	struct twl_rtc *twl_rtc;
+	struct device_node *np = pdev->dev.of_node;
 	int ret = -EINVAL;
 	int irq = platform_get_irq(pdev, 0);
 	u8 rd_reg;
 
+	if (!np) {
+		dev_err(&pdev->dev, "no DT info\n");
+		return -EINVAL;
+	}
+
 	if (irq <= 0)
 		return ret;
 
@@ -625,15 +631,11 @@ static int twl_rtc_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(twl_rtc_pm_ops, twl_rtc_suspend, twl_rtc_resume);
 
-#ifdef CONFIG_OF
 static const struct of_device_id twl_rtc_of_match[] = {
 	{.compatible = "ti,twl4030-rtc", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, twl_rtc_of_match);
-#endif
-
-MODULE_ALIAS("platform:twl_rtc");
 
 static struct platform_driver twl4030rtc_driver = {
 	.probe		= twl_rtc_probe,
-- 
2.5.5

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
