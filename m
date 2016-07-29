From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] musb: omap2430: do not assume balanced enable()/disable()
Date: Fri, 29 Jul 2016 19:42:31 +0200
Message-ID: <1469814151-2571-1-git-send-email-andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bin Liu <b-liu@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

The code assumes that omap2430_musb_enable() and
omap2430_musb_disable() is called in a balanced way. The
That fact is broken by the fact that musb_init_controller() calls
musb_platform_disable() to switch from unknown state to off state.

That means that phy_power_off() is called first so that
phy->power_count gets -1 and the phy is not enabled on phy_power_on().
In the probably common case of using the phy_twl4030, that
prevents also charging the battery and so makes further
kernel debugging hard.

The patch prevents phy_power_off() from being called when
it is already off.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/usb/musb/omap2430.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index aecb934..c7ae117 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -415,9 +415,10 @@ static void omap2430_musb_disable(struct musb *musb)
 	struct device *dev = musb->controller;
 	struct omap2430_glue *glue = dev_get_drvdata(dev->parent);
 
-	if (!WARN_ON(!musb->phy))
-		phy_power_off(musb->phy);
-
+	if (glue->enabled) {
+		if (!WARN_ON(!musb->phy))
+			phy_power_off(musb->phy);
+	}
 	if (glue->status != MUSB_UNKNOWN)
 		omap_control_usb_set_mode(glue->control_otghs,
 			USB_MODE_DISCONNECT);
-- 
2.1.4
