From: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2 01/10] usb: phy: Add APIs for runtime power management
Date: Sat, 02 Mar 2013 18:53:02 +0530
Message-ID: <1362230590-20960-2-git-send-email-gautam.vivek@samsung.com>
References: <1362230590-20960-1-git-send-email-gautam.vivek@samsung.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1362230590-20960-1-git-send-email-gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Adding  APIs to handle runtime power management on PHY
devices. PHY consumers may need to wake-up/suspend PHYs
when they work across autosuspend.

Signed-off-by: Vivek Gautam <gautam.vivek-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 include/linux/usb/phy.h |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/include/linux/usb/phy.h b/include/linux/usb/phy.h
index 15847cb..0fe7cac 100644
--- a/include/linux/usb/phy.h
+++ b/include/linux/usb/phy.h
@@ -276,4 +276,30 @@ static inline const char *usb_phy_type_string(enum usb_phy_type type)
 		return "UNKNOWN PHY TYPE";
 	}
 }
+
+#define USB_PHY_AUTOPM(function)					    \
+static inline int usb_phy_autopm_##function(struct usb_phy *x)		    \
+{									    \
+	if (!x || !x->dev) {						    \
+		dev_err(x->dev, "no PHY or attached device available\n");   \
+		return -ENODEV;						    \
+	}								    \
+									    \
+	pm_runtime_##function(x->dev);					    \
+									    \
+	return 0;							    \
+}
+USB_PHY_AUTOPM(enable)
+USB_PHY_AUTOPM(disable)
+USB_PHY_AUTOPM(get)
+USB_PHY_AUTOPM(get_sync)
+USB_PHY_AUTOPM(put)
+USB_PHY_AUTOPM(put_sync)
+USB_PHY_AUTOPM(allow)
+USB_PHY_AUTOPM(forbid)
+USB_PHY_AUTOPM(suspend)
+USB_PHY_AUTOPM(autosuspend)
+USB_PHY_AUTOPM(resume)
+USB_PHY_AUTOPM(set_active)
+
 #endif /* __LINUX_USB_PHY_H */
-- 
1.7.6.5

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
