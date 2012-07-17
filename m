From: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 10/11] usb: musb: dsps: get the PHY using phandle api
Date: Tue, 17 Jul 2012 14:43:26 +0530
Message-ID: <1342516407-16515-11-git-send-email-ajay.gupta@ti.com>
References: <1342516407-16515-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1342516407-16515-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

AM33xx has two PHY of same type used by each musb controller so
use phandle of phy nodes to get the phy pointer.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/usb/am33xx-usb.txt         |    2 ++
 drivers/usb/musb/musb_dsps.c                       |    4 +++-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/am33xx-usb.txt b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
index a314720..4ed0091 100644
--- a/Documentation/devicetree/bindings/usb/am33xx-usb.txt
+++ b/Documentation/devicetree/bindings/usb/am33xx-usb.txt
@@ -12,6 +12,8 @@ AM33XX MUSB GLUE
    represents PERIPHERAL.
  - power : Should be "250". This signifies the controller can supply upto
    500mA when operating in host mode.
+ - usb0-phy : phandle for usb0 NOP PHY
+ - usb1-phy : phandle for usb1 NOP PHY
 
 NOP USB PHY
  - compatible : Should be "ti,nop-xceiv-usb"
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 4c59809..e2b0729 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -419,6 +419,7 @@ static int dsps_musb_init(struct musb *musb)
 	struct dsps_glue *glue = platform_get_drvdata(pdev);
 	const struct dsps_musb_wrapper *wrp = glue->wrp;
 	void __iomem *reg_base = musb->ctrl_base;
+	char name[10];
 	u32 rev, val;
 	int status;
 
@@ -426,7 +427,8 @@ static int dsps_musb_init(struct musb *musb)
 	musb->mregs += wrp->musb_core_offset;
 
 	/* Get the NOP PHY */
-	musb->xceiv = usb_get_phy(USB_PHY_TYPE_USB2);
+	sprintf(name, "usb%d-phy", musb->id);
+	musb->xceiv = devm_usb_get_phy_by_phandle(&pdev->dev, name);
 	if (IS_ERR_OR_NULL(musb->xceiv))
 		return -ENODEV;
 
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
