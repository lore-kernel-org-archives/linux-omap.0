From: Ionut Nicu <ionut.nicu@gmail.com>
Subject: [PATCH v2 08/12] staging: tidspbridge: convert rmgr to list_head
Date: Fri,  5 Nov 2010 17:13:12 +0200
Message-ID: <1288969996-22103-9-git-send-email-ionut.nicu@mindbit.ro>
References: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:52110 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab0KEPOW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 11:14:22 -0400
Received: by mail-bw0-f46.google.com with SMTP id 11so2758099bwz.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 08:14:21 -0700 (PDT)
In-Reply-To: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sapiens Rene <rene.sapiens@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

Convert the rmgr module of the tidspbridge driver
to use struct list_head instead of struct lst_list.

Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
---
 drivers/staging/tidspbridge/rmgr/drv.c  |  111 +++++++++----------------------
 drivers/staging/tidspbridge/rmgr/node.c |   52 +++++----------
 drivers/staging/tidspbridge/rmgr/proc.c |    2 -
 drivers/staging/tidspbridge/rmgr/rmm.c  |   74 +++++++--------------
 4 files changed, 72 insertions(+), 167 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/drv.c b/drivers/staging/tidspbridge/rmgr/drv.c
index 91cc1685..18fae55 100644
--- a/drivers/staging/tidspbridge/rmgr/drv.c
+++ b/drivers/staging/tidspbridge/rmgr/drv.c
@@ -16,6 +16,7 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
 #include <linux/types.h>
+#include <linux/list.h>
 
 /*  ----------------------------------- Host OS */
 #include <dspbridge/host_os.h>
@@ -26,9 +27,6 @@
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
 
-/*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/list.h>
-
 /*  ----------------------------------- This */
 #include <dspbridge/drv.h>
 #include <dspbridge/dev.h>
@@ -42,8 +40,8 @@
 
 /*  ----------------------------------- Defines, Data Structures, Typedefs */
 struct drv_object {
-	struct lst_list *dev_list;
-	struct lst_list *dev_node_string;
+	struct list_head dev_list;
+	struct list_head dev_node_string;
 };
 
 /*
@@ -305,22 +303,8 @@ int drv_create(struct drv_object **drv_obj)
 	pdrv_object = kzalloc(sizeof(struct drv_object), GFP_KERNEL);
 	if (pdrv_object) {
 		/* Create and Initialize List of device objects */
-		pdrv_object->dev_list = kzalloc(sizeof(struct lst_list),
-							GFP_KERNEL);
-		if (pdrv_object->dev_list) {
-			/* Create and Initialize List of device Extension */
-			pdrv_object->dev_node_string =
-				kzalloc(sizeof(struct lst_list), GFP_KERNEL);
-			if (!(pdrv_object->dev_node_string)) {
-				status = -EPERM;
-			} else {
-				INIT_LIST_HEAD(&pdrv_object->
-					       dev_node_string->head);
-				INIT_LIST_HEAD(&pdrv_object->dev_list->head);
-			}
-		} else {
-			status = -ENOMEM;
-		}
+		INIT_LIST_HEAD(&pdrv_object->dev_list);
+		INIT_LIST_HEAD(&pdrv_object->dev_node_string);
 	} else {
 		status = -ENOMEM;
 	}
@@ -337,8 +321,6 @@ int drv_create(struct drv_object **drv_obj)
 	if (!status) {
 		*drv_obj = pdrv_object;
 	} else {
-		kfree(pdrv_object->dev_list);
-		kfree(pdrv_object->dev_node_string);
 		/* Free the DRV Object */
 		kfree(pdrv_object);
 	}
@@ -375,13 +357,6 @@ int drv_destroy(struct drv_object *driver_obj)
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(pdrv_object);
 
-	/*
-	 *  Delete the List if it exists.Should not come here
-	 *  as the drv_remove_dev_object and the Last drv_request_resources
-	 *  removes the list if the lists are empty.
-	 */
-	kfree(pdrv_object->dev_list);
-	kfree(pdrv_object->dev_node_string);
 	kfree(pdrv_object);
 	/* Update the DRV Object in the driver data */
 	if (drv_datap) {
@@ -413,7 +388,7 @@ int drv_get_dev_object(u32 index, struct drv_object *hdrv_obj,
 	DBC_REQUIRE(device_obj != NULL);
 	DBC_REQUIRE(index >= 0);
 	DBC_REQUIRE(refs > 0);
-	DBC_ASSERT(!(LST_IS_EMPTY(pdrv_obj->dev_list)));
+	DBC_ASSERT(!(list_empty(&pdrv_obj->dev_list)));
 
 	dev_obj = (struct dev_object *)drv_get_first_dev_object();
 	for (i = 0; i < index; i++) {
@@ -444,9 +419,8 @@ u32 drv_get_first_dev_object(void)
 
 	if (drv_datap && drv_datap->drv_object) {
 		pdrv_obj = drv_datap->drv_object;
-		if ((pdrv_obj->dev_list != NULL) &&
-		    !LST_IS_EMPTY(pdrv_obj->dev_list))
-			dw_dev_object = (u32) lst_first(pdrv_obj->dev_list);
+		if (!list_empty(&pdrv_obj->dev_list))
+			dw_dev_object = (u32) pdrv_obj->dev_list.next;
 	} else {
 		pr_err("%s: Failed to retrieve the object handle\n", __func__);
 	}
@@ -468,10 +442,9 @@ u32 drv_get_first_dev_extension(void)
 
 	if (drv_datap && drv_datap->drv_object) {
 		pdrv_obj = drv_datap->drv_object;
-		if ((pdrv_obj->dev_node_string != NULL) &&
-		    !LST_IS_EMPTY(pdrv_obj->dev_node_string)) {
+		if (!list_empty(&pdrv_obj->dev_node_string)) {
 			dw_dev_extension =
-			    (u32) lst_first(pdrv_obj->dev_node_string);
+			    (u32) pdrv_obj->dev_node_string.next;
 		}
 	} else {
 		pr_err("%s: Failed to retrieve the object handle\n", __func__);
@@ -492,16 +465,17 @@ u32 drv_get_next_dev_object(u32 hdev_obj)
 	u32 dw_next_dev_object = 0;
 	struct drv_object *pdrv_obj;
 	struct drv_data *drv_datap = dev_get_drvdata(bridge);
+	struct list_head *curr;
 
 	DBC_REQUIRE(hdev_obj != 0);
 
 	if (drv_datap && drv_datap->drv_object) {
 		pdrv_obj = drv_datap->drv_object;
-		if ((pdrv_obj->dev_list != NULL) &&
-		    !LST_IS_EMPTY(pdrv_obj->dev_list)) {
-			dw_next_dev_object = (u32) lst_next(pdrv_obj->dev_list,
-							    (struct list_head *)
-							    hdev_obj);
+		if (!list_empty(&pdrv_obj->dev_list)) {
+			curr = (struct list_head *)hdev_obj;
+			if (curr->next == &pdrv_obj->dev_list)
+				return 0;
+			dw_next_dev_object = (u32) curr->next;
 		}
 	} else {
 		pr_err("%s: Failed to retrieve the object handle\n", __func__);
@@ -523,16 +497,17 @@ u32 drv_get_next_dev_extension(u32 dev_extension)
 	u32 dw_dev_extension = 0;
 	struct drv_object *pdrv_obj;
 	struct drv_data *drv_datap = dev_get_drvdata(bridge);
+	struct list_head *curr;
 
 	DBC_REQUIRE(dev_extension != 0);
 
 	if (drv_datap && drv_datap->drv_object) {
 		pdrv_obj = drv_datap->drv_object;
-		if ((pdrv_obj->dev_node_string != NULL) &&
-		    !LST_IS_EMPTY(pdrv_obj->dev_node_string)) {
-			dw_dev_extension =
-			    (u32) lst_next(pdrv_obj->dev_node_string,
-					   (struct list_head *)dev_extension);
+		if (!list_empty(&pdrv_obj->dev_node_string)) {
+			curr = (struct list_head *)dev_extension;
+			if (curr->next == &pdrv_obj->dev_node_string)
+				return 0;
+			dw_dev_extension = (u32) curr->next;
 		}
 	} else {
 		pr_err("%s: Failed to retrieve the object handle\n", __func__);
@@ -573,11 +548,8 @@ int drv_insert_dev_object(struct drv_object *driver_obj,
 	DBC_REQUIRE(refs > 0);
 	DBC_REQUIRE(hdev_obj != NULL);
 	DBC_REQUIRE(pdrv_object);
-	DBC_ASSERT(pdrv_object->dev_list);
-
-	lst_put_tail(pdrv_object->dev_list, (struct list_head *)hdev_obj);
 
-	DBC_ENSURE(!LST_IS_EMPTY(pdrv_object->dev_list));
+	list_add_tail((struct list_head *)hdev_obj, &pdrv_object->dev_list);
 
 	return 0;
 }
@@ -599,26 +571,17 @@ int drv_remove_dev_object(struct drv_object *driver_obj,
 	DBC_REQUIRE(pdrv_object);
 	DBC_REQUIRE(hdev_obj != NULL);
 
-	DBC_REQUIRE(pdrv_object->dev_list != NULL);
-	DBC_REQUIRE(!LST_IS_EMPTY(pdrv_object->dev_list));
+	DBC_REQUIRE(!list_empty(&pdrv_object->dev_list));
 
 	/* Search list for p_proc_object: */
-	for (cur_elem = lst_first(pdrv_object->dev_list); cur_elem != NULL;
-	     cur_elem = lst_next(pdrv_object->dev_list, cur_elem)) {
+	list_for_each(cur_elem, &pdrv_object->dev_list) {
 		/* If found, remove it. */
 		if ((struct dev_object *)cur_elem == hdev_obj) {
-			lst_remove_elem(pdrv_object->dev_list, cur_elem);
+			list_del(cur_elem);
 			status = 0;
 			break;
 		}
 	}
-	/* Remove list if empty. */
-	if (LST_IS_EMPTY(pdrv_object->dev_list)) {
-		kfree(pdrv_object->dev_list);
-		pdrv_object->dev_list = NULL;
-	}
-	DBC_ENSURE((pdrv_object->dev_list == NULL) ||
-		   !LST_IS_EMPTY(pdrv_object->dev_list));
 
 	return status;
 }
@@ -652,14 +615,13 @@ int drv_request_resources(u32 dw_context, u32 *dev_node_strg)
 	if (!status) {
 		pszdev_node = kzalloc(sizeof(struct drv_ext), GFP_KERNEL);
 		if (pszdev_node) {
-			lst_init_elem(&pszdev_node->link);
 			strncpy(pszdev_node->sz_string,
 				(char *)dw_context, MAXREGPATHLENGTH - 1);
 			pszdev_node->sz_string[MAXREGPATHLENGTH - 1] = '\0';
 			/* Update the Driver Object List */
 			*dev_node_strg = (u32) pszdev_node->sz_string;
-			lst_put_tail(pdrv_object->dev_node_string,
-				     (struct list_head *)pszdev_node);
+			list_add_tail(&pszdev_node->link,
+					&pdrv_object->dev_node_string);
 		} else {
 			status = -ENOMEM;
 			*dev_node_strg = 0;
@@ -671,7 +633,7 @@ int drv_request_resources(u32 dw_context, u32 *dev_node_strg)
 	}
 
 	DBC_ENSURE((!status && dev_node_strg != NULL &&
-		    !LST_IS_EMPTY(pdrv_object->dev_node_string)) ||
+		    !list_empty(&pdrv_object->dev_node_string)) ||
 		   (status && *dev_node_strg == 0));
 
 	return status;
@@ -685,7 +647,6 @@ int drv_request_resources(u32 dw_context, u32 *dev_node_strg)
 int drv_release_resources(u32 dw_context, struct drv_object *hdrv_obj)
 {
 	int status = 0;
-	struct drv_object *pdrv_object = (struct drv_object *)hdrv_obj;
 	struct drv_ext *pszdev_node;
 
 	/*
@@ -695,23 +656,13 @@ int drv_release_resources(u32 dw_context, struct drv_object *hdrv_obj)
 	for (pszdev_node = (struct drv_ext *)drv_get_first_dev_extension();
 	     pszdev_node != NULL; pszdev_node = (struct drv_ext *)
 	     drv_get_next_dev_extension((u32) pszdev_node)) {
-		if (!pdrv_object->dev_node_string) {
-			/* When this could happen? */
-			continue;
-		}
 		if ((u32) pszdev_node == dw_context) {
 			/* Found it */
 			/* Delete from the Driver object list */
-			lst_remove_elem(pdrv_object->dev_node_string,
-					(struct list_head *)pszdev_node);
-			kfree((void *)pszdev_node);
+			list_del(&pszdev_node->link);
+			kfree(pszdev_node);
 			break;
 		}
-		/* Delete the List if it is empty */
-		if (LST_IS_EMPTY(pdrv_object->dev_node_string)) {
-			kfree(pdrv_object->dev_node_string);
-			pdrv_object->dev_node_string = NULL;
-		}
 	}
 	return status;
 }
diff --git a/drivers/staging/tidspbridge/rmgr/node.c b/drivers/staging/tidspbridge/rmgr/node.c
index f660d1f..34ae0ad 100644
--- a/drivers/staging/tidspbridge/rmgr/node.c
+++ b/drivers/staging/tidspbridge/rmgr/node.c
@@ -18,6 +18,8 @@
 
 #include <linux/types.h>
 #include <linux/bitmap.h>
+#include <linux/list.h>
+
 /*  ----------------------------------- Host OS */
 #include <dspbridge/host_os.h>
 
@@ -28,7 +30,6 @@
 #include <dspbridge/dbc.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/list.h>
 #include <dspbridge/memdefs.h>
 #include <dspbridge/proc.h>
 #include <dspbridge/strm.h>
@@ -128,7 +129,7 @@ struct node_mgr {
 	struct bridge_drv_interface *intf_fxns;
 	struct dcd_manager *hdcd_mgr;	/* Proc/Node data manager */
 	struct disp_object *disp_obj;	/* Node dispatcher */
-	struct lst_list *node_list;	/* List of all allocated nodes */
+	struct list_head node_list;	/* List of all allocated nodes */
 	u32 num_nodes;		/* Number of nodes in node_list */
 	u32 num_created;	/* Number of nodes *created* on DSP */
 	DECLARE_BITMAP(pipe_map, MAXPIPES); /* Pipe connection bitmap */
@@ -612,13 +613,12 @@ func_cont:
 	if (!status) {
 		/* Add the node to the node manager's list of allocated
 		 * nodes. */
-		lst_init_elem((struct list_head *)pnode);
 		NODE_SET_STATE(pnode, NODE_ALLOCATED);
 
 		mutex_lock(&hnode_mgr->node_mgr_lock);
 
-		lst_put_tail(hnode_mgr->node_list, (struct list_head *) pnode);
-			++(hnode_mgr->num_nodes);
+		list_add_tail(&pnode->list_elem, &hnode_mgr->node_list);
+		++(hnode_mgr->num_nodes);
 
 		/* Exit critical section */
 		mutex_unlock(&hnode_mgr->node_mgr_lock);
@@ -1274,11 +1274,6 @@ int node_create_mgr(struct node_mgr **node_man,
 		return -ENOMEM;
 
 	node_mgr_obj->hdev_obj = hdev_obj;
-	node_mgr_obj->node_list = kzalloc(sizeof(struct lst_list), GFP_KERNEL);
-	if (!node_mgr_obj->node_list) {
-		status = -ENOMEM;
-		goto out_err;
-	}
 
 	node_mgr_obj->ntfy_obj = kmalloc(sizeof(struct ntfy_object),
 			GFP_KERNEL);
@@ -1288,7 +1283,7 @@ int node_create_mgr(struct node_mgr **node_man,
 	}
 	ntfy_init(node_mgr_obj->ntfy_obj);
 
-	INIT_LIST_HEAD(&node_mgr_obj->node_list->head);
+	INIT_LIST_HEAD(&node_mgr_obj->node_list);
 
 	dev_get_dev_type(hdev_obj, &dev_type);
 
@@ -1500,7 +1495,7 @@ func_cont1:
 	}
 	/* Free host side resources even if a failure occurred */
 	/* Remove node from hnode_mgr->node_list */
-	lst_remove_elem(hnode_mgr->node_list, (struct list_head *)pnode);
+	list_del(&pnode->list_elem);
 	hnode_mgr->num_nodes--;
 	/* Decrement count of nodes created on DSP */
 	if ((state != NODE_ALLOCATED) || ((state == NODE_ALLOCATED) &&
@@ -1571,15 +1566,9 @@ int node_enum_nodes(struct node_mgr *hnode_mgr, void **node_tab,
 		*pu_num_nodes = 0;
 		status = -EINVAL;
 	} else {
-		hnode = (struct node_object *)lst_first(hnode_mgr->
-			node_list);
-		for (i = 0; i < hnode_mgr->num_nodes; i++) {
-			DBC_ASSERT(hnode);
-			node_tab[i] = hnode;
-			hnode = (struct node_object *)lst_next
-				(hnode_mgr->node_list,
-				(struct list_head *)hnode);
-		}
+		i = 0;
+		list_for_each_entry(hnode, &hnode_mgr->node_list, list_elem)
+			node_tab[i++] = hnode;
 		*pu_allocated = *pu_num_nodes = hnode_mgr->num_nodes;
 	}
 	/* end of sync_enter_cs */
@@ -2549,7 +2538,7 @@ func_end:
  */
 static void delete_node_mgr(struct node_mgr *hnode_mgr)
 {
-	struct node_object *hnode;
+	struct node_object *hnode, *tmp;
 
 	if (hnode_mgr) {
 		/* Free resources */
@@ -2557,13 +2546,10 @@ static void delete_node_mgr(struct node_mgr *hnode_mgr)
 			dcd_destroy_manager(hnode_mgr->hdcd_mgr);
 
 		/* Remove any elements remaining in lists */
-		if (hnode_mgr->node_list) {
-			while ((hnode = (struct node_object *)
-				lst_get_head(hnode_mgr->node_list)))
-				delete_node(hnode, NULL);
-
-			DBC_ASSERT(LST_IS_EMPTY(hnode_mgr->node_list));
-			kfree(hnode_mgr->node_list);
+		list_for_each_entry_safe(hnode, tmp, &hnode_mgr->node_list,
+				list_elem) {
+			list_del(&hnode->list_elem);
+			delete_node(hnode, NULL);
 		}
 		mutex_destroy(&hnode_mgr->node_mgr_lock);
 		if (hnode_mgr->ntfy_obj) {
@@ -3103,23 +3089,17 @@ int node_find_addr(struct node_mgr *node_mgr, u32 sym_addr,
 {
 	struct node_object *node_obj;
 	int status = -ENOENT;
-	u32 n;
 
 	pr_debug("%s(0x%x, 0x%x, 0x%x, 0x%x,  %s)\n", __func__,
 			(unsigned int) node_mgr,
 			sym_addr, offset_range,
 			(unsigned int) sym_addr_output, sym_name);
 
-	node_obj = (struct node_object *)(node_mgr->node_list->head.next);
-
-	for (n = 0; n < node_mgr->num_nodes; n++) {
+	list_for_each_entry(node_obj, &node_mgr->node_list, list_elem) {
 		status = nldr_find_addr(node_obj->nldr_node_obj, sym_addr,
 			offset_range, sym_addr_output, sym_name);
-
 		if (!status)
 			break;
-
-		node_obj = (struct node_object *) (node_obj->list_elem.next);
 	}
 
 	return status;
diff --git a/drivers/staging/tidspbridge/rmgr/proc.c b/drivers/staging/tidspbridge/rmgr/proc.c
index 7a15a02..a091a2d 100644
--- a/drivers/staging/tidspbridge/rmgr/proc.c
+++ b/drivers/staging/tidspbridge/rmgr/proc.c
@@ -29,7 +29,6 @@
 #include <dspbridge/dbc.h>
 
 /*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/list.h>
 #include <dspbridge/ntfy.h>
 #include <dspbridge/sync.h>
 /*  ----------------------------------- Bridge Driver */
@@ -344,7 +343,6 @@ proc_attach(u32 processor_id,
 		 * Return handle to this Processor Object:
 		 * Find out if the Device is already attached to a
 		 * Processor. If so, return AlreadyAttached status */
-		lst_init_elem(&p_proc_object->link);
 		status = dev_insert_proc_object(p_proc_object->hdev_obj,
 						(u32) p_proc_object,
 						&p_proc_object->
diff --git a/drivers/staging/tidspbridge/rmgr/rmm.c b/drivers/staging/tidspbridge/rmgr/rmm.c
index 761e8f4..93db337 100644
--- a/drivers/staging/tidspbridge/rmgr/rmm.c
+++ b/drivers/staging/tidspbridge/rmgr/rmm.c
@@ -38,6 +38,10 @@
  */
 
 #include <linux/types.h>
+#include <linux/list.h>
+
+/*  ----------------------------------- Host OS */
+#include <dspbridge/host_os.h>
 
 /*  ----------------------------------- DSP/BIOS Bridge */
 #include <dspbridge/dbdefs.h>
@@ -45,9 +49,6 @@
 /*  ----------------------------------- Trace & Debug */
 #include <dspbridge/dbc.h>
 
-/*  ----------------------------------- OS Adaptation Layer */
-#include <dspbridge/list.h>
-
 /*  ----------------------------------- This */
 #include <dspbridge/rmm.h>
 
@@ -79,7 +80,7 @@ struct rmm_target_obj {
 	struct rmm_segment *seg_tab;
 	struct rmm_header **free_list;
 	u32 num_segs;
-	struct lst_list *ovly_list;	/* List of overlay memory in use */
+	struct list_head ovly_list;	/* List of overlay memory in use */
 };
 
 static u32 refs;		/* module reference count */
@@ -95,8 +96,7 @@ static bool free_block(struct rmm_target_obj *target, u32 segid, u32 addr,
 int rmm_alloc(struct rmm_target_obj *target, u32 segid, u32 size,
 		     u32 align, u32 *dsp_address, bool reserve)
 {
-	struct rmm_ovly_sect *sect;
-	struct rmm_ovly_sect *prev_sect = NULL;
+	struct rmm_ovly_sect *sect, *prev_sect = NULL;
 	struct rmm_ovly_sect *new_sect;
 	u32 addr;
 	int status = 0;
@@ -120,10 +120,9 @@ int rmm_alloc(struct rmm_target_obj *target, u32 segid, u32 size,
 	/* An overlay section - See if block is already in use. If not,
 	 * insert into the list in ascending address size. */
 	addr = *dsp_address;
-	sect = (struct rmm_ovly_sect *)lst_first(target->ovly_list);
 	/*  Find place to insert new list element. List is sorted from
 	 *  smallest to largest address. */
-	while (sect != NULL) {
+	list_for_each_entry(sect, &target->ovly_list, list_elem) {
 		if (addr <= sect->addr) {
 			/* Check for overlap with sect */
 			if ((addr + size > sect->addr) || (prev_sect &&
@@ -135,9 +134,6 @@ int rmm_alloc(struct rmm_target_obj *target, u32 segid, u32 size,
 			break;
 		}
 		prev_sect = sect;
-		sect = (struct rmm_ovly_sect *)lst_next(target->ovly_list,
-							(struct list_head *)
-							sect);
 	}
 	if (!status) {
 		/* No overlap - allocate list element for new section. */
@@ -145,20 +141,17 @@ int rmm_alloc(struct rmm_target_obj *target, u32 segid, u32 size,
 		if (new_sect == NULL) {
 			status = -ENOMEM;
 		} else {
-			lst_init_elem((struct list_head *)new_sect);
 			new_sect->addr = addr;
 			new_sect->size = size;
 			new_sect->page = segid;
-			if (sect == NULL) {
+			if (sect == NULL)
 				/* Put new section at the end of the list */
-				lst_put_tail(target->ovly_list,
-					     (struct list_head *)new_sect);
-			} else {
+				list_add_tail(&new_sect->list_elem,
+						&target->ovly_list);
+			else
 				/* Put new section just before sect */
-				lst_insert_before(target->ovly_list,
-						  (struct list_head *)new_sect,
-						  (struct list_head *)sect);
-			}
+				list_add_tail(&new_sect->list_elem,
+						&sect->list_elem);
 		}
 	}
 func_end:
@@ -230,14 +223,8 @@ int rmm_create(struct rmm_target_obj **target_obj,
 	}
 func_cont:
 	/* Initialize overlay memory list */
-	if (!status) {
-		target->ovly_list = kzalloc(sizeof(struct lst_list),
-							GFP_KERNEL);
-		if (target->ovly_list == NULL)
-			status = -ENOMEM;
-		else
-			INIT_LIST_HEAD(&target->ovly_list->head);
-	}
+	if (!status)
+		INIT_LIST_HEAD(&target->ovly_list);
 
 	if (!status) {
 		*target_obj = target;
@@ -259,7 +246,7 @@ func_cont:
  */
 void rmm_delete(struct rmm_target_obj *target)
 {
-	struct rmm_ovly_sect *ovly_section;
+	struct rmm_ovly_sect *sect, *tmp;
 	struct rmm_header *hptr;
 	struct rmm_header *next;
 	u32 i;
@@ -268,13 +255,9 @@ void rmm_delete(struct rmm_target_obj *target)
 
 	kfree(target->seg_tab);
 
-	if (target->ovly_list) {
-		while ((ovly_section = (struct rmm_ovly_sect *)lst_get_head
-			(target->ovly_list))) {
-			kfree(ovly_section);
-		}
-		DBC_ASSERT(LST_IS_EMPTY(target->ovly_list));
-		kfree(target->ovly_list);
+	list_for_each_entry_safe(sect, tmp, &target->ovly_list, list_elem) {
+		list_del(&sect->list_elem);
+		kfree(sect);
 	}
 
 	if (target->free_list != NULL) {
@@ -311,8 +294,8 @@ void rmm_exit(void)
 bool rmm_free(struct rmm_target_obj *target, u32 segid, u32 dsp_addr, u32 size,
 	      bool reserved)
 {
-	struct rmm_ovly_sect *sect;
-	bool ret = true;
+	struct rmm_ovly_sect *sect, *tmp;
+	bool ret = false;
 
 	DBC_REQUIRE(target);
 
@@ -333,24 +316,17 @@ bool rmm_free(struct rmm_target_obj *target, u32 segid, u32 dsp_addr, u32 size,
 
 	} else {
 		/* Unreserve memory */
-		sect = (struct rmm_ovly_sect *)lst_first(target->ovly_list);
-		while (sect != NULL) {
+		list_for_each_entry_safe(sect, tmp, &target->ovly_list,
+				list_elem) {
 			if (dsp_addr == sect->addr) {
 				DBC_ASSERT(size == sect->size);
 				/* Remove from list */
-				lst_remove_elem(target->ovly_list,
-						(struct list_head *)sect);
+				list_del(&sect->list_elem);
 				kfree(sect);
+				ret = true;
 				break;
 			}
-			sect =
-			    (struct rmm_ovly_sect *)lst_next(target->ovly_list,
-							     (struct list_head
-							      *)sect);
 		}
-		if (sect == NULL)
-			ret = false;
-
 	}
 	return ret;
 }
-- 
1.7.2.3

