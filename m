From: Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 08/13] extcon: extcon-class: simplify extcon_updata_state()
 function
Date: Mon, 14 Apr 2014 13:46:19 +0200
Message-ID: <1397475984-28001-9-git-send-email-r.baldyga@samsung.com>
References: <1397475984-28001-1-git-send-email-r.baldyga@samsung.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1397475984-28001-1-git-send-email-r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org, jonghwa3.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rongjun.ying-kQvG35nSl+M@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch simplifies extcon_updata_state() function. There is greatly
simplified kobject_uevent preparation. Also meaning of variable passed
to raw_notifier_call_chain() (and in effect to _call_per_cable()) has
changed. Now positions on ones in variable 'val' in _call_per_cable()
indicates numbers of cables which changed their status. It allowed
to simplify also _call_per_cable() function.

Signed-off-by: Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/extcon/extcon-class.c |   81 ++++++++++++++++-------------------------
 include/linux/extcon.h        |    1 -
 2 files changed, 31 insertions(+), 51 deletions(-)

diff --git a/drivers/extcon/extcon-class.c b/drivers/extcon/extcon-class.c
index e9e5e85..13993c6 100644
--- a/drivers/extcon/extcon-class.c
+++ b/drivers/extcon/extcon-class.c
@@ -206,59 +206,48 @@ int extcon_update_state(struct extcon_dev *edev, u32 mask, u32 state)
 {
 	char name_buf[120];
 	char state_buf[120];
-	char *prop_buf;
+	char *tmp;
 	char *envp[3];
 	int env_offset = 0;
 	int length;
 	unsigned long flags;
+	u32 change;
 
 	spin_lock_irqsave(&edev->lock, flags);
 
-	if (edev->state != ((edev->state & ~mask) | (state & mask))) {
-		u32 old_state = edev->state;
-
-		if (check_mutually_exclusive(edev, (edev->state & ~mask) |
-						   (state & mask))) {
+	change = (edev->state & mask) ^ (state & mask);
+	if (change) {
+		if (check_mutually_exclusive(edev, edev->state ^ change)) {
 			spin_unlock_irqrestore(&edev->lock, flags);
 			return -EPERM;
 		}
 
-		edev->state &= ~mask;
-		edev->state |= state & mask;
-
-		raw_notifier_call_chain(&edev->nh, old_state, edev);
-		/* This could be in interrupt handler */
-		prop_buf = (char *)get_zeroed_page(GFP_ATOMIC);
-		if (prop_buf) {
-			length = name_show(&edev->dev, NULL, prop_buf);
-			if (length > 0) {
-				if (prop_buf[length - 1] == '\n')
-					prop_buf[length - 1] = 0;
-				snprintf(name_buf, sizeof(name_buf),
-					"NAME=%s", prop_buf);
-				envp[env_offset++] = name_buf;
-			}
-			length = state_show(&edev->dev, NULL, prop_buf);
-			if (length > 0) {
-				if (prop_buf[length - 1] == '\n')
-					prop_buf[length - 1] = 0;
-				snprintf(state_buf, sizeof(state_buf),
-					"STATE=%s", prop_buf);
-				envp[env_offset++] = state_buf;
-			}
-			envp[env_offset] = NULL;
-			/* Unlock early before uevent */
-			spin_unlock_irqrestore(&edev->lock, flags);
+		edev->state ^= change;
 
-			kobject_uevent_env(&edev->dev.kobj, KOBJ_CHANGE, envp);
-			free_page((unsigned long)prop_buf);
-		} else {
-			/* Unlock early before uevent */
-			spin_unlock_irqrestore(&edev->lock, flags);
+		raw_notifier_call_chain(&edev->nh, change, edev);
+
+		tmp = name_buf + sprintf(name_buf, "NAME=");
+		length = name_show(&edev->dev, NULL, tmp);
+		if (length > 0) {
+			if (tmp[length - 1] == '\n')
+				tmp[length - 1] = 0;
+			envp[env_offset++] = name_buf;
+		}
 
-			dev_err(&edev->dev, "out of memory in extcon_set_state\n");
-			kobject_uevent(&edev->dev.kobj, KOBJ_CHANGE);
+		tmp = state_buf + sprintf(state_buf, "STATE=");
+		length = state_show(&edev->dev, NULL, tmp);
+		if (length > 0) {
+			if (tmp[length - 1] == '\n')
+				tmp[length - 1] = 0;
+			envp[env_offset++] = state_buf;
 		}
+
+		envp[env_offset] = NULL;
+
+		/* Unlock early before uevent */
+		spin_unlock_irqrestore(&edev->lock, flags);
+
+		kobject_uevent_env(&edev->dev.kobj, KOBJ_CHANGE, envp);
 	} else {
 		/* No changes */
 		spin_unlock_irqrestore(&edev->lock, flags);
@@ -511,18 +500,10 @@ static int _call_per_cable(struct notifier_block *nb, unsigned long val,
 {
 	struct extcon_cable_nb *obj = container_of(nb,
 			struct extcon_cable_nb, internal_nb);
-	struct extcon_dev *edev = ptr;
-
-	if ((val & (1 << obj->cable->cable_index)) !=
-			(edev->state & (1 << obj->cable->cable_index))) {
-		bool cable_state = true;
-
-		obj->previous_value = val;
-
-		if (val & (1 << obj->cable->cable_index))
-			cable_state = false;
 
-		return obj->notifier_function(obj, cable_state);
+	if ((1 << obj->cable->cable_index) & val) {
+		int state = extcon_get_cable_state(obj->cable);
+		return obj->notifier_function(obj, !!state);
 	}
 
 	return NOTIFY_OK;
diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index 28e60fb..8792ca2 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -177,7 +177,6 @@ typedef int (*extcon_notifier_fn_t)(struct extcon_cable_nb *cable_nb,
  */
 struct extcon_cable_nb {
 	struct notifier_block internal_nb;
-	unsigned long previous_value;
 	extcon_notifier_fn_t notifier_function;
 	struct extcon_cable *cable;
 };
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
