From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v10 11/14] usb: otg: use dev_dbg() instead of VDBG()
Date: Thu, 9 Jun 2016 10:55:05 +0300
Message-ID: <575920D9.7080905@ti.com>
References: <1465376626-30122-1-git-send-email-rogerq@ti.com>
 <1465376626-30122-12-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1465376626-30122-12-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Cc: balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Now that we have a device reference in struct usb_otg
let's use dev_vdbg() for debug messages instead of VDBG().

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Acked-by: Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>
---
v10:
- in the commit message say dev_vdbg() instead of dev_dbg()

 drivers/usb/common/usb-otg-fsm.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/common/usb-otg-fsm.c b/drivers/usb/common/usb-otg-fsm.c
index 482d4c9..e6e58c2 100644
--- a/drivers/usb/common/usb-otg-fsm.c
+++ b/drivers/usb/common/usb-otg-fsm.c
@@ -30,13 +30,6 @@
 #include <linux/usb/otg.h>
 #include <linux/usb/otg-fsm.h>
 
-#ifdef VERBOSE
-#define VDBG(fmt, args...) pr_debug("[%s]  " fmt, \
-				 __func__, ## args)
-#else
-#define VDBG(stuff...)	do {} while (0)
-#endif
-
 /* Change USB protocol when there is a protocol change */
 static int otg_set_protocol(struct otg_fsm *fsm, int protocol)
 {
@@ -44,8 +37,9 @@ static int otg_set_protocol(struct otg_fsm *fsm, int protocol)
 	int ret = 0;
 
 	if (fsm->protocol != protocol) {
-		VDBG("Changing role fsm->protocol= %d; new protocol= %d\n",
-			fsm->protocol, protocol);
+		dev_vdbg(otg->dev,
+			 "Changing role fsm->protocol= %d; new protocol= %d\n",
+			 fsm->protocol, protocol);
 		/* stop old protocol */
 		if (fsm->protocol == PROTO_HOST)
 			ret = otg_start_host(otg, 0);
@@ -226,7 +220,7 @@ static int otg_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
 
 	if (otg->state == new_state)
 		return 0;
-	VDBG("Set state: %s\n", usb_otg_state_string(new_state));
+	dev_vdbg(otg->dev, "Set state: %s\n", usb_otg_state_string(new_state));
 	otg_leave_state(fsm, otg->state);
 	switch (new_state) {
 	case OTG_STATE_B_IDLE:
@@ -358,7 +352,7 @@ int otg_statemachine(struct usb_otg *otg)
 
 	switch (state) {
 	case OTG_STATE_UNDEFINED:
-		VDBG("fsm->id = %d\n", fsm->id);
+		dev_vdbg(otg->dev, "fsm->id = %d\n", fsm->id);
 		if (fsm->id)
 			otg_set_state(fsm, OTG_STATE_B_IDLE);
 		else
@@ -466,7 +460,8 @@ int otg_statemachine(struct usb_otg *otg)
 	}
 	mutex_unlock(&fsm->lock);
 
-	VDBG("quit statemachine, changed = %d\n", fsm->state_changed);
+	dev_vdbg(otg->dev, "quit statemachine, changed = %d\n",
+		 fsm->state_changed);
 	return fsm->state_changed;
 }
 EXPORT_SYMBOL_GPL(otg_statemachine);
-- 
2.7.4


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
