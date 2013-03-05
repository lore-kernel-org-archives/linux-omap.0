From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/2] usb: musb: omap2430: fix omap_musb_mailbox glue check again
Date: Tue,  5 Mar 2013 13:04:23 +0200
Message-ID: <1362481464-10813-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:56424 "EHLO
	filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab3CELEa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Mar 2013 06:04:30 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Commit 80ab72e1 (usb: musb: omap2430: fix the readiness check
in omap_musb_mailbox) made the check incorrect, as we will lose the
glue/link status during the normal built-in probe order (twl4030_usb is
probed after musb omap2430, but before musb core is ready).

As a result, if you boot with USB cable on and load g_ether, the
connection does not work as the code thinks the cable is off and the
phy gets powered down immediately. This is a major regression in 3.9-rc1.

So the proper check should be: exit if _glue is NULL, but if it's
initialized we memorize the status, and then check if the musb core
is ready.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 drivers/usb/musb/omap2430.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 1762354..2a39c11 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -237,9 +237,13 @@ void omap_musb_mailbox(enum omap_musb_vbus_id_status status)
 {
 	struct omap2430_glue	*glue = _glue;
 
-	if (glue && glue_to_musb(glue)) {
-		glue->status = status;
-	} else {
+	if (!glue) {
+		pr_err("%s: musb core is not yet initialized\n", __func__);
+		return;
+	}
+	glue->status = status;
+
+	if (!glue_to_musb(glue)) {
 		pr_err("%s: musb core is not yet ready\n", __func__);
 		return;
 	}
-- 
1.7.10.4

