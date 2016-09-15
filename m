From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 2/2] usb: musb: Fix session based PM for first invalid VBUS
Date: Thu, 15 Sep 2016 09:29:14 -0700
Message-ID: <20160915162914.8164-3-tony@atomide.com>
References: <20160915162914.8164-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160915162914.8164-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

With the session bit based PM runtime working on musb, we've
implemented few quirks to attempt to detect the current state of
the hardware. One of the quirks is for invalid VBUS as peripheral,
but it is not working in all cases.

If we start musb on dm3730 as a peripheral with no cable connected,
we will get the devctl 91 state once and will never idle as there
are not further interrupts from musb. So we need to ignore the first
devctl 91 state as there will be more interrupts if we're connected.

The invalid VBUS state also can happen always when connected to
certain USB hubs. Looks like musb on dm3730 can claim invalid VBUS
with some hubs while 3717-evm and BeagleBone don't. This causes
session as peripheral to fail for dm3730 with some hubs.

This too is fixed by ignoring only the first invalid VBUS. When
connected, we can just look at the session bit as that will clear
automatically when the session ends.

Fixes: 467d5c980709 ("usb: musb: Implement session bit based
runtime PM for musb-core")
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_core.c | 13 ++++++++-----
 drivers/usb/musb/musb_core.h |  1 +
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -1855,11 +1855,13 @@ static void musb_pm_runtime_check_session(struct musb *musb)
 		MUSB_DEVCTL_HR;
 	switch (devctl & ~s) {
 	case MUSB_QUIRK_B_INVALID_VBUS_91:
-		if (musb->session)
-			break;
-		musb_dbg(musb, "Allow PM as device with invalid vbus: %02x",
-			devctl);
-		return;
+		if (!musb->session && !musb->quirk_invalid_vbus) {
+			musb->quirk_invalid_vbus = true;
+			musb_dbg(musb,
+				 "First invalid vbus, assume no session");
+			return;
+		}
+		break;
 	case MUSB_QUIRK_A_DISCONNECT_19:
 		if (!musb->session)
 			break;
@@ -1886,6 +1888,7 @@ static void musb_pm_runtime_check_session(struct musb *musb)
 				error);
 	} else {
 		musb_dbg(musb, "Allow PM with no session: %02x", devctl);
+		musb->quirk_invalid_vbus = false;
 		pm_runtime_mark_last_busy(musb->controller);
 		pm_runtime_put_autosuspend(musb->controller);
 	}
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -379,6 +379,7 @@ struct musb {
 
 	int			port_mode;	/* MUSB_PORT_MODE_* */
 	bool			session;
+	bool			quirk_invalid_vbus;
 	bool			is_host;
 
 	int			a_wait_bcon;	/* VBUS timeout in msecs */
-- 
2.9.3
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
