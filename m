From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/2] phy: twl4030-usb: Relase usb phy on unload
Date: Mon, 30 Nov 2015 21:39:53 -0800
Message-ID: <1448948394-32078-2-git-send-email-tony@atomide.com>
References: <1448948394-32078-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448948394-32078-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Otherwise rmmod omap2430; rmmod phy-twl4030-usb; modprobe omap2430
will try to use a non-existing phy and oops:

Unable to handle kernel paging request at virtual address b6f7c1f0
...
[<c048a284>] (devm_usb_get_phy_by_node) from [<bf0758ac>]
(omap2430_musb_init+0x44/0x2b4 [omap2430])
[<bf0758ac>] (omap2430_musb_init [omap2430]) from [<bf055ec0>]
(musb_init_controller+0x194/0x878 [musb_hdrc])

Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/phy/phy-twl4030-usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/phy-twl4030-usb.c b/drivers/phy/phy-twl4030-usb.c
index 3a707dd..79870c4 100644
--- a/drivers/phy/phy-twl4030-usb.c
+++ b/drivers/phy/phy-twl4030-usb.c
@@ -750,6 +750,7 @@ static int twl4030_usb_remove(struct platform_device *pdev)
 	struct twl4030_usb *twl = platform_get_drvdata(pdev);
 	int val;
 
+	usb_remove_phy(&twl->phy);
 	pm_runtime_get_sync(twl->dev);
 	cancel_delayed_work(&twl->id_workaround_work);
 	device_remove_file(twl->dev, &dev_attr_vbus);
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
