From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] phy: phy-twl4030-usb: fix denied runtime access
Date: Mon, 27 Aug 2018 21:48:05 +0200
Message-ID: <20180827194805.20139-1-andreas@kemnade.info>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com, lee.jones@linaro.org, dmitry.torokhov@gmail.com, daniel.thompson@linaro.org, wsa@the-dreams.de, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Discussions about the Letux Kernel <letux-kernel@openphoenux.org>
Cc: Andreas Kemnade <andreas@kemnade.info>
List-Id: linux-omap@vger.kernel.org

When runtime is not enabled, pm_runtime_get_sync() returns -EACCESS,
the counter will be incremented but the resume callback not called,
so enumeration and charging will not start properly.
To avoid that happen, wait and try again later.

Practically this happens when the device is woken up from suspend by
plugging in usb.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/phy/ti/phy-twl4030-usb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/ti/phy-twl4030-usb.c b/drivers/phy/ti/phy-twl4030-usb.c
index a44680d64f9b..1f3cf4e48383 100644
--- a/drivers/phy/ti/phy-twl4030-usb.c
+++ b/drivers/phy/ti/phy-twl4030-usb.c
@@ -552,6 +552,15 @@ static irqreturn_t twl4030_usb_irq(int irq, void *_twl)
 
 	status = twl4030_usb_linkstat(twl);
 
+	/* we might get here too early when runtime is not ready yet
+	 * and we will get an EACCESS later, so try again later
+	 */
+	if (!pm_runtime_enabled(twl->dev)) {
+		cancel_delayed_work(&twl->id_workaround_work);
+		schedule_delayed_work(&twl->id_workaround_work, HZ);
+		return IRQ_HANDLED;
+	}
+
 	mutex_lock(&twl->lock);
 	if (status >= 0 && status != twl->linkstat) {
 		status_changed =
-- 
2.11.0
