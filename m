From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/4] usb: musb: Implement session bit based runtime PM for musb-core
Date: Thu, 18 Aug 2016 15:46:47 -0700
Message-ID: <1471560410-6428-2-git-send-email-tony@atomide.com>
References: <1471560410-6428-1-git-send-email-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1471560410-6428-1-git-send-email-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

We want to keep musb enabled always when the session bit is
set. This simplifies the PM runtime and allows making it more
generic across the various glue layers.

So far the only exception to just following the session bit is
host mode disconnect where the session bit stays set.

In that case, just allow PM and let the PM runtime autoidle
timeout deal with it.

Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_core.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/musb/musb_core.h |  1 +
 2 files changed, 71 insertions(+)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 74fc306..9c4e1a5 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1831,11 +1831,81 @@ static const struct attribute_group musb_attr_group = {
 	.attrs = musb_attributes,
 };
 
+#define MUSB_QUIRK_B_INVALID_VBUS_91	(MUSB_DEVCTL_BDEVICE | \
+					 (2 << MUSB_DEVCTL_VBUS_SHIFT) | \
+					 MUSB_DEVCTL_SESSION)
+#define MUSB_QUIRK_A_DISCONNECT_19	((3 << MUSB_DEVCTL_VBUS_SHIFT) | \
+					 MUSB_DEVCTL_SESSION)
+
+/*
+ * Check the musb devctl session bit to determine if we want to
+ * allow PM runtime for the device. In general, we want to keep things
+ * active when the session bit is set except after host disconnect.
+ *
+ * Only called from musb_irq_work. If this ever needs to get called
+ * elsewhere, proper locking must be implemented for musb->session.
+ */
+static void musb_pm_runtime_check_session(struct musb *musb)
+{
+	u8 devctl, s;
+	int error;
+
+	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
+
+	/* Handle session status quirks first */
+	s = MUSB_DEVCTL_FSDEV | MUSB_DEVCTL_LSDEV |
+		MUSB_DEVCTL_HR;
+	switch (devctl & ~s) {
+	case MUSB_QUIRK_B_INVALID_VBUS_91:
+		if (musb->session)
+			break;
+		dev_dbg(musb->controller,
+			"Allow PM as device with invalid vbus: %02x\n",
+			devctl);
+		return;
+	case MUSB_QUIRK_A_DISCONNECT_19:
+		if (!musb->session)
+			break;
+		dev_dbg(musb->controller,
+			"Allow PM on possible host mode disconnect\n");
+		pm_runtime_mark_last_busy(musb->controller);
+		pm_runtime_put_autosuspend(musb->controller);
+		musb->session = false;
+		return;
+	default:
+		break;
+	}
+
+	/* No need to do anything if session has not changed */
+	s = devctl & MUSB_DEVCTL_SESSION;
+	if (s == musb->session)
+		return;
+
+	/* Block PM or allow PM? */
+	if (s) {
+		dev_dbg(musb->controller, "Block PM on active session: %02x\n",
+			devctl);
+		error = pm_runtime_get_sync(musb->controller);
+		if (error < 0)
+			dev_err(musb->controller, "Could not enable: %i\n",
+				error);
+	} else {
+		dev_dbg(musb->controller, "Allow PM with no session: %02x\n",
+			devctl);
+		pm_runtime_mark_last_busy(musb->controller);
+		pm_runtime_put_autosuspend(musb->controller);
+	}
+
+	musb->session = s;
+}
+
 /* Only used to provide driver mode change events */
 static void musb_irq_work(struct work_struct *data)
 {
 	struct musb *musb = container_of(data, struct musb, irq_work);
 
+	musb_pm_runtime_check_session(musb);
+
 	if (musb->xceiv->otg->state != musb->xceiv_old_state) {
 		musb->xceiv_old_state = musb->xceiv->otg->state;
 		sysfs_notify(&musb->controller->kobj, NULL, "mode");
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index b55a776..65288a5 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -378,6 +378,7 @@ struct musb {
 	u8			min_power;	/* vbus for periph, in mA/2 */
 
 	int			port_mode;	/* MUSB_PORT_MODE_* */
+	bool			session;
 	bool			is_host;
 
 	int			a_wait_bcon;	/* VBUS timeout in msecs */
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
