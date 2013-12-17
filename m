From: anaumann-ZKHRqZ6+gQUX0D0ZMPkEVw@public.gmane.org
Subject: [PATCH V3] usb: musb: Fix unstable init of OTG_INTERFSEL.
Date: Tue, 17 Dec 2013 17:48:33 +0100
Message-ID: <1387298913-18823-1-git-send-email-anaumann@ultratronik.de>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andreas Naumann <anaumann-ZKHRqZ6+gQUX0D0ZMPkEVw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Andreas Naumann <anaumann-ZKHRqZ6+gQUX0D0ZMPkEVw@public.gmane.org>

This is a hard to reproduce problem which leads to non-functional
USB-OTG port in 0.1%-1% of all boots. Tracked it down to commit
e25bec160158abe86c276d7d206264afc3646281, which introduces save/restore
of OTG_INTERFSEL over suspend.
Since the resume function is also called early in driver init, it uses a
non-initialized value (which is 0 and a non-supported setting in DM37xx
for INTERFSEL). Shortly after the correct value is set. Apparently this
works most time, but not always.

Fix it by not writing the value on runtime resume if it has not been
initialized yet.

Signed-off-by: Andreas Naumann <anaumann-ZKHRqZ6+gQUX0D0ZMPkEVw@public.gmane.org>
---
Even though I find the implementation a bit awkward this should fix
the issue without breaking anything else. Hope everyone is happy 
with this.

 drivers/usb/musb/omap2430.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 4315d35..fbe2c08 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -48,6 +48,7 @@ struct omap2430_glue {
 	enum omap_musb_vbus_id_status status;
 	struct work_struct	omap_musb_mailbox_work;
 	struct device		*control_otghs;
+	u8 	initialized;
 };
 #define glue_to_musb(g)		platform_get_drvdata(g->musb)
 
@@ -383,6 +384,7 @@ static int omap2430_musb_init(struct musb *musb)
 	}
 
 	musb_writel(musb->mregs, OTG_INTERFSEL, l);
+	glue->initialized = 1;
 
 	pr_debug("HS USB OTG: revision 0x%x, sysconfig 0x%02x, "
 			"sysstatus 0x%x, intrfsel 0x%x, simenable  0x%x\n",
@@ -509,6 +511,7 @@ static int omap2430_probe(struct platform_device *pdev)
 	glue->dev			= &pdev->dev;
 	glue->musb			= musb;
 	glue->status			= OMAP_MUSB_UNKNOWN;
+	glue->initialized	= 0;
 
 	if (np) {
 		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
@@ -646,7 +649,8 @@ static int omap2430_runtime_resume(struct device *dev)
 
 	if (musb) {
 		omap2430_low_level_init(musb);
-		musb_writel(musb->mregs, OTG_INTERFSEL,
+		if(glue->initialized)
+			musb_writel(musb->mregs, OTG_INTERFSEL,
 				musb->context.otg_interfsel);
 
 		usb_phy_set_suspend(musb->xceiv, 0);
-- 
1.8.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
