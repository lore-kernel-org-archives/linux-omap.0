From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 5/6] usb: musb: Add missing pm_runtime_disable and drop 2430 PM timeout
Date: Fri, 11 Nov 2016 10:43:01 -0800
Message-ID: <20161111184302.2438-6-tony@atomide.com>
References: <20161111184302.2438-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161111184302.2438-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

We are missing pm_runtime_disable() in 2430 glue layer. Further,
we only need to enable PM runtime and disable it on exit. With
musb_core.c doing PM, the glue layer as a parent will always be
active when musb_core.c is active.

This fixes host enumeration issues with some devices as reported
by Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>.

If changes are needed to the autosuspend timeout, it should be
done in musb_core.c.

Reported-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Fixes: 87326e858448 ("usb: musb: Remove extra PM runtime calls from
2430 glue layer")
Tested-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/omap2430.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -513,17 +513,18 @@ static int omap2430_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_enable(glue->dev);
-	pm_runtime_use_autosuspend(glue->dev);
-	pm_runtime_set_autosuspend_delay(glue->dev, 100);
 
 	ret = platform_device_add(musb);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register musb device\n");
-		goto err2;
+		goto err3;
 	}
 
 	return 0;
 
+err3:
+	pm_runtime_disable(glue->dev);
+
 err2:
 	platform_device_put(musb);
 
@@ -535,10 +536,7 @@ static int omap2430_remove(struct platform_device *pdev)
 {
 	struct omap2430_glue *glue = platform_get_drvdata(pdev);
 
-	pm_runtime_get_sync(glue->dev);
 	platform_device_unregister(glue->musb);
-	pm_runtime_put_sync(glue->dev);
-	pm_runtime_dont_use_autosuspend(glue->dev);
 	pm_runtime_disable(glue->dev);
 
 	return 0;
-- 
2.10.2
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
