From: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 05/12] usb: chipdata: Replace the extcon API
Date: Wed, 30 Nov 2016 14:57:33 +0900
Message-ID: <1480485460-2663-6-git-send-email-cw00.choi@samsung.com>
References: <1480485460-2663-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1480485460-2663-1-git-send-email-cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Peter.Chen-3arQi8VN3Tc@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, chanwoo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-omap@vger.kernel.org

This patch uses the resource-managed extcon API for extcon_register_notifier()
and replaces the deprecated extcon API as following:
- extcon_get_cable_state_() -> extcon_get_state()

Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/chipidea/core.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 69426e644d17..a5b44963eaea 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -742,7 +742,7 @@ static int ci_get_platdata(struct device *dev,
 	cable->edev = ext_vbus;
 
 	if (!IS_ERR(ext_vbus)) {
-		ret = extcon_get_cable_state_(cable->edev, EXTCON_USB);
+		ret = extcon_get_state(cable->edev, EXTCON_USB);
 		if (ret)
 			cable->state = true;
 		else
@@ -754,7 +754,7 @@ static int ci_get_platdata(struct device *dev,
 	cable->edev = ext_id;
 
 	if (!IS_ERR(ext_id)) {
-		ret = extcon_get_cable_state_(cable->edev, EXTCON_USB_HOST);
+		ret = extcon_get_state(cable->edev, EXTCON_USB_HOST);
 		if (ret)
 			cable->state = false;
 		else
@@ -771,8 +771,8 @@ static int ci_extcon_register(struct ci_hdrc *ci)
 	id = &ci->platdata->id_extcon;
 	id->ci = ci;
 	if (!IS_ERR(id->edev)) {
-		ret = extcon_register_notifier(id->edev, EXTCON_USB_HOST,
-					       &id->nb);
+		ret = devm_extcon_register_notifier(ci->dev, id->edev,
+						EXTCON_USB_HOST, &id->nb);
 		if (ret < 0) {
 			dev_err(ci->dev, "register ID failed\n");
 			return ret;
@@ -782,11 +782,9 @@ static int ci_extcon_register(struct ci_hdrc *ci)
 	vbus = &ci->platdata->vbus_extcon;
 	vbus->ci = ci;
 	if (!IS_ERR(vbus->edev)) {
-		ret = extcon_register_notifier(vbus->edev, EXTCON_USB,
-					       &vbus->nb);
+		ret = devm_extcon_register_notifier(ci->dev, vbus->edev,
+						EXTCON_USB, &vbus->nb);
 		if (ret < 0) {
-			extcon_unregister_notifier(id->edev, EXTCON_USB_HOST,
-						   &id->nb);
 			dev_err(ci->dev, "register VBUS failed\n");
 			return ret;
 		}
@@ -795,20 +793,6 @@ static int ci_extcon_register(struct ci_hdrc *ci)
 	return 0;
 }
 
-static void ci_extcon_unregister(struct ci_hdrc *ci)
-{
-	struct ci_hdrc_cable *cable;
-
-	cable = &ci->platdata->id_extcon;
-	if (!IS_ERR(cable->edev))
-		extcon_unregister_notifier(cable->edev, EXTCON_USB_HOST,
-					   &cable->nb);
-
-	cable = &ci->platdata->vbus_extcon;
-	if (!IS_ERR(cable->edev))
-		extcon_unregister_notifier(cable->edev, EXTCON_USB, &cable->nb);
-}
