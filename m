From: Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 06/13] extcon: extcon-class: remove unused functions
Date: Thu, 10 Apr 2014 15:16:44 +0200
Message-ID: <1397135811-12866-7-git-send-email-r.baldyga@samsung.com>
References: <1397135811-12866-1-git-send-email-r.baldyga@samsung.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1397135811-12866-1-git-send-email-r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, gg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org, anton-9xeibp6oKSgdnm+yROfE0A@public.gmane.org, jonghwa3.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rongjun.ying-kQvG35nSl+M@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, aaro.koskinen-X3B1VOXEql0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

This patch removes two functions, extcon_find_cable_index() and
extcon_get_edev_by_phandle(). They are not longer needed, since
extcon client API has changed to be oriented on extcon_cable instead
of extcon_dev.

Signed-off-by: Robert Baldyga <r.baldyga-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/extcon/extcon-class.c |   67 -----------------------------------------
 include/linux/extcon.h        |   18 -----------
 2 files changed, 85 deletions(-)

diff --git a/drivers/extcon/extcon-class.c b/drivers/extcon/extcon-class.c
index 708b352..2be0ac9 100644
--- a/drivers/extcon/extcon-class.c
+++ b/drivers/extcon/extcon-class.c
@@ -283,32 +283,6 @@ int extcon_set_state(struct extcon_dev *edev, u32 state)
 EXPORT_SYMBOL_GPL(extcon_set_state);
 
 /**
- * extcon_find_cable_index() - Get the cable index based on the cable name.
- * @edev:	the extcon device that has the cable.
- * @cable_name:	cable name to be searched.
- *
- * Note that accessing a cable state based on cable_index is faster than
- * cable_name because using cable_name induces a loop with strncmp().
- * Thus, when get/set_cable_state is repeatedly used, using cable_index
- * is recommended.
- */
-int extcon_find_cable_index(struct extcon_dev *edev, const char *cable_name)
-{
-	int i;
-
-	if (edev->supported_cable) {
-		for (i = 0; edev->supported_cable[i]; i++) {
-			if (!strncmp(edev->supported_cable[i],
-				cable_name, CABLE_NAME_MAX))
-				return i;
-		}
-	}
-
-	return -EINVAL;
-}
-EXPORT_SYMBOL_GPL(extcon_find_cable_index);
-
-/**
  * extcon_get_cable_state_() - Get the status of a specific cable.
  * @edev:	the extcon device that has the cable.
  * @index:	cable index that can be retrieved by extcon_find_cable_index().
@@ -876,47 +850,6 @@ void extcon_dev_unregister(struct extcon_dev *edev)
 }
 EXPORT_SYMBOL_GPL(extcon_dev_unregister);
 
-#ifdef CONFIG_OF
-/*
- * extcon_get_edev_by_phandle - Get the extcon device from devicetree
- * @dev - instance to the given device
- * @index - index into list of extcon_dev
- *
- * return the instance of extcon device
- */
-struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev, int index)
-{
-	struct device_node *node;
-	struct extcon_dev *edev;
-
-	if (!dev->of_node) {
-		dev_err(dev, "device does not have a device node entry\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	node = of_parse_phandle(dev->of_node, "extcon", index);
-	if (!node) {
-		dev_err(dev, "failed to get phandle in %s node\n",
-			dev->of_node->full_name);
-		return ERR_PTR(-ENODEV);
-	}
-
-	edev = of_extcon_get_extcon_dev(node);
-	if (!edev) {
-		dev_err(dev, "unable to get extcon device : %s\n", node->name);
-		return ERR_PTR(-ENODEV);
-	}
-
-	return edev;
-}
-#else
-struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev, int index)
-{
-	return ERR_PTR(-ENOSYS);
-}
-#endif /* CONFIG_OF */
-EXPORT_SYMBOL_GPL(extcon_get_edev_by_phandle);
-
 static int __init extcon_class_init(void)
 {
 	return create_extcon_class();
diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index a571cad..939a7b0 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -210,8 +210,6 @@ extern int extcon_update_state(struct extcon_dev *edev, u32 mask, u32 state);
  * They are used to access the status of each cable based on the cable_name
 tt or cable_index, which is retrieved by extcon_find_cable_index
  */
-extern int extcon_find_cable_index(struct extcon_dev *sdev,
-				   const char *cable_name);
 extern int extcon_get_cable_state_(struct extcon_dev *edev, int cable_index);
 extern int extcon_set_cable_state_(struct extcon_dev *edev,
 				  int cable_index, bool cable_state);
@@ -252,11 +250,6 @@ extern int extcon_register_notifier(struct extcon_dev *edev,
 extern int extcon_unregister_notifier(struct extcon_dev *edev,
 				      struct notifier_block *nb);
 
-/*
- * Following API get the extcon device from devicetree.
- * This function use phandle of devicetree to get extcon device directly.
- */
-extern struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev, int index);
 #else /* CONFIG_EXTCON */
 static inline int extcon_dev_register(struct extcon_dev *edev)
 {
@@ -281,12 +274,6 @@ static inline int extcon_update_state(struct extcon_dev *edev, u32 mask,
 	return 0;
 }
 
-static inline int extcon_find_cable_index(struct extcon_dev *edev,
-					  const char *cable_name)
-{
-	return 0;
-}
-
 static inline int extcon_get_cable_state_(struct extcon_dev *edev,
 					  int cable_index)
 {
@@ -341,10 +328,5 @@ static inline int extcon_unregister_interest(struct extcon_cable_nb
 	return 0;
 }
 
-static inline struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
-							    int index)
-{
-	return ERR_PTR(-ENODEV);
-}
 #endif /* CONFIG_EXTCON */
 #endif /* __LINUX_EXTCON_H__ */
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
