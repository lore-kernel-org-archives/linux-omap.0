From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 2/2] extcon: Fix extcon_cable_get_state() from getting old state after notification
Date: Mon, 6 Jul 2015 17:46:58 +0300
Message-ID: <1436194018-18696-3-git-send-email-rogerq@ti.com>
References: <1436194018-18696-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436194018-18696-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cw00.choi@samsung.com
Cc: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Currently the extcon code notifiers the interested listeners
before it updates the extcon state with the new state.
This will cause the listeners that use extcon_cable_get_state()
to get the stale state and loose the new state.

Fix this by first changing the extcon state variable and then
notifying listeners.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/extcon/extcon.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index 868c6e2..26d1e1e 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -275,19 +275,25 @@ int extcon_update_state(struct extcon_dev *edev, u32 mask, u32 state)
 	spin_lock_irqsave(&edev->lock, flags);
 
 	if (edev->state != ((edev->state & ~mask) | (state & mask))) {
+		u32 old_state;
+
 		if (check_mutually_exclusive(edev, (edev->state & ~mask) |
 						   (state & mask))) {
 			spin_unlock_irqrestore(&edev->lock, flags);
 			return -EPERM;
 		}
 
+		old_state = edev->state;
+		edev->state &= ~mask;
+		edev->state |= state & mask;
+
 		for (index = 0; index < edev->max_supported; index++) {
-			if (is_extcon_changed(edev->state, state, index, &attached))
-				raw_notifier_call_chain(&edev->nh[index], attached, edev);
+			if (is_extcon_changed(old_state, edev->state, index,
+					      &attached))
+				raw_notifier_call_chain(&edev->nh[index],
+							attached, edev);
 		}
 
-		edev->state &= ~mask;
-		edev->state |= state & mask;
 
 		/* This could be in interrupt handler */
 		prop_buf = (char *)get_zeroed_page(GFP_ATOMIC);
-- 
2.1.4
