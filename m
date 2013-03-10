From: Grazvydas Ignotas <notasas@gmail.com>
Subject: [PATCH 2/7] usb: otg: twl4030-usb: ignore duplicate events
Date: Sun, 10 Mar 2013 03:07:56 +0200
Message-ID: <1362877681-8102-3-git-send-email-notasas@gmail.com>
References: <1362877681-8102-1-git-send-email-notasas@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:41379 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356Ab3CJBIP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Mar 2013 20:08:15 -0500
In-Reply-To: <1362877681-8102-1-git-send-email-notasas@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, NeilBrown <neilb@suse.de>, Grazvydas Ignotas <notasas@gmail.com>

In some rare cases we may get multiple interrupts that will generate
duplicate omap_musb_mailbox() calls. This is a problem because each
VBUS/ID event generates runtime_pm call in OMAP glue code, causing
unbalanced gets or puts and breaking PM.

The same goes for initial state, glue already defaults to "no cable"
state, so only bother it if we have VBUS or ID.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
 drivers/usb/otg/twl4030-usb.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/otg/twl4030-usb.c b/drivers/usb/otg/twl4030-usb.c
index 1515c0b..0ea576a 100644
--- a/drivers/usb/otg/twl4030-usb.c
+++ b/drivers/usb/otg/twl4030-usb.c
@@ -491,9 +491,10 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 {
 	struct twl4030_usb *twl = _twl;
 	enum omap_musb_vbus_id_status status;
+	enum omap_musb_vbus_id_status status_prev = twl->linkstat;
 
 	status = twl4030_usb_linkstat(twl);
-	if (status > 0) {
+	if (status > 0 && status != status_prev) {
 		/* FIXME add a set_power() method so that B-devices can
 		 * configure the charger appropriately.  It's not always
 		 * correct to consume VBUS power, and how much current to
@@ -530,7 +531,7 @@ static void twl4030_usb_phy_init(struct twl4030_usb *twl)
 	twl->asleep = 1;
 
 	status = twl4030_usb_linkstat(twl);
-	if (status > 0)
+	if (status == OMAP_MUSB_ID_GROUND || status == OMAP_MUSB_VBUS_VALID)
 		omap_musb_mailbox(twl->linkstat);
 
 	sysfs_notify(&twl->dev->kobj, NULL, "vbus");
-- 
1.7.9.5

