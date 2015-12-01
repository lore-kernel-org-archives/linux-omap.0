From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] usb: musb: Fix unbalanced pm_runtime_enable
Date: Mon, 30 Nov 2015 21:37:13 -0800
Message-ID: <1448948233-31804-3-git-send-email-tony@atomide.com>
References: <1448948233-31804-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448948233-31804-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

When reloading omap2430 kernel module we get a warning about
unbalanced pm_runtime_enable. Let's fix this. Note that we
need to do this after the child musb-core platform_device is
removed because of pm_runtime_irq_safe being set at the child.

Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/omap2430.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index bf05f80..c84e0322 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -664,8 +664,11 @@ static int omap2430_remove(struct platform_device *pdev)
 {
 	struct omap2430_glue		*glue = platform_get_drvdata(pdev);
 
+	pm_runtime_get_sync(glue->dev);
 	cancel_work_sync(&glue->omap_musb_mailbox_work);
 	platform_device_unregister(glue->musb);
+	pm_runtime_put_sync(glue->dev);
+	pm_runtime_disable(glue->dev);
 
 	return 0;
 }
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
