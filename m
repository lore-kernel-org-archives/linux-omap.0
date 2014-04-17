From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH V2 04/19] bus: omap_l3_noc: populate l3->dev and use it
Date: Thu, 17 Apr 2014 15:49:20 -0500
Message-ID: <1397767775-10965-5-git-send-email-nm@ti.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
 <1397767775-10965-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397767775-10965-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

l3->dev is not populated, so populate it and use it to print information
relevant to the device instead of using a generic pr_*.

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
v2: reordering, dropped the warn change as centralizing patch follows
v1: https://patchwork.kernel.org/patch/3984221/
 drivers/bus/omap_l3_noc.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/omap_l3_noc.c b/drivers/bus/omap_l3_noc.c
index 800486c..37d71b7 100644
--- a/drivers/bus/omap_l3_noc.c
+++ b/drivers/bus/omap_l3_noc.c
@@ -131,6 +131,7 @@ static int omap_l3_probe(struct platform_device *pdev)
 	if (!l3)
 		return -ENOMEM;
 
+	l3->dev = &pdev->dev;
 	platform_set_drvdata(pdev, l3);
 
 	/* Get mem resources */
@@ -140,7 +141,7 @@ static int omap_l3_probe(struct platform_device *pdev)
 
 		l3->l3_base[i] = devm_ioremap_resource(&pdev->dev, res);
 		if (IS_ERR(l3->l3_base[i])) {
-			dev_err(&pdev->dev, "ioremap %d failed\n", i);
+			dev_err(l3->dev, "ioremap %d failed\n", i);
 			return PTR_ERR(l3->l3_base[i]);
 		}
 	}
@@ -149,19 +150,19 @@ static int omap_l3_probe(struct platform_device *pdev)
 	 * Setup interrupt Handlers
 	 */
 	l3->debug_irq = platform_get_irq(pdev, 0);
-	ret = devm_request_irq(&pdev->dev, l3->debug_irq, l3_interrupt_handler,
+	ret = devm_request_irq(l3->dev, l3->debug_irq, l3_interrupt_handler,
 			       IRQF_DISABLED, "l3-dbg-irq", l3);
 	if (ret) {
-		dev_err(&pdev->dev, "request_irq failed for %d\n",
+		dev_err(l3->dev, "request_irq failed for %d\n",
 			l3->debug_irq);
 		return ret;
 	}
 
 	l3->app_irq = platform_get_irq(pdev, 1);
-	ret = devm_request_irq(&pdev->dev, l3->app_irq, l3_interrupt_handler,
+	ret = devm_request_irq(l3->dev, l3->app_irq, l3_interrupt_handler,
 			       IRQF_DISABLED, "l3-app-irq", l3);
 	if (ret)
-		dev_err(&pdev->dev, "request_irq failed for %d\n", l3->app_irq);
+		dev_err(l3->dev, "request_irq failed for %d\n", l3->app_irq);
 
 	return ret;
 }
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
